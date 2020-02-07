Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9E4C352A3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBA521741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUKZ3h8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBA521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00oU-0002A6-44
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j00nj-0001B1-0D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j00nh-0003D1-Tx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:23:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j00nh-0003Bl-QU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9s1Qx6A91TLMd+q11aMBXC3QFrx0W4N2W57XoqufQh8=;
 b=dUKZ3h8bk15xyECsEJK9uAyDRrr3gFqZ24lKFPqWnsvS21uB4eAO9kkx9TtfAZhDvB0xkT
 nuXfn9x5GMVgep11W69wflfbfC8/UZLF2ZDsYu5YNB31qrYVOqr+ZFACiF5qL6SOA3C2P0
 etL8/jhN1KN2GaBNuXXxMaFbeTb7vF0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-6KCVjVR7MBa4PnsbAQjZ6g-1; Fri, 07 Feb 2020 05:23:51 -0500
Received: by mail-qt1-f197.google.com with SMTP id c22so1321349qtn.23
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 02:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZnxDCvmuPZ5pZ0PeIwsxPJFJk2jcdWwkHN/1vNPLLDk=;
 b=Mju7AAvozIWUhjSQ8Lnk3vESxisHrEO6NPzCFlyoMi9nu0gFz9gCthtn+toSR+Sdze
 xLlXQ1bhfDS9kYiHlPeKqjHggEUDCX7NtddHWLbnD7hx85kyX2z5WM5J6RCNkt0yTd/g
 RW5hmOn/aq330mjXJWZFIQwBohZq8UnNMVDyvgLczXdWQByeb4MUFed790SkM8q2UvBA
 rSbs5GhTwvlDI2pdyAxljr/8jwwpGAEzIAT+g7VdU/XredFeeWOB+b236oOlt0XucLAz
 A2aoadH1HEKa43bMP3BX1EsSWxEPbQVeVyGNRJ/oQbSVUegFVtYqGZy+Jtsbd34l6G2A
 pYMw==
X-Gm-Message-State: APjAAAUm3drdBApoaMVf8kuHOFzgMEnd4trlg83yCoTKP1e/YsjNsMP+
 2uifv2JUVh1IX5hG8dqQaaiivRUc5aBiwljULvjqUzJDQ2Gh7VRsIFhju5mL8j9goyt3TfQpL4Q
 nTdQ148fZWV59F58=
X-Received: by 2002:ac8:607:: with SMTP id d7mr6659136qth.271.1581071031048;
 Fri, 07 Feb 2020 02:23:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxc+TXuranA8oMxcdx2IB50Rvt9e3fKtfun2BvKDyudrz+Y6Z6oRM+pTkgMGX8qk+o1/HZEFg==
X-Received: by 2002:ac8:607:: with SMTP id d7mr6659116qth.271.1581071030771;
 Fri, 07 Feb 2020 02:23:50 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id e130sm1056520qkb.72.2020.02.07.02.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 02:23:49 -0800 (PST)
Date: Fri, 7 Feb 2020 05:23:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200207052214-mutt-send-email-mst@kernel.org>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207093203.3788-9-eric.auger@redhat.com>
X-MC-Unique: 6KCVjVR7MBa4PnsbAQjZ6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> At the moment, the kernel only supports device tree
> integration of the virtio-iommu. DT bindings between the
> PCI root complex and the IOMMU must be created by the machine
> in conformance to:
>=20
> Documentation/devicetree/bindings/virtio/iommu.txt.
>=20
> To make sure the end-user is aware of this, force him to use the
> temporary device option "x-dt-binding" and also double check the
> machine has a hotplug handler for the virtio-iommu-pci device.
> This hotplug handler is in charge of creating those DT bindings.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

how about setting it by default from machine class?
See
[PATCH 1/2] spapr: Disable legacy virtio devices for pseries-5.0 and later
[PATCH 2/2] spapr: Enable virtio iommu_platform=3Don by default
which does it for spapr.

> ---
>=20
> May be squashed with previous patch
> ---
>  hw/virtio/virtio-iommu-pci.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> index d539fcce75..3d06e14000 100644
> --- a/hw/virtio/virtio-iommu-pci.c
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -14,6 +14,7 @@
>  #include "virtio-pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> =20
>  typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> =20
> @@ -27,10 +28,12 @@ typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
>  struct VirtIOIOMMUPCI {
>      VirtIOPCIProxy parent_obj;
>      VirtIOIOMMU vdev;
> +    bool dt_binding;
>  };
> =20
>  static Property virtio_iommu_pci_properties[] =3D {
>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_BOOL("x-dt-binding", VirtIOIOMMUPCI, dt_binding, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>      VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> =20
> +    if (!dev->dt_binding) {
> +        error_setg(errp,
> +                   "Instantiation currently only is possible if the mach=
ine "
> +                   "creates device tree iommu-map bindings, ie. ACPI is =
not "
> +                   "yet supported");
> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n");
> +        return;
> +    }
> +
> +    if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
> +        error_setg(errp,
> +                   "The machine does not implement a virtio-iommu-pci ho=
tplug "
> +                   " handler that creates the device tree iommu-map bind=
ings");
> +       return;
> +    }
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>      object_property_set_link(OBJECT(dev),
>                               OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> --=20
> 2.20.1


