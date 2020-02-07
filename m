Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA60C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED3B20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah+R26jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED3B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Lc-0006Sz-0r
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j02Jj-0003yZ-If
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j02Ji-00034O-8c
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j02Ji-00033R-3t
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581076861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2Mo2hN53eAfVWiUCfXmhbSOOR91bP6TiSEEZ+4ZQS0=;
 b=ah+R26jZ0x9UMpuUYh13L7spb718kC/p4dlrrDkmApBKHQfwVdPj6USRUwTiu8XJ/dXzUP
 hTLTncKyqfRs/G6SxtdhCUZ9kdavGawfSrCz4awqe6i2ioYjh59EbCHOuXmqMID1fNqUkS
 ws/NcctDSLuXHbmCXV6ODtRfoF2NHbE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-lO6mqDlNPbOfxlZzdZgd9A-1; Fri, 07 Feb 2020 07:00:59 -0500
Received: by mail-qt1-f197.google.com with SMTP id e8so1492467qtg.9
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 04:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DR7ZNVVKPCmdyCngabu8uSlBaI51LugMceNYmSjQ910=;
 b=FTFDGnqopJCabnH+dv+HvP2Z2shWhv2Vj5XAuy88Wf0cjH7h0W37tsTQiVJPGDM0h7
 7egVnDhIKTZwMs6+1SHQ4fOM4vMFLa1ZPXyMWbjYTUfad7lMD6Ay2DmBfekbuCXbeFU7
 S7MOnfWlVl8Op6F5ukZUs6w5wtNvap2p/Zxc5fqQ4bAQWpRyuaDJ5HJu7KX2+uNDAJa3
 h9pgx387t60zpYRwrqa6CYcMK4c2bGLjl5FT2Nw4rt4eTXR3JDzinDhAIRKWmwPJarhg
 w3Fol5L96jTUf9/KRmUjdvUmewzgAJAziLCe35qpozFbCOgigOS1T0fclTa3YTWAnMF+
 w6OQ==
X-Gm-Message-State: APjAAAUui+GiauuuEhQvoSTZpnNeEV45OsjV3dHTvdopT/dswhCIVyAw
 Aad/bACAa5/w/Q9bjukCfSTMGANVJbfDRRTk6IOr/c2spHsg8vsSheVmXXdNU+Bb9Z/ePMHwlYl
 Ax+ZYyhTdNU4MDN4=
X-Received: by 2002:ac8:4289:: with SMTP id o9mr7049076qtl.277.1581076859278; 
 Fri, 07 Feb 2020 04:00:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxphM62GL0V2Dt/ma7l8OdF9iJV8PFr25BSJ9LNl9X3L2Ii1aokg67qfNTq0B7CnNi5RwlUOw==
X-Received: by 2002:ac8:4289:: with SMTP id o9mr7049044qtl.277.1581076858857; 
 Fri, 07 Feb 2020 04:00:58 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id k4sm1227300qtj.74.2020.02.07.04.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 04:00:57 -0800 (PST)
Date: Fri, 7 Feb 2020 07:00:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v14 08/11] virtio-iommu-pci: Introduce the x-dt-binding
 option
Message-ID: <20200207065915-mutt-send-email-mst@kernel.org>
References: <20200207093203.3788-1-eric.auger@redhat.com>
 <20200207093203.3788-9-eric.auger@redhat.com>
 <20200207052214-mutt-send-email-mst@kernel.org>
 <25d39300-46b9-571c-6fa6-44c5f8d0be99@redhat.com>
MIME-Version: 1.0
In-Reply-To: <25d39300-46b9-571c-6fa6-44c5f8d0be99@redhat.com>
X-MC-Unique: lO6mqDlNPbOfxlZzdZgd9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Fri, Feb 07, 2020 at 11:51:55AM +0100, Auger Eric wrote:
> Hi,
>=20
> On 2/7/20 11:23 AM, Michael S. Tsirkin wrote:
> > On Fri, Feb 07, 2020 at 10:32:00AM +0100, Eric Auger wrote:
> >> At the moment, the kernel only supports device tree
> >> integration of the virtio-iommu. DT bindings between the
> >> PCI root complex and the IOMMU must be created by the machine
> >> in conformance to:
> >>
> >> Documentation/devicetree/bindings/virtio/iommu.txt.
> >>
> >> To make sure the end-user is aware of this, force him to use the
> >> temporary device option "x-dt-binding" and also double check the
> >> machine has a hotplug handler for the virtio-iommu-pci device.
> >> This hotplug handler is in charge of creating those DT bindings.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > how about setting it by default from machine class?
> Do you mean in ARM virt machine class? But this wouldn't prevent a user
> from launching an ACPI booted guest. I thought you wanted the end-user
> to know what he does.
>=20
> I don't figure out a way to know if the guest is booted in dt or acpi
> mode. I can get access to those info:
> - whether acpi is enabled
> - whether a FW is loaded
>=20
> But a FW can be loaded, acpi enabled and eventually the guest is DT
> booted with acpi=3Doff in kernel opts.

So let's say this configuration does not support the virtio-iommu
at the moment. Is that a big deal?

> Maybe at this point I could only support the case where no FW is loaded.
> In machvirt I would not register the virtio-iommu-pci hotplug handler in
> case a FW is loaded. Then I could get rid of the new x-dt-binding prop.
>=20
> Thoughts?
>=20
> Eric

Also an option.

> > See
> > [PATCH 1/2] spapr: Disable legacy virtio devices for pseries-5.0 and la=
ter
> > [PATCH 2/2] spapr: Enable virtio iommu_platform=3Don by default
> > which does it for spapr.
>=20
> >=20
> >> ---
> >>
> >> May be squashed with previous patch
> >> ---
> >>  hw/virtio/virtio-iommu-pci.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci=
.c
> >> index d539fcce75..3d06e14000 100644
> >> --- a/hw/virtio/virtio-iommu-pci.c
> >> +++ b/hw/virtio/virtio-iommu-pci.c
> >> @@ -14,6 +14,7 @@
> >>  #include "virtio-pci.h"
> >>  #include "hw/virtio/virtio-iommu.h"
> >>  #include "hw/qdev-properties.h"
> >> +#include "qapi/error.h"
> >> =20
> >>  typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >> =20
> >> @@ -27,10 +28,12 @@ typedef struct VirtIOIOMMUPCI VirtIOIOMMUPCI;
> >>  struct VirtIOIOMMUPCI {
> >>      VirtIOPCIProxy parent_obj;
> >>      VirtIOIOMMU vdev;
> >> +    bool dt_binding;
> >>  };
> >> =20
> >>  static Property virtio_iommu_pci_properties[] =3D {
> >>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> >> +    DEFINE_PROP_BOOL("x-dt-binding", VirtIOIOMMUPCI, dt_binding, fals=
e),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >> =20
> >> @@ -39,6 +42,21 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy=
 *vpci_dev, Error **errp)
> >>      VirtIOIOMMUPCI *dev =3D VIRTIO_IOMMU_PCI(vpci_dev);
> >>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> >> =20
> >> +    if (!dev->dt_binding) {
> >> +        error_setg(errp,
> >> +                   "Instantiation currently only is possible if the m=
achine "
> >> +                   "creates device tree iommu-map bindings, ie. ACPI =
is not "
> >> +                   "yet supported");
> >> +        error_append_hint(errp, "use -virtio-iommu-pci,x-dt-binding\n=
");
> >> +        return;
> >> +    }
> >> +
> >> +    if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
> >> +        error_setg(errp,
> >> +                   "The machine does not implement a virtio-iommu-pci=
 hotplug "
> >> +                   " handler that creates the device tree iommu-map b=
indings");
> >> +       return;
> >> +    }
> >>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> >>      object_property_set_link(OBJECT(dev),
> >>                               OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> >> --=20
> >> 2.20.1
> >=20


