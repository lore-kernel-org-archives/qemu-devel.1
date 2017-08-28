Received: from eggs.gnu.org ([2001:4830:134:3::10]:33177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmO8R-0006dX-3H
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmO8M-00026c-4o
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:39 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:35032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmO8L-000260-VE
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:47:34 -0400
Received: by mail-pg0-x232.google.com with SMTP id 63so3437042pgc.2
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 10:47:33 -0700 (PDT)
References: <20170828035327.17146-1-bobby.prani@gmail.com>
	<20170828035327.17146-2-bobby.prani@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f6169d2-107c-ef7b-cc6f-1ad40a25365f@linaro.org>
Date: Mon, 28 Aug 2017 10:47:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170828035327.17146-2-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] cpus-common: Cache allocated work
 items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 08/27/2017 08:53 PM, Pranith Kumar wrote:
> Using heaptrack, I found that quite a few of our temporary allocations
> are coming from allocating work items. Instead of doing this
> continously, we can cache the allocated items and reuse them instead
> of freeing them.
> 
> This reduces the number of allocations by 25% (200000 -> 150000 for
> ARM64 boot+shutdown test).
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  cpus-common.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/cpus-common.c b/cpus-common.c
> index 59f751ecf9..a1c4c7d1a3 100644
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
> @@ -33,6 +34,58 @@ static QemuCond qemu_work_cond;
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
> +    qemu_work_item *first, *last;
> +} qemu_wi_pool;
> +
> +qemu_wi_pool *wi_free_pool;
> +
> +static void qemu_init_workitem_pool(void)
> +{
> +    wi_free_pool = g_malloc0(sizeof(qemu_wi_pool));
> +    wi_free_pool->first = NULL;
> +    wi_free_pool->last  = NULL;
> +}
> +
> +static void qemu_wi_pool_insert(qemu_work_item *item)
> +{
> +    qemu_mutex_lock(&qemu_wi_pool_lock);
> +    if (wi_free_pool->last == NULL) {
> +        wi_free_pool->first = item;
> +        wi_free_pool->last = item;
> +    } else {
> +        wi_free_pool->last->next = item;
> +        wi_free_pool->last = item;
> +    }
> +    qemu_mutex_unlock(&qemu_wi_pool_lock);
> +}
> +
> +static qemu_work_item* qemu_wi_pool_remove(void)
> +{
> +    qemu_mutex_lock(&qemu_wi_pool_lock);
> +    qemu_work_item *ret = wi_free_pool->first;
> +
> +    if (ret == NULL)
> +        goto out;
> +
> +    wi_free_pool->first = ret->next;
> +    if (wi_free_pool->last == ret) {
> +        wi_free_pool->last = NULL;
> +    }

Why does this list need to record a "last" element?
It would seem a simple lifo would be sufficient.

(You would also be able to manage the list via cmpxchg without a separate lock,
but perhaps the difference between the two isn't measurable.)


r~
