Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71342C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4130820739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jkYZVcTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57715 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMbr-0002vL-Eb
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 14:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jFMb8-0002Pu-Uw
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jFMb6-0000Ul-R8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:42:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jFMb6-0000UO-Js
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 14:42:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e750e7d0001>; Fri, 20 Mar 2020 11:42:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 20 Mar 2020 11:42:19 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 20 Mar 2020 11:42:19 -0700
Received: from [10.40.103.10] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 18:42:09 +0000
Subject: Re: [PATCH v15 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-5-git-send-email-kwankhede@nvidia.com>
 <20200319165704.1f4eb36a@w520.home>
 <bc48ae5c-67f9-d95e-5d60-6c42359bb790@nvidia.com>
 <20200320120137.6acd89ee@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <cf0ee134-c1c7-f60c-afc2-8948268d8880@nvidia.com>
Date: Sat, 21 Mar 2020 00:12:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320120137.6acd89ee@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584729726; bh=hWqEMqGjcjLbX1dudD5jfb/W5JW8uQKkE5TYekIBFFs=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=jkYZVcTIRXZJ2TlcNLaDDZzURzyQC3Ed07iBXv8NPBU8wu2+pSvV5j8/p0/SUnXED
 Ap/kTUh1gx41kfezG5vb1TQc3vf9Da1HVUA8up3daKw5ot4J37fnXGYj2rjcx2IYkE
 IMe545G2jYUrkOvYPXiVHu+z5CMhNjjgKyh47Ct6eecb4x36rXjpTJeimBFCR7kXn0
 57wlRg1nIDa8BfgVcTWduoAlK31c2V5Q9fhC+PrY1dmeUZcWM/D1rbCX1O30EgCSrS
 gmiIpWpiJfKzmf2lC8a7svO79PQTCiFWEQ2luHMMCyVWgFtMuKo5weKtgMyCsUmSHw
 Zex3jh4TV0vVQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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



On 3/20/2020 11:31 PM, Alex Williamson wrote:
> On Fri, 20 Mar 2020 23:19:14 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 3/20/2020 4:27 AM, Alex Williamson wrote:
>>> On Fri, 20 Mar 2020 01:46:41 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    

<snip>

>>>> +static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
>>>> +				  size_t size, uint64_t pgsize,
>>>> +				  u64 __user *bitmap)
>>>> +{
>>>> +	struct vfio_dma *dma;
>>>> +	unsigned long pgshift = __ffs(pgsize);
>>>> +	unsigned int npages, bitmap_size;
>>>> +
>>>> +	dma = vfio_find_dma(iommu, iova, 1);
>>>> +
>>>> +	if (!dma)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (dma->iova != iova || dma->size != size)
>>>> +		return -EINVAL;
>>>> +
>>>> +	npages = dma->size >> pgshift;
>>>> +	bitmap_size = DIRTY_BITMAP_BYTES(npages);
>>>> +
>>>> +	/* mark all pages dirty if all pages are pinned and mapped. */
>>>> +	if (dma->iommu_mapped)
>>>> +		bitmap_set(dma->bitmap, 0, npages);
>>>> +
>>>> +	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
>>>> +		return -EFAULT;
>>>
>>> We still need to reset the bitmap here, clearing and re-adding the
>>> pages that are still pinned.
>>>
>>> https://lore.kernel.org/kvm/20200319070635.2ff5db56@x1.home/
>>>    
>>
>> I thought you agreed on my reply to it
>> https://lore.kernel.org/kvm/31621b70-02a9-2ea5-045f-f72b671fe703@nvidia.com/
>>
>>   > Why re-populate when there will be no change since
>>   > vfio_iova_dirty_bitmap() is called holding iommu->lock? If there is any
>>   > pin request while vfio_iova_dirty_bitmap() is still working, it will
>>   > wait till iommu->lock is released. Bitmap will be populated when page is
>>   > pinned.
> 
> As coded, dirty bits are only ever set in the bitmap, never cleared.
> If a page is unpinned between iterations of the user recording the
> dirty bitmap, it should be marked dirty in the iteration immediately
> after the unpinning and not marked dirty in the following iteration.
> That doesn't happen here.  We're reporting cumulative dirty pages since
> logging was enabled, we need to be reporting dirty pages since the user
> last retrieved the dirty bitmap.  The bitmap should be cleared and
> currently pinned pages re-added after copying to the user.  Thanks,
> 

Does that mean, we have to track every iteration? do we really need that 
tracking?

Generally the flow is:
- vendor driver pin x pages
- Enter pre-copy-phase where vCPUs are running - user starts dirty pages 
tracking, then user asks dirty bitmap, x pages reported dirty by 
VFIO_IOMMU_DIRTY_PAGES ioctl with _GET flag
- In pre-copy phase, vendor driver pins y more pages, now bitmap 
consists of x+y bits set
- In pre-copy phase, vendor driver unpins z pages, but bitmap is not 
updated, so again bitmap consists of x+y bits set.
- Enter in stop-and-copy phase, vCPUs are stopped, mdev devices are stopped
- user asks dirty bitmap - Since here vCPU and mdev devices are stopped, 
pages should not get dirty by guest driver or the physical device. 
Hence, x+y dirty pages would be reported.

I don't think we need to track every iteration of bitmap reporting.

Thanks,
Kirti




