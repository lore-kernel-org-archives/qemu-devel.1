Received: from eggs.gnu.org ([2001:4830:134:3::10]:44770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fzvyd-0000hi-NT
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 23:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fzvya-00048z-GQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 23:38:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fzvya-00048k-8o
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 23:38:00 -0400
Date: Wed, 12 Sep 2018 11:37:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180912033749.GA3829@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-4-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1536684589-11718-4-git-send-email-brijesh.singh@amd.com>
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
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Tue, Sep 11, 2018 at 11:49:46AM -0500, Brijesh Singh wrote:
> Emulate the interrupt remapping support when guest virtual APIC is
> not enabled.
> 
> See IOMMU spec: https://support.amd.com/TechDocs/48882_IOMMU.pdf
> (section 2.2.5.1) for details information.
> 
> When VAPIC is not enabled, it uses interrupt remapping as defined in
> Table 20 and Figure 15 from IOMMU spec.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  hw/i386/amd_iommu.c  | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/amd_iommu.h  |  60 ++++++++++++++++-
>  hw/i386/trace-events |   7 ++
>  3 files changed, 253 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 572ba0a..5ac19df 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -28,6 +28,8 @@
>  #include "qemu/error-report.h"
>  #include "hw/i386/apic_internal.h"
>  #include "trace.h"
> +#include "cpu.h"
> +#include "hw/i386/apic-msidef.h"
>  
>  /* used AMD-Vi MMIO registers */
>  const char *amdvi_mmio_low[] = {
> @@ -1027,6 +1029,119 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>      return ret;
>  }
>  
> +static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
> +                          union irte *irte, uint16_t devid)
> +{
> +    uint64_t irte_root, offset;
> +
> +    irte_root = dte[2] & AMDVI_IR_PHYS_ADDR_MASK;
> +    offset = (origin->data & AMDVI_IRTE_OFFSET) << 2;
> +
> +    trace_amdvi_ir_irte(irte_root, offset);
> +
> +    if (dma_memory_read(&address_space_memory, irte_root + offset,
> +                        irte, sizeof(*irte))) {
> +        trace_amdvi_ir_err("failed to get irte");
> +        return -AMDVI_IR_GET_IRTE;
> +    }
> +
> +    trace_amdvi_ir_irte_val(irte->val);
> +
> +    return 0;
> +}
> +
> +static void amdvi_generate_msi_message(struct AMDVIIrq *irq, MSIMessage *out)
> +{
> +    out->address = APIC_DEFAULT_ADDRESS | \
> +        (irq->dest_mode << MSI_ADDR_DEST_MODE_SHIFT) | \
> +        (irq->redir_hint << MSI_ADDR_REDIRECTION_SHIFT) | \
> +        (irq->dest << MSI_ADDR_DEST_ID_SHIFT);
> +
> +    out->data = (irq->vector << MSI_DATA_VECTOR_SHIFT) | \
> +        (irq->delivery_mode << MSI_DATA_DELIVERY_MODE_SHIFT);
> +
> +    trace_amdvi_ir_generate_msi_message(irq->vector, irq->delivery_mode,
> +            irq->dest_mode, irq->dest, irq->redir_hint);
> +}
> +
> +static int amdvi_int_remap_legacy(AMDVIState *iommu,
> +                                  MSIMessage *origin,
> +                                  MSIMessage *translated,
> +                                  uint64_t *dte,
> +                                  struct AMDVIIrq *irq,
> +                                  uint16_t sid)
> +{
> +    int ret;
> +    union irte irte;
> +
> +    /* get interrupt remapping table */

... get interrupt remapping table "entry"? :)

I see similar wordings in your spec, e.g., Table 20 is named as
"Interrupt Remapping Table Fields - Basic Format", but actually AFAICT
it's for the entry fields.  I'm confused a bit with them.

> +    ret = amdvi_get_irte(iommu, origin, dte, &irte, sid);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (!irte.fields.valid) {
> +        trace_amdvi_ir_target_abort("RemapEn is disabled");
> +        return -AMDVI_IR_TARGET_ABORT;
> +    }
> +
> +    if (irte.fields.guest_mode) {
> +        trace_amdvi_ir_target_abort("guest mode is not zero");
> +        return -AMDVI_IR_TARGET_ABORT;
> +    }
> +
> +    if (irte.fields.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
> +        trace_amdvi_ir_target_abort("reserved int_type");
> +        return -AMDVI_IR_TARGET_ABORT;
> +    }
> +
> +    irq->delivery_mode = irte.fields.int_type;
> +    irq->vector = irte.fields.vector;
> +    irq->dest_mode = irte.fields.dm;
> +    irq->redir_hint = irte.fields.rq_eoi;
> +    irq->dest = irte.fields.destination;
> +
> +    return 0;
> +}
> +
> +static int __amdvi_int_remap_msi(AMDVIState *iommu,
> +                                 MSIMessage *origin,
> +                                 MSIMessage *translated,
> +                                 uint64_t *dte,
> +                                 uint16_t sid)
> +{
> +    int ret;
> +    uint8_t int_ctl;
> +    struct AMDVIIrq irq = { 0 };
> +
> +    int_ctl = (dte[2] >> AMDVI_IR_INTCTL_SHIFT) & 3;
> +    trace_amdvi_ir_intctl(int_ctl);
> +
> +    switch (int_ctl) {
> +    case AMDVI_IR_INTCTL_PASS:
> +        memcpy(translated, origin, sizeof(*origin));
> +        return 0;
> +    case AMDVI_IR_INTCTL_REMAP:
> +        break;
> +    case AMDVI_IR_INTCTL_ABORT:
> +        trace_amdvi_ir_target_abort("int_ctl abort");
> +        return -AMDVI_IR_TARGET_ABORT;
> +    default:
> +        trace_amdvi_ir_target_abort("int_ctl reserved");
> +        return -AMDVI_IR_TARGET_ABORT;
> +    }
> +
> +    ret = amdvi_int_remap_legacy(iommu, origin, translated, dte, &irq, sid);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* Translate AMDVIIrq to MSI message */
> +    amdvi_generate_msi_message(&irq, translated);
> +
> +    return 0;
> +}
> +
>  /* Interrupt remapping for MSI/MSI-X entry */
>  static int amdvi_int_remap_msi(AMDVIState *iommu,
>                                 MSIMessage *origin,
> @@ -1034,6 +1149,9 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
>                                 uint16_t sid)
>  {
>      int ret;
> +    uint64_t pass = 0;
> +    uint64_t dte[4] = { 0 };
> +    uint8_t dest_mode, delivery_mode;
>  
>      assert(origin && translated);
>  
> @@ -1055,10 +1173,79 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
>          return -AMDVI_IR_ERR;
>      }
>  
> +    /*
> +     * When IOMMU is enabled, interrupt remap request will come either from
> +     * IO-APIC or PCI device. If interrupt is from PCI device then it will
> +     * have a valid requester id but if the interrupt it from IO-APIC
> +     * then requester is will be invalid.

s/is/id/

> +     */
> +    if (sid == X86_IOMMU_SID_INVALID) {
> +        sid = AMDVI_SB_IOAPIC_ID;
> +    }
> +
> +    amdvi_get_dte(iommu, sid, dte);

Mind to check the return value?

After all it's provided, and we have the fault path to handle it in
this function.

> +
> +    /* interrupt remapping is disabled */
> +    if (!(dte[2] & AMDVI_IR_REMAP_ENABLE)) {
> +        memcpy(translated, origin, sizeof(*origin));
> +        goto out;
> +    }
> +
> +    /* deliver_mode and dest_mode from MSI data */
> +    dest_mode = (origin->data >> 11) & 1;       /* Bit 11 */
> +    delivery_mode = (origin->data >> 7) & 7;    /* Bits 10:8 */

Nit: The comments are already nice, though IMHO some mask macros would
be nicer, like AMDVI_IR_PHYS_ADDR_MASK.

Also, could you hint me where are these things defined in the spec?
I'm looking at Figure 14, but there MSI data bits 15:11 are defined as
"XXXXXb", and bits 10:8 seems to be part of the interrupt table offset.

> +
> +    switch (delivery_mode) {
> +    case AMDVI_IOAPIC_INT_TYPE_FIXED:
> +    case AMDVI_IOAPIC_INT_TYPE_ARBITRATED:
> +        trace_amdvi_ir_delivery_mode("fixed/arbitrated");
> +        ret = __amdvi_int_remap_msi(iommu, origin, translated, dte, sid);
> +        if (ret < 0) {
> +            goto remap_fail;
> +        } else {
> +            goto out;
> +        }
> +    case AMDVI_IOAPIC_INT_TYPE_SMI:
> +        error_report("SMI is not supported!");
> +        goto remap_fail;

(I'm not sure whether some compiler will try to find the "break" and
 spit things if it failed to do so, so normally I'll keep them
 there... but I might be wrong)

> +    case AMDVI_IOAPIC_INT_TYPE_NMI:
> +        pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
> +        trace_amdvi_ir_delivery_mode("nmi");
> +        break;
> +    case AMDVI_IOAPIC_INT_TYPE_INIT:
> +        pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
> +        trace_amdvi_ir_delivery_mode("init");
> +        break;
> +    case AMDVI_IOAPIC_INT_TYPE_EINT:
> +        pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
> +        trace_amdvi_ir_delivery_mode("eint");
> +        break;
> +    default:
> +        trace_amdvi_ir_delivery_mode("unsupported delivery_mode");
> +        goto remap_fail;
> +    }
> +
> +    /* dest_mode 1 is valid for fixed and arbitrated interrupts only */
> +    if (dest_mode) {
> +        trace_amdvi_ir_err("invalid dest_mode");
> +        goto remap_fail;
> +    }

I think this check can be moved even before the switch?

> +
> +    if (pass) {
> +        memcpy(translated, origin, sizeof(*origin));
> +    } else {
> +        /* pass through is not enabled */
> +        trace_amdvi_ir_err("passthrough is not enabled");
> +        goto remap_fail;
> +    }
> +
>  out:
>      trace_amdvi_ir_remap_msi(origin->address, origin->data,
>                               translated->address, translated->data);
>      return 0;
> +
> +remap_fail:
> +    return -AMDVI_IR_TARGET_ABORT;
>  }
>  
>  static int amdvi_int_remap(X86IOMMUState *iommu,
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 74e568b..58ef4db 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -217,7 +217,65 @@
>  
>  /* Interrupt remapping errors */
>  #define AMDVI_IR_ERR            0x1
> -
> +#define AMDVI_IR_GET_IRTE       0x2
> +#define AMDVI_IR_TARGET_ABORT   0x3
> +
> +/* Interrupt remapping */
> +#define AMDVI_IR_REMAP_ENABLE           1ULL
> +#define AMDVI_IR_INTCTL_SHIFT           60
> +#define AMDVI_IR_INTCTL_ABORT           0
> +#define AMDVI_IR_INTCTL_PASS            1
> +#define AMDVI_IR_INTCTL_REMAP           2
> +
> +#define AMDVI_IR_PHYS_ADDR_MASK         (((1ULL << 45) - 1) << 6)
> +
> +/* MSI data 10:0 bits (section 2.2.5.1 Fig 14) */
> +#define AMDVI_IRTE_OFFSET               0x7ff
> +
> +/* Delivery mode of MSI data (same as IOAPIC deilver mode encoding) */
> +#define AMDVI_IOAPIC_INT_TYPE_FIXED          0x0
> +#define AMDVI_IOAPIC_INT_TYPE_ARBITRATED     0x1
> +#define AMDVI_IOAPIC_INT_TYPE_SMI            0x2
> +#define AMDVI_IOAPIC_INT_TYPE_NMI            0x4
> +#define AMDVI_IOAPIC_INT_TYPE_INIT           0x5
> +#define AMDVI_IOAPIC_INT_TYPE_EINT           0x7
> +
> +/* Pass through interrupt */
> +#define AMDVI_DEV_INT_PASS_MASK         (1UL << 56)
> +#define AMDVI_DEV_EINT_PASS_MASK        (1UL << 57)
> +#define AMDVI_DEV_NMI_PASS_MASK         (1UL << 58)
> +#define AMDVI_DEV_LINT0_PASS_MASK       (1UL << 62)
> +#define AMDVI_DEV_LINT1_PASS_MASK       (1UL << 63)
> +
> +/* Generic IRQ entry information */
> +struct AMDVIIrq {
> +    /* Used by both IOAPIC/MSI interrupt remapping */
> +    uint8_t trigger_mode;
> +    uint8_t vector;
> +    uint8_t delivery_mode;
> +    uint32_t dest;
> +    uint8_t dest_mode;
> +
> +    /* only used by MSI interrupt remapping */
> +    uint8_t redir_hint;
> +    uint8_t msi_addr_last_bits;
> +};

This is VTDIrq.

We're having some similar codes between the vt-d and amd-vi ir
implementations.  I'm thinking to what extend we could share the code.
I don't think it would worth it if we need to spend too much extra
time, but things like this one might still be good candidates that we
can share them at the very beginning since it won't be that hard (like
what you did in patch 1).

(maybe also things like amdvi_generate_msi_message but I'm not sure)

> +
> +/* Interrupt remapping table fields (Guest VAPIC not enabled) */
> +union irte {
> +    uint32_t val;
> +    struct {
> +        uint32_t valid:1,
> +                 no_fault:1,
> +                 int_type:3,
> +                 rq_eoi:1,
> +                 dm:1,
> +                 guest_mode:1,
> +                 destination:8,
> +                 vector:8,
> +                 rsvd:8;
> +    } fields;
> +};
>  
>  #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
>  #define AMD_IOMMU_DEVICE(obj)\
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 41d533c..98150c9 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -106,6 +106,13 @@ amdvi_mem_ir_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" data 0x%"PRIx6
>  amdvi_ir_remap_msi_req(uint64_t addr, uint64_t data, uint8_t devid) "addr 0x%"PRIx64" data 0x%"PRIx64" devid 0x%"PRIx8
>  amdvi_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%"PRIx64")"
>  amdvi_err(const char *str) "%s"
> +amdvi_ir_irte(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" offset 0x%"PRIx64
> +amdvi_ir_irte_val(uint32_t data) "data 0x%"PRIx32
> +amdvi_ir_err(const char *str) "%s"
> +amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
> +amdvi_ir_target_abort(const char *str) "%s"
> +amdvi_ir_delivery_mode(const char *str) "%s"
> +amdvi_ir_generate_msi_message(uint8_t vector, uint8_t delivery_mode, uint8_t dest_mode, uint8_t dest, uint8_t rh) "vector %d delivery-mode %d dest-mode %d dest-id %d rh %d"
>  
>  # hw/i386/vmport.c
>  vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
> -- 
> 2.7.4
> 
> 

Regards,

-- 
Peter Xu
