Received: from eggs.gnu.org ([2001:4830:134:3::10]:37241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ef6se-0000Gw-F9
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ef6sZ-0005UU-GB
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:29:32 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35599)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1ef6sY-0005TO-Ke
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:29:27 -0500
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <a3ff0fd0-306f-788d-c2f4-d67a2c20e759@samsung.com>
Date: Fri, 26 Jan 2018 19:29:20 +0300
In-reply-to: <73901dff-4a71-bb97-6769-70a54f03aa5a@amsat.org>
Content-language: en-GB
References: <1516982720-26501-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180126160531eucas1p2e972758feaca9f6d174e6399aca78c81@eucas1p2.samsung.com>
	<1516982720-26501-2-git-send-email-a.perevalov@samsung.com>
	<73901dff-4a71-bb97-6769-70a54f03aa5a@amsat.org>
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: lvivier@redhat.com, peterx@redhat.com, quintela@redhat.com, ash.billore@samsung.com

On 01/26/2018 07:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Alexey,
>
> On 01/26/2018 01:05 PM, Alexey Perevalov wrote:
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
>> ---
>>   hmp.c                    |  4 ++--
>>   migration/postcopy-ram.c | 37 ++++++++++++++++++++-----------------
>>   migration/trace-events   |  4 ++--
>>   qapi/migration.json      |  4 ++--
>>   4 files changed, 26 insertions(+), 23 deletions(-)
>>
>> diff --git a/hmp.c b/hmp.c
>> index c6bab53..3c376b3 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -265,7 +265,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *q=
dict)
>>       }
>>  =20
>>       if (info->has_postcopy_blocktime) {
>> -        monitor_printf(mon, "postcopy blocktime: %" PRId64 "\n",
>> +        monitor_printf(mon, "postcopy blocktime: %u\n",
>>                          info->postcopy_blocktime);
>>       }
>>  =20
>> @@ -273,7 +273,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *q=
dict)
>>           Visitor *v;
>>           char *str;
>>           v =3D string_output_visitor_new(false, &str);
>> -        visit_type_int64List(v, NULL, &info->postcopy_vcpu_blocktime,=
 NULL);
>> +        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime=
, NULL);
>>           visit_complete(v, &str);
>>           monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
>>           g_free(str);
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 7814da5..bd08c24 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -63,14 +63,14 @@ struct PostcopyDiscardState {
>>  =20
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
>>  =20
>> @@ -99,22 +99,22 @@ static void migration_exit_cb(Notifier *n, void *d=
ata)
>>   static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>>   {
>>       PostcopyBlocktimeContext *ctx =3D g_new0(PostcopyBlocktimeContex=
t, 1);
>> -    ctx->page_fault_vcpu_time =3D g_new0(int64_t, smp_cpus);
>> +    ctx->page_fault_vcpu_time =3D g_new0(uint32_t, smp_cpus);
>>       ctx->vcpu_addr =3D g_new0(uintptr_t, smp_cpus);
>> -    ctx->vcpu_blocktime =3D g_new0(int64_t, smp_cpus);
>> +    ctx->vcpu_blocktime =3D g_new0(uint32_t, smp_cpus);
>>  =20
>>       ctx->exit_notifier.notify =3D migration_exit_cb;
>>       qemu_add_exit_notifier(&ctx->exit_notifier);
>>       return ctx;
>>   }
>>  =20
>> -static int64List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *c=
tx)
>> +static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *=
ctx)
>>   {
>> -    int64List *list =3D NULL, *entry =3D NULL;
>> +    uint32List *list =3D NULL, *entry =3D NULL;
>>       int i;
>>  =20
>>       for (i =3D smp_cpus - 1; i >=3D 0; i--) {
>> -        entry =3D g_new0(int64List, 1);
>> +        entry =3D g_new0(uint32List, 1);
>>           entry->value =3D ctx->vcpu_blocktime[i];
>>           entry->next =3D list;
>>           list =3D entry;
>> @@ -145,7 +145,7 @@ void fill_destination_postcopy_migration_info(Migr=
ationInfo *info)
>>       info->postcopy_vcpu_blocktime =3D get_vcpu_blocktime_list(bc);
>>   }
>>  =20
>> -static uint64_t get_postcopy_total_blocktime(void)
>> +static uint32_t get_postcopy_total_blocktime(void)
>>   {
>>       MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
>>       PostcopyBlocktimeContext *bc =3D mis->blocktime_ctx;
>> @@ -634,6 +634,7 @@ static void mark_postcopy_blocktime_begin(uintptr_=
t addr, uint32_t ptid,
>>       MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
>>       PostcopyBlocktimeContext *dc =3D mis->blocktime_ctx;
>>       int64_t now_ms;
>> +    uint32_t least_now;
>>  =20
>>       if (!dc || ptid =3D=3D 0) {
>>           return;
>> @@ -644,13 +645,14 @@ static void mark_postcopy_blocktime_begin(uintpt=
r_t addr, uint32_t ptid,
>>       }
>>  =20
>>       now_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> +    least_now =3D (uint32_t)now_ms;
>>       if (dc->vcpu_addr[cpu] =3D=3D 0) {
>>           atomic_inc(&dc->smp_cpus_down);
>>       }
>>  =20
>> -    atomic_xchg__nocheck(&dc->last_begin, now_ms);
>> -    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
>> -    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
>> +    atomic_xchg(&dc->last_begin, least_now);
>> +    atomic_xchg(&dc->page_fault_vcpu_time[cpu], least_now);
>> +    atomic_xchg(&dc->vcpu_addr[cpu], addr);
>>  =20
>>       /* check it here, not at the begining of the function,
>>        * due to, check could accur early than bitmap_set in
>> @@ -699,20 +701,21 @@ static void mark_postcopy_blocktime_end(uintptr_=
t addr)
>>       int i, affected_cpu =3D 0;
>>       int64_t now_ms;
>>       bool vcpu_total_blocktime =3D false;
>> -    int64_t read_vcpu_time;
>> +    uint32_t read_vcpu_time, least_now;
>>  =20
>>       if (!dc) {
>>           return;
>>       }
>>  =20
>>       now_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> +    least_now =3D now_ms & 0xffffffff;
> This might deserve a comment.
>
> I also find using UINT32_MAX clearer.
yes, thanks, I'll use named constant.
>>  =20
>>       /* lookup cpu, to clear it,
>>        * that algorithm looks straighforward, but it's not
>>        * optimal, more optimal algorithm is keeping tree or hash
>>        * where key is address value is a list of  */
>>       for (i =3D 0; i < smp_cpus; i++) {
>> -        uint64_t vcpu_blocktime =3D 0;
>> +        uint32_t vcpu_blocktime =3D 0;
>>  =20
>>           read_vcpu_time =3D atomic_fetch_add(&dc->page_fault_vcpu_tim=
e[i], 0);
>>           if (atomic_fetch_add(&dc->vcpu_addr[i], 0) !=3D addr ||
>> @@ -720,7 +723,7 @@ static void mark_postcopy_blocktime_end(uintptr_t =
addr)
>>               continue;
>>           }
>>           atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
>> -        vcpu_blocktime =3D now_ms - read_vcpu_time;
>> +        vcpu_blocktime =3D least_now - read_vcpu_time;
>>           affected_cpu +=3D 1;
>>           /* we need to know is that mark_postcopy_end was due to
>>            * faulted page, another possible case it's prefetched
>> @@ -735,7 +738,7 @@ static void mark_postcopy_blocktime_end(uintptr_t =
addr)
>>  =20
>>       atomic_sub(&dc->smp_cpus_down, affected_cpu);
>>       if (vcpu_total_blocktime) {
>> -        dc->total_blocktime +=3D now_ms - atomic_fetch_add(&dc->last_=
begin, 0);
>> +        dc->total_blocktime +=3D least_now - atomic_fetch_add(&dc->la=
st_begin, 0);
>>       }
>>       trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
>>                                         affected_cpu);
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 141e773..0defbc3 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -115,8 +115,8 @@ process_incoming_migration_co_end(int ret, int ps)=
 "ret=3D%d postcopy-state=3D%d"
>>   process_incoming_migration_co_postcopy_end_main(void) ""
>>   migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=3D=
%p ioctype=3D%s"
>>   migration_set_outgoing_channel(void *ioc, const char *ioctype, const=
 char *hostname)  "ioc=3D%p ioctype=3D%s hostname=3D%s"
>> -mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, =
int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", c=
pu: %d, already_received: %d"
>> -mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time, in=
t affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", affected=
_cpu: %d"
>> +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time,=
 int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d, =
already_received: %d"
>> +mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, i=
nt affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d=
"
>>  =20
>>   # migration/rdma.c
>>   qemu_rdma_accept_incoming_migration(void) ""
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 70e7b67..ee55d7c 100644
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
>>  =20
>>   ##
>>   # @query-migrate:
>>
>
>

--=20
Best regards,
Alexey Perevalov
