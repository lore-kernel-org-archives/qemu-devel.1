Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCCC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E039B20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO8oIX+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E039B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bGD-0006UL-3q
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1bF4-00061A-ML
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1bF1-0000kv-Kg
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:30:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1bF0-0000fB-1g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581449436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn2OpWAdFpLaZmNhJEh6ZNF2aVhguE+hygX6mL5T3l0=;
 b=SO8oIX+Vnlgfecp/unKQRIFIXCi5fzAwbhpP4sS7uCTqVsmoYRMzxmbby6EnY51PXZKczQ
 MM5LUuLXVn007tiE4IAxgmTRvy+IuElEn8PxZBhpsCIXzwEGVAe8C8ZQqnpr0lhVhNHov5
 +yDWk6G2kJI4v+OSFf9OkZcUyY3wn9A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-hd86h0MUPgC7S9GhVL-6mA-1; Tue, 11 Feb 2020 14:30:27 -0500
Received: by mail-qv1-f72.google.com with SMTP id v3so7911803qvm.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8/RCUyQmY3b0O8AQSk1+jlR5RNjP8umXMh5ezZmYzvI=;
 b=rXOqFYzoMNhhM8AnGx3CXPxOq8+BhmXSjq08pd6z3+EqJkdy1hSPFsIlRHXfQ4SSK/
 +vIuL5V9Nd1ZtdZmGzvnfhEFMssqe4Gxao4LizRoekICsgoi8X6tuMnFe7wLDyESxYk2
 ULwAPCd5b7SfY+ZrbQtc7+4xfpO6WQ/9GBN7Ezx32jb7UL59dcngJ7iCxGnFD2LSiiZ9
 5TIPop0Nf9+/4hmLQwULg06CLi1iuFIrbSBH4DRgx5CvHVJHD/W4wM9xXwIu3S1odpOg
 k6/kGA3iihYwbO9RZ1vs/IDhPGoeXRAf6s92Akn7N935kvkNxCsm8RY1YbgDZrD59kzL
 BauQ==
X-Gm-Message-State: APjAAAX3zzkJJjRMgg2J7Pv1eGWY4/ONpW1tXGr1WJTRpTp5Z2ks7XNG
 FBq723rD4oPy1hIYSbf8ALlxSocl0L6yPMK++vafzzjlrXW8krVna/0kunqRJt0I5BvsrpWcilB
 oodGRjnaC8h4hmMk=
X-Received: by 2002:aed:20f1:: with SMTP id 104mr3844933qtb.121.1581449426138; 
 Tue, 11 Feb 2020 11:30:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwV7nTONMBjVSfOQa7+i/GT2MWP7mnSbWBzLJMFZCetQl5L8ytr9gNO7kK+R69gcoYxbEk3VA==
X-Received: by 2002:aed:20f1:: with SMTP id 104mr3844911qtb.121.1581449425846; 
 Tue, 11 Feb 2020 11:30:25 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id 24sm2612882qka.32.2020.02.11.11.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:30:25 -0800 (PST)
Date: Tue, 11 Feb 2020 14:30:22 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 11/25] vfio: get stage-1 pasid formats from Kernel
Message-ID: <20200211193022.GI984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-12-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1580300216-86172-12-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: hd86h0MUPgC7S9GhVL-6mA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 04:16:42AM -0800, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> VFIO checks IOMMU UAPI version when it finds Kernel supports
> VFIO_TYPE1_NESTING_IOMMU. It is enough for UAPI compatibility
> check. However, IOMMU UAPI may support multiple stage-1 pasid
> formats in a specific UAPI version, which is highly possible
> since IOMMU UAPI supports stage-1 formats across all IOMMU vendors.
> So VFIO needs to get the supported formats from Kernel and tell
> vIOMMU. Let vIOMMU select proper format when setup dual stage DMA
> translation.
>=20
> This patch gets the stage-1 pasid format from kernel by using IOCTL
> VFIO_IOMMU_GET_INFO and pass the supported format to vIOMMU by the
> DualStageIOMMUObject instance which has been registered to vIOMMU.
>=20
> This patch referred some code from Shameer Kolothum.
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03759.html
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/iommu/dual_stage_iommu.c         |  5 ++-
>  hw/vfio/common.c                    | 85 +++++++++++++++++++++++++++++++=
+++++-
>  include/hw/iommu/dual_stage_iommu.h | 10 ++++-
>  3 files changed, 97 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/iommu/dual_stage_iommu.c b/hw/iommu/dual_stage_iommu.c
> index be4179d..d5a7168 100644
> --- a/hw/iommu/dual_stage_iommu.c
> +++ b/hw/iommu/dual_stage_iommu.c
> @@ -48,9 +48,12 @@ int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj,=
 uint32_t pasid)
>  }
> =20
>  void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
> -                          DualStageIOMMUOps *ops)
> +                          DualStageIOMMUOps *ops,
> +                          DualStageIOMMUInfo *uinfo)
>  {
>      dsi_obj->ops =3D ops;
> +
> +    dsi_obj->uinfo.pasid_format =3D uinfo->pasid_format;
>  }
> =20
>  void ds_iommu_object_destroy(DualStageIOMMUObject *dsi_obj)
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fc1723d..a07824b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1182,10 +1182,84 @@ static int vfio_get_iommu_type(VFIOContainer *con=
tainer,
>  static struct DualStageIOMMUOps vfio_ds_iommu_ops =3D {
>  };
> =20
> +static int vfio_get_iommu_info(VFIOContainer *container,
> +                         struct vfio_iommu_type1_info **info)

Better comment on the function to remember to free(*info) after use
for the callers.

> +{
> +
> +    size_t argsz =3D sizeof(struct vfio_iommu_type1_info);
> +

Nit: extra newline.

> +
> +    *info =3D g_malloc0(argsz);
> +
> +retry:
> +    (*info)->argsz =3D argsz;
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
> +        g_free(*info);
> +        *info =3D NULL;
> +        return -errno;
> +    }
> +
> +    if (((*info)->argsz > argsz)) {
> +        argsz =3D (*info)->argsz;
> +        *info =3D g_realloc(*info, argsz);
> +        goto retry;
> +    }
> +
> +    return 0;
> +}
> +
> +static struct vfio_info_cap_header *
> +vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
> +{
> +    struct vfio_info_cap_header *hdr;
> +    void *ptr =3D info;
> +
> +    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
> +        return NULL;
> +    }
> +
> +    for (hdr =3D ptr + info->cap_offset; hdr !=3D ptr; hdr =3D ptr + hdr=
->next) {
> +        if (hdr->id =3D=3D id) {
> +            return hdr;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static int vfio_get_nesting_iommu_format(VFIOContainer *container,
> +                                         uint32_t *pasid_format)
> +{
> +    struct vfio_iommu_type1_info *info;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_iommu_type1_info_cap_nesting *cap;
> +
> +    if (vfio_get_iommu_info(container, &info)) {
> +        return -errno;

Should return the retcode from vfio_get_iommu_info.

> +    }
> +
> +    hdr =3D vfio_get_iommu_info_cap(info,
> +                        VFIO_IOMMU_TYPE1_INFO_CAP_NESTING);
> +    if (!hdr) {
> +        g_free(info);
> +        return -errno;
> +    }
> +
> +    cap =3D container_of(hdr,
> +                struct vfio_iommu_type1_info_cap_nesting, header);
> +    *pasid_format =3D cap->pasid_format;
> +
> +    g_free(info);
> +    return 0;
> +}
> +
>  static int vfio_init_container(VFIOContainer *container, int group_fd,
>                                 Error **errp)
>  {
>      int iommu_type, ret;
> +    uint32_t format;
> +    DualStageIOMMUInfo uinfo;
> =20
>      iommu_type =3D vfio_get_iommu_type(container, errp);
>      if (iommu_type < 0) {
> @@ -1214,7 +1288,16 @@ static int vfio_init_container(VFIOContainer *cont=
ainer, int group_fd,
>      }
> =20
>      if (iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
> -        ds_iommu_object_init(&container->dsi_obj, &vfio_ds_iommu_ops);
> +        if (vfio_get_nesting_iommu_format(container, &format)) {
> +            error_setg_errno(errp, errno,
> +                             "Failed to get nesting iommu format");
> +            return -errno;

Same here, you might want to return the retcode from
vfio_get_nesting_iommu_format()?

> +        }
> +
> +        uinfo.pasid_format =3D format;
> +        ds_iommu_object_init(&container->dsi_obj,
> +                             &vfio_ds_iommu_ops, &uinfo);
> +
>          if (iommu_context_register_ds_iommu(container->iommu_ctx,
>                                              &container->dsi_obj)) {
>              /*
> diff --git a/include/hw/iommu/dual_stage_iommu.h b/include/hw/iommu/dual_=
stage_iommu.h
> index e9891e3..c6100b4 100644
> --- a/include/hw/iommu/dual_stage_iommu.h
> +++ b/include/hw/iommu/dual_stage_iommu.h
> @@ -23,12 +23,14 @@
>  #define HW_DS_IOMMU_H
> =20
>  #include "qemu/queue.h"
> +#include <linux/iommu.h>
>  #ifndef CONFIG_USER_ONLY
>  #include "exec/hwaddr.h"
>  #endif
> =20
>  typedef struct DualStageIOMMUObject DualStageIOMMUObject;
>  typedef struct DualStageIOMMUOps DualStageIOMMUOps;
> +typedef struct DualStageIOMMUInfo DualStageIOMMUInfo;
> =20
>  struct DualStageIOMMUOps {
>      /* Allocate pasid from DualStageIOMMU (a.k.a. host IOMMU) */
> @@ -41,11 +43,16 @@ struct DualStageIOMMUOps {
>                        uint32_t pasid);
>  };
> =20
> +struct DualStageIOMMUInfo {
> +    uint32_t pasid_format;
> +};
> +
>  /*
>   * This is an abstraction of Dual-stage IOMMU.
>   */
>  struct DualStageIOMMUObject {
>      DualStageIOMMUOps *ops;
> +    DualStageIOMMUInfo uinfo;
>  };
> =20
>  int ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj, uint32_t min,
> @@ -53,7 +60,8 @@ int ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj,=
 uint32_t min,
>  int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj, uint32_t pasid);
> =20
>  void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
> -                          DualStageIOMMUOps *ops);
> +                          DualStageIOMMUOps *ops,
> +                          DualStageIOMMUInfo *uinfo);
>  void ds_iommu_object_destroy(DualStageIOMMUObject *dsi_obj);
> =20
>  #endif
> --=20
> 2.7.4
>=20

--=20
Peter Xu


