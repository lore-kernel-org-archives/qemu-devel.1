Received: from eggs.gnu.org ([2001:4830:134:3::10]:36853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTpDR-0001kp-8j
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTpDN-0000e0-7G
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:19:49 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:36821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cTpDM-0000dh-RP
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:19:45 -0500
Received: by mail-lf0-x244.google.com with SMTP id h65so1508191lfi.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 04:19:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2163e04a-68cb-6c49-61bf-71c9e32e0487@redhat.com>
Date: Wed, 18 Jan 2017 13:19:40 +0100
MIME-Version: 1.0
In-Reply-To: <1484026704-28027-9-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>, Richard Henderson <rth@twiddle.net>



On 10/01/2017 06:39, Michael S. Tsirkin wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> This patch enables device IOTLB support for intel iommu. The major
> work is to implement QI device IOTLB descriptor processing and notify
> the device through iommu notifier.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu_internal.h | 13 ++++++-
>  include/hw/i386/x86-iommu.h    |  1 +
>  hw/i386/intel_iommu.c          | 83 +++++++++++++++++++++++++++++++++++++++---
>  hw/i386/x86-iommu.c            | 17 +++++++++
>  4 files changed, 107 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 11abfa2..356f188 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -183,6 +183,7 @@
>  /* (offset >> 4) << 8 */
>  #define VTD_ECAP_IRO                (DMAR_IOTLB_REG_OFFSET << 4)
>  #define VTD_ECAP_QI                 (1ULL << 1)
> +#define VTD_ECAP_DT                 (1ULL << 2)
>  /* Interrupt Remapping support */
>  #define VTD_ECAP_IR                 (1ULL << 3)
>  #define VTD_ECAP_EIM                (1ULL << 4)
> @@ -326,6 +327,7 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_TYPE               0xf
>  #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
>  #define VTD_INV_DESC_IOTLB              0x2
> +#define VTD_INV_DESC_DEVICE             0x3
>  #define VTD_INV_DESC_IEC                0x4 /* Interrupt Entry Cache
>                                                 Invalidate Descriptor */
>  #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
> @@ -361,6 +363,13 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>  #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>  
> +/* Mask for Device IOTLB Invalidate Descriptor */
> +#define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
> +#define VTD_INV_DESC_DEVICE_IOTLB_SIZE(val) ((val) & 0x1)
> +#define VTD_INV_DESC_DEVICE_IOTLB_SID(val) (((val) >> 32) & 0xFFFFULL)
> +#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
> +#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> @@ -399,8 +408,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CONTEXT_ENTRY_FPD       (1ULL << 1) /* Fault Processing Disable */
>  #define VTD_CONTEXT_ENTRY_TT        (3ULL << 2) /* Translation Type */
>  #define VTD_CONTEXT_TT_MULTI_LEVEL  0
> -#define VTD_CONTEXT_TT_DEV_IOTLB    1
> -#define VTD_CONTEXT_TT_PASS_THROUGH 2
> +#define VTD_CONTEXT_TT_DEV_IOTLB    (1ULL << 2)
> +#define VTD_CONTEXT_TT_PASS_THROUGH (2ULL << 2)
>  /* Second Level Page Translation Pointer*/
>  #define VTD_CONTEXT_ENTRY_SLPTPTR   (~0xfffULL)
>  #define VTD_CONTEXT_ENTRY_RSVD_LO   (0xff0ULL | ~VTD_HAW_MASK)
> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
> index 0c89d98..361c07c 100644
> --- a/include/hw/i386/x86-iommu.h
> +++ b/include/hw/i386/x86-iommu.h
> @@ -73,6 +73,7 @@ typedef struct IEC_Notifier IEC_Notifier;
>  struct X86IOMMUState {
>      SysBusDevice busdev;
>      bool intr_supported;        /* Whether vIOMMU supports IR */
> +    bool dt_supported;          /* Whether vIOMMU supports DT */
>      IommuType type;             /* IOMMU type - AMD/Intel     */
>      QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
>  };
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e39b764..ec62239 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -738,11 +738,18 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>                      "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
>                      ce->hi, ce->lo);
>          return -VTD_FR_CONTEXT_ENTRY_INV;
> -    } else if (ce->lo & VTD_CONTEXT_ENTRY_TT) {
> -        VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in "
> -                    "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
> -                    ce->hi, ce->lo);
> -        return -VTD_FR_CONTEXT_ENTRY_INV;
> +    } else {
> +        switch (ce->lo & VTD_CONTEXT_ENTRY_TT) {
> +        case VTD_CONTEXT_TT_MULTI_LEVEL:
> +            /* fall through */
> +        case VTD_CONTEXT_TT_DEV_IOTLB:
> +            break;
> +        default:
> +            VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in "
> +                        "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
> +                        ce->hi, ce->lo);
> +            return -VTD_FR_CONTEXT_ENTRY_INV;
> +        }
>      }
>      return 0;
>  }
> @@ -1438,7 +1445,61 @@ static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>      vtd_iec_notify_all(s, !inv_desc->iec.granularity,
>                         inv_desc->iec.index,
>                         inv_desc->iec.index_mask);
> +    return true;
> +}
> +
> +static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
> +                                          VTDInvDesc *inv_desc)
> +{
> +    VTDAddressSpace *vtd_dev_as;
> +    IOMMUTLBEntry entry;
> +    struct VTDBus *vtd_bus;
> +    hwaddr addr;
> +    uint64_t sz;
> +    uint16_t sid;
> +    uint8_t devfn;
> +    bool size;
> +    uint8_t bus_num;
> +
> +    addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
> +    sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
> +    devfn = sid & 0xff;
> +    bus_num = sid >> 8;
> +    size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
> +
> +    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
> +        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
> +        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Device "
> +                    "IOTLB Invalidate Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
> +                    inv_desc->hi, inv_desc->lo);
> +        return false;
> +    }
> +
> +    vtd_bus = vtd_find_as_from_bus_num(s, bus_num);
> +    if (!vtd_bus) {
> +        goto done;
> +    }
> +
> +    vtd_dev_as = vtd_bus->dev_as[devfn];
> +    if (!vtd_dev_as) {
> +        goto done;
> +    }
> +
> +    if (size) {
> +        sz = 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);

This should be 1ULL.  It could also be converted to cto64:

(VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT)

Here, I'm shifting addr right to avoid the case of an addr that is all ones.

It probably could use a comment too. :)  The examples in table 2-4 of
the PCIe ATS specification are useful:

	S = 0, bits 15:12 = xxxx     range size: 4K
	S = 1, bits 15:12 = xxx0     range size: 8K
	S = 1, bits 15:12 = xx01     range size: 16K
	S = 1, bits 15:12 = x011     range size: 32K
	S = 1, bits 15:12 = 0111     range size: 64K

        and so on

> +        addr &= ~(sz - 1);
> +    } else {
> +        sz = VTD_PAGE_SIZE;
> +    }
>  
> +    entry.target_as = &vtd_dev_as->as;
> +    entry.addr_mask = sz - 1;
> +    entry.iova = addr;

If S=1, entry.iova must mask away the 1 bits that specified the size.
For example,

     addr = 0xabcd1000

has cto64(0xabcd1) == 1, so it indicates a 16K invalidation from
0xabcd0000 to 0xabcd3fff.  The "1" must be masked away with "addr & -sz"
or "addr & ~entry.addr_mask".

Thanks,

Paolo

> +    entry.perm = IOMMU_NONE;
> +    entry.translated_addr = 0;
> +    memory_region_notify_iommu(entry.target_as->root, entry);
> +
> +done:
>      return true;
>  }
>  
> @@ -1490,6 +1551,14 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>          }
>          break;
>  
> +    case VTD_INV_DESC_DEVICE:
> +        VTD_DPRINTF(INV, "Device IOTLB Invalidation Descriptor hi 0x%"PRIx64
> +                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
> +        if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>      default:
>          VTD_DPRINTF(GENERAL, "error: unkonw Invalidation Descriptor type "
>                      "hi 0x%"PRIx64 " lo 0x%"PRIx64 " type %"PRIu8,
> @@ -2415,6 +2484,10 @@ static void vtd_init(IntelIOMMUState *s)
>          assert(s->intr_eim != ON_OFF_AUTO_AUTO);
>      }
>  
> +    if (x86_iommu->dt_supported) {
> +        s->ecap |= VTD_ECAP_DT;
> +    }
> +
>      vtd_reset_context_cache(s);
>      vtd_reset_iotlb(s);
>  
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 2278af7..23dcd3f 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -106,6 +106,18 @@ static void x86_iommu_intremap_prop_set(Object *o, bool value, Error **errp)
>      s->intr_supported = value;
>  }
>  
> +static bool x86_iommu_device_iotlb_prop_get(Object *o, Error **errp)
> +{
> +    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
> +    return s->dt_supported;
> +}
> +
> +static void x86_iommu_device_iotlb_prop_set(Object *o, bool value, Error **errp)
> +{
> +    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
> +    s->dt_supported = value;
> +}
> +
>  static void x86_iommu_instance_init(Object *o)
>  {
>      X86IOMMUState *s = X86_IOMMU_DEVICE(o);
> @@ -114,6 +126,11 @@ static void x86_iommu_instance_init(Object *o)
>      s->intr_supported = false;
>      object_property_add_bool(o, "intremap", x86_iommu_intremap_prop_get,
>                               x86_iommu_intremap_prop_set, NULL);
> +    s->dt_supported = false;
> +    object_property_add_bool(o, "device-iotlb",
> +                             x86_iommu_device_iotlb_prop_get,
> +                             x86_iommu_device_iotlb_prop_set,
> +                             NULL);
>  }
>  
>  static const TypeInfo x86_iommu_info = {
> 
