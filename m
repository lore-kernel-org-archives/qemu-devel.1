Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEBEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80CF20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eza59TaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80CF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnZj-0004VN-4w
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGnYY-0003bZ-FR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGnYR-0007EB-4I
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:41:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGnYQ-0007E2-UA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpW5D+RmgoIo9QMXgyVqHDhWxb6BOI9RL+RqXaduzxk=;
 b=Eza59TaSbSlWBVJUItkujYDaWjDqc7KwYhxuOPx8iEnPXaoj0h2tY2pPP8oY+O7pUj74Q/
 5XCczCyIn0G1wJ2RKRBnxQfsVD8HVIT0EqZpVsAvQ1Gue9Rwe3nzajFjqRuep6EU7A63mX
 mA1NXbDG0Y3yoJOpS095l0BdOWh5tBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-28JADvwaPc2whXgl3IhU1A-1; Tue, 24 Mar 2020 13:41:28 -0400
X-MC-Unique: 28JADvwaPc2whXgl3IhU1A-1
Received: by mail-wm1-f71.google.com with SMTP id g26so1526762wmk.6
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 10:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1cxwpAjAvJgiTag2oVzWW4NLxKFpoQLU/K4LJGxmdn4=;
 b=JGK88RbnMU0OujlMKZTniMpB9lleKna2abPfuCtfrIKYtt7QjPT6FvaED8ZDVMtLNO
 gp8vkzTB3rYqw5myRoS+J4tTP94dzucixRNe/u9ooLR87GcVhd1ahoa46cIM9gGA52mA
 KnKAxrgRA9OFxyQA/rlfj3dNDJa3jmVKeXYx6RfNxHG9AEV/C9SozPSQI4xMp03FWYrV
 njlhSZ0JA1jGV3JKgPor/HLeA02Pv11OrpIRHYK90aE9Ny4ihEjpnOsF8+CRnrfoYtxA
 0pQ2XQqPW+bsQtXF+MKkLndSmYE/2uG/JUXgpa5qv1P23rCJOi58pnZPM7X1+lW2l6xg
 Y8fw==
X-Gm-Message-State: ANhLgQ0UzWg6hxkwvDiK/OmJpKgLZUxa0wbhu/Hv4eahQLV7GLdgbyzU
 d64I9ZU4j9T+m5zrOsYeKV2Hi1EiopnYl7GaWmVFRAoBbxOEW4PBuvIvJquuyIu9Ha8YxgaxOK9
 crEuEK+MLbBbvyhY=
X-Received: by 2002:adf:e58b:: with SMTP id l11mr37584225wrm.284.1585071685547; 
 Tue, 24 Mar 2020 10:41:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vskLeqJJmIEg7vdsO1QDMncjP2clWiJKq0b3N1n1wRxCfHVqpqMMkxuGAp2sqmv+URSA6KjRg==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr37584183wrm.284.1585071685293; 
 Tue, 24 Mar 2020 10:41:25 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id w11sm29978822wrv.86.2020.03.24.10.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 10:41:24 -0700 (PDT)
Date: Tue, 24 Mar 2020 13:41:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 13/22] vfio: add bind stage-1 page table support
Message-ID: <20200324174121.GX127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-14-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-14-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:10AM -0700, Liu Yi L wrote:
> This patch adds bind_stage1_pgtbl() definition in HostIOMMUContextClass,
> also adds corresponding implementation in VFIO. This is to expose a way
> for vIOMMU to setup dual stage DMA translation for passthru devices on
> hardware.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/iommu/host_iommu_context.c         | 49 +++++++++++++++++++++++++++++=
+-
>  hw/vfio/common.c                      | 55 +++++++++++++++++++++++++++++=
+++++-
>  include/hw/iommu/host_iommu_context.h | 26 ++++++++++++++++-
>  3 files changed, 127 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.=
c
> index af61899..8a53376 100644
> --- a/hw/iommu/host_iommu_context.c
> +++ b/hw/iommu/host_iommu_context.c
> @@ -69,21 +69,67 @@ int host_iommu_ctx_pasid_free(HostIOMMUContext *host_=
icx, uint32_t pasid)
>      return hicxc->pasid_free(host_icx, pasid);
>  }
> =20
> +int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,
> +                                     DualIOMMUStage1BindData *data)
> +{
> +    HostIOMMUContextClass *hicxc;
> +
> +    if (!host_icx) {
> +        return -EINVAL;
> +    }
> +
> +    hicxc =3D HOST_IOMMU_CONTEXT_GET_CLASS(host_icx);
> +    if (!hicxc) {
> +        return -EINVAL;
> +    }
> +
> +    if (!(host_icx->flags & HOST_IOMMU_NESTING) ||
> +        !hicxc->bind_stage1_pgtbl) {
> +        return -EINVAL;
> +    }
> +
> +    return hicxc->bind_stage1_pgtbl(host_icx, data);
> +}
> +
> +int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
> +                                       DualIOMMUStage1BindData *data)
> +{
> +    HostIOMMUContextClass *hicxc;
> +
> +    if (!host_icx) {
> +        return -EINVAL;
> +    }
> +
> +    hicxc =3D HOST_IOMMU_CONTEXT_GET_CLASS(host_icx);
> +    if (!hicxc) {
> +        return -EINVAL;
> +    }
> +
> +    if (!(host_icx->flags & HOST_IOMMU_NESTING) ||
> +        !hicxc->unbind_stage1_pgtbl) {
> +        return -EINVAL;
> +    }
> +
> +    return hicxc->unbind_stage1_pgtbl(host_icx, data);
> +}
> +
>  void host_iommu_ctx_init(void *_host_icx, size_t instance_size,
>                           const char *mrtypename,
> -                         uint64_t flags)
> +                         uint64_t flags, uint32_t formats)
>  {
>      HostIOMMUContext *host_icx;
> =20
>      object_initialize(_host_icx, instance_size, mrtypename);
>      host_icx =3D HOST_IOMMU_CONTEXT(_host_icx);
>      host_icx->flags =3D flags;
> +    host_icx->stage1_formats =3D formats;
>      host_icx->initialized =3D true;
>  }
> =20
>  void host_iommu_ctx_destroy(HostIOMMUContext *host_icx)
>  {
>      host_icx->flags =3D 0x0;
> +    host_icx->stage1_formats =3D 0x0;

This could be dropped too with the function..

>      host_icx->initialized =3D false;
>  }
> =20
> @@ -92,6 +138,7 @@ static void host_icx_init_fn(Object *obj)
>      HostIOMMUContext *host_icx =3D HOST_IOMMU_CONTEXT(obj);
> =20
>      host_icx->flags =3D 0x0;
> +    host_icx->stage1_formats =3D 0x0;

Same here...

>      host_icx->initialized =3D false;
>  }
> =20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e0f2828..770a785 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1223,6 +1223,52 @@ static int vfio_host_icx_pasid_free(HostIOMMUConte=
xt *host_icx,
>      return 0;
>  }
> =20
> +static int vfio_host_icx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,

Same name issue on icx?  Feel free to choose anything that aligns with
your previous decision...

> +                                           DualIOMMUStage1BindData *bind=
_data)
> +{
> +    VFIOContainer *container =3D container_of(host_icx, VFIOContainer, h=
ost_icx);
> +    struct vfio_iommu_type1_bind *bind;
> +    unsigned long argsz;
> +    int ret =3D 0;
> +
> +    argsz =3D sizeof(*bind) + sizeof(bind_data->bind_data);
> +    bind =3D g_malloc0(argsz);
> +    bind->argsz =3D argsz;
> +    bind->flags =3D VFIO_IOMMU_BIND_GUEST_PGTBL;
> +    memcpy(&bind->data, &bind_data->bind_data, sizeof(bind_data->bind_da=
ta));
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_BIND, bind)) {
> +        ret =3D -errno;
> +        error_report("%s: pasid (%u) bind failed: %d",
> +                      __func__, bind_data->pasid, ret);
> +    }
> +    g_free(bind);
> +    return ret;
> +}
> +
> +static int vfio_host_icx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
> +                                        DualIOMMUStage1BindData *bind_da=
ta)
> +{
> +    VFIOContainer *container =3D container_of(host_icx, VFIOContainer, h=
ost_icx);
> +    struct vfio_iommu_type1_bind *bind;
> +    unsigned long argsz;
> +    int ret =3D 0;
> +
> +    argsz =3D sizeof(*bind) + sizeof(bind_data->bind_data);
> +    bind =3D g_malloc0(argsz);
> +    bind->argsz =3D argsz;
> +    bind->flags =3D VFIO_IOMMU_UNBIND_GUEST_PGTBL;
> +    memcpy(&bind->data, &bind_data->bind_data, sizeof(bind_data->bind_da=
ta));
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_BIND, bind)) {
> +        ret =3D -errno;
> +        error_report("%s: pasid (%u) unbind failed: %d",
> +                      __func__, bind_data->pasid, ret);
> +    }
> +    g_free(bind);
> +    return ret;
> +}
> +
>  /**
>   * Get iommu info from host. Caller of this funcion should free
>   * the memory pointed by the returned pointer stored in @info
> @@ -1337,6 +1383,7 @@ static int vfio_init_container(VFIOContainer *conta=
iner, int group_fd,
>          struct vfio_iommu_type1_info_cap_nesting nesting =3D {
>                                           .nesting_capabilities =3D 0x0,
>                                           .stage1_formats =3D 0, };
> +        uint32_t stage1_formats;
> =20
>          ret =3D vfio_get_nesting_iommu_cap(container, &nesting);
>          if (ret) {
> @@ -1347,10 +1394,14 @@ static int vfio_init_container(VFIOContainer *con=
tainer, int group_fd,
> =20
>          flags |=3D (nesting.nesting_capabilities & VFIO_IOMMU_PASID_REQS=
) ?
>                   HOST_IOMMU_PASID_REQUEST : 0;
> +        flags |=3D HOST_IOMMU_NESTING;
> +        stage1_formats =3D nesting.stage1_formats;
> +
>          host_iommu_ctx_init(&container->host_icx,
>                              sizeof(container->host_icx),
>                              TYPE_VFIO_HOST_IOMMU_CONTEXT,
> -                            flags);
> +                            flags,
> +                            stage1_formats);

We can consider passing in nesting.stage1_formats and drop
stage1_formats.

>      }
> =20
>      container->iommu_type =3D iommu_type;
> @@ -1943,6 +1994,8 @@ static void vfio_host_iommu_context_class_init(Obje=
ctClass *klass,
> =20
>      hicxc->pasid_alloc =3D vfio_host_icx_pasid_alloc;
>      hicxc->pasid_free =3D vfio_host_icx_pasid_free;
> +    hicxc->bind_stage1_pgtbl =3D vfio_host_icx_bind_stage1_pgtbl;
> +    hicxc->unbind_stage1_pgtbl =3D vfio_host_icx_unbind_stage1_pgtbl;
>  }
> =20
>  static const TypeInfo vfio_host_iommu_context_info =3D {
> diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/hos=
t_iommu_context.h
> index 5f11a4c..97c9473 100644
> --- a/include/hw/iommu/host_iommu_context.h
> +++ b/include/hw/iommu/host_iommu_context.h
> @@ -41,6 +41,7 @@
>                           TYPE_HOST_IOMMU_CONTEXT)
> =20
>  typedef struct HostIOMMUContext HostIOMMUContext;
> +typedef struct DualIOMMUStage1BindData DualIOMMUStage1BindData;
> =20
>  typedef struct HostIOMMUContextClass {
>      /* private */
> @@ -54,6 +55,16 @@ typedef struct HostIOMMUContextClass {
>      /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
>      int (*pasid_free)(HostIOMMUContext *host_icx,
>                        uint32_t pasid);
> +    /*
> +     * Bind stage-1 page table to a hostIOMMU w/ dual stage
> +     * DMA translation capability.
> +     * @bind_data specifies the bind configurations.
> +     */
> +    int (*bind_stage1_pgtbl)(HostIOMMUContext *dsi_obj,
> +                             DualIOMMUStage1BindData *bind_data);
> +    /* Undo a previous bind. @bind_data specifies the unbind info. */
> +    int (*unbind_stage1_pgtbl)(HostIOMMUContext *dsi_obj,
> +                               DualIOMMUStage1BindData *bind_data);
>  } HostIOMMUContextClass;
> =20
>  /*
> @@ -62,17 +73,30 @@ typedef struct HostIOMMUContextClass {
>  struct HostIOMMUContext {
>      Object parent_obj;
>  #define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
> +#define HOST_IOMMU_NESTING       (1ULL << 1)
>      uint64_t flags;
> +    uint32_t stage1_formats;
>      bool initialized;
>  };
> =20
> +struct DualIOMMUStage1BindData {
> +    uint32_t pasid;
> +    union {
> +        struct iommu_gpasid_bind_data gpasid_bind;
> +    } bind_data;
> +};
> +
>  int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
>                                 uint32_t max, uint32_t *pasid);
>  int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid=
);
> +int host_iommu_ctx_bind_stage1_pgtbl(HostIOMMUContext *host_icx,
> +                                     DualIOMMUStage1BindData *data);
> +int host_iommu_ctx_unbind_stage1_pgtbl(HostIOMMUContext *host_icx,
> +                                       DualIOMMUStage1BindData *data);
> =20
>  void host_iommu_ctx_init(void *_host_icx, size_t instance_size,
>                           const char *mrtypename,
> -                         uint64_t flags);
> +                         uint64_t flags, uint32_t formats);
>  void host_iommu_ctx_destroy(HostIOMMUContext *host_icx);
> =20
>  #endif
> --=20
> 2.7.4
>=20

--=20
Peter Xu


