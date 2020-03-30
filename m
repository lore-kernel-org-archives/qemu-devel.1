Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E56C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7909720714
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIErVCt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7909720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ1Vu-0003Oa-Gf
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 17:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jJ1UH-00023i-NB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jJ1UG-00051U-6E
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:58:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jJ1UF-00050i-VG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585601903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SqyxpylnzX9QV3EQRIJLEZiYOB+dr6xLBHm2BEft+8=;
 b=TIErVCt7J1HTKuW8TljyPD3Jubj+yLbX2Qtjk1gycS0ebRJF4MRTjTbqldK79Ey+HWEDKv
 1jkLUSyeVK0R4C8E/zdgkgmCwHRBgP+82oa8cC9E2TED6Fn9PIW3ovPWvjXcrLG9LAMazf
 /4Y4rPb93s/fTeJIjqENYF9wWDR8gKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-aUrSYrqQMcSTVAfcVvUcjQ-1; Mon, 30 Mar 2020 16:58:19 -0400
X-MC-Unique: aUrSYrqQMcSTVAfcVvUcjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F040A800D50;
 Mon, 30 Mar 2020 20:58:16 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05F9F5C1BB;
 Mon, 30 Mar 2020 20:58:14 +0000 (UTC)
Date: Mon, 30 Mar 2020 14:58:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v17 Kernel 6/7] vfio iommu: Adds flag to indicate dirty
 pages tracking capability support
Message-ID: <20200330145814.32d9b652@w520.home>
In-Reply-To: <1585587044-2408-7-git-send-email-kwankhede@nvidia.com>
References: <1585587044-2408-1-git-send-email-kwankhede@nvidia.com>
 <1585587044-2408-7-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Mon, 30 Mar 2020 22:20:43 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Flag VFIO_IOMMU_INFO_DIRTY_PGS in VFIO_IOMMU_GET_INFO indicates that driver
> support dirty pages tracking.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 3 ++-
>  include/uapi/linux/vfio.h       | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 266550bd7307..9fe12b425976 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2390,7 +2390,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  			info.cap_offset = 0; /* output, no-recopy necessary */
>  		}
>  
> -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
> +		info.flags = VFIO_IOMMU_INFO_PGSIZES |
> +			     VFIO_IOMMU_INFO_DIRTY_PGS;
>  
>  		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e3cbf8b78623..0fe7c9a6f211 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -985,8 +985,9 @@ struct vfio_device_feature {
>  struct vfio_iommu_type1_info {
>  	__u32	argsz;
>  	__u32	flags;
> -#define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
> -#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
> +#define VFIO_IOMMU_INFO_PGSIZES   (1 << 0) /* supported page sizes info */
> +#define VFIO_IOMMU_INFO_CAPS      (1 << 1) /* Info supports caps */
> +#define VFIO_IOMMU_INFO_DIRTY_PGS (1 << 2) /* supports dirty page tracking */
>  	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
>  	__u32   cap_offset;	/* Offset within info struct of first cap */
>  };


As I just mentioned in my reply to Yan, I'm wondering if
VFIO_CHECK_EXTENSION would be a better way to expose this.  The
difference is relatively trivial, but currently the only flag
set by VFIO_IOMMU_GET_INFO is to indicate the presence of a field in
the returned structure.  I think this is largely true of other INFO
ioctls within vfio as well and we're already using the
VFIO_CHECK_EXTENSION ioctl to check supported IOMMU models, and IOMMU
cache coherency.  We'd simply need to define a VFIO_DIRTY_PGS_IOMMU
value (9) and return 1 for that case.  Then when we enable support for
dirt pages that can span multiple mappings, we can add a v2 extensions,
or "MULTI" variant of this extension, since it should be backwards
compatible.

The v2/multi version will again require that the user provide a zero'd
bitmap, but I don't think that should be a problem as part of the
definition of that version (we won't know if the user is using v1 or
v2, but a v1 user should only retrieve bitmaps that exactly match
existing mappings, where all bits will be written).  Thanks,

Alex


