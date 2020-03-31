Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D38AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4790C207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GAe7CXCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4790C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJLv2-0005jl-Ev
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jJLuB-0005Fw-NZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jJLu9-00066u-P3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:46:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jJLu9-00065X-IQ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:46:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e838fa20000>; Tue, 31 Mar 2020 11:44:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 31 Mar 2020 11:46:27 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 31 Mar 2020 11:46:27 -0700
Received: from [10.40.162.111] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 18:46:18 +0000
Subject: Re: [PATCH v17 Kernel 5/7] vfio iommu: Update UNMAP_DMA ioctl to get
 dirty bitmap before unmap
To: Alex Williamson <alex.williamson@redhat.com>
References: <1585587044-2408-1-git-send-email-kwankhede@nvidia.com>
 <1585587044-2408-6-git-send-email-kwankhede@nvidia.com>
 <20200330153421.6246c2c6@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <66af06b5-4e87-9f7a-be85-08a68d6ab982@nvidia.com>
Date: Wed, 1 Apr 2020 00:16:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330153421.6246c2c6@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585680290; bh=iWzduZHbPfAp/fpaS0jcEjAbJwVc7RSEbxv51ssxb+4=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=GAe7CXCcFLpbdEe0Z6rQS9Aw3uM2cOnGPiTMJuU9K4g8ym+NSf/4D3/Knjzaah3qI
 Mbff020O6MmoXnpMhBzgjIYWbJm7uX61roLebl5dXcYkIoahYJD+wgPtY2K2iFTTOI
 PLAls7X/ja/eatyNTXqMKEQ61EyK6IuK4zTucztDvAfFYiXrorx/eNff+KKsO1KnVy
 d2z+77/dbdOzlxLxiNEgpFvSVUcsXPur2M3/c+8c+450+2bSL8atpkTfXHI1l8oJro
 toOFZ6J2YzftnHLrGw7pyZfnHqH6UnhtkT+5kvaFFnytoCx3BpmncQz2nWbEklpq8g
 OIxLNqGRUVJPA==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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



On 3/31/2020 3:04 AM, Alex Williamson wrote:
> On Mon, 30 Mar 2020 22:20:42 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> DMA mapped pages, including those pinned by mdev vendor drivers, might
>> get unpinned and unmapped while migration is active and device is still
>> running. For example, in pre-copy phase while guest driver could access
>> those pages, host device or vendor driver can dirty these mapped pages.
>> Such pages should be marked dirty so as to maintain memory consistency
>> for a user making use of dirty page tracking.
>>
>> To get bitmap during unmap, user should allocate memory for bitmap, set
>> size of allocated memory, set page size to be considered for bitmap and
>> set flag VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 55 ++++++++++++++++++++++++++++++++++++++---
>>   include/uapi/linux/vfio.h       | 10 ++++++++
>>   2 files changed, 61 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 5efebc2b60e1..266550bd7307 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -983,7 +983,8 @@ static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>>   }
>>   
>>   static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>> -			     struct vfio_iommu_type1_dma_unmap *unmap)
>> +			     struct vfio_iommu_type1_dma_unmap *unmap,
>> +			     struct vfio_bitmap *bitmap)
>>   {
>>   	uint64_t mask;
>>   	struct vfio_dma *dma, *dma_last = NULL;
>> @@ -1034,6 +1035,10 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   	 * will be returned if these conditions are not met.  The v2 interface
>>   	 * will only return success and a size of zero if there were no
>>   	 * mappings within the range.
>> +	 *
>> +	 * When VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP flag is set, unmap request
>> +	 * must be for single mapping. Multiple mappings with this flag set is
>> +	 * not supported.
>>   	 */
>>   	if (iommu->v2) {
>>   		dma = vfio_find_dma(iommu, unmap->iova, 1);
>> @@ -1041,6 +1046,14 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>>   			ret = -EINVAL;
>>   			goto unlock;
>>   		}
>> +
>> +		if ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>> +		    dma &&
>> +		    (dma->iova != unmap->iova || dma->size != unmap->size)) {
> 
> 
> I think your intention was to return error if the user asked for the
> dirty bitmap and the requested unmap range doesn't exactly match the
> vfio_dma.  Not finding a vfio_dma should therefore also be an error.
> For example, if we had a single mapping at {0x1000-0x1fff} and the user
> unmapped with dirty bitmap {0x0-0x2fff}, that should return an error,
> but it's not caught by the above because there is no vfio_dma @0x0.
> Therefore I think you want:
> 
> ((unmap->flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) &&
>   (!dma || dma->iova != unmap->iova || dma->size != unmap->size))
> 
> Right?  Thanks,
> 


Yes, updating check.

Is !dma here also error case when VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP 
flag is not set?
DMA_UNMAP ioctl returns how much was unmapped, from user space 
perspective this would be from start of range (unmap->iova), right?

Thanks,
Kirti

