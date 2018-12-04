Received: from eggs.gnu.org ([2001:4830:134:3::10]:55349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869b801c3=Paul.Durrant@citrix.com>)
	id 1gUD4Z-0007RD-Fe
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869b801c3=Paul.Durrant@citrix.com>)
	id 1gUD4V-0002uw-EV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:57:19 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 4 Dec 2018 15:50:48 +0000
Message-ID: <bf0b3df5c0c44ddabf153df52321dc4c@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-4-paul.durrant@citrix.com>
	<20181129160541.GG14786@perard.uk.xensource.com>
	<311937f3c787461686f2ebf68a70a326@AMSPEX02CL03.citrite.net>
	<20181204154908.GX14786@perard.uk.xensource.com>
In-Reply-To: <20181204154908.GX14786@perard.uk.xensource.com>
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
> Sent: 04 December 2018 15:49
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 03/18] xen: introduce 'xen-qdisk'
>=20
> On Tue, Dec 04, 2018 at 03:20:04PM +0000, Paul Durrant wrote:
> > > > +static char *disk_to_vbd_name(unsigned int disk)
> > > > +{
> > > > +    unsigned int len =3D DIV_ROUND_UP(disk, 26);
> > > > +    char *name =3D g_malloc0(len + 1);
> > > > +
> > > > +    do {
> > > > +        name[len--] =3D 'a' + (disk % 26);
> > > > +        disk /=3D 26;
> > > > +    } while (disk !=3D 0);
> > > > +    assert(len =3D=3D 0);
> > > > +
> > > > +    return name;
> > > > +}
> > >
> > > That function doesn't work.
> > >
> > > For a simple xvdp, (so disk=3D=3D15), it return "", I mean "\0p".
> > >
> > > For a more complicated 'xvdbhwza', we have len =3D=3D 22901. And the
> assert
> > > failed.
> > >
> > > Maybe the recursing algo in libxl would be fine, with a buffer that i=
s
> > > big enough, and could probably be on the stack (in _get_vdev).
> >
> > I used libxl__device_disk_dev_number() as my model (as well as cross-
> checking with the spec), but I guess a recursing algorithm would be
> neater.
>=20
> There is libxl__devid_to_vdev() actually just after ;-) which calls
> encode_disk_name which is recursing.

Ah, I'll look for that. Currently having trouble reconciling the 'tq' -> 53=
6 mapping in the doc.

  Paul

>=20
> > > > diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.=
h
> > > > new file mode 100644
> > > > index 0000000000..ade0866037
> > > > --- /dev/null
> > > > +++ b/include/hw/xen/xen-qdisk.h
> > > > @@ -0,0 +1,38 @@
> > > > +/*
> > > > + * Copyright (c) Citrix Systems Inc.
> > > > + * All rights reserved.
> > > > + */
> > > > +
> > > > +#ifndef HW_XEN_QDISK_H
> > > > +#define HW_XEN_QDISK_H
> > > > +
> > > > +#include "hw/xen/xen-bus.h"
> > > > +
> > > > +typedef enum XenQdiskVdevType {
> > > > +    XEN_QDISK_VDEV_TYPE_DP,
> > >
> > > Maybe we could set type_dp value to 1, so that, when vdev->type isn't
> > > set, we can detect it later.
> >
> > Rather than having the 'valid' bool? Yes, that would work.
>=20
> Well, the 'valid' bool doesn't seems to always be check so it would be
> better. e.g. xen_qdisk_get_vdev() doesn't check `valid` before
> genereting a string. Then xen_qdisk_set_vdev could set `type` to invalid
> when it is invalid.
>=20
> --
> Anthony PERARD
