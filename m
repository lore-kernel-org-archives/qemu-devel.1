Received: from eggs.gnu.org ([2001:4830:134:3::10]:36255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUtMv-0000EP-2Z
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUtMr-000255-Ae
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:07:04 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 6 Dec 2018 13:06:25 +0000
Message-ID: <8772cbe6a11d46908c3f4f56365e899e@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-17-paul.durrant@citrix.com>
	<20181204164052.GY14786@perard.uk.xensource.com>
In-Reply-To: <20181204164052.GY14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 16/18] xen: automatically create
 XenQdiskDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 04 December 2018 16:41
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 16/18] xen: automatically create XenQdiskDevice-s
>=20
> On Wed, Nov 21, 2018 at 03:12:09PM +0000, Paul Durrant wrote:
> > This patch adds a creator function for XenQdiskDevice-s so that they ca=
n
> > be created automatically when the Xen toolstack instantiates a new
> > PV backend. When the XenQdiskDevice is created this way it is also
> > necessary to create a drive which matches the configuration that the Xe=
n
> > toolstack has written into xenstore. This drive is marked 'auto_del' so
> > that it will be removed when the XenQdiskDevice is destroyed. Also, for
> > compatibilitye with the legacy 'xen_disk' implementation, an iothread
> > is automatically created for the new XenQdiskDevice. This will also be
> > removed when he XenQdiskDevice is destroyed.
>=20
> "the XenQdiskDevice"
>=20
> [...]
> > +    qemu_opt_set(drive_opts, "file.locking", "off", &local_err);
>=20
> That looks new, compared to the xen_disk.c implementation. Maybe that
> should be mention in the commit message.
>=20

It's necessary to avoid problems when an emulated device is also present. T=
he xen_disk code avoided the issue by basically bypassing the checks and st=
ooging into the middle of the block code. I'll add a comment to the code sa=
ying why locking needs to be off.

>=20
> [..]
>=20
> > +static void xen_qdisk_device_create(BusState *bus, const char *name,
> > +                                    QDict *opts, Error **errp)
> > +{
> [...]
> > +    iothread =3D iothread_create(vdev, &error_abort);
>=20
> I would just propagate the error, since iothread could fail for external
> reason. No need to crash qemu while a VM is running.

True.

>=20
> > +
> > +    dev =3D qdev_create(bus, TYPE_XEN_QDISK_DEVICE);
> > +
> > +    qdev_prop_set_string(dev, "vdev", vdev);
> > +
> > +    if (XEN_QDISK_DEVICE(dev)->vdev.number !=3D number) {
> > +        error_setg(errp, "invalid dev parameter '%s'", vdev);
> > +        goto unref;
> > +    }
> > +
> > +    qdev_prop_set_drive(dev, "drive", blk, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "failed to set 'drive': ");
> > +        goto unref;
> > +    }
> > +
> > +    XEN_QDISK_DEVICE(dev)->auto_iothread =3D iothread;
> > +
> > +    qdev_init_nofail(dev);
>=20
> That function shouldn't be use during hotplug. But I'm not sure what
> should be done instead, probably object_property_set_bool(..., true
> "realized") and check for error.

Ok, I'll do that.

  Paul

>=20
>=20
> Thanks,
>=20
> --
> Anthony PERARD
