Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EE3C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8242467E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AAWgAqdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8242467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Kqz-0006Wo-BY
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1j2Kq3-00067c-E4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1j2Kq0-0000x7-Ll
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:11:54 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1j2Kpz-0000qz-QI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:11:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e45ad680001>; Thu, 13 Feb 2020 12:11:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 13 Feb 2020 12:11:49 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 13 Feb 2020 12:11:49 -0800
Received: from [10.40.101.172] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 20:11:40 +0000
Subject: Re: [PATCH v12 Kernel 4/7] vfio iommu: Implementation of ioctl to for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
 <1581104554-10704-5-git-send-email-kwankhede@nvidia.com>
 <20200210102518.490a0d87@x1.home>
 <7e7356c8-29ed-31fa-5c0b-2545ae69f321@nvidia.com>
 <20200212161320.02d8dfac@w520.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <0244aca6-80f7-1c1d-812e-d53a48b5479d@nvidia.com>
Date: Fri, 14 Feb 2020 01:41:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200212161320.02d8dfac@w520.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581624681; bh=xiVoieBRW2v08kbEd1YczMwhnMTz76U5hIDt6Vr05EA=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=AAWgAqdDbvsL1dYEacGpDNqcqPZbLR17ODICpGHXqDV88cS9IrUebvURZxxbD/l6W
 4V/Fuk8math+yQGU9D7VcccEyOdw11qug8znD1AzxwnT0pHZIRpvrsBwA1t9IrHwwS
 5f5q4hNd0Gk2CmOR/7Tqtr6GeAU3BFwpzRpfKCsubmL/Be9WcPDP6rr2rc8N9trlBK
 rizVbHckQeWegni9I3jzm/oBZlkNCnK+IxbvzIZfZnoYKHUpugbFpz9wOKS++eXJui
 QFcl8Gb3PcEFAf+GCCkSBz2Q8mlzK1YAifIaC0RGRR6lRydD9ZxP7yFXNOnvUbWS1U
 4cEeH6YtXqXHg==
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


<snip>

>>>>    
>>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
>>>> +				  size_t size, uint64_t pgsize,
>>>> +				  unsigned char __user *bitmap)
>>>> +{
>>>> +	struct vfio_dma *dma;
>>>> +	dma_addr_t i = iova, iova_limit;
>>>> +	unsigned int bsize, nbits = 0, l = 0;
>>>> +	unsigned long pgshift = __ffs(pgsize);
>>>> +
>>>> +	while ((dma = vfio_find_dma(iommu, i, pgsize))) {
>>>> +		int ret, j;
>>>> +		unsigned int npages = 0, shift = 0;
>>>> +		unsigned char temp = 0;
>>>> +
>>>> +		/* mark all pages dirty if all pages are pinned and mapped. */
>>>> +		if (dma->iommu_mapped) {
>>>> +			iova_limit = min(dma->iova + dma->size, iova + size);
>>>> +			npages = iova_limit/pgsize;
>>>> +			bitmap_set(dma->bitmap, 0, npages);
>>>
>>> npages is derived from iova_limit, which is the number of bits to set
>>> dirty relative to the first requested iova, not iova zero, ie. the set
>>> of dirty bits is offset from those requested unless iova == dma->iova.
>>>    
>>
>> Right, fixing.
>>
>>> Also I hope dma->bitmap was actually allocated.  Not only does the
>>> START error path potentially leave dirty tracking enabled without all
>>> the bitmap allocated, when does the bitmap get allocated for a new
>>> vfio_dma when dirty tracking is enabled?  Seems it only occurs if a
>>> vpfn gets marked dirty.
>>>    
>>
>> Right.
>>
>> Fixing error paths.
>>
>>
>>>> +		} else if (dma->bitmap) {
>>>> +			struct rb_node *n = rb_first(&dma->pfn_list);
>>>> +			bool found = false;
>>>> +
>>>> +			for (; n; n = rb_next(n)) {
>>>> +				struct vfio_pfn *vpfn = rb_entry(n,
>>>> +						struct vfio_pfn, node);
>>>> +				if (vpfn->iova >= i) {
>>>> +					found = true;
>>>> +					break;
>>>> +				}
>>>> +			}
>>>> +
>>>> +			if (!found) {
>>>> +				i += dma->size;
>>>> +				continue;
>>>> +			}
>>>> +
>>>> +			for (; n; n = rb_next(n)) {
>>>> +				unsigned int s;
>>>> +				struct vfio_pfn *vpfn = rb_entry(n,
>>>> +						struct vfio_pfn, node);
>>>> +
>>>> +				if (vpfn->iova >= iova + size)
>>>> +					break;
>>>> +
>>>> +				s = (vpfn->iova - dma->iova) >> pgshift;
>>>> +				bitmap_set(dma->bitmap, s, 1);
>>>> +
>>>> +				iova_limit = vpfn->iova + pgsize;
>>>> +			}
>>>> +			npages = iova_limit/pgsize;
>>>
>>> Isn't iova_limit potentially uninitialized here?  For example, if our
>>> vfio_dma covers {0,8192} and we ask for the bitmap of {0,4096} and
>>> there's a vpfn at {4096,8192}.  I think that means vpfn->iova >= i
>>> (4096 >= 0), so we break with found = true, then we test 4096 >= 0 +
>>> 4096 and break, and npages = ????/pgsize.
>>>    
>>
>> Right, Fixing it.
>>
>>>> +		}
>>>> +
>>>> +		bsize = dirty_bitmap_bytes(npages);
>>>> +		shift = nbits % BITS_PER_BYTE;
>>>> +
>>>> +		if (npages && shift) {
>>>> +			l--;
>>>> +			if (!access_ok((void __user *)bitmap + l,
>>>> +					sizeof(unsigned char)))
>>>> +				return -EINVAL;
>>>> +
>>>> +			ret = __get_user(temp, bitmap + l);
>>>
>>> I don't understand why we care to get the user's bitmap, are we trying
>>> to leave whatever garbage they might have set in it and only also set
>>> the dirty bits?  That seems unnecessary.
>>>    
>>
>> Suppose dma mapped ranges are {start, size}:
>> {0, 0xa000}, {0xa000, 0x10000}
>>
>> Bitmap asked from 0 - 0x10000. Say suppose all pages are dirty.
>> Then in first iteration for dma {0,0xa000} there are 10 pages, so 10
>> bits are set, put_user() happens for 2 bytes, (00000011 11111111b).
>> In second iteration for dma {0xa000, 0x10000} there are 6 pages and
>> these bits should be appended to previous byte. So get_user() that byte,
>> then shift-OR rest of the bitmap, result should be: (11111111 11111111b)
>>
>> Without get_user() and shift-OR, resulting bitmap would be
>> 111111 00000011 11111111b which would be wrong.
> 
> Seems like if we use a put_user() approach then we should look for
> adjacent vfio_dmas within the same byte/word/dword before we push it to
> the user to avoid this sort of inefficiency.
> 

Won't that add more complication to logic?

>>> Also why do we need these access_ok() checks when we already checked
>>> the range at the start of the ioctl?
>>
>> Since pointer is updated runtime here, better to check that pointer
>> before using that pointer.
> 
> Sorry, I still don't understand this, we check access_ok() with a
> pointer and a length, therefore as long as we're incrementing the
> pointer within that length, why do we need to retest?
> 

Ideally caller for put_user() and get_user() must check the pointer with 
access_ok() which is used as argument to these functions before calling 
this function. That makes sure that pointer is correct after pointer 
arithematic. May be lets remove previous check of pointer and length, 
but keep these checks.

>>>    
>>>> +			if (ret)
>>>> +				return ret;
>>>> +		}
>>>> +
>>>> +		for (j = 0; j < bsize; j++, l++) {
>>>> +			temp = temp |
>>>> +			       (*((unsigned char *)dma->bitmap + j) << shift);
>>>
>>> |=
>>>    
>>>> +			if (!access_ok((void __user *)bitmap + l,
>>>> +					sizeof(unsigned char)))
>>>> +				return -EINVAL;
>>>> +
>>>> +			ret = __put_user(temp, bitmap + l);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +			if (shift) {
>>>> +				temp = *((unsigned char *)dma->bitmap + j) >>
>>>> +					(BITS_PER_BYTE - shift);
>>>> +			}
>>>
>>> When shift == 0, temp just seems to accumulate bits that never get
>>> cleared.
>>>    
>>
>> Hope example above explains the shift logic.
> 
> But that example is when shift is non-zero.  When shift is zero, each
> iteration of the loop just ORs in new bits to temp without ever
> clearing the bits for the previous iteration.
> 
> 

Oh right, fixing it.

>>>> +		}
>>>> +
>>>> +		nbits += npages;
>>>> +
>>>> +		i = min(dma->iova + dma->size, iova + size);
>>>> +		if (i >= iova + size)
>>>> +			break;
>>>
>>> So whether we error or succeed, we leave cruft in dma->bitmap for the
>>> next pass.  It doesn't seem to make any sense why we pre-allocated the
>>> bitmap, we might as well just allocate it on demand here.  Actually, if
>>> we're not going to do a copy_to_user() for some range of the bitmap,
>>> I'm not sure what it's purpose is at all.  I think the big advantages
>>> of the bitmap are that we can't amortize the cost across every pinned
>>> page or DMA mapping, we don't need the overhead of tracking unmapped
>>> vpfns, and we can use copy_to_user() to push the bitmap out.  We're not
>>> getting any of those advantages here.
>>>    
>>
>> That would still not work if dma range size is not multiples of 8 pages.
>> See example above.
> 
> I don't understand this comment, what about the example above justifies
> the bitmap?

copy_to_user() could be used if dma range size is not multiple of 8 pages.

>  As I understand the above algorithm, we find a vfio_dma
> overlapping the request and populate the bitmap for that range.  Then
> we go back and put_user() for each byte that we touched.  We could
> instead simply work on a one byte buffer as we enumerate the requested
> range and do a put_user() ever time we reach the end of it and have bits
> set. That would greatly simplify the above example.  But I would expect > that we're a) more likely to get asked for ranges covering a single
> vfio_dma 

QEMU ask for single vfio_dma during each iteration.

If we restrict this ABI to cover single vfio_dma only, then it 
simplifies the logic here. That was my original suggestion. Should we 
think about that again?

> and b) we're going to spend far more time operating in the
> middle of the range and limiting ourselves to one-byte operations there
> seems absurd.  If we want to specify that the user provides 4-byte
> aligned buffers and naturally aligned iova ranges to make our lives
> easier in the kernel, now would be the time to do that.
> 
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static long verify_bitmap_size(unsigned long npages, unsigned long bitmap_size)
>>>> +{
>>>> +	long bsize;
>>>> +
>>>> +	if (!bitmap_size || bitmap_size > SIZE_MAX)
>>>> +		return -EINVAL;
>>>> +
>>>> +	bsize = dirty_bitmap_bytes(npages);
>>>> +
>>>> +	if (bitmap_size < bsize)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return bsize;
>>>> +}
>>>
>>> Seems like this could simply return int, -errno or zero for success.
>>> The returned bsize is not used for anything else.
>>>    
>>
>> ok.
>>
>>>> +
>>>>    static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>>>    			     struct vfio_iommu_type1_dma_unmap *unmap)
>>>>    {
>>>> @@ -2277,6 +2478,80 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>>>    
>>>>    		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>>>    			-EFAULT : 0;
>>>> +	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
>>>> +		struct vfio_iommu_type1_dirty_bitmap range;
>>>> +		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
>>>> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
>>>> +				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
>>>> +		int ret;
>>>> +
>>>> +		if (!iommu->v2)
>>>> +			return -EACCES;
>>>> +
>>>> +		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
>>>> +				    bitmap);
>>>
>>> We require the user to provide iova, size, pgsize, bitmap_size, and
>>> bitmap fields to START/STOP?  Why?
>>>   
>>
>> No. But those are part of structure.
> 
> But we do require it, minsz here includes all those fields, which would
> probably make a user scratch their head wondering why they need to pass
> irrelevant data for START/STOP.  It almost implies that we support
> starting and stopping dirty logging for specific ranges of the IOVA
> space.  We could define the structure, for example:
> 
> struct vfio_iommu_type1_dirty_bitmap {
> 	__u32	argsz;
> 	__u32	flags;
> 	__u8	data[];
> };
> 
> struct vfio_iommu_type1_dirty_bitmap_get {
> 	__u64	iova;
> 	__u64	size;
> 	__u64	pgsize;
> 	__u64	bitmap_size;
> 	void __user *bitmap;
> };
> 
> Where data[] is defined as the latter structure when FLAG_GET_BITMAP is
> specified.

Ok. Changing as above.

>  BTW, don't we need to specify the trailing void* as __u64?
> We could theoretically be talking to an ILP32 user process.  Thanks,
> 

Even on ILP32, using void* pointer will reserve the size required to 
save a pointer address. I don't think using void* should be problem.

Thanks,
Kirti


> Alex
> 
>>>> +
>>>> +		if (copy_from_user(&range, (void __user *)arg, minsz))
>>>> +			return -EFAULT;
>>>> +
>>>> +		if (range.argsz < minsz || range.flags & ~mask)
>>>> +			return -EINVAL;
>>>> +
>>>> +		/* only one flag should be set at a time */
>>>> +		if (__ffs(range.flags) != __fls(range.flags))
>>>> +			return -EINVAL;
>>>> +
>>>> +		if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
>>>> +			unsigned long iommu_pgsizes = vfio_pgsize_bitmap(iommu);
>>>> +
>>>> +			mutex_lock(&iommu->lock);
>>>> +			iommu->dirty_page_tracking = true;
>>>> +			ret = vfio_dma_all_bitmap_alloc(iommu, iommu_pgsizes);
>>>
>>> So dirty page tracking is enabled even if we fail to allocate all the
>>> bitmaps?  Shouldn't this return an error if dirty tracking is already
>>> enabled?
>>>    
>>
>> Adding error handling here in next patch.
>>
>>>> +			mutex_unlock(&iommu->lock);
>>>> +			return ret;
>>>> +		} else if (range.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
>>>> +			mutex_lock(&iommu->lock);
>>>> +			iommu->dirty_page_tracking = false;
>>>
>>> Shouldn't we only allow STOP if tracking is enabled?
>>>    
>>
>> Right,adding.
>>
>>>> +			vfio_dma_all_bitmap_free(iommu);
>>>
>>> Here's where that user induced double free enters the picture.
>>>    
>>
>> Error handling as mentioned above will prevent double free.
>>
>> Thanks,
>> Kirti
>>
>>>> +			vfio_remove_unpinned_from_dma_list(iommu);
>>>> +			mutex_unlock(&iommu->lock);
>>>> +			return 0;
>>>> +		} else if (range.flags &
>>>> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
>>>> +			long bsize;
>>>> +			unsigned long pgshift = __ffs(range.pgsize);
>>>> +			uint64_t iommu_pgsizes = vfio_pgsize_bitmap(iommu);
>>>> +			uint64_t iommu_pgmask =
>>>> +				 ((uint64_t)1 << __ffs(iommu_pgsizes)) - 1;
>>>> +
>>>> +			if ((range.pgsize & iommu_pgsizes) != range.pgsize)
>>>> +				return -EINVAL;
>>>> +			if (range.iova & iommu_pgmask)
>>>> +				return -EINVAL;
>>>> +			if (!range.size || range.size & iommu_pgmask)
>>>> +				return -EINVAL;
>>>> +			if (range.iova + range.size < range.iova)
>>>> +				return -EINVAL;
>>>> +			if (!access_ok((void __user *)range.bitmap,
>>>> +				       range.bitmap_size))
>>>> +				return -EINVAL;
>>>> +
>>>> +			bsize = verify_bitmap_size(range.size >> pgshift,
>>>> +						   range.bitmap_size);
>>>> +			if (bsize < 0)
>>>> +				return bsize;
>>>> +
>>>> +			mutex_lock(&iommu->lock);
>>>> +			if (iommu->dirty_page_tracking)
>>>> +				ret = vfio_iova_dirty_bitmap(iommu, range.iova,
>>>> +					 range.size, range.pgsize,
>>>> +					 (unsigned char __user *)range.bitmap);
>>>> +			else
>>>> +				ret = -EINVAL;
>>>> +			mutex_unlock(&iommu->lock);
>>>> +
>>>> +			return ret;
>>>> +		}
>>>>    	}
>>>>    
>>>>    	return -ENOTTY;
>>>
>>> Thanks,
>>> Alex
>>>    
>>
> 

