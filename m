Received: from eggs.gnu.org ([2001:4830:134:3::10]:50131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUskk-0005Bj-2M
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUskf-0003yK-Vq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:27:38 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 6 Dec 2018 12:27:15 +0000
Message-ID: <1c081c0b852045f9a37306ae92b3764d@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-15-paul.durrant@citrix.com>
	<20181204123349.GU14786@perard.uk.xensource.com>
In-Reply-To: <20181204123349.GU14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 14/18] xen: add implementations of
 xen-qdisk connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 04 December 2018 12:34
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>;
> Kevin Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH 14/18] xen: add implementations of xen-qdisk connect
> and disconnect functions...
>=20
> On Wed, Nov 21, 2018 at 03:12:07PM +0000, Paul Durrant wrote:
> > diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> > index 35f7b70480..8c88393832 100644
> > --- a/hw/block/xen-qdisk.c
> > +++ b/hw/block/xen-qdisk.c
> >  static void xen_qdisk_connect(XenQdiskDevice *qdiskdev, Error **errp)
> >  {
> >      XenQdiskVdev *vdev =3D &qdiskdev->vdev;
> > +    XenDevice *xendev =3D XEN_DEVICE(qdiskdev);
> > +    unsigned int order, nr_ring_ref, *ring_ref, event_channel,
> protocol;
> > +    char *str;
> >
> >      trace_xen_qdisk_connect(vdev->disk, vdev->partition);
> > +
> > +    if (xen_device_frontend_scanf(xendev, "ring-page-order", "%u",
> > +                                  &order) !=3D 1) {
> > +        nr_ring_ref =3D 1;
> > +        ring_ref =3D g_new(unsigned int, nr_ring_ref);
> > +
> > +        if (xen_device_frontend_scanf(xendev, "ring-ref", "%u",
> > +                                      &ring_ref[0]) !=3D 1) {
> > +            error_setg(errp, "failed to read ring-ref");
>=20
> Don't you need to free `ring_ref`?

Yes.

>=20
> > +            return;
> > +        }
> [...]
>=20
> > diff --git a/include/hw/xen/xen-qdisk.h b/include/hw/xen/xen-qdisk.h
> > index ade0866037..d7dd2bf0ee 100644
> > --- a/include/hw/xen/xen-qdisk.h
> > +++ b/include/hw/xen/xen-qdisk.h
> > @@ -6,7 +6,15 @@
> >  #ifndef HW_XEN_QDISK_H
> >  #define HW_XEN_QDISK_H
> >
> > +#include "hw/xen/xen.h"
> >  #include "hw/xen/xen-bus.h"
> > +#include "hw/block/block.h"
> > +#include "hw/block/xen_blkif.h"
> > +#include "hw/block/dataplane/xen-qdisk.h"
> > +#include "sysemu/blockdev.h"
> > +#include "sysemu/iothread.h"
> > +#include "sysemu/block-backend.h"
> > +#include "sysemu/iothread.h"
>=20
> You don't need that many includes, especially not iothread.h twice ;-).
>=20

Oops.

> I think those new includes would be enough:
> #include "hw/block/block.h"; for BlockConf
> #include "sysemu/iothread.h"
> #include "hw/block/dataplane/xen-qdisk.h"
>=20

Yes, those seem to be enough.

  Paul

> >
> >  typedef enum XenQdiskVdevType {
> >      XEN_QDISK_VDEV_TYPE_DP,
> > @@ -33,6 +41,10 @@ typedef struct XenQdiskDevice XenQdiskDevice;
> >  struct XenQdiskDevice {
> >      XenDevice xendev;
> >      XenQdiskVdev vdev;
> > +    BlockConf conf;
> > +    unsigned int max_ring_page_order;
> > +    IOThread *iothread;
> > +    XenQdiskDataPlane *dataplane;
> >  };
> >
> >  #endif /* HW_XEN_QDISK_H */
>=20
> --
> Anthony PERARD
