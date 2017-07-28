Received: from eggs.gnu.org ([2001:4830:134:3::10]:46275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1daykZ-0002wo-Ub
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1daykW-0005zk-Gk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:27:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1daykV-0005uL-TI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:27:48 -0400
References: <1501122974-18860-1-git-send-email-jianjay.zhou@huawei.com>
	<5c0789ef-9c29-b867-5e84-8624d04c16cc@redhat.com>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <597AD8F3.3020702@huawei.com>
Date: Fri, 28 Jul 2017 14:25:55 +0800
MIME-Version: 1.0
In-Reply-To: <5c0789ef-9c29-b867-5e84-8624d04c16cc@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] migration: optimize the downtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, arei.gonglei@huawei.com, zhang.zhanghailiang@huawei.com, wangxinxin.wang@huawei.com, weidong.huang@huawei.com, xiaoguangrong@tencent.com, jdenemar@redhat.com, huangzhichao@huawei.com

Hi Paolo,

On 2017/7/27 22:15, Paolo Bonzini wrote:
> On 27/07/2017 04:36, Jay Zhou wrote:
>> Qemu_savevm_state_cleanup takes about 300ms in my ram migration tests
>> with a 8U24G vm(20G is really occupied), the main cost comes from
>> KVM_SET_USER_MEMORY_REGION ioctl when mem.memory_size = 0 in
>> kvm_set_user_memory_region. In kmod, the main cost is
>> kvm_zap_obsolete_pages, which traverses the active_mmu_pages list to
>> zap the unsync sptes.
>>
>> It can be optimized by delaying memory_global_dirty_log_stop to the next
>> vm_start.
>>
>> Changes v1->v2:
>>   - create a VMChangeStateHandler in memory.c to reduce the coupling [Paolo]
>>
>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>
> memory_vm_change_state_handler should delete the handler.
>
> Apart from that, because there is no protection against nested
> invocations of memory_global_dirty_log_start/stop, a little more work is
> needed.

Thank for your patience and pointing everything out, I will fix all of them.

Jay

>> ---
>>   memory.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/memory.c b/memory.c
>> index a7bc70a..4c22b7e 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -2357,8 +2357,14 @@ void memory_global_dirty_log_sync(void)
>>       }
>>   }
>>
>> +static VMChangeStateEntry *vmstate_change;
>> +
>>   void memory_global_dirty_log_start(void)
>>   {
>> +    if (vmstate_change) {
>> +        qemu_del_vm_change_state_handler(vmstate_change);
>
> This should also NULL vmstate_change, so that you can detect the case
> where the handler is already installed.
>
>> +    }
>> +
>>       global_dirty_log = true;
>>
>>       MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>> @@ -2369,7 +2375,7 @@ void memory_global_dirty_log_start(void)
>>       memory_region_transaction_commit();
>>   }
>>
>> -void memory_global_dirty_log_stop(void)
>> +static void memory_global_dirty_log_do_stop(void)
>>   {
>>       global_dirty_log = false;
>>
>> @@ -2381,6 +2387,25 @@ void memory_global_dirty_log_stop(void)
>>       MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
>>   }
>>
>> +static void memory_vm_change_state_handler(void *opaque, int running,
>> +                                           RunState state)
>> +{
>> +    if (running) {
>> +        memory_global_dirty_log_do_stop();
>
> Because this will delete the handler, it should also NULL vmstate_change.
>
>> +    }
>> +}
>> +
>> +void memory_global_dirty_log_stop(void)
>> +{
>> +    if (!runstate_is_running()) {
>> +        vmstate_change = qemu_add_vm_change_state_handler(
>> +                                memory_vm_change_state_handler, NULL);
>
> And this needs to exit immediately if you have an installed handler.
>
> Thanks,
>
> Paolo
>
>> +        return;
>> +    }
>> +
>> +    memory_global_dirty_log_do_stop();
>> +}
>> +
>>   static void listener_add_address_space(MemoryListener *listener,
>>                                          AddressSpace *as)
>>   {
>>
>
>
> .
>
