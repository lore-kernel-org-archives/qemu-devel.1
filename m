Received: from eggs.gnu.org ([2001:4830:134:3::10]:41931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cU3Sw-0001A7-Ho
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:32:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cU3St-0004wK-D9
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:32:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cU3St-0004vm-3u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:32:43 -0500
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<2163e04a-68cb-6c49-61bf-71c9e32e0487@redhat.com>
	<b9d04ac2-1978-1821-abdf-d73ef80276e4@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <665c0c20-e39d-8f6e-2a09-e2169e5376bb@redhat.com>
Date: Thu, 19 Jan 2017 11:32:35 +0800
MIME-Version: 1.0
In-Reply-To: <b9d04ac2-1978-1821-abdf-d73ef80276e4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Richard Henderson <rth@twiddle.net>



On 2017=E5=B9=B401=E6=9C=8819=E6=97=A5 10:50, Jason Wang wrote:
>
>
> On 2017=E5=B9=B401=E6=9C=8818=E6=97=A5 20:19, Paolo Bonzini wrote:
>>
>> On 10/01/2017 06:39, Michael S. Tsirkin wrote:
>>> From: Jason Wang <jasowang@redhat.com>
>>>
>>> This patch enables device IOTLB support for intel iommu. The major
>>> work is to implement QI device IOTLB descriptor processing and notify
>>> the device through iommu notifier.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   hw/i386/intel_iommu_internal.h | 13 ++++++-
>>>   include/hw/i386/x86-iommu.h    |  1 +
>>>   hw/i386/intel_iommu.c          | 83=20
>>> +++++++++++++++++++++++++++++++++++++++---
>>>   hw/i386/x86-iommu.c            | 17 +++++++++
>>>   4 files changed, 107 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h=20
>>> b/hw/i386/intel_iommu_internal.h
>>> index 11abfa2..356f188 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -183,6 +183,7 @@
>>>   /* (offset >> 4) << 8 */
>>>   #define VTD_ECAP_IRO                (DMAR_IOTLB_REG_OFFSET << 4)
>>>   #define VTD_ECAP_QI                 (1ULL << 1)
>>> +#define VTD_ECAP_DT                 (1ULL << 2)
>>>   /* Interrupt Remapping support */
>>>   #define VTD_ECAP_IR                 (1ULL << 3)
>>>   #define VTD_ECAP_EIM                (1ULL << 4)
>>> @@ -326,6 +327,7 @@ typedef union VTDInvDesc VTDInvDesc;
>>>   #define VTD_INV_DESC_TYPE               0xf
>>>   #define VTD_INV_DESC_CC                 0x1 /* Context-cache=20
>>> Invalidate Desc */
>>>   #define VTD_INV_DESC_IOTLB              0x2
>>> +#define VTD_INV_DESC_DEVICE             0x3
>>>   #define VTD_INV_DESC_IEC                0x4 /* Interrupt Entry Cach=
e
>>>                                                  Invalidate=20
>>> Descriptor */
>>>   #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait=20
>>> Descriptor */
>>> @@ -361,6 +363,13 @@ typedef union VTDInvDesc VTDInvDesc;
>>>   #define VTD_INV_DESC_IOTLB_RSVD_LO 0xffffffff0000ff00ULL
>>>   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>>>   +/* Mask for Device IOTLB Invalidate Descriptor */
>>> +#define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &=20
>>> 0xfffffffffffff000ULL)
>>> +#define VTD_INV_DESC_DEVICE_IOTLB_SIZE(val) ((val) & 0x1)
>>> +#define VTD_INV_DESC_DEVICE_IOTLB_SID(val) (((val) >> 32) & 0xFFFFUL=
L)
>>> +#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
>>> +#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
>>> +
>>>   /* Information about page-selective IOTLB invalidate */
>>>   struct VTDIOTLBPageInvInfo {
>>>       uint16_t domain_id;
>>> @@ -399,8 +408,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>   #define VTD_CONTEXT_ENTRY_FPD       (1ULL << 1) /* Fault=20
>>> Processing Disable */
>>>   #define VTD_CONTEXT_ENTRY_TT        (3ULL << 2) /* Translation=20
>>> Type */
>>>   #define VTD_CONTEXT_TT_MULTI_LEVEL  0
>>> -#define VTD_CONTEXT_TT_DEV_IOTLB    1
>>> -#define VTD_CONTEXT_TT_PASS_THROUGH 2
>>> +#define VTD_CONTEXT_TT_DEV_IOTLB    (1ULL << 2)
>>> +#define VTD_CONTEXT_TT_PASS_THROUGH (2ULL << 2)
>>>   /* Second Level Page Translation Pointer*/
>>>   #define VTD_CONTEXT_ENTRY_SLPTPTR   (~0xfffULL)
>>>   #define VTD_CONTEXT_ENTRY_RSVD_LO   (0xff0ULL | ~VTD_HAW_MASK)
>>> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.=
h
>>> index 0c89d98..361c07c 100644
>>> --- a/include/hw/i386/x86-iommu.h
>>> +++ b/include/hw/i386/x86-iommu.h
>>> @@ -73,6 +73,7 @@ typedef struct IEC_Notifier IEC_Notifier;
>>>   struct X86IOMMUState {
>>>       SysBusDevice busdev;
>>>       bool intr_supported;        /* Whether vIOMMU supports IR */
>>> +    bool dt_supported;          /* Whether vIOMMU supports DT */
>>>       IommuType type;             /* IOMMU type - AMD/Intel     */
>>>       QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
>>>   };
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index e39b764..ec62239 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -738,11 +738,18 @@ static int=20
>>> vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>>                       "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
>>>                       ce->hi, ce->lo);
>>>           return -VTD_FR_CONTEXT_ENTRY_INV;
>>> -    } else if (ce->lo & VTD_CONTEXT_ENTRY_TT) {
>>> -        VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in=
 "
>>> -                    "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
>>> -                    ce->hi, ce->lo);
>>> -        return -VTD_FR_CONTEXT_ENTRY_INV;
>>> +    } else {
>>> +        switch (ce->lo & VTD_CONTEXT_ENTRY_TT) {
>>> +        case VTD_CONTEXT_TT_MULTI_LEVEL:
>>> +            /* fall through */
>>> +        case VTD_CONTEXT_TT_DEV_IOTLB:
>>> +            break;
>>> +        default:
>>> +            VTD_DPRINTF(GENERAL, "error: unsupported Translation=20
>>> Type in "
>>> +                        "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64=
,
>>> +                        ce->hi, ce->lo);
>>> +            return -VTD_FR_CONTEXT_ENTRY_INV;
>>> +        }
>>>       }
>>>       return 0;
>>>   }
>>> @@ -1438,7 +1445,61 @@ static bool=20
>>> vtd_process_inv_iec_desc(IntelIOMMUState *s,
>>>       vtd_iec_notify_all(s, !inv_desc->iec.granularity,
>>>                          inv_desc->iec.index,
>>>                          inv_desc->iec.index_mask);
>>> +    return true;
>>> +}
>>> +
>>> +static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>>> +                                          VTDInvDesc *inv_desc)
>>> +{
>>> +    VTDAddressSpace *vtd_dev_as;
>>> +    IOMMUTLBEntry entry;
>>> +    struct VTDBus *vtd_bus;
>>> +    hwaddr addr;
>>> +    uint64_t sz;
>>> +    uint16_t sid;
>>> +    uint8_t devfn;
>>> +    bool size;
>>> +    uint8_t bus_num;
>>> +
>>> +    addr =3D VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
>>> +    sid =3D VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
>>> +    devfn =3D sid & 0xff;
>>> +    bus_num =3D sid >> 8;
>>> +    size =3D VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
>>> +
>>> +    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
>>> +        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
>>> +        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in=20
>>> Device "
>>> +                    "IOTLB Invalidate Descriptor hi 0x%"PRIx64 " lo=20
>>> 0x%"PRIx64,
>>> +                    inv_desc->hi, inv_desc->lo);
>>> +        return false;
>>> +    }
>>> +
>>> +    vtd_bus =3D vtd_find_as_from_bus_num(s, bus_num);
>>> +    if (!vtd_bus) {
>>> +        goto done;
>>> +    }
>>> +
>>> +    vtd_dev_as =3D vtd_bus->dev_as[devfn];
>>> +    if (!vtd_dev_as) {
>>> +        goto done;
>>> +    }
>>> +
>>> +    if (size) {
>>> +        sz =3D 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);
>> This should be 1ULL.
>
> Yes.
>
>>    It could also be converted to cto64:
>>
>> (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT)
>>
>> Here, I'm shifting addr right to avoid the case of an addr that is=20
>> all ones.
>>
>> It probably could use a comment too. :)  The examples in table 2-4 of
>> the PCIe ATS specification are useful:
>>
>>     S =3D 0, bits 15:12 =3D xxxx     range size: 4K
>>     S =3D 1, bits 15:12 =3D xxx0     range size: 8K
>>     S =3D 1, bits 15:12 =3D xx01     range size: 16K
>>     S =3D 1, bits 15:12 =3D x011     range size: 32K
>>     S =3D 1, bits 15:12 =3D 0111     range size: 64K
>>
>>          and so on
>
> This seems simpler let me add them comment and convert it to cto64.
>
>>
>>> +        addr &=3D ~(sz - 1);
>>> +    } else {
>>> +        sz =3D VTD_PAGE_SIZE;
>>> +    }
>>>   +    entry.target_as =3D &vtd_dev_as->as;
>>> +    entry.addr_mask =3D sz - 1;
>>> +    entry.iova =3D addr;
>> If S=3D1, entry.iova must mask away the 1 bits that specified the size=
.
>> For example,
>>
>>       addr =3D 0xabcd1000
>>
>> has cto64(0xabcd1) =3D=3D 1, so it indicates a 16K invalidation from
>> 0xabcd0000 to 0xabcd3fff.  The "1" must be masked away with "addr & -s=
z"
>> or "addr & ~entry.addr_mask".
>>
>> Thanks,
>>
>> Paolo
>
> Good catch.

It should be addr & ~(sz - 1) I think? And it has been done above :)

Thanks

>
> Let me fix it.
>
> Thanks
>
