Received: from eggs.gnu.org ([2001:4830:134:3::10]:43532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceEr4-0005rR-HJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceEr1-0004g8-Cv
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:43:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceEr1-0004ft-42
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 00:43:43 -0500
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c1f86fba-6b22-8316-156f-2024bee46b0c@redhat.com>
Date: Thu, 16 Feb 2017 13:43:30 +0800
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, Alex Williamson <alex.williamson@redhat.com>



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 13:36, Liu, Yi L wrote:
>> -----Original Message-----
>> From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongn=
u.org]
>> On Behalf Of Michael S. Tsirkin
>> Sent: Tuesday, January 10, 2017 1:40 PM
>> To: qemu-devel@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Eduardo Habkost
>> <ehabkost@redhat.com>; Jason Wang <jasowang@redhat.com>; Peter Xu
>> <peterx@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
>> Henderson <rth@twiddle.net>
>> Subject: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
>> descriptor
>>
>> From: Jason Wang <jasowang@redhat.com>
>>
>> This patch enables device IOTLB support for intel iommu. The major wor=
k is to
>> implement QI device IOTLB descriptor processing and notify the device =
through
>> iommu notifier.
>>
> Hi Jason/Michael,
> =09
> Recently Peter Xu's patch also touched intel-iommu emulation. His patch=
 shadows
> second-level page table by capturing iotlb flush from guest. It would r=
esult in page
> table updating in host. Does this patch also use the same map/umap API =
provided
> by VFIO?

Yes, it depends on the iommu notifier too.

> If it is, then I think it would also update page table in host. It look=
s to be
> a duplicate update. Pls refer to the following snapshot captured from s=
ection 6.5.2.5
> of vtd spec.
>
> "Since translation requests from a device may be serviced by hardware f=
rom the IOTLB, software must
> always request IOTLB invalidation (iotlb_inv_dsc) before requesting cor=
responding Device-TLB
> (dev_tlb_inv_dsc) invalidation."
>
> Maybe for device-iotlb, we need a separate API which just pass down the=
 invalidate
> info without updating page table. Any thoughts?

cc Alex.

If we want ATS to be visible for guest (but I'm not sure if VFIO support=20
this), we probably need another notifier or a new flag.

Thanks

>
> Thanks,
> Yi L
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   hw/i386/intel_iommu_internal.h | 13 ++++++-
>>   include/hw/i386/x86-iommu.h    |  1 +
>>   hw/i386/intel_iommu.c          | 83
>> +++++++++++++++++++++++++++++++++++++++---
>>   hw/i386/x86-iommu.c            | 17 +++++++++
>>   4 files changed, 107 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h index 11abfa2..356f188 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -183,6 +183,7 @@
>>   /* (offset >> 4) << 8 */
>>   #define VTD_ECAP_IRO                (DMAR_IOTLB_REG_OFFSET << 4)
>>   #define VTD_ECAP_QI                 (1ULL << 1)
>> +#define VTD_ECAP_DT                 (1ULL << 2)
>>   /* Interrupt Remapping support */
>>   #define VTD_ECAP_IR                 (1ULL << 3)
>>   #define VTD_ECAP_EIM                (1ULL << 4)
>> @@ -326,6 +327,7 @@ typedef union VTDInvDesc VTDInvDesc;
>>   #define VTD_INV_DESC_TYPE               0xf
>>   #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalid=
ate Desc */
>>   #define VTD_INV_DESC_IOTLB              0x2
>> +#define VTD_INV_DESC_DEVICE             0x3
>>   #define VTD_INV_DESC_IEC                0x4 /* Interrupt Entry Cache
>>                                                  Invalidate Descriptor=
 */
>>   #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Des=
criptor */
>> @@ -361,6 +363,13 @@ typedef union VTDInvDesc VTDInvDesc;
>>   #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>>   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>>
>> +/* Mask for Device IOTLB Invalidate Descriptor */ #define
>> +VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
>> +#define VTD_INV_DESC_DEVICE_IOTLB_SIZE(val) ((val) & 0x1) #define
>> +VTD_INV_DESC_DEVICE_IOTLB_SID(val) (((val) >> 32) & 0xFFFFULL) #defin=
e
>> +VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL #define
>> +VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
>> +
>>   /* Information about page-selective IOTLB invalidate */  struct
>> VTDIOTLBPageInvInfo {
>>       uint16_t domain_id;
>> @@ -399,8 +408,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>>   #define VTD_CONTEXT_ENTRY_FPD       (1ULL << 1) /* Fault Processing =
Disable
>> */
>>   #define VTD_CONTEXT_ENTRY_TT        (3ULL << 2) /* Translation Type =
*/
>>   #define VTD_CONTEXT_TT_MULTI_LEVEL  0
>> -#define VTD_CONTEXT_TT_DEV_IOTLB    1
>> -#define VTD_CONTEXT_TT_PASS_THROUGH 2
>> +#define VTD_CONTEXT_TT_DEV_IOTLB    (1ULL << 2)
>> +#define VTD_CONTEXT_TT_PASS_THROUGH (2ULL << 2)
>>   /* Second Level Page Translation Pointer*/
>>   #define VTD_CONTEXT_ENTRY_SLPTPTR   (~0xfffULL)
>>   #define VTD_CONTEXT_ENTRY_RSVD_LO   (0xff0ULL | ~VTD_HAW_MASK)
>> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
>> index 0c89d98..361c07c 100644
>> --- a/include/hw/i386/x86-iommu.h
>> +++ b/include/hw/i386/x86-iommu.h
>> @@ -73,6 +73,7 @@ typedef struct IEC_Notifier IEC_Notifier;  struct
>> X86IOMMUState {
>>       SysBusDevice busdev;
>>       bool intr_supported;        /* Whether vIOMMU supports IR */
>> +    bool dt_supported;          /* Whether vIOMMU supports DT */
>>       IommuType type;             /* IOMMU type - AMD/Intel     */
>>       QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */ =
 }; diff --git
>> a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index e39b764..ec62239
>> 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -738,11 +738,18 @@ static int
>> vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>                       "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
>>                       ce->hi, ce->lo);
>>           return -VTD_FR_CONTEXT_ENTRY_INV;
>> -    } else if (ce->lo & VTD_CONTEXT_ENTRY_TT) {
>> -        VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in =
"
>> -                    "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
>> -                    ce->hi, ce->lo);
>> -        return -VTD_FR_CONTEXT_ENTRY_INV;
>> +    } else {
>> +        switch (ce->lo & VTD_CONTEXT_ENTRY_TT) {
>> +        case VTD_CONTEXT_TT_MULTI_LEVEL:
>> +            /* fall through */
>> +        case VTD_CONTEXT_TT_DEV_IOTLB:
>> +            break;
>> +        default:
>> +            VTD_DPRINTF(GENERAL, "error: unsupported Translation Type=
 in "
>> +                        "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
>> +                        ce->hi, ce->lo);
>> +            return -VTD_FR_CONTEXT_ENTRY_INV;
>> +        }
>>       }
>>       return 0;
>>   }
>> @@ -1438,7 +1445,61 @@ static bool
>> vtd_process_inv_iec_desc(IntelIOMMUState *s,
>>       vtd_iec_notify_all(s, !inv_desc->iec.granularity,
>>                          inv_desc->iec.index,
>>                          inv_desc->iec.index_mask);
>> +    return true;
>> +}
>> +
>> +static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>> +                                          VTDInvDesc *inv_desc) {
>> +    VTDAddressSpace *vtd_dev_as;
>> +    IOMMUTLBEntry entry;
>> +    struct VTDBus *vtd_bus;
>> +    hwaddr addr;
>> +    uint64_t sz;
>> +    uint16_t sid;
>> +    uint8_t devfn;
>> +    bool size;
>> +    uint8_t bus_num;
>> +
>> +    addr =3D VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
>> +    sid =3D VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
>> +    devfn =3D sid & 0xff;
>> +    bus_num =3D sid >> 8;
>> +    size =3D VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
>> +
>> +    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
>> +        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
>> +        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Devic=
e "
>> +                    "IOTLB Invalidate Descriptor hi 0x%"PRIx64 " lo 0=
x%"PRIx64,
>> +                    inv_desc->hi, inv_desc->lo);
>> +        return false;
>> +    }
>> +
>> +    vtd_bus =3D vtd_find_as_from_bus_num(s, bus_num);
>> +    if (!vtd_bus) {
>> +        goto done;
>> +    }
>> +
>> +    vtd_dev_as =3D vtd_bus->dev_as[devfn];
>> +    if (!vtd_dev_as) {
>> +        goto done;
>> +    }
>> +
>> +    if (size) {
>> +        sz =3D 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);
>> +        addr &=3D ~(sz - 1);
>> +    } else {
>> +        sz =3D VTD_PAGE_SIZE;
>> +    }
>>
>> +    entry.target_as =3D &vtd_dev_as->as;
>> +    entry.addr_mask =3D sz - 1;
>> +    entry.iova =3D addr;
>> +    entry.perm =3D IOMMU_NONE;
>> +    entry.translated_addr =3D 0;
>> +    memory_region_notify_iommu(entry.target_as->root, entry);
>> +
>> +done:
>>       return true;
>>   }
>>
>> @@ -1490,6 +1551,14 @@ static bool vtd_process_inv_desc(IntelIOMMUStat=
e
>> *s)
>>           }
>>           break;
>>
>> +    case VTD_INV_DESC_DEVICE:
>> +        VTD_DPRINTF(INV, "Device IOTLB Invalidation Descriptor hi 0x%=
"PRIx64
>> +                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
>> +        if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
>> +            return false;
>> +        }
>> +        break;
>> +
>>       default:
>>           VTD_DPRINTF(GENERAL, "error: unkonw Invalidation Descriptor =
type "
>>                       "hi 0x%"PRIx64 " lo 0x%"PRIx64 " type %"PRIu8, @=
@ -2415,6
>> +2484,10 @@ static void vtd_init(IntelIOMMUState *s)
>>           assert(s->intr_eim !=3D ON_OFF_AUTO_AUTO);
>>       }
>>
>> +    if (x86_iommu->dt_supported) {
>> +        s->ecap |=3D VTD_ECAP_DT;
>> +    }
>> +
>>       vtd_reset_context_cache(s);
>>       vtd_reset_iotlb(s);
>>
>> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c index
>> 2278af7..23dcd3f 100644
>> --- a/hw/i386/x86-iommu.c
>> +++ b/hw/i386/x86-iommu.c
>> @@ -106,6 +106,18 @@ static void x86_iommu_intremap_prop_set(Object *o=
,
>> bool value, Error **errp)
>>       s->intr_supported =3D value;
>>   }
>>
>> +static bool x86_iommu_device_iotlb_prop_get(Object *o, Error **errp) =
{
>> +    X86IOMMUState *s =3D X86_IOMMU_DEVICE(o);
>> +    return s->dt_supported;
>> +}
>> +
>> +static void x86_iommu_device_iotlb_prop_set(Object *o, bool value,
>> +Error **errp) {
>> +    X86IOMMUState *s =3D X86_IOMMU_DEVICE(o);
>> +    s->dt_supported =3D value;
>> +}
>> +
>>   static void x86_iommu_instance_init(Object *o)  {
>>       X86IOMMUState *s =3D X86_IOMMU_DEVICE(o); @@ -114,6 +126,11 @@
>> static void x86_iommu_instance_init(Object *o)
>>       s->intr_supported =3D false;
>>       object_property_add_bool(o, "intremap", x86_iommu_intremap_prop_=
get,
>>                                x86_iommu_intremap_prop_set, NULL);
>> +    s->dt_supported =3D false;
>> +    object_property_add_bool(o, "device-iotlb",
>> +                             x86_iommu_device_iotlb_prop_get,
>> +                             x86_iommu_device_iotlb_prop_set,
>> +                             NULL);
>>   }
>>
>>   static const TypeInfo x86_iommu_info =3D {
>> --
>> MST
>>
