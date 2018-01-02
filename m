Received: from eggs.gnu.org ([2001:4830:134:3::10]:54216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWDRJ-0001JG-Am
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWDRG-0002wZ-8k
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:40:33 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eWDRG-0002vT-24
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:40:30 -0500
Received: by mail-pf0-x241.google.com with SMTP id a90so25196712pfk.1
	for <qemu-devel@nongnu.org>; Mon, 01 Jan 2018 19:40:29 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
	by smtp.googlemail.com with ESMTPSA id
	a87sm90721123pfg.159.2018.01.01.19.40.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Jan 2018 19:40:27 -0800 (PST)
References: <20171215052326.21386-1-aik@ozlabs.ru>
	<20171215094623.bp3ettoza5llp6vv@starbug-vm.ie.oracle.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <60e3a5ae-60e2-7de3-75b2-3d39ff4e4be1@ozlabs.ru>
Date: Tue, 2 Jan 2018 14:40:24 +1100
MIME-Version: 1.0
In-Reply-To: <20171215094623.bp3ettoza5llp6vv@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] kvm: Add kvm_set_user_memory
 tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 15/12/17 20:46, Darren Kenny wrote:
> On Fri, Dec 15, 2017 at 04:23:26PM +1100, Alexey Kardashevskiy wrote:
>> This adds a tracepoint to trace the KVM_SET_USER_MEMORY_REGION ioctl
>> parameters which is quite useful for debugging VFIO memory regions
>> being actually registered with KVM.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * added forgotten change to trace-events
>> ---
>> accel/kvm/kvm-all.c    | 6 +++++-
>> accel/kvm/trace-events | 1 +
>> 2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index f290f48..b91fcb7 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -235,6 +235,7 @@ static int
>> kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
>> {
>>     KVMState *s = kvm_state;
>>     struct kvm_userspace_memory_region mem;
>> +    int ret;
>>
>>     mem.slot = slot->slot | (kml->as_id << 16);
>>     mem.guest_phys_addr = slot->start_addr;
>> @@ -248,7 +249,10 @@ static int
>> kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot)
>>         kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>>     }
>>     mem.memory_size = slot->memory_size;
>> -    return kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>> +    ret = kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
>> +    trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
>> +                              mem.memory_size, mem.userspace_addr, ret);
>> +    return ret;
>> }
>>
>> int kvm_destroy_vcpu(CPUState *cpu)
>> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
>> index f89ba55..58e98ef 100644
>> --- a/accel/kvm/trace-events
>> +++ b/accel/kvm/trace-events
>> @@ -12,4 +12,5 @@ kvm_irqchip_commit_routes(void) ""
>> kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s
>> vector %d virq %d"
>> kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
>> kvm_irqchip_release_virq(int virq) "virq %d"
>> +kvm_set_user_memory(uint32_t slot, uint32_t flags, uint64_t
>> guest_phys_addr, uint64_t memory_size, uint64_t userspace_addr, int ret)
>> "Slot#%d flags=0x%x gpa=0x%"PRIx64 " size=0x%"PRIx64 " ua=0x%"PRIx64 "
>> ret=%d"
> 
> Should the slot not be %u?:
> 
>   "Slot#%u ...


Could be, repost?


> 
> Otherwise,
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 


-- 
Alexey
