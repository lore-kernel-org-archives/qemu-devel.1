Received: from eggs.gnu.org ([2001:4830:134:3::10]:41424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dZuJG-0007eb-8g
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dZuJC-0000an-6o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:31:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1dZuJB-0000Zt-81
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:31:10 -0400
References: <1500522569-10760-1-git-send-email-jianjay.zhou@huawei.com>
	<20170721094943.GC2133@work-vm> <5971F246.5080000@huawei.com>
	<20170724153521.GD2127@work-vm>
	<9cea170f-90eb-78e5-6b52-8dd882efd160@redhat.com>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <5976F364.1050705@huawei.com>
Date: Tue, 25 Jul 2017 15:29:40 +0800
MIME-Version: 1.0
In-Reply-To: <9cea170f-90eb-78e5-6b52-8dd882efd160@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, rkrcmar@redhat.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, aarcange@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>


On 2017/7/25 0:33, Paolo Bonzini wrote:
> On 24/07/2017 17:35, Dr. David Alan Gilbert wrote:
>> * Jay Zhou (jianjay.zhou@huawei.com) wrote:
>>> Hi Dave,
>>>
>>> On 2017/7/21 17:49, Dr. David Alan Gilbert wrote:
>>>> * Jay Zhou (jianjay.zhou@huawei.com) wrote:
>>>>> Qemu_savevm_state_cleanup() takes about 300ms in my ram migration tests
>>>>> with a 8U24G vm(20G is really occupied), the main cost comes from
>>>>> KVM_SET_USER_MEMORY_REGION ioctl when mem.memory_size = 0 in
>>>>> kvm_set_user_memory_region(). In kmod, the main cost is
>>>>> kvm_zap_obsolete_pages(), which traverses the active_mmu_pages list to
>>>>> zap the unsync sptes.
>>>>
>>>> Hi Jay,
>>>>     Is this actually increasing the real downtime when the guest isn't
>>>> running, or is it just the reported time? I see that the s->downtime
>>>> value is calculated right after where we currently call
>>>> qemu_savevm_state_cleanup.
>>>
>>> It actually increased the real downtime, I used the "ping" command to
>>> test. Reason is that the source side libvirt sends qmp to qemu to query
>>> the status of migration, which needs the BQL. qemu_savevm_state_cleanup
>>> is done with BQL, qemu can not handle the qmp if qemu_savevm_state_cleanup
>>> has not finished. And the source side libvirt delays about 300ms to notify
>>> the destination side libvirt to send the "cont" command to start the vm.
>>>
>>> I think the value of s->downtime is not accurate enough, maybe we could
>>> move the calculation of end_time after qemu_savevm_state_cleanup has done.
>>
>> I'm copying in Paolo, Radim and Andrea- is there anyway we can make the
>> teardown of KVMs dirty tracking not take so long? 300ms is a silly long time
>> on only a small VM.
>
> Xiao Guangrong is working on something vaguely related (but different
> and simpler because it's entirely contained within KVM), which is to
> make log_sync faster.
>
> The Intel folks working on clear containers also would like
> MemoryListeners to have a better complexity, but that's again separate
> from the "zapping" of SPTEs.
>
>> Can you tell me which version of libvirt you're using?
>> I thought the newer ones were supposed to use events so they did't
>> have to poll qemu.
>>
>>   If we move qemu_savevm_state_cleanup is it still safe? Are there
>> some things we're supposed to do at that point which are wrong if
>> we don't.
>>
>> I wonder about something like;  take a mutex in
>> memory_global_dirty_log_start, release it in
>> memory_global_dirty_log_stop.  Then make ram_save_cleanup start
>> a new thread that does the call to memory_global_dirty_log_stop.
>
> I don't like having such a long-lived mutex (it seems like a recipe for
> deadlocks with the BQL), plus memory_region_transaction_commit (the
> expensive part of memory_global_dirty_log_stop) needs to be under the
> BQL itself because it calls MemoryListeners.
>
> Maybe memory_global_dirty_log_stop can delay itself to the next vm_start
> if it's called while runstate_running() returns false (which should be
> always the case)?

It is logical, but then we need to put some migration related codes into
the file of cpus.c(in my patch, I put some codes into the file of qmp.c),
is there any elegant way to reduce the coupling?

Thanks,
Jay

> It could even be entirely enclosed within memory.c if you do it with a
> VMChangeStateHandler.
>
> Thanks,
>
> Paolo
>
>> Dave
>>
>>> Thanks,
>>> Jay
>>>
>>>> However, we would need to be a bit careful of anything that needs
>>>> cleaning up before the source restarts on failure; I'm not sure of
>>>> the semantics of all the current things wired into save_cleanup.
>>>>
>>>> Dave
>>>>
>>>>
>>>>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>>>>> ---
>>>>>    migration/migration.c | 16 +++++++++-------
>>>>>    qmp.c                 | 10 ++++++++++
>>>>>    2 files changed, 19 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index a0db40d..72832be 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -1877,6 +1877,15 @@ static void *migration_thread(void *opaque)
>>>>>            if (qemu_file_get_error(s->to_dst_file)) {
>>>>>                migrate_set_state(&s->state, current_active_state,
>>>>>                                  MIGRATION_STATUS_FAILED);
>>>>> +            /*
>>>>> +             * The resource has been allocated by migration will be reused in
>>>>> +             * COLO process, so don't release them.
>>>>> +             */
>>>>> +            if (!enable_colo) {
>>>>> +                qemu_mutex_lock_iothread();
>>>>> +                qemu_savevm_state_cleanup();
>>>>> +                qemu_mutex_unlock_iothread();
>>>>> +            }
>>>>>                trace_migration_thread_file_err();
>>>>>                break;
>>>>>            }
>>>>> @@ -1916,13 +1925,6 @@ static void *migration_thread(void *opaque)
>>>>>        end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>>>
>>>>>        qemu_mutex_lock_iothread();
>>>>> -    /*
>>>>> -     * The resource has been allocated by migration will be reused in COLO
>>>>> -     * process, so don't release them.
>>>>> -     */
>>>>> -    if (!enable_colo) {
>>>>> -        qemu_savevm_state_cleanup();
>>>>> -    }
>>>>>        if (s->state == MIGRATION_STATUS_COMPLETED) {
>>>>>            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
>>>>>            s->total_time = end_time - s->total_time;
>>>>> diff --git a/qmp.c b/qmp.c
>>>>> index b86201e..0e68eaa 100644
>>>>> --- a/qmp.c
>>>>> +++ b/qmp.c
>>>>> @@ -37,6 +37,8 @@
>>>>>    #include "qom/object_interfaces.h"
>>>>>    #include "hw/mem/pc-dimm.h"
>>>>>    #include "hw/acpi/acpi_dev_interface.h"
>>>>> +#include "migration/migration.h"
>>>>> +#include "migration/savevm.h"
>>>>>
>>>>>    NameInfo *qmp_query_name(Error **errp)
>>>>>    {
>>>>> @@ -200,6 +202,14 @@ void qmp_cont(Error **errp)
>>>>>        if (runstate_check(RUN_STATE_INMIGRATE)) {
>>>>>            autostart = 1;
>>>>>        } else {
>>>>> +        /*
>>>>> +         * Delay the cleanup to reduce the downtime of migration.
>>>>> +         * The resource has been allocated by migration will be reused
>>>>> +         * in COLO process, so don't release them.
>>>>> +         */
>>>>> +        if (runstate_check(RUN_STATE_POSTMIGRATE) && !migrate_colo_enabled()) {
>>>>> +            qemu_savevm_state_cleanup();
>>>>> +        }
>>>>>            vm_start();
>>>>>        }
>>>>>    }
>>>>> --
>>>>> 1.8.3.1
>>>>>
>>>>>
>>>> --
>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>
>>>> .
>>>>
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>
>
> .
>
