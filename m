Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTU5y-0001vx-Cf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTU5S-0000vV-67
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:46:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTU5R-0000uy-PV
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:46:10 -0500
References: <20170112182446.9600-1-lersek@redhat.com>
	<20170112182446.9600-3-lersek@redhat.com>
	<20170113140914.62af8755@nial.brq.redhat.com>
	<32d3f5cf-9428-29db-45bb-d3a35c6cbd04@redhat.com>
	<20170117122131.466d4147@nial.brq.redhat.com>
	<bbd7f2a5-cdec-aaf3-acfb-c99ce9054a3c@redhat.com>
	<20170117142059.3a7689de@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <17a61164-0cb8-98fd-b340-8cb3a27edb0e@redhat.com>
Date: Tue, 17 Jan 2017 14:46:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170117142059.3a7689de@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 wave 2 2/3] hw/isa/lpc_ich9: add
 broadcast SMI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Kinney <michael.d.kinney@intel.com>

On 01/17/17 14:20, Igor Mammedov wrote:
> On Tue, 17 Jan 2017 13:06:13 +0100
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 01/17/17 12:21, Igor Mammedov wrote:
>>> On Mon, 16 Jan 2017 21:46:55 +0100
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>   
>>>> On 01/13/17 14:09, Igor Mammedov wrote:  
>>>>> On Thu, 12 Jan 2017 19:24:45 +0100
>>>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>>>     
>>>>>> The generic edk2 SMM infrastructure prefers
>>>>>> EFI_SMM_CONTROL2_PROTOCOL.Trigger() to inject an SMI on each processor. If
>>>>>> Trigger() only brings the current processor into SMM, then edk2 handles it
>>>>>> in the following ways:
>>>>>>
>>>>>> (1) If Trigger() is executed by the BSP (which is guaranteed before
>>>>>>     ExitBootServices(), but is not necessarily true at runtime), then:
>>>>>>
>>>>>>     (a) If edk2 has been configured for "traditional" SMM synchronization,
>>>>>>         then the BSP sends directed SMIs to the APs with APIC delivery,
>>>>>>         bringing them into SMM individually. Then the BSP runs the SMI
>>>>>>         handler / dispatcher.
>>>>>>
>>>>>>     (b) If edk2 has been configured for "relaxed" SMM synchronization,
>>>>>>         then the APs that are not already in SMM are not brought in, and
>>>>>>         the BSP runs the SMI handler / dispatcher.
>>>>>>
>>>>>> (2) If Trigger() is executed by an AP (which is possible after
>>>>>>     ExitBootServices(), and can be forced e.g. by "taskset -c 1
>>>>>>     efibootmgr"), then the AP in question brings in the BSP with a
>>>>>>     directed SMI, and the BSP runs the SMI handler / dispatcher.
>>>>>>
>>>>>> The smaller problem with (1a) and (2) is that the BSP and AP
>>>>>> synchronization is slow. For example, the "taskset -c 1 efibootmgr"
>>>>>> command from (2) can take more than 3 seconds to complete, because
>>>>>> efibootmgr accesses non-volatile UEFI variables intensively.
>>>>>>
>>>>>> The larger problem is that QEMU's current behavior diverges from the
>>>>>> behavior usually seen on physical hardware, and that keeps exposing
>>>>>> obscure corner cases, race conditions and other instabilities in edk2,
>>>>>> which generally expects / prefers a software SMI to affect all CPUs at
>>>>>> once.
>>>>>>
>>>>>> Therefore introduce the "broadcast SMI" feature that causes QEMU to inject
>>>>>> the SMI on all VCPUs.
>>>>>>
>>>>>> While the original posting of this patch
>>>>>> <http://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05658.html>
>>>>>> only intended to speed up (2), based on our recent "stress testing" of SMM
>>>>>> this patch actually provides functional improvements.
>>>>>>
>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> ---
>>>>>>
>>>>>> Notes:
>>>>>>     v6:
>>>>>>     - no changes, pick up Michael's R-b
>>>>>>     
>>>>>>     v5:
>>>>>>     - replace the ICH9_LPC_SMI_F_BROADCAST bit value with the
>>>>>>       ICH9_LPC_SMI_F_BROADCAST_BIT bit position (necessary for
>>>>>>       DEFINE_PROP_BIT() in the next patch)
>>>>>>
>>>>>>  include/hw/i386/ich9.h |  3 +++
>>>>>>  hw/isa/lpc_ich9.c      | 10 +++++++++-
>>>>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
>>>>>> index da1118727146..18dcca7ebcbf 100644
>>>>>> --- a/include/hw/i386/ich9.h
>>>>>> +++ b/include/hw/i386/ich9.h
>>>>>> @@ -250,4 +250,7 @@ Object *ich9_lpc_find(void);
>>>>>>  #define ICH9_SMB_HST_D1                         0x06
>>>>>>  #define ICH9_SMB_HOST_BLOCK_DB                  0x07
>>>>>>  
>>>>>> +/* bit positions used in fw_cfg SMI feature negotiation */
>>>>>> +#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
>>>>>> +
>>>>>>  #endif /* HW_ICH9_H */
>>>>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>>>>> index 376b7801a42c..ced6f803a4f2 100644
>>>>>> --- a/hw/isa/lpc_ich9.c
>>>>>> +++ b/hw/isa/lpc_ich9.c
>>>>>> @@ -437,7 +437,15 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
>>>>>>  
>>>>>>      /* SMI_EN = PMBASE + 30. SMI control and enable register */
>>>>>>      if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
>>>>>> -        cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>>>>> +        if (lpc->smi_negotiated_features &
>>>>>> +            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
>>>>>> +            CPUState *cs;
>>>>>> +            CPU_FOREACH(cs) {
>>>>>> +                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>>>>>> +            }    
>>>>> Shouldn't CPUs with default SMI base be excluded from broadcast?    
>>>>
>>>> I don't think so; as far as I recall, in edk2 the initial SMM entry code
>>>> -- before SMBASE relocation -- accommodates all VCPUs entering the same
>>>> code area for execution. The VCPUs are told apart from each other by
>>>> Initial APIC ID (that is, "who am I"), which is used as an index or
>>>> search criterion into a global shared array. Once they find their
>>>> respective private data blocks, the VCPUs don't step on each other's toes.  
>>> That's what I'm not sure.
>>> If broadcast SMI is sent before relocation all CPUs will use
>>> the same SMBASE and as result save their state in the same
>>> memory (even if it's state after RESET/POWER ON) racing/overwriting
>>> each other's saved state  
>>
>> Good point!
>>
>>> and then on exit from SMI they all will restore
>>> whatever state that race produced so it seems plain wrong thing to do.
>>>
>>> Are you sure that edk2 does broadcast for SMI initialization or does it
>>> using directed SMIs?  
>>
>> Hmmm, you are right. The SmmRelocateBases() function in
>> "UefiCpuPkg/PiSmmCpuDxeSmm/PiSmmCpuDxeSmm.c" first relocates SMBASE for
>> each individual AP in succession, by sending SMI IPIs to them, one by
>> one. Then it does the same for the BSP, by sending itself a similar SMI IPI.
>>
>> The above QEMU code is only exercised much later, after the SMBASE
>> relocation, with the SMM stack up and running. It is used when a
>> (preferably broadcast) SMI is triggered for firmware services (for
>> example, the UEFI variable services).
>>
>> So, you are right.
>>
>> Considering edk2 only, the difference shouldn't matter -- when this code
>> is invoked (via an IO port write), the SMBASEs will all have been relocated.
>>
>> Also, I've been informed that on real hardware, writing to APM_CNT
>> triggers an SMI on all CPUs, regardless of the individual SMBASE values.
>> So I believe the above code should be closest to real hardware, and the
>> pre-patch code was only written in unicast form for SeaBIOS's sake.
>>
>> I think the code is safe above. If the guest injects an SMI via APM_CNT
>> after negotiating SMI broadcast, it should have not left any VCPUs
>> without an SMI handler by that time. edk2 / OVMF conforms to this. In
>> the future we can tweak this further, if necessary; we have 63 more
>> bits, and we'll be able to reject invalid combinations of bits.
>>
>> Do you feel that we should skip VCPUs whose SMBASE has not been changed
>> from the default?
>>
>> If so, doesn't that run the risk of missing a VCPU that has an actual
>> SMI handler installed, and it just happens to be placed at the default
>> SMBASE location?
>>
>> ... I wouldn't mind skipping VCPUs with apparently unrelocated SMBASEs,
>> but I think (a) that's not what real hardware does, and (b) it is risky
>> if a VCPU's actual SMI handler has been installed while keeping the
>> default SMBASE value.
>>
>> What do you think?
> (a) probably doesn't consider hotplug, so it's totally fine for the case
> where firmware is the only one who wakes up/initializes CPUs.
> however consider 2 CPU hotplugged and then broadcast SMI happens
> to serve some other task (if there isn't unpark 'feature').
> Even if real hw does it, it's behavior not defined by SDM with possibly
> bad consequences.
> 
> (b) alone it's risky so I'd skip based on combination of
>  
>  if (default SMBASE & CPU is in reset state)
>     skip;
> 
> that should be safe and it leaves open possibility to avoid adding
> unpark 'feature' to CPU.

The above attributes ("SMBASE" and "CPU is in reset state") are specific
to x86 VCPUs. Should I use some dynamic QOM casting for this? Like the
X86_CPU() macro?

Can I assume here that the macro will never return NULL? (I think so,
LPC is only used with x86.)

... I guess SMBASE can be accessed as

  X86_CPU(cs)->env.smbase

How do I figure out if the CPU is in reset state ("waiting for first
INIT") though? Note that this state should be distinguished from simply
"halted" (i.e., after a HLT). After a HLT, the SMI should be injected
and delivered; see commit a9bad65d2c1f. Edk2 regularly uses HLT to send
APs to sleep.

Thanks
Laszlo

> 
>>
>> Thanks!
>> Laszlo
>>
>>>   
>>>>
>>>> Thanks
>>>> Laszlo
>>>>  
>>>>>     
>>>>>> +        } else {
>>>>>> +            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>>>>> +        }
>>>>>>      }
>>>>>>  }
>>>>>>      
>>>>>     
>>>>  
>>>   
>>
> 
