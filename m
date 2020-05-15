Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3270EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0034D2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dtlAvlT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0034D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZeFz-0004N9-2D
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZeFJ-0003fA-Bx
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:35:41 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jZeFH-0002dN-6l
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:35:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ebed25d0002>; Fri, 15 May 2020 10:33:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 15 May 2020 10:35:36 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 15 May 2020 10:35:36 -0700
Received: from [10.40.103.94] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 May
 2020 17:35:28 +0000
Subject: Re: [PATCH Kernel v20 4/8] vfio iommu: Add ioctl definition for dirty
 pages tracking
To: Cornelia Huck <cohuck@redhat.com>
References: <1589488667-9683-1-git-send-email-kwankhede@nvidia.com>
 <1589488667-9683-5-git-send-email-kwankhede@nvidia.com>
 <20200515125916.78723321.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <bdb9c1d3-e673-5bb1-aced-f7443f4dfe58@nvidia.com>
Date: Fri, 15 May 2020 23:05:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200515125916.78723321.cohuck@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589563998; bh=ayKJyENVWVq+++eaQa/RNQ3Hiaj6T+Ugv63pCGUuAUE=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=dtlAvlT38WGDkPjIhiGYjrh5KgLWYJC+TPqVNjivA9id56PtMEKtLV31xSol22Jjw
 A5Y1JwbXU1prlK1vZqwvKhu/dH2dPUFaMRJyvxpnxMKaRuX1kDDg6GfcNOk67lGDYh
 XgnDFNC8Viw8PvVKEBMAMVPv1Ng/xeCiScx65T5ZuWnoTrMLnvtrIm27tHNHUqtkNL
 /N8h5RQrI/FYWRimkDkJhwvbcB6DHU5Cd/tl9Ote37R3wNWdz7Yvqx3Jgjv5yRIlsu
 scqteeHZd40SDRd9xUcrpXYXt7CQ6Du4CdQirzu+OwyFzFXnNDTCL6KOJ7Ni7qJbDc
 0AZpFuStfaepA==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 13:35:37
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/15/2020 4:29 PM, Cornelia Huck wrote:
> On Fri, 15 May 2020 02:07:43 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
>> All pages pinned by vendor driver through this API should be considered as
>> dirty during migration. When container consists of IOMMU capable device and
>> all pages are pinned and mapped, then all pages are marked dirty.
>> Added support to start/stop dirtied pages tracking and to get bitmap of all
>> dirtied pages for requested IO virtual address range.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   include/uapi/linux/vfio.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index ad9bb5af3463..123de3bc2dce 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1033,6 +1033,12 @@ struct vfio_iommu_type1_dma_map {
>>   
>>   #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
>>   
>> +struct vfio_bitmap {
>> +	__u64        pgsize;	/* page size for bitmap in bytes */
>> +	__u64        size;	/* in bytes */
>> +	__u64 __user *data;	/* one bit per page */
>> +};
>> +
>>   /**
>>    * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
>>    *							struct vfio_dma_unmap)
>> @@ -1059,6 +1065,55 @@ struct vfio_iommu_type1_dma_unmap {
>>   #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>>   #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>>   
>> +/**
>> + * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
>> + *                                     struct vfio_iommu_type1_dirty_bitmap)
>> + * IOCTL is used for dirty pages tracking.
>> + * Caller should set flag depending on which operation to perform, details as
>> + * below:
>> + *
>> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
>> + * migration is active and IOMMU module should track pages which are dirtied or
>> + * potentially dirtied by device.
> 
> "Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_START instructs the
> IOMMU driver to track pages that are dirtied or potentially dirtied by
> the device; designed to be used when a migration is in progress."
> 
> ?
> 

Ok, updating.

>> + * Dirty pages are tracked until tracking is stopped by user application by
>> + * setting VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
> 
> "...by calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP." ?
> 
>> + *
>> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
>> + * IOMMU should stop tracking dirtied pages.
> 
> "Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP instructs the
> IOMMU driver to stop tracking dirtied pages."
> 
> ?
> 

Ok.

>> + *
>> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
>> + * IOCTL returns dirty pages bitmap for IOMMU container during migration for
>> + * given IOVA range.
> 
> "Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_GET_BITMAP returns the
> dirty pages bitmap for the IOMMU container for a given IOVA range." ?
> 
> Q: How does this interact with the two other operations? I imagine
> getting an empty bitmap before _START 

No, if dirty page tracking is not started, get_bitmap IOCTL will fail 
with -EINVAL.

> and a bitmap-in-progress between
> _START and _STOP. > After _STOP, will subsequent calls always give the
> same bitmap?
>

No, return -EINVAL.


>> User must provide data[] as the structure
>> + * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range and
>> + * pgsize.
> 
> "The user must specify the IOVA range and the pgsize through the
> vfio_iommu_type1_dirty_bitmap_get structure in the data[] portion."
> 
> ?
> 
>> This interface supports to get bitmap of smallest supported pgsize
>> + * only and can be modified in future to get bitmap of specified pgsize.
> 
> That's a current restriction? How can the user find out whether it has
> been lifted (or, more generally, find out which pgsize values are
> supported)?

Migration capability is added to IOMMU info chain. That gives supported 
pgsize bitmap by IOMMU driver.

> 
>> + * User must allocate memory for bitmap, zero the bitmap memory  and set size
>> + * of allocated memory in bitmap.size field.
> 
> "The user must provide a zeroed memory area for the bitmap memory and
> specify its size in bitmap.size."
> 
> ?
> 
>> One bit is used to represent one
>> + * page consecutively starting from iova offset. User should provide page size
>> + * in bitmap.pgsize field.
> 
> s/User/The user/
> 
> Is that the 'pgsize' the comment above talks about?
> 

By specifying pgsize here user can ask for bitmap of specific pgsize.

>> Bit set in bitmap indicates page at that offset from
>> + * iova is dirty.
> 
> "A bit set in the bitmap indicates that the page at that offset from
> iova is dirty." ?
> 
>> Caller must set argsz including size of structure
>> + * vfio_iommu_type1_dirty_bitmap_get.
> 
> s/Caller/The caller/
> 
> Does argz also include the size of the bitmap?

No.

> 
>> + *
>> + * Only one of the flags _START, STOP and _GET may be specified at a time.
> 
> s/STOP/_STOP/
> 
> (just to be consistent)
> 
>> + *
>> + */
>> +struct vfio_iommu_type1_dirty_bitmap {
>> +	__u32        argsz;
>> +	__u32        flags;
>> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_START	(1 << 0)
>> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP	(1 << 1)
>> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP	(1 << 2)
>> +	__u8         data[];
>> +};
>> +
>> +struct vfio_iommu_type1_dirty_bitmap_get {
>> +	__u64              iova;	/* IO virtual address */
>> +	__u64              size;	/* Size of iova range */
>> +	struct vfio_bitmap bitmap;
>> +};
> 
> That's for type1 only, right?
>

Yes.

Thanks,
Kirti

>> +
>> +#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
>> +
>>   /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>>   
>>   /*
> 

