Received: from eggs.gnu.org ([2001:4830:134:3::10]:50978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0S1G-0006Hh-FF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1e0S1C-0005t6-EA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 08:46:22 -0400
References: <20171006114624.10771-1-maxime.coquelin@redhat.com>
	<20171006114624.10771-2-maxime.coquelin@redhat.com>
	<1a2849a9-1dc8-eb8b-8f59-5c9ca4849e1c@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <ca80a3c7-c011-fe61-2af6-6261bd6f4d42@redhat.com>
Date: Fri, 6 Oct 2017 14:46:07 +0200
MIME-Version: 1.0
In-Reply-To: <1a2849a9-1dc8-eb8b-8f59-5c9ca4849e1c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] exec: add page_mask for
 flatview_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org



On 10/06/2017 02:31 PM, Paolo Bonzini wrote:
> On 06/10/2017 13:46, Maxime Coquelin wrote:
>> +    hwaddr page_mask = ~TARGET_PAGE_MASK;
>> +    hwaddr plen = (hwaddr)(-1);
>> +
>> +    if (plen_out) {
>> +        plen = *plen_out;
>> +    }
>>   
>>       for (;;) {
>>           section = address_space_translate_internal(
>>                   flatview_to_dispatch(fv), addr, &addr,
>> -                plen, is_mmio);
>> +                &plen, is_mmio);
>>   
>>           iommu_mr = memory_region_get_iommu(section->mr);
>>           if (!iommu_mr) {
>> @@ -496,7 +520,8 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
>>                                   IOMMU_WO : IOMMU_RO);
>>           addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
>>                   | (addr & iotlb.addr_mask));
>> -        *plen = MIN(*plen, (addr | iotlb.addr_mask) - addr + 1);
>> +        page_mask = iotlb.addr_mask;
> 
> Should this be "page_mask &= iotlb.addr_mask"?
 >
> If you have multiple IOMMUs on top of each other (yeah, I know...) I
> think the smallest size should win.  This is also consistent with the
> MIN in the line below.

I agree, but changin to "page_mask &= iotlb.addr_mask" will not be
enough, we also have to change the init value. Else we will always end
up with 0xfff.

Maybe we could do as plen was handled before, i.e. setting page_mask
init value to (hwaddr)(-1), and after the loop set it to
~TARGET_PAGE_MASK if it hasn't been changed.

Does that sound reasonable?

Thanks,
Maxime
> 
> Otherwise looks good.
> 
> Paolo
> 
>> +        plen = MIN(plen, (addr | iotlb.addr_mask) - addr + 1);
>>           if (!(iotlb.perm & (1 << is_write))) {
>>               goto translate_fail;
> 
