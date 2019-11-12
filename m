Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9422196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/uSRdNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9422196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUemp-0008Rp-Vb
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 17:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iUehf-0004TD-Fv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iUehe-00083C-5j
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:32:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iUehe-000836-29
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573597921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZX4cLGsoeJ0evGnj3YgZAtBIHFTksN47O88ZYipkno=;
 b=d/uSRdNgqxxAFRQwm/RXfBVU2z9vMrcBbs44ooJR5yGszr/oPYq0K2YOAnU3O9hgAXcClf
 XmYRWjMDnz/5CzK4QtD4HTAvuYtJF+pzUlt0ru+eJ5wQfvkhixVjOzKZTBb8KV9xgnUW3K
 ipZrsXSX17KcEAxUWM0cRtqZIqcQngs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-K1EeJhRdMome9ky99dcI1Q-1; Tue, 12 Nov 2019 17:30:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C5341005509;
 Tue, 12 Nov 2019 22:30:19 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8B4B10027B9;
 Tue, 12 Nov 2019 22:30:17 +0000 (UTC)
Date: Tue, 12 Nov 2019 15:30:17 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 3/5] vfio iommu: Add ioctl defination to unmap
 IOVA and return dirty bitmap
Message-ID: <20191112153017.3c792673@x1.home>
In-Reply-To: <1573578220-7530-4-git-send-email-kwankhede@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-4-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: K1EeJhRdMome9ky99dcI1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, 12 Nov 2019 22:33:38 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> With vIOMMU, during pre-copy phase of migration, while CPUs are still
> running, IO virtual address unmap can happen while device still keeping
> reference of guest pfns. Those pages should be reported as dirty before
> unmap, so that VFIO user space application can copy content of those page=
s
> from source to destination.
>=20
> IOCTL defination added here add bitmap pointer, size and flag. If flag

definition, adds

> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set and bitmap memory is allocate=
d
> and bitmap_size of set, then ioctl will create bitmap of pinned pages and

s/of/is/

> then unmap those.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 6fd3822aa610..72fd297baf52 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -925,6 +925,39 @@ struct vfio_iommu_type1_dirty_bitmap {
> =20
>  #define VFIO_IOMMU_GET_DIRTY_BITMAP             _IO(VFIO_TYPE, VFIO_BASE=
 + 17)
> =20
> +/**
> + * VFIO_IOMMU_UNMAP_DMA_GET_BITMAP - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> + *=09=09=09=09      struct vfio_iommu_type1_dma_unmap_bitmap)
> + *
> + * Unmap IO virtual addresses using the provided struct
> + * vfio_iommu_type1_dma_unmap_bitmap.  Caller sets argsz.
> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP should be set to get dirty bitma=
p
> + * before unmapping IO virtual addresses. If this flag is not set, only =
IO
> + * virtual address are unmapped without creating pinned pages bitmap, th=
at
> + * is, behave same as VFIO_IOMMU_UNMAP_DMA ioctl.
> + * User should allocate memory to get bitmap and should set size of allo=
cated
> + * memory in bitmap_size field. One bit in bitmap is used to represent p=
er page
> + * consecutively starting from iova offset. Bit set indicates page at th=
at
> + * offset from iova is dirty.
> + * The actual unmapped size is returned in the size field and bitmap of =
pages
> + * in the range of unmapped size is returned in bitmap if flag
> + * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is set.
> + *
> + * No guarantee is made to the user that arbitrary unmaps of iova or siz=
e
> + * different from those used in the original mapping call will succeed.
> + */
> +struct vfio_iommu_type1_dma_unmap_bitmap {
> +=09__u32        argsz;
> +=09__u32        flags;
> +#define VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP (1 << 0)
> +=09__u64        iova;                        /* IO virtual address */
> +=09__u64        size;                        /* Size of mapping (bytes) =
*/
> +=09__u64        bitmap_size;                 /* in bytes */
> +=09void __user *bitmap;                      /* one bit per page */
> +};
> +
> +#define VFIO_IOMMU_UNMAP_DMA_GET_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 18)
> +

Why not extend VFIO_IOMMU_UNMAP_DMA to support this rather than add an
ioctl that duplicates the functionality and extends it??  Otherwise
same comments as previous, in fact it's too bad we can't use this ioctl
for both, but a DONT_UNMAP flag on the UNMAP_DMA ioctl seems a bit
absurd.

I suspect we also want a flags bit in VFIO_IOMMU_GET_INFO to indicate
these capabilities are supported.

Maybe for both ioctls we also want to define it as the user's
responsibility to zero the bitmap, requiring the kernel to only set
bits as necessary.  Thanks,

Alex

>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU --------=
 */
> =20
>  /*


