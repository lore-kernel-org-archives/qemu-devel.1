Received: from eggs.gnu.org ([2001:4830:134:3::10]:56936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869b801c3=Paul.Durrant@citrix.com>)
	id 1gUEcE-0005Tj-RN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869b801c3=Paul.Durrant@citrix.com>)
	id 1gUEcD-0005iF-6J
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:36:10 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 4 Dec 2018 17:14:01 +0000
Message-ID: <ff67fbfdb62e49b1bd28ed70cdb461ca@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-4-paul.durrant@citrix.com>
	<20181129160541.GG14786@perard.uk.xensource.com>
	<311937f3c787461686f2ebf68a70a326@AMSPEX02CL03.citrite.net>
In-Reply-To: <311937f3c787461686f2ebf68a70a326@AMSPEX02CL03.citrite.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 03/18] xen: introduce 'xen-qdisk'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Paul Durrant
> Sent: 04 December 2018 15:20
> To: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>; Stefano Stabellini
> <sstabellini@kernel.org>; qemu-block@nongnu.org; qemu-devel@nongnu.org;
> Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org
> Subject: Re: [Qemu-devel] [PATCH 03/18] xen: introduce 'xen-qdisk'
>=20
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 29 November 2018 16:06
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> > devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > Subject: Re: [PATCH 03/18] xen: introduce 'xen-qdisk'
> >
> > On Wed, Nov 21, 2018 at 03:11:56PM +0000, Paul Durrant wrote:
> > > This patch adds a new XenDevice: 'xen-qdisk' [1]. This will eventuall=
y
> > > replace the 'xen_disk' legacy PV backend but it is illustrative to
> build
> > > up the implementation incrementally, along with the XenBus/XenDevice
> > > framework. Subsequent patches will therefore add to this device's
> > > implementation as new features are added to the framework.
> > >
> > > After this patch has been applied it is possible to instantiate a new
> > > 'xen-qdisk' device with a single 'vdev' parameter, which accepts
> values
> > > adhering to the Xen VBD naming scheme [2]. For example, a command-lin=
e
> > > instantiation of a xen-qdisk can be done with an argument similar to
> the
> > > following:
> > >
> > > -device xen-qdisk,vdev=3Dhda
> >
> > That works when QEMU boot, but doing the same thing once the guest have
> > booted, via QMP, doesn't. Here is the result (tested in qmp-shell):
> >
> > (QEMU) device_add driver=3Dxen-qdisk vdev=3Dhda
> > {
> >     "error": {
> >         "class": "GenericError",
> >         "desc": "Bus 'xen-bus.0' does not support hotplugging"
> >     }
> > }
> >
> > That's probably why I've asked about the hotplug capability on the
> > previous patch.
> >
>=20
> Ok. I've added the hotplug now so I'll make sure QMP DTRT.
>=20
> > > The implementation of the vdev parameter formulates the appropriate
> VBD
> > > number for use in the PV protocol.
> > >
> > > [1] The name 'qdisk' as always been the name given to the QEMU
> > >     implementation of the Xen PV block protocol backend implementatio=
n
> > > [2] http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dblob;f=3Ddocs/man/=
xen-
> vbd-
> > interface.markdown.7
> >
> > Maybe a link to the generated docs would be better:
> > https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
> >
>=20
> Ok.
>=20
> > Also, it would be useful to have the same link in the source code.
> >
>=20
> Yes, I'll add a comment.
>=20
> > > diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> > > new file mode 100644
> > > index 0000000000..72122073f7
> > > --- /dev/null
> > > +++ b/hw/block/xen-qdisk.c
> > [...]
> > > +static char *disk_to_vbd_name(unsigned int disk)
> > > +{
> > > +    unsigned int len =3D DIV_ROUND_UP(disk, 26);
> > > +    char *name =3D g_malloc0(len + 1);
> > > +
> > > +    do {
> > > +        name[len--] =3D 'a' + (disk % 26);
> > > +        disk /=3D 26;
> > > +    } while (disk !=3D 0);
> > > +    assert(len =3D=3D 0);
> > > +
> > > +    return name;
> > > +}
> >
> > That function doesn't work.
> >
> > For a simple xvdp, (so disk=3D=3D15), it return "", I mean "\0p".
> >
> > For a more complicated 'xvdbhwza', we have len =3D=3D 22901. And the as=
sert
> > failed.
> >
> > Maybe the recursing algo in libxl would be fine, with a buffer that is
> > big enough, and could probably be on the stack (in _get_vdev).
>=20
> I used libxl__device_disk_dev_number() as my model (as well as cross-
> checking with the spec), but I guess a recursing algorithm would be
> neater.
>=20
> >
> > > +
> > > +    switch (vdev->type) {
> > > +    case XEN_QDISK_VDEV_TYPE_DP:
> > > +    case XEN_QDISK_VDEV_TYPE_XVD:
> > > +        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
> > > +            vdev->number =3D (202 << 8) | (vdev->disk << 4) |
> > > +                vdev->partition;
> > > +        } else if (vdev->disk < (1 << 20) && vdev->partition < (1 <<
> > 8)) {
> > > +            vdev->number =3D (1 << 28) | (vdev->disk << 8) |
> > > +                vdev->partition;
> > > +        } else {
> > > +            goto invalid;
> > > +        }
> > > +        break;
> > > +
> > > +    case XEN_QDISK_VDEV_TYPE_HD:
> > > +        if ((vdev->disk =3D=3D 0 || vdev->disk =3D=3D 1) &&
> > > +            vdev->partition < (1 << 4)) {
> >
> > I think that should be:
> >
> >     vdev->partition < (1 << 6)
> >
> > Because hd disk have 0..63 partitions.
>=20
> Yes, I must have typo-ed it...
>=20
> >
> > > +            vdev->number =3D (3 << 8) | (vdev->disk << 6) | vdev-
> > >partition;
> > > +        } else if ((vdev->disk =3D=3D 2 || vdev->disk =3D=3D 3) &&
> > > +                   vdev->partition < (1 << 4)) {
> >
> > same here.
>=20
> ...and then cut'n'pasted.
>=20
> >
> > > +            vdev->number =3D (22 << 8) | ((vdev->disk - 2) << 6) |
> > > +                vdev->partition;
> > > +        } else {
> > > +            goto invalid;
> > > +        }
> > > +        break;
> > > +
> > > +    case XEN_QDISK_VDEV_TYPE_SD:
> > > +        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
> > > +            vdev->number =3D (8 << 8) | (vdev->disk << 4) | vdev-
> > >partition;
> > > +        } else {
> > > +            goto invalid;
> > > +        }
> > > +        break;
> > > +
> > > +    default:
> > > +        goto invalid;
> > > +    }
> > > +
> > > +    g_free(str);
> > > +    vdev->valid =3D true;
> > > +    return;
> > > +
> > > +invalid:
> > > +    error_setg(errp, "invalid virtual disk specifier");
> > > +    g_free(str);
> >
> > :(, g_free is called twice.
>=20
> Oops. Good catch.

Oh, I thought you'd found a double free...

>=20
> >
> > maybe we could have:
> >     vdev->valid=3Dtrue;
> >     out:
> >       if (!vdev->valid)
> >         error_setg(...);
> >       g_free;

No, that's quite convoluted. I prefer separate 'fail' and 'success' paths, =
even if they both need to call g_free().

  Paul

> >
> > > diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
> > > new file mode 100644
> > > index 0000000000..ade0866037
> > > --- /dev/null
> > > +++ b/include/hw/xen/xen-qdisk.h
> > > @@ -0,0 +1,38 @@
> > > +/*
> > > + * Copyright (c) Citrix Systems Inc.
> > > + * All rights reserved.
> > > + */
> > > +
> > > +#ifndef HW_XEN_QDISK_H
> > > +#define HW_XEN_QDISK_H
> > > +
> > > +#include "hw/xen/xen-bus.h"
> > > +
> > > +typedef enum XenQdiskVdevType {
> > > +    XEN_QDISK_VDEV_TYPE_DP,
> >
> > Maybe we could set type_dp value to 1, so that, when vdev->type isn't
> > set, we can detect it later.
>=20
> Rather than having the 'valid' bool? Yes, that would work.
>=20
>   Paul
>=20
> >
> >
> > > +    XEN_QDISK_VDEV_TYPE_XVD,
> > > +    XEN_QDISK_VDEV_TYPE_HD,
> > > +    XEN_QDISK_VDEV_TYPE_SD,
> > > +    XEN_QDISK_VDEV_TYPE__MAX
> > > +} XenQdiskVdevType;
> >
> > Thanks,
> >
> > --
> > Anthony PERARD
