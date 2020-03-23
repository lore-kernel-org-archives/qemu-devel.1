Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83C1C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B90206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 21:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNmiC3qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B90206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGUNF-0005J5-Il
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 17:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jGUMS-0004u3-61
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jGUMP-0001ec-VI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:11:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jGUMP-0001eQ-OE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 17:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584997909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4jxkOGkxX4sSb0SR5BuCRAmRA16c3eLjFmjSDZcPB4=;
 b=BNmiC3qRH1JtvpSiHicLE5gntb+pR9lKHsghq/S3F1AfzAYaHHRVL+TYTdxVhUmb0cJpn4
 +aEQQ44fZs3VQB3NFUrnMexGbVxUPZuM9WEYOhT0/OcBOnNO3tRksxG/AXd8ZSHYTQ/SNt
 71wYJbctB6Y/3gwGY7Q0YUJxZnvtUW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-z4OB08HLNgmyuHKWU1fQsg-1; Mon, 23 Mar 2020 17:11:41 -0400
X-MC-Unique: z4OB08HLNgmyuHKWU1fQsg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09FA8DBE5;
 Mon, 23 Mar 2020 21:11:39 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A473D5C1B5;
 Mon, 23 Mar 2020 21:11:30 +0000 (UTC)
Subject: Re: [PATCH v15 Kernel 3/7] vfio iommu: Add ioctl definition for dirty
 pages tracking.
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-4-git-send-email-kwankhede@nvidia.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6c58c249-9dc8-77bd-454e-9418216cdf92@redhat.com>
Date: Mon, 23 Mar 2020 22:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1584649004-8285-4-git-send-email-kwankhede@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Hi Kirti,

On 3/19/20 9:16 PM, Kirti Wankhede wrote:
> IOMMU container maintains a list of all pages pinned by vfio_pin_pages API.
> All pages pinned by vendor driver through this API should be considered as
> dirty during migration. When container consists of IOMMU capable device and
> all pages are pinned and mapped, then all pages are marked dirty.
> Added support to start/stop dirtied pages tracking and to get bitmap of all
> dirtied pages for requested IO virtual address range.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index d0021467af53..8138f94cac15 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -995,6 +995,12 @@ struct vfio_iommu_type1_dma_map {
>  
>  #define VFIO_IOMMU_MAP_DMA _IO(VFIO_TYPE, VFIO_BASE + 13)
>  
> +struct vfio_bitmap {
> +	__u64        pgsize;	/* page size for bitmap */
in bytes as well
> +	__u64        size;	/* in bytes */
> +	__u64 __user *data;	/* one bit per page */
> +};
> +
>  /**
>   * VFIO_IOMMU_UNMAP_DMA - _IOWR(VFIO_TYPE, VFIO_BASE + 14,
>   *							struct vfio_dma_unmap)
> @@ -1021,6 +1027,55 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/**
> + * VFIO_IOMMU_DIRTY_PAGES - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
> + *                                     struct vfio_iommu_type1_dirty_bitmap)
> + * IOCTL is used for dirty pages tracking. Caller sets argsz, which is size of> + * struct vfio_iommu_type1_dirty_bitmap.
nit: This may become outdated when adding new fields. argz use mode is
documented at the beginning of the file.

 Caller set flag depend on which
> + * operation to perform, details as below:
> + *
> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_START set, indicates
> + * migration is active and IOMMU module should track pages which are dirtied or
> + * potentially dirtied by device.
> + * Dirty pages are tracked until tracking is stopped by user application by
> + * setting VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP flag.
> + *
> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP set, indicates
> + * IOMMU should stop tracking dirtied pages.
> + *
> + * When IOCTL is called with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set,
> + * IOCTL returns dirty pages bitmap for IOMMU container during migration for
> + * given IOVA range. User must provide data[] as the structure
> + * vfio_iommu_type1_dirty_bitmap_get through which user provides IOVA range
I think the fact the IOVA range must match the vfio dma_size must be
documented.
 and
> + * pgsize. This interface supports to get bitmap of smallest supported pgsize
> + * only and can be modified in future to get bitmap of specified pgsize.
> + * User must allocate memory for bitmap, zero the bitmap memory and set size
> + * of allocated memory in bitmap_size field. One bit is used to represent one
> + * page consecutively starting from iova offset. User should provide page size
> + * in 'pgsize'. Bit set in bitmap indicates page at that offset from iova is
> + * dirty. Caller must set argsz including size of structure
> + * vfio_iommu_type1_dirty_bitmap_get.
nit: ditto
> + *
> + * Only one of the flags _START, STOP and _GET may be specified at a time.
> + *
> + */
> +struct vfio_iommu_type1_dirty_bitmap {
> +	__u32        argsz;
> +	__u32        flags;
> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_START	(1 << 0)
> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP	(1 << 1)
> +#define VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP	(1 << 2)
> +	__u8         data[];
> +};
> +
> +struct vfio_iommu_type1_dirty_bitmap_get {
> +	__u64              iova;	/* IO virtual address */
> +	__u64              size;	/* Size of iova range */
> +	struct vfio_bitmap bitmap;
> +};
> +
> +#define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
> 
Thanks

Eric


