Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F42AC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583EA207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a1E3o/Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583EA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih96M-0000cL-Gw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 04:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1ih95l-0000AS-Le
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1ih95j-0003WM-6m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:24:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1ih95i-0003VU-Sd
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 04:24:31 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df89ec30000>; Tue, 17 Dec 2019 01:24:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 17 Dec 2019 01:24:28 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 17 Dec 2019 01:24:28 -0800
Received: from [10.40.102.133] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 09:24:19 +0000
Subject: Re: [PATCH v10 Kernel 4/5] vfio iommu: Implementation of ioctl to for
 dirty pages tracking.
To: Yan Zhao <yan.y.zhao@intel.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-5-git-send-email-kwankhede@nvidia.com>
 <20191217051513.GE21868@joy-OptiPlex-7040>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <17ac4c3b-5f7c-0e52-2c2b-d847d4d4e3b1@nvidia.com>
Date: Tue, 17 Dec 2019 14:54:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191217051513.GE21868@joy-OptiPlex-7040>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576574660; bh=Pqw6VI4p0jfE1SemHvv2JBmMtoydrWwHo/AzIsQSHjI=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=a1E3o/Qgc2vT2oYH5ovZXscs5Hd/hW3fTNlRm6/0bbr3zZGtQKKSMYcPQQttwcI+2
 Vj6dSDiLHN1SuX32w1JbiZsEZo60P5Nn98M5Xmzj7Jpqg6B5cQ7/kZ1MVOT4/y+vSU
 WPyBJ5mwVgsT6tuf0ChwI0A6PGrpcwJxNiedO0tUEDnMxAkmYt4d3nDrPpfaysJPeb
 8j1YAKufXh8MqghQq2QcNU/Okgp6svH9t0LJzip6ahRXkEBcF8hKr9EFCXPqQSnq7F
 GD/jNPslUYrcNgljlUlC21jgc9gHpEi8CnOnlcI/MKOw3rrndvB9HQeNA8QWxYmBQN
 Tvq3X634VZ0kQ==
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/17/2019 10:45 AM, Yan Zhao wrote:
> On Tue, Dec 17, 2019 at 04:21:39AM +0800, Kirti Wankhede wrote:
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
>>   drivers/vfio/vfio_iommu_type1.c | 210 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 203 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 3f6b04f2334f..264449654d3f 100644
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
>> +
>> +		if (vpfn->unpinned)
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
> if physical page here is put, it may cause problem when pin this iova
> next time:
> vfio_iommu_type1_pin_pages {
>      ...
>      vpfn = vfio_iova_get_vfio_pfn(dma, iova);
>      if (vpfn) {
>          phys_pfn[i] = vpfn->pfn;
>          continue;
>      }
>      ...
> }
> 

Good point. Fixing it as:

                 vpfn = vfio_iova_get_vfio_pfn(dma, iova);
                 if (vpfn) {
-                       phys_pfn[i] = vpfn->pfn;
-                       continue;
+                       if (vpfn->unpinned)
+                               vfio_remove_from_pfn_list(dma, vpfn);
+                       else {
+                               phys_pfn[i] = vpfn->pfn;
+                               continue;
+                       }
                 }



>> -		vfio_remove_from_pfn_list(dma, vpfn);
>> +		if (dirty_tracking)
>> +			vpfn->unpinned = true;
>> +		else
>> +			vfio_remove_from_pfn_list(dma, vpfn);
> so the unpinned pages before dirty page tracking is not treated as
> dirty?
> 

Yes. That's we agreed on previous version:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg663157.html

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
>> +
>> +	unlocked = vfio_iova_put_vfio_pfn(dma, vpfn, dirty_tracking);
>>   
>>   	if (do_accounting)
>>   		vfio_lock_acct(dma, -unlocked, true);
>> @@ -583,7 +618,8 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>   
>>   		ret = vfio_add_to_pfn_list(dma, iova, phys_pfn[i]);
>>   		if (ret) {
>> -			vfio_unpin_page_external(dma, iova, do_accounting);
>> +			vfio_unpin_page_external(dma, iova, do_accounting,
>> +						 false);
>>   			goto pin_unwind;
>>   		}
>>   	}
>> @@ -598,7 +634,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>>   
>>   		iova = user_pfn[j] << PAGE_SHIFT;
>>   		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>> -		vfio_unpin_page_external(dma, iova, do_accounting);
>> +		vfio_unpin_page_external(dma, iova, do_accounting, false);
>>   		phys_pfn[j] = 0;
>>   	}
>>   pin_done:
>> @@ -632,7 +668,8 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>>   		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
>>   		if (!dma)
>>   			goto unpin_exit;
>> -		vfio_unpin_page_external(dma, iova, do_accounting);
>> +		vfio_unpin_page_external(dma, iova, do_accounting,
>> +					 iommu->dirty_page_tracking);
>>   	}
>>   
>>   unpin_exit:
>> @@ -850,6 +887,88 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
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
> This prevents pass-through devices from calling vfio_pin_pages to do
> fine grained log dirty.

Yes, I mentioned that in yet TODO item in cover letter:

"If IOMMU capable device is present in the container, then all pages are
marked dirty. Need to think smart way to know if IOMMU capable device's
driver is smart to report pages to be marked dirty by pinning those 
pages externally."


>> +			dma_addr_t iova_limit;
>> +
>> +			iova_limit = (dma->iova + dma->size) < (iova + size) ?
>> +				     (dma->iova + dma->size) : (iova + size);
>> +
>> +			for (; i < iova_limit; i += pgsize) {
>> +				unsigned int start;
>> +
>> +				start = (i - start_iova) >> pgshift;
>> +
>> +				__bitmap_set(bitmap, start, 1);
>> +			}
>> +			if (i >= iova + size)
>> +				return;
>> +		} else {
>> +			struct rb_node *n = rb_first(&dma->pfn_list);
>> +			bool found = false;
>> +
>> +			for (; n; n = rb_next(n)) {
>> +				struct vfio_pfn *vpfn = rb_entry(n,
>> +							struct vfio_pfn, node);
>> +				if (vpfn->iova >= i) {
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
>> @@ -2298,6 +2417,83 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
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
>> +			if (bsize)
>> +				return ret;
>> +
>> +			bitmap = kmalloc(bsize, GFP_KERNEL);
>> +			if (!bitmap)
>> +				return -ENOMEM;
>> +
>> +			ret = copy_from_user(bitmap,
>> +			     (void __user *)range.bitmap, bsize) ? -EFAULT : 0;
>> +			if (ret)
>> +				goto bitmap_exit;
>> +
>> +			iommu->dirty_page_tracking = false;
> why iommu->dirty_page_tracking is false here?
> suppose this ioctl can be called several times.
> 

This ioctl can be called several times, but once this ioctl is called 
that means vCPUs are stopped and VFIO devices are stopped (i.e. in 
stop-and-copy phase) and dirty pages bitmap are being queried by user.

Thanks,
Kirti


> Thanks
> Yan
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
>> -- 
>> 2.7.0
>>

