Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835AC20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGKEIYEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835AC20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzcV-0002vJ-J8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1igzbt-0002WL-K7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1igzbq-0001kJ-EE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:17:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1igzbq-0001h4-AL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576538221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tAtNALxr1oOpTMQ1PlOaAzpjjcezAUmdZUsGLw1ANI=;
 b=fGKEIYEdSl30RcfJMqSHdLhk3kEsEOv9A+vPHzFEBnt7ehLJw0sFf1kqOqeIdNcDqJ8bxn
 hXwrG15UxKy4dxkCHY4dWMcLQUft4aGElI+2Acfr9faWJWDCxf1g0oHpDLY4c+Dkytw1T6
 xb/W+PvuHvSbu5trBYqRLTfb+ood/uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-w-xh_1QINty9oy20tRskiA-1; Mon, 16 Dec 2019 18:16:57 -0500
X-MC-Unique: w-xh_1QINty9oy20tRskiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F33A1801E77;
 Mon, 16 Dec 2019 23:16:54 +0000 (UTC)
Received: from x1.home (ovpn-116-53.phx2.redhat.com [10.3.116.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59CD768863;
 Mon, 16 Dec 2019 23:16:53 +0000 (UTC)
Date: Mon, 16 Dec 2019 16:16:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v10 Kernel 2/5] vfio iommu: Adds flag to indicate dirty
 pages tracking capability support
Message-ID: <20191216161652.30681b05@x1.home>
In-Reply-To: <1576527700-21805-3-git-send-email-kwankhede@nvidia.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-3-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Tue, 17 Dec 2019 01:51:37 +0530
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
> index 2ada8e6cdb88..3f6b04f2334f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2234,7 +2234,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  			info.cap_offset = 0; /* output, no-recopy necessary */
>  		}
>  
> -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
> +		info.flags = VFIO_IOMMU_INFO_PGSIZES |
> +			     VFIO_IOMMU_INFO_DIRTY_PGS;

Type1 shouldn't advertise it until it's supported though, right?
Thanks,

Alex

>  
>  		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index a0817ba267c1..81847ed54eb7 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -900,8 +900,9 @@ struct vfio_device_ioeventfd {
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


