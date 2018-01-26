Received: from eggs.gnu.org ([2001:4830:134:3::10]:39850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef6xk-0004Hi-PK
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef6xf-0008U9-QK
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:34:48 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:47040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ef6xf-0008Tv-LD
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:34:43 -0500
Received: by mail-qt0-x241.google.com with SMTP id o35so2635220qtj.13
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 08:34:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1516982720-26501-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180126160531eucas1p2e972758feaca9f6d174e6399aca78c81@eucas1p2.samsung.com>
	<1516982720-26501-2-git-send-email-a.perevalov@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <73901dff-4a71-bb97-6769-70a54f03aa5a@amsat.org>
Date: Fri, 26 Jan 2018 13:13:12 -0300
MIME-Version: 1.0
In-Reply-To: <1516982720-26501-2-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] migration: change blocktime type to
 uint32_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: lvivier@redhat.com, peterx@redhat.com, quintela@redhat.com, ash.billore@samsung.com

Hi Alexey,

On 01/26/2018 01:05 PM, Alexey Perevalov wrote:
> Initially int64_t was used, but on PowerPC architecture,
> clang doesn't have atomic_*_8 function, so it produces
> link time error.
> 
> QEMU is working with time as with 64bit value, but by
> fact 32 bit is enough with CLOCK_REALTIME. In this case
> blocktime will keep only 1200 hours time interval.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> Acked-by: Eric Blake <eblake@redhat.com>
> ---
>  hmp.c                    |  4 ++--
>  migration/postcopy-ram.c | 37 ++++++++++++++++++++-----------------
>  migration/trace-events   |  4 ++--
>  qapi/migration.json      |  4 ++--
>  4 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index c6bab53..3c376b3 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -265,7 +265,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>      }
>  
>      if (info->has_postcopy_blocktime) {
> -        monitor_printf(mon, "postcopy blocktime: %" PRId64 "\n",
> +        monitor_printf(mon, "postcopy blocktime: %u\n",
>                         info->postcopy_blocktime);
>      }
>  
> @@ -273,7 +273,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          Visitor *v;
>          char *str;
>          v = string_output_visitor_new(false, &str);
> -        visit_type_int64List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
> +        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
>          visit_complete(v, &str);
>          monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
>          g_free(str);
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 7814da5..bd08c24 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -63,14 +63,14 @@ struct PostcopyDiscardState {
>  
>  typedef struct PostcopyBlocktimeContext {
>      /* time when page fault initiated per vCPU */
> -    int64_t *page_fault_vcpu_time;
> +    uint32_t *page_fault_vcpu_time;
>      /* page address per vCPU */
>      uintptr_t *vcpu_addr;
> -    int64_t total_blocktime;
> +    uint32_t total_blocktime;
>      /* blocktime per vCPU */
> -    int64_t *vcpu_blocktime;
> +    uint32_t *vcpu_blocktime;
>      /* point in time when last page fault was initiated */
> -    int64_t last_begin;
> +    uint32_t last_begin;
>      /* number of vCPU are suspended */
>      int smp_cpus_down;
>  
> @@ -99,22 +99,22 @@ static void migration_exit_cb(Notifier *n, void *data)
>  static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>  {
>      PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
> -    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
> +    ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
>      ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
> -    ctx->vcpu_blocktime = g_new0(int64_t, smp_cpus);
> +    ctx->vcpu_blocktime = g_new0(uint32_t, smp_cpus);
>  
>      ctx->exit_notifier.notify = migration_exit_cb;
>      qemu_add_exit_notifier(&ctx->exit_notifier);
>      return ctx;
>  }
>  
> -static int64List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
> +static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
>  {
> -    int64List *list = NULL, *entry = NULL;
> +    uint32List *list = NULL, *entry = NULL;
>      int i;
>  
>      for (i = smp_cpus - 1; i >= 0; i--) {
> -        entry = g_new0(int64List, 1);
> +        entry = g_new0(uint32List, 1);
>          entry->value = ctx->vcpu_blocktime[i];
>          entry->next = list;
>          list = entry;
> @@ -145,7 +145,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
>      info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
>  }
>  
> -static uint64_t get_postcopy_total_blocktime(void)
> +static uint32_t get_postcopy_total_blocktime(void)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
> @@ -634,6 +634,7 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>      int64_t now_ms;
> +    uint32_t least_now;
>  
>      if (!dc || ptid == 0) {
>          return;
> @@ -644,13 +645,14 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>      }
>  
>      now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    least_now = (uint32_t)now_ms;
>      if (dc->vcpu_addr[cpu] == 0) {
>          atomic_inc(&dc->smp_cpus_down);
>      }
>  
> -    atomic_xchg__nocheck(&dc->last_begin, now_ms);
> -    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
> -    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
> +    atomic_xchg(&dc->last_begin, least_now);
> +    atomic_xchg(&dc->page_fault_vcpu_time[cpu], least_now);
> +    atomic_xchg(&dc->vcpu_addr[cpu], addr);
>  
>      /* check it here, not at the begining of the function,
>       * due to, check could accur early than bitmap_set in
> @@ -699,20 +701,21 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>      int i, affected_cpu = 0;
>      int64_t now_ms;
>      bool vcpu_total_blocktime = false;
> -    int64_t read_vcpu_time;
> +    uint32_t read_vcpu_time, least_now;
>  
>      if (!dc) {
>          return;
>      }
>  
>      now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    least_now = now_ms & 0xffffffff;

This might deserve a comment.

I also find using UINT32_MAX clearer.

>  
>      /* lookup cpu, to clear it,
>       * that algorithm looks straighforward, but it's not
>       * optimal, more optimal algorithm is keeping tree or hash
>       * where key is address value is a list of  */
>      for (i = 0; i < smp_cpus; i++) {
> -        uint64_t vcpu_blocktime = 0;
> +        uint32_t vcpu_blocktime = 0;
>  
>          read_vcpu_time = atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
>          if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr ||
> @@ -720,7 +723,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>              continue;
>          }
>          atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
> -        vcpu_blocktime = now_ms - read_vcpu_time;
> +        vcpu_blocktime = least_now - read_vcpu_time;
>          affected_cpu += 1;
>          /* we need to know is that mark_postcopy_end was due to
>           * faulted page, another possible case it's prefetched
> @@ -735,7 +738,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>  
>      atomic_sub(&dc->smp_cpus_down, affected_cpu);
>      if (vcpu_total_blocktime) {
> -        dc->total_blocktime += now_ms - atomic_fetch_add(&dc->last_begin, 0);
> +        dc->total_blocktime += least_now - atomic_fetch_add(&dc->last_begin, 0);
>      }
>      trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
>                                        affected_cpu);
> diff --git a/migration/trace-events b/migration/trace-events
> index 141e773..0defbc3 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -115,8 +115,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> -mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", cpu: %d, already_received: %d"
> -mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", affected_cpu: %d"
> +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d, already_received: %d"
> +mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
>  
>  # migration/rdma.c
>  qemu_rdma_accept_incoming_migration(void) ""
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 70e7b67..ee55d7c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -175,8 +175,8 @@
>             '*setup-time': 'int',
>             '*cpu-throttle-percentage': 'int',
>             '*error-desc': 'str',
> -           '*postcopy-blocktime' : 'int64',
> -           '*postcopy-vcpu-blocktime': ['int64']} }
> +           '*postcopy-blocktime' : 'uint32',
> +           '*postcopy-vcpu-blocktime': ['uint32']} }
>  
>  ##
>  # @query-migrate:
> 
