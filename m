Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E4CC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9611820708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwdR/43p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9611820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bHr-0007Ow-P0
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1bGR-0006lz-EP
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1bGQ-000561-5b
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:32:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1bGQ-00053i-0Z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581449525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OTWGxF5+1h1H41uFi8g1CTT5H1rjL3rKGPKHYpLiXaE=;
 b=JwdR/43pYC0dras5nlwDVfIvhs0B5p+8gPD9moRSd8jFQChpoWQvaD6s+IjFFMQ1WdOpcZ
 z+qTO66JnXUfbMyQxfg+8JZ9VbcpOIjG6NUYXnOeDggX2PKFcNu81vteZ4Id3XWpmoKAFn
 BC9lu19mZ1qr7b+6o8TbH91ZMeWoD8I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-LVfYD1Q6MA62ZKir0NxQFA-1; Tue, 11 Feb 2020 14:32:03 -0500
Received: by mail-qv1-f72.google.com with SMTP id e10so7856187qvq.18
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xIa0c6b5VKhEq1vbnW1agX1g7hVxdrY8O/5iEHdfqqs=;
 b=OlAl+NtL2mPEaKzFldA1tJ4+hfX2hVB3aqwoYLxLKeS8g/jSUIo8Fcpk2mw7UIY4dD
 7OpnBLF+i74cPuKM3A/SsvFvbmy4gjoeB4CBKsiBQBToxqRbZDV40rmXx+EJd1vfz91p
 poUKU8sJhTol/1lXYZbFGXkVqUS4vl+wJSiYzYo0cbJFk3yzx7m2sL9PKZ15KIpE1iob
 CwhXQaE5kNy0JQTgGyFQHKbhhkAxYoZAyFdVdVdJgFvlTJGpdGI1BE1Eifp+O/s/6bk1
 ltPjSoY10oDOluaNrPOuxEilp7o3D5PNzwpkbknwXiS2jZA3AoFf1fqnF0iC7nmuNJEH
 T9Ew==
X-Gm-Message-State: APjAAAWCT3FNpjTBJe+xxRL0Mx+S3SFPCEIoNMVazhKn5jey2Izu288o
 3bu81mKdCjRSwKIVjjY3n0XChOXtS1bMeRwJUoQh4lcA7y3joMXFbH6kw31/nbd9JyVpL+o2ZWk
 4cEBoWWWtFAaoYCg=
X-Received: by 2002:ae9:f714:: with SMTP id s20mr7602624qkg.236.1581449522538; 
 Tue, 11 Feb 2020 11:32:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQk3R2onk6mtzijhC++V2RPaLKgwEcFXbTvq/y0AOteeR8FWx7SBKNMK17v6GLLiGEaKSQNQ==
X-Received: by 2002:ae9:f714:: with SMTP id s20mr7602599qkg.236.1581449522334; 
 Tue, 11 Feb 2020 11:32:02 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id m16sm2479945qka.8.2020.02.11.11.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:32:01 -0800 (PST)
Date: Tue, 11 Feb 2020 14:31:59 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 12/25] vfio/common: add pasid_alloc/free support
Message-ID: <20200211193159.GJ984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-13-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1580300216-86172-13-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: LVfYD1Q6MA62ZKir0NxQFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 04:16:43AM -0800, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> This patch adds VFIO pasid alloc/free support to allow host intercept
> in PASID allocation for VM by adding VFIO implementation of
> DualStageIOMMUOps.pasid_alloc/free callbacks.
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
>  hw/vfio/common.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index a07824b..014f4e7 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1179,7 +1179,49 @@ static int vfio_get_iommu_type(VFIOContainer *cont=
ainer,
>      return -EINVAL;
>  }
> =20
> +static int vfio_ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj,
> +                         uint32_t min, uint32_t max, uint32_t *pasid)
> +{
> +    VFIOContainer *container =3D container_of(dsi_obj, VFIOContainer, ds=
i_obj);
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
> +
> +    argsz =3D sizeof(req);
> +    req.argsz =3D argsz;
> +    req.flags =3D VFIO_IOMMU_PASID_ALLOC;
> +    req.alloc_pasid.min =3D min;
> +    req.alloc_pasid.max =3D max;
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)) {
> +        error_report("%s: %d, alloc failed", __func__, -errno);
> +        return -errno;

Note that errno is prone to change by other syscalls.  Better cache it
right after the ioctl.

> +    }
> +    *pasid =3D req.alloc_pasid.result;
> +    return 0;
> +}
> +
> +static int vfio_ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj,
> +                                     uint32_t pasid)
> +{
> +    VFIOContainer *container =3D container_of(dsi_obj, VFIOContainer, ds=
i_obj);
> +    struct vfio_iommu_type1_pasid_request req;
> +    unsigned long argsz;
> +
> +    argsz =3D sizeof(req);
> +    req.argsz =3D argsz;
> +    req.flags =3D VFIO_IOMMU_PASID_FREE;
> +    req.free_pasid =3D pasid;
> +
> +    if (ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)) {
> +        error_report("%s: %d, free failed", __func__, -errno);
> +        return -errno;

Same here.

> +    }
> +    return 0;
> +}
> +
>  static struct DualStageIOMMUOps vfio_ds_iommu_ops =3D {
> +    .pasid_alloc =3D vfio_ds_iommu_pasid_alloc,
> +    .pasid_free =3D vfio_ds_iommu_pasid_free,
>  };
> =20
>  static int vfio_get_iommu_info(VFIOContainer *container,
> --=20
> 2.7.4
>=20

--=20
Peter Xu


