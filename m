Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5BFC54FCF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC73820753
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Cg7i1KOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC73820753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpZE-0002eJ-4a
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGpYS-00026m-8s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGpYQ-0004uH-Ar
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:49:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGpYQ-0004tP-3y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:49:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a63f60000>; Tue, 24 Mar 2020 12:48:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 12:49:36 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 24 Mar 2020 12:49:36 -0700
Received: from [10.40.103.72] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 19:49:27 +0000
Subject: Re: [PATCH v15 Kernel 3/7] vfio iommu: Add ioctl definition for dirty
 pages tracking.
To: Auger Eric <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
 <cjia@nvidia.com>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-4-git-send-email-kwankhede@nvidia.com>
 <6c58c249-9dc8-77bd-454e-9418216cdf92@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <f32e2007-17d6-57d1-59eb-6f3a8de83107@nvidia.com>
Date: Wed, 25 Mar 2020 01:19:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6c58c249-9dc8-77bd-454e-9418216cdf92@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585079286; bh=RdAy2FBF0O9VSVyz3xc8php8cO+9Bp16RiUmoATviYc=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Cg7i1KOYCqiXUN1SyINPqn7igYUL9H55sfOfYzdkwfmO1K7cASlxybC/E/kzGv5CG
 ZvLDchyaK5YX6d/jRJ6sK40l0Dp6vYz51rULdFefcp5c6m5gi6IRLRjv3e5wl90tyd
 lDoFlmnx3/Oh4oDEawSKOyjCh+d75d6/uXrNogVrli5wK5bpmgaCZuR52FE5C1shQS
 RafT8bwDQzWXlCVfNi50KxWA070hQ67+y1x6IzRR3EQn9Hi2O0GNTQGA5N40yCnUoo
 xMGy72p43IHmtC/u+XUk9ODGD1zIo8gSmW+87dtkn8GE3wKBnmeKJhUlkO2mVvcHRp
 6BRP5Np56O2aw==
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/24/2020 2:41 AM, Auger Eric wrote:
> Hi Kirti,
> 
> On 3/19/20 9:16 PM, Kirti Wankhede wrote:
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
>> index d0021467af53..8138f94cac15 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -995,6 +995,12 @@ struct vfio_iommu_type1_dma_map {
>>   
>>   #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
>>   
>> +struct vfio_bitmap {
>> +	__u64        pgsize;	/* page size for bitmap */
> in bytes as well

Added.

>> +	__u64        size;	/* in bytes */
>> +	__u64 __user *data;	/* one bit per page */
>> +};
>> +
>>   /**
>>    * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
>>    *							struct vfio_dma_unmap)
>> @@ -1021,6 +1027,55 @@ struct vfio_iommu_type1_dma_unmap {
>>   #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>>   #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>>   
>> +/**
>> + * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
>> + *                                     struct vfio_iommu_type1_dirty_bitmap)
>> + * IOCTL is used for dirty pages tracking. Caller sets argsz, which is size of> + * struct vfio_iommu_type1_dirty_bitmap.
> nit: This may become outdated when adding new fields. argz use mode is
> documented at the beginning of the file.
>

Ok.

>   Caller set flag depend on which
>> + * operation to perform, details as below:
>> + *
>> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
>> + * migration is active and IOMMU module should track pages which are dirtied or
>> + * potentially dirtied by device.
>> + * Dirty pages are tracked until tracking is stopped by user application by
>> + * setting VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
>> + *
>> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
>> + * IOMMU should stop tracking dirtied pages.
>> + *
>> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
>> + * IOCTL returns dirty pages bitmap for IOMMU container during migration for
>> + * given IOVA range. User must provide data[] as the structure
>> + * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range
> I think the fact the IOVA range must match the vfio dma_size must be
> documented.

Added.

>   and
>> + * pgsize. This interface supports to get bitmap of smallest supported pgsize
>> + * only and can be modified in future to get bitmap of specified pgsize.
>> + * User must allocate memory for bitmap, zero the bitmap memory and set size
>> + * of allocated memory in bitmap_size field. One bit is used to represent one
>> + * page consecutively starting from iova offset. User should provide page size
>> + * in 'pgsize'. Bit set in bitmap indicates page at that offset from iova is
>> + * dirty. Caller must set argsz including size of structure
>> + * vfio_iommu_type1_dirty_bitmap_get.
> nit: ditto

I think this is still needed here because vfio_bitmap is only used in 
case of this particular flag.

Thanks,
Kirti

>> + *
>> + * Only one of the flags _START, STOP and _GET may be specified at a time.
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
>> +
>> +#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
>> +
>>   /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>>   
>>   /*
>>
> Thanks
> 
> Eric
> 

