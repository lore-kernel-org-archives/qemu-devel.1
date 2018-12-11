Received: from eggs.gnu.org ([2001:4830:134:3::10]:53816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWXuJ-0005r6-1j
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gWXuF-0001hh-1w
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:36:22 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gWXuE-0001h3-LX
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:36:18 -0500
Received: by mail-pg1-x543.google.com with SMTP id z11so5922409pgu.0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 18:36:17 -0800 (PST)
References: <20181108010258.27010-1-aik@ozlabs.ru>
	<20181113145124.GA2542@work-vm>
	<b5e3298e-66da-ff99-dd45-26211c1f7ff9@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1e75e001-eae5-0d4b-6f0d-8ee0516c17f3@ozlabs.ru>
Date: Tue, 11 Dec 2018 13:36:12 +1100
MIME-Version: 1.0
In-Reply-To: <b5e3298e-66da-ff99-dd45-26211c1f7ff9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] hmp: Print if memory section is
 registered in KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org



On 14/11/2018 02:56, Paolo Bonzini wrote:
> On 13/11/2018 15:51, Dr. David Alan Gilbert wrote:
>> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
>>> This adds a "KVM" marker to the "into mtree -f" to tell the user if
>>> a particular memory section is registered as a KVM memory slot; useful
>>> for debugging purposes.
>>>
>>> Since it is memory sections which get registered in KVM (rather than
>>> memory regions), this only prints "KVM" for flatviews.
>>>
>>> For example:
>>>  Root memory region: system
>>>   0000000000000000-00000003ffffffff (prio 0, ram): ppc_spapr.ram KVM
>>>   0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> From HMP I'm ok with this, but I wonder if we should make this
>> code more general to other accelerators and not specific to kvm?
> 
> Can't this be derived from the type (ram, i/o, ...)?


Sorry for the delay with the response.

Derived what? "ramd" is usually KVM but not always if we emulate a
portion of it (a bit of MMIO space from VFIO quirks, for example), and
we could do this to "ram" as well, I just do not have an example handy.

I tried to hack it. I basically need a way to tell in
mtree_print_flatview() if a specific FlatRange is "accelerated.

Option1:
- add FlatRange to MemoryRegionSection (MRSs are always local, FRs are
permanent);
- change kvm_set_phys_mem() to store accelerator in mrs->FlatRange;
- print FlatView->FlatRange->accel name.
Pro: fast - no additional lookups;
Con: accel/kvm/kvm-all.c needs to know the FlatRange definition which is
too invasive for such a small task.


Option2:
- replace global is_kvm_memory() with AccelClass::is_memory_registered();
- define the callback for KVM;
- call that from mtree_print_flatview().
Pro: no touching FlatRange/MemoryRegionSection structures.
Con: suboptimal but we probably do not care as much.


Or have I missed something? Thanks,


> 
> Paolo
> 
>>
>> Dave
>>
>>> ---
>>>  include/sysemu/kvm.h |  1 +
>>>  accel/kvm/kvm-all.c  |  7 +++++++
>>>  memory.c             | 10 ++++++++++
>>>  3 files changed, 18 insertions(+)
>>>
>>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>>> index 97d8d9d0d5..9eab5ac1b1 100644
>>> --- a/include/sysemu/kvm.h
>>> +++ b/include/sysemu/kvm.h
>>> @@ -471,6 +471,7 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>>>  #if !defined(CONFIG_USER_ONLY)
>>>  int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>>>                                         hwaddr *phys_addr);
>>> +bool is_kvm_memory(hwaddr start_addr, hwaddr size);
>>>  #endif
>>>  
>>>  #endif /* NEED_CPU_H */
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 4880a05399..d72808aaa6 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -216,6 +216,13 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
>>>      return NULL;
>>>  }
>>>  
>>> +bool is_kvm_memory(hwaddr start_addr, hwaddr size)
>>> +{
>>> +    KVMMemoryListener *kml = &kvm_state->memory_listener;
>>> +
>>> +    return NULL != kvm_lookup_matching_slot(kml, start_addr, size);
>>> +}
>>> +
>>>  /*
>>>   * Calculate and align the start address and the size of the section.
>>>   * Return the size. If the size is 0, the aligned section is empty.
>>> diff --git a/memory.c b/memory.c
>>> index 51204aa079..56c733c687 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -2916,6 +2916,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>      int n = view->nr;
>>>      int i;
>>>      AddressSpace *as;
>>> +    bool print_kvm = false;
>>>  
>>>      p(f, "FlatView #%d\n", fvi->counter);
>>>      ++fvi->counter;
>>> @@ -2927,6 +2928,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>              p(f, ", alias %s", memory_region_name(as->root->alias));
>>>          }
>>>          p(f, "\n");
>>> +        if (as == &address_space_memory) {
>>> +            print_kvm = true;
>>> +        }
>>>      }
>>>  
>>>      p(f, " Root memory region: %s\n",
>>> @@ -2960,6 +2964,12 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>          if (fvi->owner) {
>>>              mtree_print_mr_owner(p, f, mr);
>>>          }
>>> +
>>> +        if (kvm_enabled() && print_kvm &&
>>> +            is_kvm_memory(int128_get64(range->addr.start),
>>> +                          MR_SIZE(range->addr.size) + 1)) {
>>> +            p(f, " KVM");
>>> +        }
>>>          p(f, "\n");
>>>          range++;
>>>      }
>>> -- 
>>> 2.17.1
>>>
>>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
> 

-- 
Alexey
