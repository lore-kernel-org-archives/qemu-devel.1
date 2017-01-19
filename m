Received: from eggs.gnu.org ([2001:4830:134:3::10]:42490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cU3Vb-0002nM-PT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cU3VY-0006A1-Mw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:35:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cU3VY-00068s-Dj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 22:35:28 -0500
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<2163e04a-68cb-6c49-61bf-71c9e32e0487@redhat.com>
	<b9d04ac2-1978-1821-abdf-d73ef80276e4@redhat.com>
	<20170119032805.GB4914@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6b0da7ee-818b-bd50-d9fe-f20714178d73@redhat.com>
Date: Thu, 19 Jan 2017 11:35:21 +0800
MIME-Version: 1.0
In-Reply-To: <20170119032805.GB4914@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>



On 2017=E5=B9=B401=E6=9C=8819=E6=97=A5 11:28, Peter Xu wrote:
> On Thu, Jan 19, 2017 at 10:50:59AM +0800, Jason Wang wrote:
>
> [...]
>
>>>> +static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
>>>> +                                          VTDInvDesc *inv_desc)
>>>> +{
>>>> +    VTDAddressSpace *vtd_dev_as;
>>>> +    IOMMUTLBEntry entry;
>>>> +    struct VTDBus *vtd_bus;
>>>> +    hwaddr addr;
>>>> +    uint64_t sz;
>>>> +    uint16_t sid;
>>>> +    uint8_t devfn;
>>>> +    bool size;
>>>> +    uint8_t bus_num;
>>>> +
>>>> +    addr =3D VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
>>>> +    sid =3D VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
>>>> +    devfn =3D sid & 0xff;
>>>> +    bus_num =3D sid >> 8;
>>>> +    size =3D VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
>>>> +
>>>> +    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
>>>> +        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
>>>> +        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Dev=
ice "
>>>> +                    "IOTLB Invalidate Descriptor hi 0x%"PRIx64 " lo=
 0x%"PRIx64,
>>>> +                    inv_desc->hi, inv_desc->lo);
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    vtd_bus =3D vtd_find_as_from_bus_num(s, bus_num);
>>>> +    if (!vtd_bus) {
>>>> +        goto done;
>>>> +    }
>>>> +
>>>> +    vtd_dev_as =3D vtd_bus->dev_as[devfn];
>>>> +    if (!vtd_dev_as) {
>>>> +        goto done;
>>>> +    }
>>>> +
>>>> +    if (size) {
>>>> +        sz =3D 1 << (ctz64(~(addr | (VTD_PAGE_MASK_4K - 1))) + 1);
>>> This should be 1ULL.
>> Yes.
>>
>>>    It could also be converted to cto64:
>>>
>>> (VTD_PAGE_SIZE * 2) << cto64(addr >> VTD_PAGE_SHIFT)
>>>
>>> Here, I'm shifting addr right to avoid the case of an addr that is al=
l ones.
>>>
>>> It probably could use a comment too. :)  The examples in table 2-4 of
>>> the PCIe ATS specification are useful:
>>>
>>> 	S =3D 0, bits 15:12 =3D xxxx     range size: 4K
>>> 	S =3D 1, bits 15:12 =3D xxx0     range size: 8K
>>> 	S =3D 1, bits 15:12 =3D xx01     range size: 16K
>>> 	S =3D 1, bits 15:12 =3D x011     range size: 32K
>>> 	S =3D 1, bits 15:12 =3D 0111     range size: 64K
>>>
>>>          and so on
>> This seems simpler let me add them comment and convert it to cto64.
>>
>>>> +        addr &=3D ~(sz - 1);
> [1]
>
>>>> +    } else {
>>>> +        sz =3D VTD_PAGE_SIZE;
>>>> +    }
>>>> +    entry.target_as =3D &vtd_dev_as->as;
>>>> +    entry.addr_mask =3D sz - 1;
>>>> +    entry.iova =3D addr;
>>> If S=3D1, entry.iova must mask away the 1 bits that specified the siz=
e.
>>> For example,
>>>
>>>       addr =3D 0xabcd1000
>>>
>>> has cto64(0xabcd1) =3D=3D 1, so it indicates a 16K invalidation from
>>> 0xabcd0000 to 0xabcd3fff.  The "1" must be masked away with "addr & -=
sz"
>>> or "addr & ~entry.addr_mask".
>>>
>>> Thanks,
>>>
>>> Paolo
>> Good catch.
>>
>> Let me fix it.
> Is above [1] doing that?
>
> Thanks,
>
> -- peterx

Yes, speak too fast :(

Thanks
