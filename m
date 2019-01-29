Received: from eggs.gnu.org ([209.51.188.92]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goJAq-0001je-2S
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1goJAo-0002oi-Ci
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:30:52 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1goJAn-0002nj-Q3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 21:30:50 -0500
Received: by mail-pg1-x541.google.com with SMTP id g189so8087884pgc.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 18:30:49 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20181214025849.84274-1-aik@ozlabs.ru>
	<8727c6e5-006c-20e5-cb6b-be525154e184@redhat.com>
	<bda42f7c-9068-3c4d-d839-7f6c52561cc9@ozlabs.ru>
	<69a29694-b777-721a-eafd-4ff38c457f6d@redhat.com>
	<db36d006-3bdc-47fe-9987-519440446c4e@ozlabs.ru>
	<20190103173753.GJ2316@work-vm>
	<d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
Message-ID: <b18fb294-c213-3183-7c92-3653674d4d80@ozlabs.ru>
Date: Tue, 29 Jan 2019 13:30:42 +1100
MIME-Version: 1.0
In-Reply-To: <d4b8695c-3d37-ba92-d62b-e067b77274c8@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb413@gmail.com>



On 14/01/2019 12:43, Alexey Kardashevskiy wrote:
> 
> 
> On 04/01/2019 04:37, Dr. David Alan Gilbert wrote:
>> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
>>>
>>>
>>> On 17/12/2018 23:47, Philippe Mathieu-Daudé wrote:
>>>> On 12/17/18 2:27 AM, Alexey Kardashevskiy wrote:
>>>>> On 14/12/2018 22:07, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Alexey,
>>>>>>
>>>>>> On 12/14/18 3:58 AM, Alexey Kardashevskiy wrote:
>>>>>>> This adds an accelerator name to the "into mtree -f" to tell the user if
>>>>>>> a particular memory section is registered with the accelerator;
>>>>>>> the primary user for this is KVM and such information is useful
>>>>>>> for debugging purposes.
>>>>>>>
>>>>>>> This adds a has_memory() callback to the accelerator class allowing any
>>>>>>> accelerator to have a label in that memory tree dump.
>>>>>>>
>>>>>>> Since memory sections are passed to memory listeners and get registered
>>>>>>> in accelerators (rather than memory regions), this only prints new labels
>>>>>>> for flatviews attached to the system address space.
>>>>>>>
>>>>>>> An example:
>>>>>>>  Root memory region: system
>>>>>>>   0000000000000000-0000002fffffffff (prio 0, ram): /objects/mem0 kvm
>>>>>>>   0000003000000000-0000005fffffffff (prio 0, ram): /objects/mem1 kvm
>>>>>>>   0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
>>>>>>>   0000200080000000-000020008000003f (prio 0, i/o): capabilities
>>>>>>>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>> ---
>>>>>>>
>>>>>>> This supercedes "[PATCH qemu] hmp: Print if memory section is registered in KVM"
>>>>>>>
>>>>>>> ---
>>>>>>> Changes:
>>>>>>> v2:
>>>>>>> * added an accelerator callback instead of hardcoding it to kvm only
>>>>>>> ---
>>>>>>>  include/sysemu/accel.h |  2 ++
>>>>>>>  accel/kvm/kvm-all.c    | 10 ++++++++++
>>>>>>>  memory.c               | 22 ++++++++++++++++++++++
>>>>>>>  3 files changed, 34 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
>>>>>>> index 637358f..30b456d 100644
>>>>>>> --- a/include/sysemu/accel.h
>>>>>>> +++ b/include/sysemu/accel.h
>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>  
>>>>>>>  #include "qom/object.h"
>>>>>>>  #include "hw/qdev-properties.h"
>>>>>>> +#include "exec/hwaddr.h"
>>>>>>>  
>>>>>>>  typedef struct AccelState {
>>>>>>>      /*< private >*/
>>>>>>> @@ -41,6 +42,7 @@ typedef struct AccelClass {
>>>>>>>      int (*available)(void);
>>>>>>>      int (*init_machine)(MachineState *ms);
>>>>>>>      void (*setup_post)(MachineState *ms, AccelState *accel);
>>>>>>> +    bool (*has_memory)(MachineState *ms, hwaddr start_addr, hwaddr size);
>>>>>>>      bool *allowed;
>>>>>>>      /*
>>>>>>>       * Array of global properties that would be applied when specific
>>>>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>>>>> index 4880a05..634f386 100644
>>>>>>> --- a/accel/kvm/kvm-all.c
>>>>>>> +++ b/accel/kvm/kvm-all.c
>>>>>>> @@ -2589,11 +2589,21 @@ int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target)
>>>>>>>      return r;
>>>>>>>  }
>>>>>>>  
>>>>>>> +static bool kvm_accel_has_memory(MachineState *ms, hwaddr start_addr,
>>>>>>> +                                 hwaddr size)
>>>>>>> +{
>>>>>>> +    KVMState *kvm = KVM_STATE(ms->accelerator);
>>>>>>> +    KVMMemoryListener *kml = &kvm->memory_listener;
>>>>>>> +
>>>>>>> +    return NULL != kvm_lookup_matching_slot(kml, start_addr, size);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static void kvm_accel_class_init(ObjectClass *oc, void *data)
>>>>>>>  {
>>>>>>>      AccelClass *ac = ACCEL_CLASS(oc);
>>>>>>>      ac->name = "KVM";
>>>>>>>      ac->init_machine = kvm_init;
>>>>>>> +    ac->has_memory = kvm_accel_has_memory;
>>>>>>>      ac->allowed = &kvm_allowed;
>>>>>>>  }
>>>>>>>  
>>>>>>> diff --git a/memory.c b/memory.c
>>>>>>> index d14c6de..61e758a 100644
>>>>>>> --- a/memory.c
>>>>>>> +++ b/memory.c
>>>>>>> @@ -29,7 +29,9 @@
>>>>>>>  #include "exec/ram_addr.h"
>>>>>>>  #include "sysemu/kvm.h"
>>>>>>>  #include "sysemu/sysemu.h"
>>>>>>> +#include "sysemu/accel.h"
>>>>>>>  #include "hw/qdev-properties.h"
>>>>>>> +#include "hw/boards.h"
>>>>>>>  #include "migration/vmstate.h"
>>>>>>>  
>>>>>>>  //#define DEBUG_UNASSIGNED
>>>>>>> @@ -2924,6 +2926,8 @@ struct FlatViewInfo {
>>>>>>>      int counter;
>>>>>>>      bool dispatch_tree;
>>>>>>>      bool owner;
>>>>>>> +    AccelClass *ac;
>>>>>>> +    const char *ac_name;
>>>>>>>  };
>>>>>>>  
>>>>>>>  static void mtree_print_flatview(gpointer key, gpointer value,
>>>>>>> @@ -2939,6 +2943,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>>>>      int n = view->nr;
>>>>>>>      int i;
>>>>>>>      AddressSpace *as;
>>>>>>> +    bool system_as = false;
>>>>>>>  
>>>>>>>      p(f, "FlatView #%d\n", fvi->counter);
>>>>>>>      ++fvi->counter;
>>>>>>> @@ -2950,6 +2955,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>>>>              p(f, ", alias %s", memory_region_name(as->root->alias));
>>>>>>>          }
>>>>>>>          p(f, "\n");
>>>>>>> +        if (as == &address_space_memory) {
>>>>>>> +            system_as = true;
>>>>>>> +        }
>>>>>>>      }
>>>>>>>  
>>>>>>>      p(f, " Root memory region: %s\n",
>>>>>>> @@ -2985,6 +2993,13 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>>>>>>>          if (fvi->owner) {
>>>>>>>              mtree_print_mr_owner(p, f, mr);
>>>>>>>          }
>>>>>>> +
>>>>>>> +        if (system_as && fvi->ac &&
>>>>>>> +            fvi->ac->has_memory(current_machine,
>>>>>>> +                                int128_get64(range->addr.start),
>>>>>>> +                                MR_SIZE(range->addr.size) + 1)) {
>>>>>>> +            p(f, " %s", fvi->ac_name);
>>>>>>
>>>>>> Why not simply display fvi->ac->name?
>>>>>> You could avoid to add the ac_name field.
>>>>>
>>>>>
>>>>> Well, I thought I better print whatever the user passed via the command
>>>>> line (which is current_machine->accel and equals to "kvm" in my case)
>>>>> rather than robotic, dry and excessive "kvm-accel".
>>>>
>>>> I have no hit for 'kvm-accel':
>>>>
>>>> $ git grep kvm-accel
>>>> $
>>>>
>>>> Names looks human friendly:
>>>
>>>
>>> Ah, I confused with object_class_get_name(). Anyway, I'd still show the
>>> user provided accelerator name than some internal name.
>>
>> Aren't they exactly the same?
> 
> Nope. "kvm" vs. "kvm-accel".
> 
>> I think the accel= thing from the user is
>> parsed by comparing it with the ACCEL_CLASS_NAME declarations:
>>
>> ./target/i386/whpx-all.c:    .name = ACCEL_CLASS_NAME("whpx"),
>> ./target/i386/hax-all.c:    .name = ACCEL_CLASS_NAME("hax"),
>> ./hw/xen/xen-common.c:#define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
>> ./qtest.c:#define TYPE_QTEST_ACCEL ACCEL_CLASS_NAME("qtest")
>> ./accel/tcg/tcg-all.c:#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
>> ./include/sysemu/hvf.h:#define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>> ./include/sysemu/kvm_int.h:#define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
>>
>> and the code in accel/accel.c accel_find
> 
> 
> https://git.qemu.org/?p=qemu.git;a=blob;f=include/sysemu/accel.h;h=5565e00a96136bc5024c17c401116ef6a497138a;hb=HEAD#l58
> 
>   55 #define TYPE_ACCEL "accel"
>   56
>   57 #define ACCEL_CLASS_SUFFIX  "-" TYPE_ACCEL
>   58 #define ACCEL_CLASS_NAME(a) (a ACCEL_CLASS_SUFFIX)


Ping, anybody?


> 
> 
> 
>>
>> Dave
>>
>>>
>>>>
>>>> $ git grep 'ac->name ='
>>>> accel/kvm/kvm-all.c:2595:    ac->name = "KVM";
>>>> accel/tcg/tcg-all.c:74:    ac->name = "tcg";
>>>> hw/xen/xen-common.c:184:    ac->name = "Xen";
>>>> target/i386/hax-all.c:1088:    ac->name = "HAX";
>>>> target/i386/hvf/hvf.c:959:    ac->name = "HVF";
>>>> target/i386/whpx-all.c:1477:    ac->name = "WHPX";
>>>> qtest.c:755:    ac->name = "QTest";
>>>>
>>>>>>
>>>>>>> +        }
>>>>>>>          p(f, "\n");
>>>>>>>          range++;
>>>>>>>      }
>>>>>>> @@ -3028,6 +3043,13 @@ void mtree_info(fprintf_function mon_printf, void *f, bool flatview,
>>>>>>>          };
>>>>>>>          GArray *fv_address_spaces;
>>>>>>>          GHashTable *views = g_hash_table_new(g_direct_hash, g_direct_equal);
>>>>>>> +        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
>>>>>>> +
>>>>>>> +        if (ac->has_memory) {
>>>>>>> +            fvi.ac = ac;
>>>>>>> +            fvi.ac_name = current_machine->accel ? current_machine->accel :
>>>>>>> +                object_class_get_name(OBJECT_CLASS(ac));
>>>>>>> +        }
>>>>>>>  
>>>>>>>          /* Gather all FVs in one table */
>>>>>>>          QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>>>>>>>
>>>
>>> -- 
>>> Alexey
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
> 

-- 
Alexey
