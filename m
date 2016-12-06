Received: from eggs.gnu.org ([2001:4830:134:3::10]:51047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cEKNZ-00053k-Oe
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1cEKNU-0001u0-Nw
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:22:13 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1cEKNU-0001tj-Ev
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 13:22:08 -0500
References: <1481044410-23862-1-git-send-email-kwankhede@nvidia.com>
	<20161206103859.2fd91db0@t450s.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f651038a-ce11-eb9c-3454-f0530e0f7db4@nvidia.com>
Date: Tue, 6 Dec 2016 23:50:59 +0530
MIME-Version: 1.0
In-Reply-To: <20161206103859.2fd91db0@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio iommu type1: Fix size argument
 to vfio_find_dma() during DMA UNMAP.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org



On 12/6/2016 11:08 PM, Alex Williamson wrote:
> On Tue, 6 Dec 2016 22:43:30 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> vfio_dma keeps track of address range from (dma->iova + 0) to
>> (dma->iova + dma->size - 1), while vfio_find_dma() search logic looks for
>> range from (dma->iova + 1) to (dma->iova + dma->size).
> 
> This is not true.  The issue is with the non-inclusive address at the
> end of a range being incompatible with passing zero for the range
> size.  Passing zero for the range size is a bit of a hack and doing
> such triggers a corner case in the end of range detection where we test
> (start + size <= dma->iova).  Using <= here covers the non-inclusive
> range end, ie. if the range was start=0x0, size=0x1000, the range is
> actually 0x0-0xfff.  Thus if start+size is 0x1000, it should not be
> considered part of a range beginning at 0x1000.  So there's no
> incompatibility as implied in the statement above, it's more that using
> zero for the size isn't compatible with matching the start address of
> an existing vfio_dma.  Thanks,
> 

Makes sense. Updating the description of both patch.

Thanks,
Kirti

> Alex
> 
>> In vfio_find_dma(), when the start address is equal to dma->iova and size
>> is 0, check for the end of search range makes it to take wrong side of
>> RB-tree. That fails the search even though the address is present in
>> mapped dma ranges. Due to this, in vfio_dma_do_unmap(), while checking
>> boundary conditions, size should be set to 1 for verifying start address
>> of unmap range.
>> vfio_find_dma() is also used to verify last address in unmap range with
>> size = 0, but in that case address to be searched is calculated with
>> size - 1 and so it works correctly.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Signed-off-by: Neo Jia <cjia@nvidia.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index a28fbddb505c..8e9e94ccb2ff 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -826,7 +826,7 @@ again:
>>  	 * mappings within the range.
>>  	 */
>>  	if (iommu->v2) {
>> -		dma = vfio_find_dma(iommu, unmap->iova, 0);
>> +		dma = vfio_find_dma(iommu, unmap->iova, 1);
>>  		if (dma && dma->iova != unmap->iova) {
>>  			ret = -EINVAL;
>>  			goto unlock;
> 
