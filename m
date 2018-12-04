Received: from eggs.gnu.org ([2001:4830:134:3::10]:43036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869b801c3=Paul.Durrant@citrix.com>)
	id 1gUCaA-0002yo-VV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869b801c3=Paul.Durrant@citrix.com>)
	id 1gUCa8-0000h1-KW
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:25:54 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 4 Dec 2018 15:20:04 +0000
Message-ID: <311937f3c787461686f2ebf68a70a326@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-4-paul.durrant@citrix.com>
	<20181129160541.GG14786@perard.uk.xensource.com>
In-Reply-To: <20181129160541.GG14786@perard.uk.xensource.com>
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
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 29 November 2018 16:06
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 03/18] xen: introduce 'xen-qdisk'
>=20
> On Wed, Nov 21, 2018 at 03:11:56PM +0000, Paul Durrant wrote:
> > This patch adds a new XenDevice: 'xen-qdisk' [1]. This will eventually
> > replace the 'xen_disk' legacy PV backend but it is illustrative to buil=
d
> > up the implementation incrementally, along with the XenBus/XenDevice
> > framework. Subsequent patches will therefore add to this device's
> > implementation as new features are added to the framework.
> >
> > After this patch has been applied it is possible to instantiate a new
> > 'xen-qdisk' device with a single 'vdev' parameter, which accepts values
> > adhering to the Xen VBD naming scheme [2]. For example, a command-line
> > instantiation of a xen-qdisk can be done with an argument similar to th=
e
> > following:
> >
> > -device xen-qdisk,vdev=3Dhda
>=20
> That works when QEMU boot, but doing the same thing once the guest have
> booted, via QMP, doesn't. Here is the result (tested in qmp-shell):
>=20
> (QEMU) device_add driver=3Dxen-qdisk vdev=3Dhda
> {
>     "error": {
>         "class": "GenericError",
>         "desc": "Bus 'xen-bus.0' does not support hotplugging"
>     }
> }
>=20
> That's probably why I've asked about the hotplug capability on the
> previous patch.
>=20

Ok. I've added the hotplug now so I'll make sure QMP DTRT.

> > The implementation of the vdev parameter formulates the appropriate VBD
> > number for use in the PV protocol.
> >
> > [1] The name 'qdisk' as always been the name given to the QEMU
> >     implementation of the Xen PV block protocol backend implementation
> > [2] http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dblob;f=3Ddocs/man/xe=
n-vbd-
> interface.markdown.7
>=20
> Maybe a link to the generated docs would be better:
> https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
>=20

Ok.

> Also, it would be useful to have the same link in the source code.
>=20

Yes, I'll add a comment.

> > diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> > new file mode 100644
> > index 0000000000..72122073f7
> > --- /dev/null
> > +++ b/hw/block/xen-qdisk.c
> [...]
> > +static char *disk_to_vbd_name(unsigned int disk)
> > +{
> > +    unsigned int len =3D DIV_ROUND_UP(disk, 26);
> > +    char *name =3D g_malloc0(len + 1);
> > +
> > +    do {
> > +        name[len--] =3D 'a' + (disk % 26);
> > +        disk /=3D 26;
> > +    } while (disk !=3D 0);
> > +    assert(len =3D=3D 0);
> > +
> > +    return name;
> > +}
>=20
> That function doesn't work.
>=20
> For a simple xvdp, (so disk=3D=3D15), it return "", I mean "\0p".
>=20
> For a more complicated 'xvdbhwza', we have len =3D=3D 22901. And the asse=
rt
> failed.
>=20
> Maybe the recursing algo in libxl would be fine, with a buffer that is
> big enough, and could probably be on the stack (in _get_vdev).

I used libxl__device_disk_dev_number() as my model (as well as cross-checki=
ng with the spec), but I guess a recursing algorithm would be neater.

>=20
> > +
> > +    switch (vdev->type) {
> > +    case XEN_QDISK_VDEV_TYPE_DP:
> > +    case XEN_QDISK_VDEV_TYPE_XVD:
> > +        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
> > +            vdev->number =3D (202 << 8) | (vdev->disk << 4) |
> > +                vdev->partition;
> > +        } else if (vdev->disk < (1 << 20) && vdev->partition < (1 <<
> 8)) {
> > +            vdev->number =3D (1 << 28) | (vdev->disk << 8) |
> > +                vdev->partition;
> > +        } else {
> > +            goto invalid;
> > +        }
> > +        break;
> > +
> > +    case XEN_QDISK_VDEV_TYPE_HD:
> > +        if ((vdev->disk =3D=3D 0 || vdev->disk =3D=3D 1) &&
> > +            vdev->partition < (1 << 4)) {
>=20
> I think that should be:
>=20
>     vdev->partition < (1 << 6)
>=20
> Because hd disk have 0..63 partitions.

Yes, I must have typo-ed it...

>=20
> > +            vdev->number =3D (3 << 8) | (vdev->disk << 6) | vdev-
> >partition;
> > +        } else if ((vdev->disk =3D=3D 2 || vdev->disk =3D=3D 3) &&
> > +                   vdev->partition < (1 << 4)) {
>=20
> same here.

...and then cut'n'pasted.

>=20
> > +            vdev->number =3D (22 << 8) | ((vdev->disk - 2) << 6) |
> > +                vdev->partition;
> > +        } else {
> > +            goto invalid;
> > +        }
> > +        break;
> > +
> > +    case XEN_QDISK_VDEV_TYPE_SD:
> > +        if (vdev->disk < (1 << 4) && vdev->partition < (1 << 4)) {
> > +            vdev->number =3D (8 << 8) | (vdev->disk << 4) | vdev-
> >partition;
> > +        } else {
> > +            goto invalid;
> > +        }
> > +        break;
> > +
> > +    default:
> > +        goto invalid;
> > +    }
> > +
> > +    g_free(str);
> > +    vdev->valid =3D true;
> > +    return;
> > +
> > +invalid:
> > +    error_setg(errp, "invalid virtual disk specifier");
> > +    g_free(str);
>=20
> :(, g_free is called twice.

Oops. Good catch.

>=20
> maybe we could have:
>     vdev->valid=3Dtrue;
>     out:
>       if (!vdev->valid)
>         error_setg(...);
>       g_free;
>=20
> > diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
> > new file mode 100644
> > index 0000000000..ade0866037
> > --- /dev/null
> > +++ b/include/hw/xen/xen-qdisk.h
> > @@ -0,0 +1,38 @@
> > +/*
> > + * Copyright (c) Citrix Systems Inc.
> > + * All rights reserved.
> > + */
> > +
> > +#ifndef HW_XEN_QDISK_H
> > +#define HW_XEN_QDISK_H
> > +
> > +#include "hw/xen/xen-bus.h"
> > +
> > +typedef enum XenQdiskVdevType {
> > +    XEN_QDISK_VDEV_TYPE_DP,
>=20
> Maybe we could set type_dp value to 1, so that, when vdev->type isn't
> set, we can detect it later.

Rather than having the 'valid' bool? Yes, that would work.

  Paul

>=20
>=20
> > +    XEN_QDISK_VDEV_TYPE_XVD,
> > +    XEN_QDISK_VDEV_TYPE_HD,
> > +    XEN_QDISK_VDEV_TYPE_SD,
> > +    XEN_QDISK_VDEV_TYPE__MAX
> > +} XenQdiskVdevType;
>=20
> Thanks,
>=20
> --
> Anthony PERARD
