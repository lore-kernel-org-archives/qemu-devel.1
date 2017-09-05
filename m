Received: from eggs.gnu.org ([2001:4830:134:3::10]:48794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpCyM-000689-Ij
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dpCyE-0005W1-Fx
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:28:54 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dpCyE-0005Vm-6u
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:28:46 -0400
Received: by mail-wr0-x22b.google.com with SMTP id n33so8385259wrn.4
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:28:46 -0700 (PDT)
References: <20170829063313.10237-1-bobby.prani@gmail.com>
	<20170829063313.10237-2-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170829063313.10237-2-bobby.prani@gmail.com>
Date: Tue, 05 Sep 2017 13:28:43 +0100
Message-ID: <87k21dmiro.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 PATCH 2/5] cpus-common: Cache allocated
 work items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Sergey Fedorov <serge.fdrv@gmail.com>, qemu-devel@nongnu.org


Pranith Kumar <bobby.prani@gmail.com> writes:

> Using heaptrack, I found that quite a few of our temporary allocations
> are coming from allocating work items. Instead of doing this
> continously, we can cache the allocated items and reuse them instead
> of freeing them.
>
> Stats from an ARM64 guest (boot+shutdown):
>
> heaptrack stats(before):
>         allocations:            1471317
>         leaked allocations:     73824
>         temporary allocations:  651293
>
> heaptrack stats(after):
>         allocations:            1143130
>         leaked allocations:     73693
>         temporary allocations:  487342
>
> The improvement in speedup is minor and within error margins, however I think the
> patch is still worth. We can also explore atomics instead of taking a lock for
> the work item pool.

When we where doing the original MTTCG work I looked at using GArray for
the work queue, see:

  http://lists.gnu.org/archive/html/qemu-devel/2016-08/msg00367.html

specifically:

  Subject: [PATCH v5 13/13] cpu-exec: replace cpu->queued_work with GArray
  Date: Tue,  2 Aug 2016 18:27:44 +0100
  Message-Id: <1470158864-17651-14-git-send-email-alex.bennee@linaro.org>

which I personally think might yield better results than messing around
with custom allocators and GSlice and the like. You still get the
dynamic sizing of a malloc based array but for operations like insertion
and iterating through the work queue should be cache friendly.

Once the array has (transparently) reached a reasonable size to service
all allocations in the usual servicing period the same memory can be
used over and over again ;-)

My fondness for arrays is informed by comments by Bjarne Stroustrup:

  https://www.youtube.com/watch?v=YQs6IC-vgmo

Obviously this patch would need to be re-worked given how much the code
has changes since it was merged.

>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpus-common.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 60 insertions(+), 15 deletions(-)
>
> diff --git a/cpus-common.c b/cpus-common.c
> index 59f751ecf9..ccf5f50e4e 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -24,6 +24,7 @@
>  #include "sysemu/cpus.h"
>
>  static QemuMutex qemu_cpu_list_lock;
> +static QemuMutex qemu_wi_pool_lock;
>  static QemuCond exclusive_cond;
>  static QemuCond exclusive_resume;
>  static QemuCond qemu_work_cond;
> @@ -33,6 +34,49 @@ static QemuCond qemu_work_cond;
>   */
>  static int pending_cpus;
>
> +typedef struct qemu_work_item {
> +    struct qemu_work_item *next;
> +    run_on_cpu_func func;
> +    run_on_cpu_data data;
> +    bool free, exclusive, done;
> +} qemu_work_item;
> +
> +typedef struct qemu_wi_pool {
> +    qemu_work_item *head;
> +    int num_items;
> +} qemu_wi_pool;
> +
> +qemu_wi_pool *wi_free_pool;
> +
> +static void qemu_init_workitem_pool(void)
> +{
> +    wi_free_pool = g_malloc0(sizeof(qemu_wi_pool));
> +}
> +
> +static void qemu_wi_pool_insert(qemu_work_item *item)
> +{
> +    qemu_mutex_lock(&qemu_wi_pool_lock);
> +    qemu_work_item *curr = atomic_read(&wi_free_pool->head);
> +    item->next = curr;
> +    wi_free_pool->head = item;
> +    qemu_mutex_unlock(&qemu_wi_pool_lock);
> +}
> +
> +static qemu_work_item *qemu_wi_pool_remove(void)
> +{
> +    qemu_mutex_lock(&qemu_wi_pool_lock);
> +    qemu_work_item *curr = atomic_read(&wi_free_pool->head);
> +    if (curr == NULL) {
> +        goto out;
> +    }
> +    wi_free_pool->head = curr->next;
> +    curr->next = NULL;
> +
> + out:
> +    qemu_mutex_unlock(&qemu_wi_pool_lock);
> +    return curr;
> +}
> +
>  void qemu_init_cpu_list(void)
>  {
>      /* This is needed because qemu_init_cpu_list is also called by the
> @@ -43,6 +87,9 @@ void qemu_init_cpu_list(void)
>      qemu_cond_init(&exclusive_cond);
>      qemu_cond_init(&exclusive_resume);
>      qemu_cond_init(&qemu_work_cond);
> +
> +    qemu_init_workitem_pool();
> +    qemu_mutex_init(&qemu_wi_pool_lock);
>  }
>
>  void cpu_list_lock(void)
> @@ -106,14 +153,7 @@ void cpu_list_remove(CPUState *cpu)
>      qemu_mutex_unlock(&qemu_cpu_list_lock);
>  }
>
> -struct qemu_work_item {
> -    struct qemu_work_item *next;
> -    run_on_cpu_func func;
> -    run_on_cpu_data data;
> -    bool free, exclusive, done;
> -};
> -
> -static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
> +static void queue_work_on_cpu(CPUState *cpu, qemu_work_item *wi)
>  {
>      qemu_mutex_lock(&cpu->work_mutex);
>      if (cpu->queued_work_first == NULL) {
> @@ -132,7 +172,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
>  void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
>                     QemuMutex *mutex)
>  {
> -    struct qemu_work_item wi;
> +    qemu_work_item wi;
>
>      if (qemu_cpu_is_self(cpu)) {
>          func(cpu, data);
> @@ -156,9 +196,11 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
>
>  void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
>  {
> -    struct qemu_work_item *wi;
> +    qemu_work_item *wi = qemu_wi_pool_remove();
>
> -    wi = g_malloc0(sizeof(struct qemu_work_item));
> +    if (!wi) {
> +        wi = g_malloc0(sizeof(qemu_work_item));
> +    }
>      wi->func = func;
>      wi->data = data;
>      wi->free = true;
> @@ -299,9 +341,11 @@ void cpu_exec_end(CPUState *cpu)
>  void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
>                             run_on_cpu_data data)
>  {
> -    struct qemu_work_item *wi;
> +    qemu_work_item *wi = qemu_wi_pool_remove();
>
> -    wi = g_malloc0(sizeof(struct qemu_work_item));
> +    if (!wi) {
> +        wi = g_malloc0(sizeof(qemu_work_item));
> +    }
>      wi->func = func;
>      wi->data = data;
>      wi->free = true;
> @@ -312,7 +356,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
>
>  void process_queued_cpu_work(CPUState *cpu)
>  {
> -    struct qemu_work_item *wi;
> +    qemu_work_item *wi;
>
>      if (cpu->queued_work_first == NULL) {
>          return;
> @@ -343,7 +387,8 @@ void process_queued_cpu_work(CPUState *cpu)
>          }
>          qemu_mutex_lock(&cpu->work_mutex);
>          if (wi->free) {
> -            g_free(wi);
> +            memset(wi, 0, sizeof(qemu_work_item));
> +            qemu_wi_pool_insert(wi);
>          } else {
>              atomic_mb_set(&wi->done, true);
>          }


--
Alex Bennée
