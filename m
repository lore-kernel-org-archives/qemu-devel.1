Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B241C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B717E2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hBFm9pUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B717E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iov9H-0005rd-Po
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 15:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iov8L-0005KJ-9c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iov8J-0006xM-1J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:07:21 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iov8I-0006vz-Nz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:07:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e14e4e30001>; Tue, 07 Jan 2020 12:06:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 07 Jan 2020 12:07:16 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 12:07:16 -0800
Received: from [10.40.100.83] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 20:07:07 +0000
Subject: Re: [PATCH v11 Kernel 3/6] vfio iommu: Implementation of ioctl to for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
 <1576602651-15430-4-git-send-email-kwankhede@nvidia.com>
 <20191217151203.342b686a@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <ebd08133-e258-9f5e-5c8f-f88d7165cd7a@nvidia.com>
Date: Wed, 8 Jan 2020 01:37:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191217151203.342b686a@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1578427619; bh=IF4NHQPWea6S9lG9Pzp90OE5CkGeqEJ5WiCLBgMiC28=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=hBFm9pUt8R5iKGILOBH0wlzOPBzJU8eyM7+Q5x5k4k4UDm/cr3vk3fhPeZWfuVFXA
 drF6b3IZ5X6GjPOTnKVm+QFo0dmvqmLSgUsWKOBm5iPAKqtlj/dKqKUG+mfgscwCdf
 Mz+HKEOuIAqswR5uQzXVYn1zBn6gT5IxyH3tLLkqheFd6q1Kbn8kj/jSCoNarQj5mh
 V1IOcOIpaoxvCyqOtzZtcUZaFlh/bI0+CEtJnioMRBuRbiYdKzMlEgKgZXqQXoMyuA
 AZ2+h9OfIUm2WU8GZtqfVsiwfqtSD4GCXyhipU/ncQcX4Cq0JJ9CH8ZwTA0xfazoWd
 BllJZ7kTsz+QQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/18/2019 3:42 AM, Alex Williamson wrote:
> On Tue, 17 Dec 2019 22:40:48 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
>> - Start unpinned pages dirty pages tracking while migration is active and
>>    device is running, i.e. during pre-copy phase.
>> - Stop unpinned pages dirty pages tracking. This is required to stop
>>    unpinned dirty pages tracking if migration failed or cancelled during
>>    pre-copy phase. Unpinned pages tracking is clear.
>> - Get dirty pages bitmap. Stop unpinned dirty pages tracking and clear
>>    unpinned pages information on bitmap read. This ioctl returns bitmap of
>>    dirty pages, its user space application responsibility to copy content
>>    of dirty pages from source to destination during migration.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 218 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 209 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 2ada8e6cdb88..215aecb25453 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -70,6 +70,7 @@ struct vfio_iommu {
>>   	unsigned int		dma_avail;
>>   	bool			v2;
>>   	bool			nesting;
>> +	bool			dirty_page_tracking;
>>   };
>>   
>>   struct vfio_domain {
>> @@ -112,6 +113,7 @@ struct vfio_pfn {
>>   	dma_addr_t		iova;		/* Device address */
>>   	unsigned long		pfn;		/* Host pfn */
>>   	atomic_t		ref_count;
>> +	bool			unpinned;
> 
> Doesn't this duplicate ref_count == 0?
> 

Yes, actually. Removing unpinned.

>>   };
>>   
>>   struct vfio_regions {
>> @@ -244,6 +246,32 @@ static void vfio_remove_from_pfn_list(struct vfio_dma *dma,
>>   	kfree(vpfn);
>>   }
>>   
>> +static void vfio_remove_unpinned_from_pfn_list(struct vfio_dma *dma, bool warn)
>> +{
>> +	struct rb_node *n = rb_first(&dma->pfn_list);
>> +
>> +	for (; n; n = rb_next(n)) {
>> +		struct vfio_pfn *vpfn = rb_entry(n, struct vfio_pfn, node);
>> +
>> +		if (warn)
>> +			WARN_ON_ONCE(vpfn->unpinned);
> 
> This option isn't used within this patch, perhaps better to add with
> its use case, but it seems this presents both a denial of service via
> kernel tainting and an undocumented feature/bug.  As I interpret its
> use within the next patch, this generates a warning if the user
> unmapped the IOVA with dirty pages present, without using the dirty
> bitmap extension of the unmap call.  Our job is not to babysit the
> user, if they don't care to look at the dirty bitmap, that's their
> prerogative.  Drop this warning and the function arg.
> 

I was trying to extra cautious. Dropping this warning.

>> +
>> +		if (vpfn->unpinned)
> 
> if (!atomic_read(&vpfn->ref_count))
> 

Ok.

>> +			vfio_remove_from_pfn_list(dma, vpfn);
>> +	}
>> +}
>> +
>> +static void vfio_remove_unpinned_from_dma_list(struct vfio_iommu *iommu)
>> +{
>> +	struct rb_node *n = rb_first(&iommu->dma_list);
>> +
>> +	for (; n; n = rb_next(n)) {
>> +		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
>> +
>> +		vfio_remove_unpinned_from_pfn_list(dma, false);
>> +	}
>> +}
>> +
>>   static struct vfio_pfn *vfio_iova_get_vfio_pfn(struct vfio_dma *dma,
>>   					       unsigned long iova)
>>   {
>> @@ -254,13 +282,17 @@ static struct vfio_pfn *vfio_iova_get_vfio_pfn(struct vfio_dma *dma,
>>   	return vpfn;
>>   }
>>   
>> -static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>> +static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn,
>> +				  bool dirty_tracking)
>>   {
>>   	int ret = 0;
>>   
>>   	if (atomic_dec_and_test(&vpfn->ref_count)) {
>>   		ret = put_pfn(vpfn->pfn, dma->prot);
>> -		vfio_remove_from_pfn_list(dma, vpfn);
>> +		if (dirty_tracking)
>> +			vpfn->unpinned = true;
>> +		else
>> +			vfio_remove_from_pfn_list(dma, vpfn);
> 
> This can also simply use ref_count.  BTW, checking the locking, I think
> ->ref_count is only manipulated under iommu->lock, therefore the atomic
> ops are probably overkill.
> 

Yes, I'll create a seperate commit to remove atomic.

>>   	}
>>   	return ret;
>>   }
>> @@ -504,7 +536,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
>>   }
>>   
>>   static int vfio_unpin_page_external(struct vfio_dma *dma, dma_addr_t iova,
>> -				    bool do_accounting)
>> +				    bool do_accounting, bool dirty_tracking)
>>   {
>>   	int unlocked;
>>   	struct vfio_pfn *vpfn = vfio_find_vpfn(dma, iova);
>> @@ -512,7 +544,10 @@ static int vfio_unpin_page_external(struct vfio_dma *dma, dma_addr_t iova,
>>   	if (!vpfn)
>>   		return 0;
>>   
>> -	unlocked = vfio_iova_put_vfio_pfn(dma, vpfn);
>> +	if (vpfn->unpinned)
>> +		return 0;
> 
> Combine with above, if (!vpfn || !vpfn->ref_count)
> 

Yes.

>> +
>> +	unlocked = vfio_iova_put_vfio_pfn(dma, vpfn, dirty_tracking);
>>   
>>   	if (do_accounting)
>>   		vfio_lock_acct(dma, -unlocked, true);
>> @@ -571,8 +606,12 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>   
>>   		vpfn = vfio_iova_get_vfio_pfn(dma, iova);
>>   		if (vpfn) {
>> -			phys_pfn[i] = vpfn->pfn;
>> -			continue;
>> +			if (vpfn->unpinned)
>> +				vfio_remove_from_pfn_list(dma, vpfn);
> 
> This seems inefficient, we have an allocated vpfn at the right places
> in the list, wouldn't it be better to repin the page?
> 

vfio_pin_page_external() takes care of pinning and accounting as well.


>> +			else {
>> +				phys_pfn[i] = vpfn->pfn;
>> +				continue;
>> +			}
>>   		}
>>   
>>   		remote_vaddr = dma->vaddr + iova - dma->iova;
>> @@ -583,7 +622,8 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>   
>>   		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn[i]);
>>   		if (ret) {
>> -			vfio_unpin_page_external(dma, iova, do_accounting);
>> +			vfio_unpin_page_external(dma, iova, do_accounting,
>> +						 false);
>>   			goto pin_unwind;
>>   		}
>>   	}
>> @@ -598,7 +638,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>   
>>   		iova = user_pfn[j] << PAGE_SHIFT;
>>   		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>> -		vfio_unpin_page_external(dma, iova, do_accounting);
>> +		vfio_unpin_page_external(dma, iova, do_accounting, false);
>>   		phys_pfn[j] = 0;
>>   	}
>>   pin_done:
>> @@ -632,7 +672,8 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>>   		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>>   		if (!dma)
>>   			goto unpin_exit;
>> -		vfio_unpin_page_external(dma, iova, do_accounting);
>> +		vfio_unpin_page_external(dma, iova, do_accounting,
>> +					 iommu->dirty_page_tracking);
>>   	}
>>   
>>   unpin_exit:
>> @@ -850,6 +891,88 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>>   	return bitmap;
>>   }
>>   
>> +/*
>> + * start_iova is the reference from where bitmaping started. This is called
>> + * from DMA_UNMAP where start_iova can be different than iova
>> + */
>> +
>> +static void vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
>> +				  size_t size, uint64_t pgsize,
>> +				  dma_addr_t start_iova, unsigned long *bitmap)
>> +{
>> +	struct vfio_dma *dma;
>> +	dma_addr_t i = iova;
>> +	unsigned long pgshift = __ffs(pgsize);
>> +
>> +	while ((dma = vfio_find_dma(iommu, i, pgsize))) {
>> +		/* mark all pages dirty if all pages are pinned and mapped. */
>> +		if (dma->iommu_mapped) {
>> +			dma_addr_t iova_limit;
>> +
>> +			iova_limit = (dma->iova + dma->size) < (iova + size) ?
>> +				     (dma->iova + dma->size) : (iova + size);
> 
> min(dma->iova + dma->size, iova + size);
> 
>> +
>> +			for (; i < iova_limit; i += pgsize) {
>> +				unsigned int start;
>> +
>> +				start = (i - start_iova) >> pgshift;
>> +
>> +				__bitmap_set(bitmap, start, 1);
> 
> Why __bitmap_set() rather than bitmap_set()?  Also why not try to take
> advantage of the number of bits arg?
> 
bitmap_set() can be used, I didn't checked about it earlier.
Yes, we can take advantage of nbits, updating it.


>> +			}
>> +			if (i >= iova + size)
>> +				return;
> 
> This skips the removed unpinned callback at the end of the loop,
> leaving unnecessarily tracked, unpinned vpfns.
> 

Right, fixing it.

>> +		} else {
>> +			struct rb_node *n = rb_first(&dma->pfn_list);
>> +			bool found = false;
>> +
>> +			for (; n; n = rb_next(n)) {
>> +				struct vfio_pfn *vpfn = rb_entry(n,
>> +							struct vfio_pfn, node);
>> +				if (vpfn->iova >= i) {
> 
> This doesn't look right, how does a vpfn with .iova > i necessarily
> contain i?
> 

i might not be equal to dma->iova.
Also iova == i might not be pinned, but there might be pages pinned 
between i to iova + size. So find a vpfn node whose (vpfn->iova >= i)

>> +					found = true;
>> +					break;
>> +				}
>> +			}
>> +
>> +			if (!found) {
>> +				i += dma->size;
>> +				continue;
>> +			}
>> +
>> +			for (; n; n = rb_next(n)) {
>> +				unsigned int start;
>> +				struct vfio_pfn *vpfn = rb_entry(n,
>> +							struct vfio_pfn, node);
>> +
>> +				if (vpfn->iova >= iova + size)
>> +					return;
>> +
>> +				start = (vpfn->iova - start_iova) >> pgshift;
>> +
>> +				__bitmap_set(bitmap, start, 1);
> 
> Don't we need to iterate over the vfpn relative to pgsize?  Oh, I
> see below that pgsize is the minimum user advertised size, which is at
> least PAGE_SIZE, to maybe not.  Same bitmap_set() question as above
> though.
> 

Changing to bitmap_set.

>> +
>> +				i = vpfn->iova + pgsize;
>> +			}
>> +		}
>> +		vfio_remove_unpinned_from_pfn_list(dma, false);
>> +	}
>> +}
>> +
>> +static long verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
>> +{
>> +	long bsize;
>> +
>> +	if (!bitmap_size || bitmap_size > SIZE_MAX)
>> +		return -EINVAL;
>> +
>> +	bsize = ALIGN(npages, BITS_PER_LONG) / sizeof(unsigned long);
>> +
>> +	if (bitmap_size < bsize)
>> +		return -EINVAL;
>> +
>> +	return bsize;
>> +}
>> +
>>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   			     struct vfio_iommu_type1_dma_unmap *unmap)
>>   {
>> @@ -2297,6 +2420,83 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   
>>   		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>   			-EFAULT : 0;
>> +	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
>> +		struct vfio_iommu_type1_dirty_bitmap range;
>> +		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
>> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
>> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
>> +		int ret;
>> +
>> +		if (!iommu->v2)
>> +			return -EACCES;
>> +
>> +		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
>> +				    bitmap);
>> +
>> +		if (copy_from_user(&range, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (range.argsz < minsz || range.flags & ~mask)
>> +			return -EINVAL;
>> +
> 
> flags should be sanitized further, invalid combinations should be
> rejected.  For example, if a user provides STOP|GET_BITMAP it should
> either populate the bitmap AND turn off tracking, or error.  It's not
> acceptable to turn off tracking and silently ignore GET_BITMAP.
> 

Ok. adding a check such that only one flag should be set at a time is 
valid.

>> +		if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
>> +			iommu->dirty_page_tracking = true;
>> +			return 0;
>> +		} else if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
>> +			iommu->dirty_page_tracking = false;
>> +
>> +			mutex_lock(&iommu->lock);
>> +			vfio_remove_unpinned_from_dma_list(iommu);
>> +			mutex_unlock(&iommu->lock);
>> +			return 0;
>> +
>> +		} else if (range.flags &
>> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
>> +			uint64_t iommu_pgmask;
>> +			unsigned long pgshift = __ffs(range.pgsize);
>> +			unsigned long *bitmap;
>> +			long bsize;
>> +
>> +			iommu_pgmask =
>> +			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
>> +
>> +			if (((range.pgsize - 1) & iommu_pgmask) !=
>> +			    (range.pgsize - 1))
>> +				return -EINVAL;
>> +
>> +			if (range.iova & iommu_pgmask)
>> +				return -EINVAL;
>> +			if (!range.size || range.size > SIZE_MAX)
>> +				return -EINVAL;
>> +			if (range.iova + range.size < range.iova)
>> +				return -EINVAL;
>> +
>> +			bsize = verify_bitmap_size(range.size >> pgshift,
>> +						   range.bitmap_size);
>> +			if (bsize < 0)
>> +				return ret;
>> +
>> +			bitmap = kmalloc(bsize, GFP_KERNEL);
> 
> I think I remember mentioning previously that we cannot allocate an
> arbitrary buffer on behalf of the user, it's far too easy for them to
> kill the kernel that way.  kmalloc is also limited in what it can
> alloc.  

That's the reason added verify_bitmap_size(), so that size is verified

> Can't we use the user buffer directly or only work on a part of
> it at a time?
> 

without copy_from_user(), how?


>> +			if (!bitmap)
>> +				return -ENOMEM;
>> +
>> +			ret = copy_from_user(bitmap,
>> +			     (void __user *)range.bitmap, bsize) ? -EFAULT : 0;
>> +			if (ret)
>> +				goto bitmap_exit;
>> +
>> +			iommu->dirty_page_tracking = false;
> 
> a) This is done outside of the mutex and susceptible to races,

moving inside lock

> b) why is this done?
once bitmap is read, dirty_page_tracking should be stopped. Right?

Thanks,
Kirti

> 
> Thanks,
> Alex
> 
>> +			mutex_lock(&iommu->lock);
>> +			vfio_iova_dirty_bitmap(iommu, range.iova, range.size,
>> +					     range.pgsize, range.iova, bitmap);
>> +			mutex_unlock(&iommu->lock);
>> +
>> +			ret = copy_to_user((void __user *)range.bitmap, bitmap,
>> +					   range.bitmap_size) ? -EFAULT : 0;
>> +bitmap_exit:
>> +			kfree(bitmap);
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	return -ENOTTY;
> 

