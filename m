Received: from eggs.gnu.org ([2001:4830:134:3::10]:33995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evRei-0003qR-M4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evRee-0000oT-MN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:54:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1evRee-0000mr-5J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 13:54:36 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <3224d090-0ec5-86ee-1f5f-ad20c1e66836@samsung.com>
Date: Mon, 12 Mar 2018 20:54:28 +0300
MIME-version: 1.0
In-reply-to: <20180308125913.GA3038@work-vm>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1519289107-20251-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180222084520eucas1p16aa4a165d2e1c0f5ec4da12257eda269@eucas1p1.samsung.com>
	<1519289107-20251-2-git-send-email-a.perevalov@samsung.com>
	<20180308125913.GA3038@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4] migration: change blocktime type to
 uint32_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

On 03/08/2018 03:59 PM, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
>> Initially int64_t was used, but on PowerPC architecture,
>> clang doesn't have atomic_*_8 function, so it produces
>> link time error.
>>
>> QEMU is working with time as with 64bit value, but by
>> fact 32 bit is enough with CLOCK_REALTIME. In this case
>> blocktime will keep only 1200 hours time interval.
>>
>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>> Acked-by: Eric Blake <eblake@redhat.com>
> Hi Alexey,
>    So yes, I think that works;  can you repost this merged with your full
> set of block-time code; because we had to revert it, we need to put it
> back all  in again.
Do you mean just to add this patch to set of reverted patches,
or merge code of this patch into "migration: calculate vCPU blocktime on 
dst side"?

>
> Thanks,
>
> Dave
>
>> ---
>>   hmp.c                    |  4 ++--
>>   migration/postcopy-ram.c | 52 ++++++++++++++++++++++++++++--------------------
>>   migration/trace-events   |  4 ++--
>>   qapi/migration.json      |  4 ++--
>>   4 files changed, 36 insertions(+), 28 deletions(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index be091e0..ec90043 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -267,7 +267,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>       }
>>   
>>       if (info->has_postcopy_blocktime) {
>> -        monitor_printf(mon, "postcopy blocktime: %" PRId64 "\n",
>> +        monitor_printf(mon, "postcopy blocktime: %u\n",
>>                          info->postcopy_blocktime);
>>       }
>>   
>> @@ -275,7 +275,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>>           Visitor *v;
>>           char *str;
>>           v = string_output_visitor_new(false, &str);
>> -        visit_type_int64List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
>> +        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime, NULL);
>>           visit_complete(v, &str);
>>           monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
>>           g_free(str);
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 05475e0..c46225c 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -63,16 +63,17 @@ struct PostcopyDiscardState {
>>   
>>   typedef struct PostcopyBlocktimeContext {
>>       /* time when page fault initiated per vCPU */
>> -    int64_t *page_fault_vcpu_time;
>> +    uint32_t *page_fault_vcpu_time;
>>       /* page address per vCPU */
>>       uintptr_t *vcpu_addr;
>> -    int64_t total_blocktime;
>> +    uint32_t total_blocktime;
>>       /* blocktime per vCPU */
>> -    int64_t *vcpu_blocktime;
>> +    uint32_t *vcpu_blocktime;
>>       /* point in time when last page fault was initiated */
>> -    int64_t last_begin;
>> +    uint32_t last_begin;
>>       /* number of vCPU are suspended */
>>       int smp_cpus_down;
>> +    uint64_t start_time;
>>   
>>       /*
>>        * Handler for exit event, necessary for
>> @@ -99,22 +100,23 @@ static void migration_exit_cb(Notifier *n, void *data)
>>   static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>>   {
>>       PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
>> -    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
>> +    ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
>>       ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
>> -    ctx->vcpu_blocktime = g_new0(int64_t, smp_cpus);
>> +    ctx->vcpu_blocktime = g_new0(uint32_t, smp_cpus);
>>   
>>       ctx->exit_notifier.notify = migration_exit_cb;
>> +    ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>       qemu_add_exit_notifier(&ctx->exit_notifier);
>>       return ctx;
>>   }
>>   
>> -static int64List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
>> +static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
>>   {
>> -    int64List *list = NULL, *entry = NULL;
>> +    uint32List *list = NULL, *entry = NULL;
>>       int i;
>>   
>>       for (i = smp_cpus - 1; i >= 0; i--) {
>> -        entry = g_new0(int64List, 1);
>> +        entry = g_new0(uint32List, 1);
>>           entry->value = ctx->vcpu_blocktime[i];
>>           entry->next = list;
>>           list = entry;
>> @@ -145,7 +147,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
>>       info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
>>   }
>>   
>> -static uint64_t get_postcopy_total_blocktime(void)
>> +static uint32_t get_postcopy_total_blocktime(void)
>>   {
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>       PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
>> @@ -610,6 +612,13 @@ static int get_mem_fault_cpu_index(uint32_t pid)
>>       return -1;
>>   }
>>   
>> +static uint32_t get_low_time_offset(PostcopyBlocktimeContext *dc)
>> +{
>> +    int64_t start_time_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
>> +                                    dc->start_time;
>> +    return start_time_offset < 1 ? 1 : start_time_offset & UINT32_MAX;
>> +}
>> +
>>   /*
>>    * This function is being called when pagefault occurs. It
>>    * tracks down vCPU blocking time.
>> @@ -624,7 +633,7 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>>       int cpu, already_received;
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>       PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>> -    int64_t now_ms;
>> +    uint32_t low_time_offset;
>>   
>>       if (!dc || ptid == 0) {
>>           return;
>> @@ -634,14 +643,14 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>>           return;
>>       }
>>   
>> -    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> +    low_time_offset = get_low_time_offset(dc);
>>       if (dc->vcpu_addr[cpu] == 0) {
>>           atomic_inc(&dc->smp_cpus_down);
>>       }
>>   
>> -    atomic_xchg__nocheck(&dc->last_begin, now_ms);
>> -    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
>> -    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
>> +    atomic_xchg(&dc->last_begin, low_time_offset);
>> +    atomic_xchg(&dc->page_fault_vcpu_time[cpu], low_time_offset);
>> +    atomic_xchg(&dc->vcpu_addr[cpu], addr);
>>   
>>       /* check it here, not at the begining of the function,
>>        * due to, check could accur early than bitmap_set in
>> @@ -688,22 +697,20 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>>       MigrationIncomingState *mis = migration_incoming_get_current();
>>       PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>>       int i, affected_cpu = 0;
>> -    int64_t now_ms;
>>       bool vcpu_total_blocktime = false;
>> -    int64_t read_vcpu_time;
>> +    uint32_t read_vcpu_time, low_time_offset;
>>   
>>       if (!dc) {
>>           return;
>>       }
>>   
>> -    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> -
>> +    low_time_offset = get_low_time_offset(dc);
>>       /* lookup cpu, to clear it,
>>        * that algorithm looks straighforward, but it's not
>>        * optimal, more optimal algorithm is keeping tree or hash
>>        * where key is address value is a list of  */
>>       for (i = 0; i < smp_cpus; i++) {
>> -        uint64_t vcpu_blocktime = 0;
>> +        uint32_t vcpu_blocktime = 0;
>>   
>>           read_vcpu_time = atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
>>           if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr ||
>> @@ -711,7 +718,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>>               continue;
>>           }
>>           atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
>> -        vcpu_blocktime = now_ms - read_vcpu_time;
>> +        vcpu_blocktime = low_time_offset - read_vcpu_time;
>>           affected_cpu += 1;
>>           /* we need to know is that mark_postcopy_end was due to
>>            * faulted page, another possible case it's prefetched
>> @@ -726,7 +733,8 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
>>   
>>       atomic_sub(&dc->smp_cpus_down, affected_cpu);
>>       if (vcpu_total_blocktime) {
>> -        dc->total_blocktime += now_ms - atomic_fetch_add(&dc->last_begin, 0);
>> +        dc->total_blocktime += low_time_offset - atomic_fetch_add(
>> +                &dc->last_begin, 0);
>>       }
>>       trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
>>                                         affected_cpu);
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 59b1a2d..def03c4 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -115,8 +115,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>>   process_incoming_migration_co_postcopy_end_main(void) ""
>>   migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>>   migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
>> -mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", cpu: %d, already_received: %d"
>> -mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", affected_cpu: %d"
>> +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d, already_received: %d"
>> +mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
>>   
>>   # migration/rdma.c
>>   qemu_rdma_accept_incoming_migration(void) ""
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 90d125c..c4737f8 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -175,8 +175,8 @@
>>              '*setup-time': 'int',
>>              '*cpu-throttle-percentage': 'int',
>>              '*error-desc': 'str',
>> -           '*postcopy-blocktime' : 'int64',
>> -           '*postcopy-vcpu-blocktime': ['int64']} }
>> +           '*postcopy-blocktime' : 'uint32',
>> +           '*postcopy-vcpu-blocktime': ['uint32']} }
>>   
>>   ##
>>   # @query-migrate:
>> -- 
>> 2.7.4
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>

-- 
Best regards,
Alexey Perevalov
