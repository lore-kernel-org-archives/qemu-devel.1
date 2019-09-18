Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F43C4CECE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2AC214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zsr7z/V9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2AC214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWwc-0003uW-MJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAWqA-0005Yb-3o
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAWq8-0007ow-Pq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:05:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAWq8-0007mv-Ho
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:05:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id y21so1848993wmi.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Z0zRKdp2nWIQsyrG+mOBKCwlS65rFtkbaBXjhseSnVQ=;
 b=Zsr7z/V9jYiwT44d4MLUR9I3bOreJ0hiGxc61oyNl8P30a25FFF0wv7NwZOQdrXALG
 BN/2dZG4a82KlP1d2FyOChs2UFVzI0iW2tIAr9V0ur9rkKOyBmsUl3LPkS/bH1BHkOPn
 66tHi9diKD/Gp6Sj7IGxk+L+1OD1/e7NCG++q/oBhq4FtAYRWt/yIWYiffosggXvanw8
 lgdxYMZMOXfhF6xn7SpBbwa5oH440v9edZoY2YSUU5BELB/9xWPAQfSExleZcbaPYpOI
 utsLEEZeGCDHNC6RDSm0DA0KAK6PXTUSXlFYhBoNGKi7CzCsJAP6PMhegZtmgaeelaT4
 Losg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Z0zRKdp2nWIQsyrG+mOBKCwlS65rFtkbaBXjhseSnVQ=;
 b=BEXZyo50QXdSPuf8vVdggtBq7pfoSkUhb5iVxkgC2sU13PU4wQkJ0dI+d3DnZrznFr
 kP3O4ipmprLnjGBGMzHM32zSx3M2NDRLtrstz7u3WS9yQUTBzJ6f/14TpWU+4zE3V4Qv
 KxMNcGYDC0a9sgARe3Kk0D5jov/JxwMXvpQSv2wTNAZLDGCAyCzAsY6gyeWTbdZsZkyJ
 Jk4bIqUYouinaAP3fKiDQOvBT35BlUwrFz8SdarA6jlDDA/dlMIHl7MvZ9ay0VnWuT7M
 koml7VVtpMCJGuty9N6RwW7MkTAcABzZoBHEJgUMyhD0GnV2Fu+eAXGUV+DgP/qnJuEA
 gf6g==
X-Gm-Message-State: APjAAAXQ6NrCMQJn4odYg2GoO28LZ/T6Llwax3BxOwCAH92VSd93sBML
 NpPcd5LR0oyTH1oSRS6UJDI=
X-Google-Smtp-Source: APXvYqx6cRQn90k1OoBmXoI7qiYi2w9lxY5WjimsdeqsEedJ07owLJw/TI3EZPYjdcXSshIX67Ew7g==
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr2281016wmg.50.1568801135321; 
 Wed, 18 Sep 2019 03:05:35 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r2sm5335084wrm.3.2019.09.18.03.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 03:05:34 -0700 (PDT)
Date: Wed, 18 Sep 2019 11:05:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190918100533.GF26027@stefanha-x1.localdomain>
References: <20190917160057.11847-1-dgilbert@redhat.com>
 <20190917160057.11847-4-dgilbert@redhat.com>
 <5D8187F9.1090303@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <5D8187F9.1090303@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 3/3] virtio: add vhost-user-fs-pci device
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
Cc: mszeredi@redhat.com, mst@redhat.com, cohuck@redhat.com,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:27:21AM +0800, piaojun wrote:
>=20
>=20
> On 2019/9/18 0:00, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Add the PCI version of vhost-user-fs.
> >=20
> > Launch QEMU like this:
> >=20
> >   qemu -chardev socket,path=3D/tmp/vhost-fs.sock,id=3Dchr0
> >        -device x-vhost-user-fs-pci,tag=3Dmyfs,chardev=3Dchr0
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/virtio/Makefile.objs       |  1 +
> >  hw/virtio/vhost-user-fs-pci.c | 85 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >  create mode 100644 hw/virtio/vhost-user-fs-pci.c
> >=20
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index 47ffbf22c4..e2f70fbb89 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_VHOST_USER_FS) +=3D vhost-user-fs.o
> >  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) +=3D vir=
tio-crypto-pci.o
> >  obj-$(CONFIG_VIRTIO_PMEM) +=3D virtio-pmem.o
> >  common-obj-$(call land,$(CONFIG_VIRTIO_PMEM),$(CONFIG_VIRTIO_PCI)) +=
=3D virtio-pmem-pci.o
> > +obj-$(call land,$(CONFIG_VHOST_USER_FS),$(CONFIG_VIRTIO_PCI)) +=3D vho=
st-user-fs-pci.o
> >  obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
> > =20
> >  ifeq ($(CONFIG_VIRTIO_PCI),y)
> > diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pc=
i.c
> > new file mode 100644
> > index 0000000000..0e70985094
> > --- /dev/null
> > +++ b/hw/virtio/vhost-user-fs-pci.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * Vhost-user filesystem virtio device PCI glue
> > + *
> > + * Copyright 2018-2019 Red Hat, Inc.
> > + *
> > + * Authors:
> > + *  Dr. David Alan Gilbert <dgilbert@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/virtio/vhost-user-fs.h"
> > +#include "virtio-pci.h"
> > +
> > +struct VHostUserFSPCI {
> > +    VirtIOPCIProxy parent_obj;
> > +    VHostUserFS vdev;
> > +};
> > +
> > +typedef struct VHostUserFSPCI VHostUserFSPCI;
> > +
> > +#define TYPE_VHOST_USER_FS_PCI "vhost-user-fs-pci-base"
> > +
> > +#define VHOST_USER_FS_PCI(obj) \
> > +        OBJECT_CHECK(VHostUserFSPCI, (obj), TYPE_VHOST_USER_FS_PCI)
> > +
> > +static Property vhost_user_fs_pci_properties[] =3D {
> > +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> > +                       DEV_NVECTORS_UNSPECIFIED),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error =
**errp)
> > +{
> > +    VHostUserFSPCI *dev =3D VHOST_USER_FS_PCI(vpci_dev);
> > +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> > +
> > +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> > +        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 1;
> > +    }
> > +
> > +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> > +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> > +}
> > +
> > +static void vhost_user_fs_pci_class_init(ObjectClass *klass, void *dat=
a)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> > +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> > +    k->realize =3D vhost_user_fs_pci_realize;
> > +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > +    dc->props =3D vhost_user_fs_pci_properties;
> > +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> > +    pcidev_k->device_id =3D 0; /* Set by virtio-pci based on virtio id=
 */
>=20
> Why not set *PCI_DEVICE_ID_VIRTIO_FS* here just like virtio_blk? I'm
> not very familiar with this code, and just compare it with the other
> same logic.

The comment indicates that virtio-pci computes the correct PCI Device ID
based on the VIRTIO Device ID.  The PCI Device ID depends on the
Legacy/Transitional/Modern mode supported by the device and therefore
cannot be hardcoded.  If we set it here it will be overwritten later
anyway.

Stefan

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2CAWwACgkQnKSrs4Gr
c8gbIwgApD3esCkIXpaVv1LJDa05dPRXphz6v0grsXaItRfnpM6C5Qcwd/feNJKo
NpaskAHZDFfbOg/RwfS5pzz2334n9gMG9XUfPuiPR0jQFLFg5AgG1TpyyJYr0gV+
ckABfo5mcSZKKeiTtSo3ZVqwqiYcymNMWY3XbP5OanqQtdH3ceIx8qmRCjL6uY5g
dTIL3Ph5f/tkRlicCLsNC+czLAvnJDM/xlt6UA8mAacL0tzZF1ti9Hkptscbq3Xr
LLvbsPB8X1yvWbpTwNYNSQoyNzL4XGx4NXSRFy3Z3tgStSld5M/hgIzerHFR/aqy
jAzZWR1qr4BehgrXC2k6HsTTchpNPw==
=Lsw+
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--

