Received: from eggs.gnu.org ([209.51.188.92]:44143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJAWR-0002AD-SQ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hJAWQ-0007L1-3h
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:32:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hJAWP-0007I3-GI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:32:42 -0400
Received: by mail-pl1-x642.google.com with SMTP id w24so8685532plp.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 22:32:40 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20181214025849.84274-1-aik@ozlabs.ru>
	<8727c6e5-006c-20e5-cb6b-be525154e184@redhat.com>
	<bda42f7c-9068-3c4d-d839-7f6c52561cc9@ozlabs.ru>
	<69a29694-b777-721a-eafd-4ff38c457f6d@redhat.com>
	<db36d006-3bdc-47fe-9987-519440446c4e@ozlabs.ru>
	<20190103173753.GJ2316@work-vm>
	<d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
	<20190207114953.GB2773@work-vm>
	<16486ff4-eb62-b4f2-78f8-a1ec7e3fbb0b@redhat.com>
	<30a5a208-249f-106e-f885-94caf9b82970@ozlabs.ru>
	<f346fdcb-1849-3397-7f4c-2d6ee07fcd7c@ozlabs.ru>
Message-ID: <aca6d2ae-806f-55b3-d9d5-f5a2cfd760b9@ozlabs.ru>
Date: Wed, 24 Apr 2019 15:32:34 +1000
MIME-Version: 1.0
In-Reply-To: <f346fdcb-1849-3397-7f4c-2d6ee07fcd7c@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] hmp: Print if memory section is
 registered with an accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>

Paolo, ping?


On 19/03/2019 18:05, Alexey Kardashevskiy wrote:
> 
> 
> On 11/02/2019 15:56, Alexey Kardashevskiy wrote:
>>
>>
>> On 09/02/2019 04:26, Paolo Bonzini wrote:
>>> On 07/02/19 12:49, Dr. David Alan Gilbert wrote:
>>>>  //#define DEBUG_UNASSIGNED
>>>> @@ -2924,6 +2926,8 @@ struct FlatViewInfo {
>>>>      int counter;
>>>>      bool dispatch_tree;
>>>>      bool owner;
>>>> +    AccelClass *ac;
>>>> +    const char *ac_name;
>>>>  };
>>>>  
>>>>  static void mtree_print_flatview(gpointer key, gpointer value,
>>>> @@ -2939,6 +2943,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>      int n = view->nr;
>>>>      int i;
>>>>      AddressSpace *as;
>>>> +    bool system_as = false;
>>>>  
>>>>      p(f, "FlatView #%d\n", fvi->counter);
>>>>      ++fvi->counter;
>>>> @@ -2950,6 +2955,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>              p(f, ", alias %s", memory_region_name(as->root->alias));
>>>>          }
>>>>          p(f, "\n");
>>>> +        if (as == &address_space_memory) {
>>>> +            system_as = true;
>>>> +        }
>>>>      }
>>>>  
>>>>      p(f, " Root memory region: %s\n",
>>>> @@ -2985,6 +2993,13 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>          if (fvi->owner) {
>>>>              mtree_print_mr_owner(p, f, mr);
>>>>          }
>>>> +
>>>> +        if (system_as && fvi->ac &&
>>>> +            fvi->ac->has_memory(current_machine,
>>>> +                                int128_get64(range->addr.start),
>>>> +                                MR_SIZE(range->addr.size) + 1)) {
>>>> +            p(f, " %s", fvi->ac_name);
>>>
>>> I don't understand this.  This doesn't check that the memory range
>>> actually matches the memory registered with the accelerator, only that
>>> there is something in that range. 
>>
>>
>> It is checking that a flat range (i.e. what actually works) has a
>> corresponding KVM slot:
>> https://git.qemu.org/?p=qemu.git;a=blob;f=accel/kvm/kvm-all.c;h=4e1de942ce554c734ac2673030031c228a752ac9;hb=HEAD#l201
>>
>>
>>> Why isn't it enough to use "info
>>> mtree" and look at the KVM address space?
>>
>>
>> There is no such thing in my QEMU, did you mean "KVM-SMRAM" (which is
>> missing on spapr)? I am not sure I understand its purpose for the task -
>> it prints all same ranges on my x86 laptop, not just ones which we told
>> KVM about.
>>
>> My task is that if let's say "0000:00:1a.0 BAR 0 mmaps[0]" is split into
>> several sections because MSIX happens to be in a middle of that BAR and
>> it is not system page size aligned, then it is going to be several
>> ranges with no clear indication whether or not these were registered as
>> KVM slots. A memory chunk can be "ram" and not a KVM slot if it is 4K on
>> PPC with 64K system pages, for example.
>>
>>
>> FlatView #0
>>  AS "memory", root: system
>>  AS "cpu-memory-0", root: system
>>  AS "cpu-memory-1", root: system
>>  AS "cpu-memory-2", root: system
>>  AS "cpu-memory-3", root: system
>>  AS "piix3-ide", root: bus master container
>>  AS "virtio-net-pci", root: bus master container
>>  AS "vfio-pci", root: bus master container
>>  Root memory region: system
>>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram kvm
>>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram
>> @00000000000c0000 kvm
>>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram
>> @00000000000c1000 kvm
>>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram
>> @00000000000c4000 kvm
>>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram
>> @00000000000e8000 kvm
>>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram
>> @00000000000f0000 kvm
>>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram
>> @0000000000100000 kvm
>>   00000000febc0000-00000000febc0fff (prio 0, ramd): 0000:00:1a.0 BAR 0
>> mmaps[0] kvm
>>   00000000febc1000-00000000febc102f (prio 0, i/o): msix-table
>>   00000000febc1800-00000000febc1807 (prio 0, i/o): msix-pba
>>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
>>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
>>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
>>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
>>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios kvm
>>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram
>> @00000000c0000000 kvm
>>
>>
>>
>> FlatView #3
>>  AS "KVM-SMRAM", root: mem-container-smram
>>  Root memory region: mem-container-smram
>>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram
>>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram @00000000000c0000
>>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram @00000000000c1000
>>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram @00000000000c4000
>>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram @00000000000e8000
>>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram @00000000000f0000
>>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram @0000000000100000
>>   00000000febc0000-00000000febc0fff (prio 0, ramd): 0000:00:1a.0 BAR 0
>> mmaps[0]
>>   00000000febc1000-00000000febc102f (prio 0, i/o): msix-table
>>   00000000febc1800-00000000febc1807 (prio 0, i/o): msix-pba
>>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
>>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
>>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
>>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
>>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram @00000000c0000000
>>
>>
>>
>>
>>> Perhaps you could add instead an argument to "info mtree" that prints
>>> only the AddressSpace with a given name?
>>
>> Nah, this is not what it is about.
> 
> 
> 
> Still a nack? :)



-- 
Alexey
