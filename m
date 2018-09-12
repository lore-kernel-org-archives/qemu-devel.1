Received: from eggs.gnu.org ([2001:4830:134:3::10]:33617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0ADv-00062l-SS
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0ADr-0001xD-9h
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:50:47 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com
	([104.47.37.61]:62432
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0ADq-0001wd-MH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 14:50:43 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-4-git-send-email-brijesh.singh@amd.com>
	<20180912033749.GA3829@xz-x1>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d8bcd7ce-164a-a69f-75fe-e8ebf7345d6b@amd.com>
Date: Wed, 12 Sep 2018 13:50:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180912033749.GA3829@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] x86_iommu/amd: Add interrupt remap
 support when VAPIC is not enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>


Thanks for the quick review feedback.

On 09/11/2018 10:37 PM, Peter Xu wrote:
> On Tue, Sep 11, 2018 at 11:49:46AM -0500, Brijesh Singh wrote:
>> Emulate the interrupt remapping support when guest virtual APIC is
>> not enabled.
>>
>> See IOMMU spec: https://support.amd.com/TechDocs/48882_IOMMU.pdf
>> (section 2.2.5.1) for details information.
>>
>> When VAPIC is not enabled, it uses interrupt remapping as defined in
>> Table 20 and Figure 15 from IOMMU spec.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
>> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   hw/i386/amd_iommu.c  | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/i386/amd_iommu.h  |  60 ++++++++++++++++-
>>   hw/i386/trace-events |   7 ++
>>   3 files changed, 253 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 572ba0a..5ac19df 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -28,6 +28,8 @@
>>   #include "qemu/error-report.h"
>>   #include "hw/i386/apic_internal.h"
>>   #include "trace.h"
>> +#include "cpu.h"
>> +#include "hw/i386/apic-msidef.h"
>>   
>>   /* used AMD-Vi MMIO registers */
>>   const char *amdvi_mmio_low[] = {
>> @@ -1027,6 +1029,119 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>>       return ret;
>>   }
>>   
>> +static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
>> +                          union irte *irte, uint16_t devid)
>> +{
>> +    uint64_t irte_root, offset;
>> +
>> +    irte_root = dte[2] & AMDVI_IR_PHYS_ADDR_MASK;
>> +    offset = (origin->data & AMDVI_IRTE_OFFSET) << 2;
>> +
>> +    trace_amdvi_ir_irte(irte_root, offset);
>> +
>> +    if (dma_memory_read(&address_space_memory, irte_root + offset,
>> +                        irte, sizeof(*irte))) {
>> +        trace_amdvi_ir_err("failed to get irte");
>> +        return -AMDVI_IR_GET_IRTE;
>> +    }
>> +
>> +    trace_amdvi_ir_irte_val(irte->val);
>> +
>> +    return 0;
>> +}
>> +
>> +static void amdvi_generate_msi_message(struct AMDVIIrq *irq, MSIMessage *out)
>> +{
>> +    out->address = APIC_DEFAULT_ADDRESS | \
>> +        (irq->dest_mode << MSI_ADDR_DEST_MODE_SHIFT) | \
>> +        (irq->redir_hint << MSI_ADDR_REDIRECTION_SHIFT) | \
>> +        (irq->dest << MSI_ADDR_DEST_ID_SHIFT);
>> +
>> +    out->data = (irq->vector << MSI_DATA_VECTOR_SHIFT) | \
>> +        (irq->delivery_mode << MSI_DATA_DELIVERY_MODE_SHIFT);
>> +
>> +    trace_amdvi_ir_generate_msi_message(irq->vector, irq->delivery_mode,
>> +            irq->dest_mode, irq->dest, irq->redir_hint);
>> +}
>> +
>> +static int amdvi_int_remap_legacy(AMDVIState *iommu,
>> +                                  MSIMessage *origin,
>> +                                  MSIMessage *translated,
>> +                                  uint64_t *dte,
>> +                                  struct AMDVIIrq *irq,
>> +                                  uint16_t sid)
>> +{
>> +    int ret;
>> +    union irte irte;
>> +
>> +    /* get interrupt remapping table */
> 
> ... get interrupt remapping table "entry"? :)
> 
> I see similar wordings in your spec, e.g., Table 20 is named as
> "Interrupt Remapping Table Fields - Basic Format", but actually AFAICT
> it's for the entry fields.  I'm confused a bit with them.
> 

I was too much in spec hence used the same wording as spec. But, I agree
with you that we should use "... interrupt remapping table entry".


>> +    ret = amdvi_get_irte(iommu, origin, dte, &irte, sid);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (!irte.fields.valid) {
>> +        trace_amdvi_ir_target_abort("RemapEn is disabled");
>> +        return -AMDVI_IR_TARGET_ABORT;
>> +    }
>> +
>> +    if (irte.fields.guest_mode) {
>> +        trace_amdvi_ir_target_abort("guest mode is not zero");
>> +        return -AMDVI_IR_TARGET_ABORT;
>> +    }
>> +
>> +    if (irte.fields.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
>> +        trace_amdvi_ir_target_abort("reserved int_type");
>> +        return -AMDVI_IR_TARGET_ABORT;
>> +    }
>> +
>> +    irq->delivery_mode = irte.fields.int_type;
>> +    irq->vector = irte.fields.vector;
>> +    irq->dest_mode = irte.fields.dm;
>> +    irq->redir_hint = irte.fields.rq_eoi;
>> +    irq->dest = irte.fields.destination;
>> +
>> +    return 0;
>> +}
>> +
>> +static int __amdvi_int_remap_msi(AMDVIState *iommu,
>> +                                 MSIMessage *origin,
>> +                                 MSIMessage *translated,
>> +                                 uint64_t *dte,
>> +                                 uint16_t sid)
>> +{
>> +    int ret;
>> +    uint8_t int_ctl;
>> +    struct AMDVIIrq irq = { 0 };
>> +
>> +    int_ctl = (dte[2] >> AMDVI_IR_INTCTL_SHIFT) & 3;
>> +    trace_amdvi_ir_intctl(int_ctl);
>> +
>> +    switch (int_ctl) {
>> +    case AMDVI_IR_INTCTL_PASS:
>> +        memcpy(translated, origin, sizeof(*origin));
>> +        return 0;
>> +    case AMDVI_IR_INTCTL_REMAP:
>> +        break;
>> +    case AMDVI_IR_INTCTL_ABORT:
>> +        trace_amdvi_ir_target_abort("int_ctl abort");
>> +        return -AMDVI_IR_TARGET_ABORT;
>> +    default:
>> +        trace_amdvi_ir_target_abort("int_ctl reserved");
>> +        return -AMDVI_IR_TARGET_ABORT;
>> +    }
>> +
>> +    ret = amdvi_int_remap_legacy(iommu, origin, translated, dte, &irq, sid);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    /* Translate AMDVIIrq to MSI message */
>> +    amdvi_generate_msi_message(&irq, translated);
>> +
>> +    return 0;
>> +}
>> +
>>   /* Interrupt remapping for MSI/MSI-X entry */
>>   static int amdvi_int_remap_msi(AMDVIState *iommu,
>>                                  MSIMessage *origin,
>> @@ -1034,6 +1149,9 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
>>                                  uint16_t sid)
>>   {
>>       int ret;
>> +    uint64_t pass = 0;
>> +    uint64_t dte[4] = { 0 };
>> +    uint8_t dest_mode, delivery_mode;
>>   
>>       assert(origin && translated);
>>   
>> @@ -1055,10 +1173,79 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
>>           return -AMDVI_IR_ERR;
>>       }
>>   
>> +    /*
>> +     * When IOMMU is enabled, interrupt remap request will come either from
>> +     * IO-APIC or PCI device. If interrupt is from PCI device then it will
>> +     * have a valid requester id but if the interrupt it from IO-APIC
>> +     * then requester is will be invalid.
> 
> s/is/id/
> 

I will fix the comment thanks

>> +     */
>> +    if (sid == X86_IOMMU_SID_INVALID) {
>> +        sid = AMDVI_SB_IOAPIC_ID;
>> +    }
>> +
>> +    amdvi_get_dte(iommu, sid, dte);
> 
> Mind to check the return value?
> 
> After all it's provided, and we have the fault path to handle it in
> this function.
> 

The amdvi_get_dte(..) does not check the IR bit. It only checks for the
address-translation enabled bit. I can extend the function to check for
IR flag so that we can check the error status of this function.


>> +
>> +    /* interrupt remapping is disabled */
>> +    if (!(dte[2] & AMDVI_IR_REMAP_ENABLE)) {
>> +        memcpy(translated, origin, sizeof(*origin));
>> +        goto out;
>> +    }
>> +
>> +    /* deliver_mode and dest_mode from MSI data */
>> +    dest_mode = (origin->data >> 11) & 1;       /* Bit 11 */
>> +    delivery_mode = (origin->data >> 7) & 7;    /* Bits 10:8 */
> 
> Nit: The comments are already nice, though IMHO some mask macros would
> be nicer, like AMDVI_IR_PHYS_ADDR_MASK.
> 
> Also, could you hint me where are these things defined in the spec?
> I'm looking at Figure 14, but there MSI data bits 15:11 are defined as
> "XXXXXb", and bits 10:8 seems to be part of the interrupt table offset.
> 

Since we are not emulating the Hyper Transport hence we need to look at
the encoding of the delivery mode of MSI data, which  is the same as
APIC/IOAPIC delivery mode encoding. See

* For MSI Data, 
https://pdfs.semanticscholar.org/presentation/9420/c279e942eca568157711ef5c92b800c40a79.pdf
   (page 5)
* For IOAPIC, https://wiki.osdev.org/APIC

They are similar to Hyper Transport MT encoding, but not quite the same.

enum ioapic_irq_destination_types {
         dest_Fixed              = 0,
         dest_LowestPrio         = 1,
         dest_SMI                = 2,
         dest__reserved_1        = 3,
         dest_NMI                = 4,
         dest_INIT               = 5,
         dest__reserved_2        = 6,
         dest_ExtINT             = 7
};

I will add the comments in the code and also provide the link


>> +
>> +    switch (delivery_mode) {
>> +    case AMDVI_IOAPIC_INT_TYPE_FIXED:
>> +    case AMDVI_IOAPIC_INT_TYPE_ARBITRATED:
>> +        trace_amdvi_ir_delivery_mode("fixed/arbitrated");
>> +        ret = __amdvi_int_remap_msi(iommu, origin, translated, dte, sid);
>> +        if (ret < 0) {
>> +            goto remap_fail;
>> +        } else {
>> +            goto out;
>> +        }
>> +    case AMDVI_IOAPIC_INT_TYPE_SMI:
>> +        error_report("SMI is not supported!");
>> +        goto remap_fail;
> 
> (I'm not sure whether some compiler will try to find the "break" and
>   spit things if it failed to do so, so normally I'll keep them
>   there... but I might be wrong)
> 
>> +    case AMDVI_IOAPIC_INT_TYPE_NMI:
>> +        pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
>> +        trace_amdvi_ir_delivery_mode("nmi");
>> +        break;
>> +    case AMDVI_IOAPIC_INT_TYPE_INIT:
>> +        pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
>> +        trace_amdvi_ir_delivery_mode("init");
>> +        break;
>> +    case AMDVI_IOAPIC_INT_TYPE_EINT:
>> +        pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
>> +        trace_amdvi_ir_delivery_mode("eint");
>> +        break;
>> +    default:
>> +        trace_amdvi_ir_delivery_mode("unsupported delivery_mode");
>> +        goto remap_fail;
>> +    }
>> +
>> +    /* dest_mode 1 is valid for fixed and arbitrated interrupts only */
>> +    if (dest_mode) {
>> +        trace_amdvi_ir_err("invalid dest_mode");
>> +        goto remap_fail;
>> +    }
> 
> I think this check can be moved even before the switch?
> 

Theoretically yes but it will require adding me additional checks
before the switch statement. The dest_mode check  need me done for
non fixed or arbitrated interrupt type only.


>> +
>> +    if (pass) {
>> +        memcpy(translated, origin, sizeof(*origin));
>> +    } else {
>> +        /* pass through is not enabled */
>> +        trace_amdvi_ir_err("passthrough is not enabled");
>> +        goto remap_fail;
>> +    }
>> +
>>   out:
>>       trace_amdvi_ir_remap_msi(origin->address, origin->data,
>>                                translated->address, translated->data);
>>       return 0;
>> +
>> +remap_fail:
>> +    return -AMDVI_IR_TARGET_ABORT;
>>   }
>>   
>>   static int amdvi_int_remap(X86IOMMUState *iommu,
>> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> index 74e568b..58ef4db 100644
>> --- a/hw/i386/amd_iommu.h
>> +++ b/hw/i386/amd_iommu.h
>> @@ -217,7 +217,65 @@
>>   
>>   /* Interrupt remapping errors */
>>   #define AMDVI_IR_ERR            0x1
>> -
>> +#define AMDVI_IR_GET_IRTE       0x2
>> +#define AMDVI_IR_TARGET_ABORT   0x3
>> +
>> +/* Interrupt remapping */
>> +#define AMDVI_IR_REMAP_ENABLE           1ULL
>> +#define AMDVI_IR_INTCTL_SHIFT           60
>> +#define AMDVI_IR_INTCTL_ABORT           0
>> +#define AMDVI_IR_INTCTL_PASS            1
>> +#define AMDVI_IR_INTCTL_REMAP           2
>> +
>> +#define AMDVI_IR_PHYS_ADDR_MASK         (((1ULL << 45) - 1) << 6)
>> +
>> +/* MSI data 10:0 bits (section 2.2.5.1 Fig 14) */
>> +#define AMDVI_IRTE_OFFSET               0x7ff
>> +
>> +/* Delivery mode of MSI data (same as IOAPIC deilver mode encoding) */
>> +#define AMDVI_IOAPIC_INT_TYPE_FIXED          0x0
>> +#define AMDVI_IOAPIC_INT_TYPE_ARBITRATED     0x1
>> +#define AMDVI_IOAPIC_INT_TYPE_SMI            0x2
>> +#define AMDVI_IOAPIC_INT_TYPE_NMI            0x4
>> +#define AMDVI_IOAPIC_INT_TYPE_INIT           0x5
>> +#define AMDVI_IOAPIC_INT_TYPE_EINT           0x7
>> +
>> +/* Pass through interrupt */
>> +#define AMDVI_DEV_INT_PASS_MASK         (1UL << 56)
>> +#define AMDVI_DEV_EINT_PASS_MASK        (1UL << 57)
>> +#define AMDVI_DEV_NMI_PASS_MASK         (1UL << 58)
>> +#define AMDVI_DEV_LINT0_PASS_MASK       (1UL << 62)
>> +#define AMDVI_DEV_LINT1_PASS_MASK       (1UL << 63)
>> +
>> +/* Generic IRQ entry information */
>> +struct AMDVIIrq {
>> +    /* Used by both IOAPIC/MSI interrupt remapping */
>> +    uint8_t trigger_mode;
>> +    uint8_t vector;
>> +    uint8_t delivery_mode;
>> +    uint32_t dest;
>> +    uint8_t dest_mode;
>> +
>> +    /* only used by MSI interrupt remapping */
>> +    uint8_t redir_hint;
>> +    uint8_t msi_addr_last_bits;
>> +};
> 
> This is VTDIrq.
> 
> We're having some similar codes between the vt-d and amd-vi ir
> implementations.  I'm thinking to what extend we could share the code.
> I don't think it would worth it if we need to spend too much extra
> time, but things like this one might still be good candidates that we
> can share them at the very beginning since it won't be that hard (like
> what you did in patch 1).
> 
> (maybe also things like amdvi_generate_msi_message but I'm not sure)
> 

I will see what can be done to move the VTDIrq struct and msi message
generation in common file.

thanks
