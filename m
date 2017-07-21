Received: from eggs.gnu.org ([2001:4830:134:3::10]:52944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dYWzC-00008S-3K
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dYWz8-0001Vd-4c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:24:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dYWz7-0001RN-5v
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:24:46 -0400
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <5971F246.5080000@huawei.com>
Date: Fri, 21 Jul 2017 20:23:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170721094943.GC2133@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com

Hi Dave,

On 2017/7/21 17:49, Dr. David Alan Gilbert wrote:
> * Jay Zhou (jianjay.zhou@huawei.com) wrote:
>> Qemu_savevm_state_cleanup() takes about 300ms in my ram migration tests
>> with a 8U24G vm(20G is really occupied), the main cost comes from
>> KVM_SET_USER_MEMORY_REGION ioctl when mem.memory_size = 0 in
>> kvm_set_user_memory_region(). In kmod, the main cost is
>> kvm_zap_obsolete_pages(), which traverses the active_mmu_pages list to
>> zap the unsync sptes.
>
> Hi Jay,
>    Is this actually increasing the real downtime when the guest isn't
> running, or is it just the reported time? I see that the s->downtime
> value is calculated right after where we currently call
> qemu_savevm_state_cleanup.

It actually increased the real downtime, I used the "ping" command to
test. Reason is that the source side libvirt sends qmp to qemu to query
the status of migration, which needs the BQL. qemu_savevm_state_cleanup
is done with BQL, qemu can not handle the qmp if qemu_savevm_state_cleanup
has not finished. And the source side libvirt delays about 300ms to notify
the destination side libvirt to send the "cont" command to start the vm.

I think the value of s->downtime is not accurate enough, maybe we could
move the calculation of end_time after qemu_savevm_state_cleanup has done.

>    I guess the biggest problem is that 300ms happens before we restart
> the guest on the source if a migration fails.

300ms happens even if a migration succeeds.

>> I think it can be optimized:
>> (1) source vm will be destroyed if the migration is successfully done,
>>      so the resources will be cleanuped automatically by the system
>> (2) delay the cleanup if the migration failed
>
> I don't like putting it in qmp_cont; that shouldn't have migration magic
> in it.

Yes, it is not a ideal place. :(

> I guess we could put it in migrate_fd_cleanup perhaps? It gets called on
> a bh near the end -  or could we just move it closer to the end of
> migration_thread?

I have tested putting it in migrate_fd_cleanup, but the downtime is not
optimized. So I think it is the same to move it closer to the end of
migration_thread if it holds the BQL.
Could we put it in migrate_init?

Thanks,
Jay

> However, we would need to be a bit careful of anything that needs
> cleaning up before the source restarts on failure; I'm not sure of
> the semantics of all the current things wired into save_cleanup.
>
> Dave
>
>
>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>> ---
>>   migration/migration.c | 16 +++++++++-------
>>   qmp.c                 | 10 ++++++++++
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a0db40d..72832be 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1877,6 +1877,15 @@ static void *migration_thread(void *opaque)
>>           if (qemu_file_get_error(s->to_dst_file)) {
>>               migrate_set_state(&s->state, current_active_state,
>>                                 MIGRATION_STATUS_FAILED);
>> +            /*
>> +             * The resource has been allocated by migration will be reused in
>> +             * COLO process, so don't release them.
>> +             */
>> +            if (!enable_colo) {
>> +                qemu_mutex_lock_iothread();
>> +                qemu_savevm_state_cleanup();
>> +                qemu_mutex_unlock_iothread();
>> +            }
>>               trace_migration_thread_file_err();
>>               break;
>>           }
>> @@ -1916,13 +1925,6 @@ static void *migration_thread(void *opaque)
>>       end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>
>>       qemu_mutex_lock_iothread();
>> -    /*
>> -     * The resource has been allocated by migration will be reused in COLO
>> -     * process, so don't release them.
>> -     */
>> -    if (!enable_colo) {
>> -        qemu_savevm_state_cleanup();
>> -    }
>>       if (s->state == MIGRATION_STATUS_COMPLETED) {
>>           uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
>>           s->total_time = end_time - s->total_time;
>> diff --git a/qmp.c b/qmp.c
>> index b86201e..0e68eaa 100644
>> --- a/qmp.c
>> +++ b/qmp.c
>> @@ -37,6 +37,8 @@
>>   #include "qom/object_interfaces.h"
>>   #include "hw/mem/pc-dimm.h"
>>   #include "hw/acpi/acpi_dev_interface.h"
>> +#include "migration/migration.h"
>> +#include "migration/savevm.h"
>>
>>   NameInfo *qmp_query_name(Error **errp)
>>   {
>> @@ -200,6 +202,14 @@ void qmp_cont(Error **errp)
>>       if (runstate_check(RUN_STATE_INMIGRATE)) {
>>           autostart = 1;
>>       } else {
>> +        /*
>> +         * Delay the cleanup to reduce the downtime of migration.
>> +         * The resource has been allocated by migration will be reused
>> +         * in COLO process, so don't release them.
>> +         */
>> +        if (runstate_check(RUN_STATE_POSTMIGRATE) && !migrate_colo_enabled()) {
>> +            qemu_savevm_state_cleanup();
>> +        }
>>           vm_start();
>>       }
>>   }
>> --
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
