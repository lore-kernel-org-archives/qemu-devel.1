Received: from eggs.gnu.org ([2001:4830:134:3::10]:46617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUb16-0006uo-KT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUb14-0000oe-O6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:31:20 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 17:31:10 +0000
Message-ID: <3337892391384c0fab8e92c4a048d336@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-11-paul.durrant@citrix.com>
	<20181203180911.GQ14786@perard.uk.xensource.com>
In-Reply-To: <20181203180911.GQ14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 10/18] xen: add header and build
 dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano
	Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 03 December 2018 18:09
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefan Hajnoczi <stefanha@redhat.com>; Kevin
> Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; Stefano Stabellin=
i
> <sstabellini@kernel.org>
> Subject: Re: [PATCH 10/18] xen: add header and build dataplane/xen-qdisk.=
c
>=20
> On Wed, Nov 21, 2018 at 03:12:03PM +0000, Paul Durrant wrote:
> > This patch adds the transformations necessary to get dataplane/xen-
> qdisk.c
> > to build against the new XenBus/XenDevice framework. MAINTAINERS is als=
o
> > updated due to the introduction of dataplane/xen-qdisk.h.
> >
> > NOTE: Existing data structure names are retained for the moment. These
> will
> >       be modified by subsequent patches. A typedef for XenQdiskDataPlan=
e
> >       has been added to the header (based on the old struct XenBlkDev
> name
> >       for the moment) so that the old names don't need to leak out of
> the
> >       dataplane code.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > diff --git a/hw/block/dataplane/xen-qdisk.c b/hw/block/dataplane/xen-
> qdisk.c
> > index 8e4368e7af..b075aa975d 100644
> > --- a/hw/block/dataplane/xen-qdisk.c
> > +++ b/hw/block/dataplane/xen-qdisk.c
> > @@ -5,65 +5,56 @@
> >   * Based on original code (c) Gerd Hoffmann <kraxel@redhat.com>
> >   */
> >
> > +#include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> > +#include "qapi/error.h"
> > +#include "hw/hw.h"
> > +#include "hw/xen/xen.h"
>=20
> xen.h isn't needed, xen_common.h should be enough.
>=20
> > +#include "hw/xen/xen_common.h"
> > +#include "hw/block/block.h"
>=20
> block.h isn't needed, block-backend.h should be enough.
>=20
> > +#include "hw/block/xen_blkif.h"
> > +#include "sysemu/blockdev.h"
>=20
> blockdev.h doesn't seems to be used.
>=20

Ok. I'll clean these up.

> > +#include "sysemu/block-backend.h"
> > +#include "sysemu/iothread.h"
> > +#include "xen-qdisk.h"
> > +
> > @@ -227,20 +219,24 @@ static int ioreq_grant_copy(struct ioreq *ioreq)
> >                  file_blk;
> >              segs[i].dest.virt =3D virt;
> >          }
> > -        segs[i].len =3D (ioreq->req.seg[i].last_sect
> > -                       - ioreq->req.seg[i].first_sect + 1) * file_blk;
> > +        segs[i].len =3D (ioreq->req.seg[i].last_sect -
> > +                       ioreq->req.seg[i].first_sect + 1) * file_blk;
> >          virt +=3D segs[i].len;
> >      }
> >
> > -    rc =3D xen_be_copy_grant_refs(xendev, to_domain, segs, count);
> > +    xen_device_copy_grant_refs(xendev, to_domain, segs, count,
> &local_err);
> > +
> > +    if (local_err) {
> > +        const char *msg =3D error_get_pretty(local_err);
> > +
> > +        error_report("failed to copy data: %s", msg);
> > +        error_free(local_err);
>=20
> You can do the  following instead:
>     error_prepend(local_err, "failed to copy data: ")
>     error_report_err(local_err);
>=20

Done.

> > +void xen_qdisk_dataplane_start(struct XenBlkDev *blkdev,
> > +                               const unsigned int ring_ref[],
> > +                               unsigned int nr_ring_ref,
> > +                               unsigned int event_channel,
> > +                               unsigned int protocol)
> >  {
> > -    struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkDev=
,
> xendev);
> > +    XenDevice *xendev =3D blkdev->xendev;
> > +    unsigned int ring_size;
> > +    unsigned int i;
> >
> > -    qemu_bh_schedule(blkdev->bh);
> > +    blkdev->nr_ring_ref =3D nr_ring_ref;
> > +    blkdev->ring_ref =3D g_new(unsigned int, nr_ring_ref);
> > +
> > +    for (i =3D 0; i < nr_ring_ref; i++) {
> > +        blkdev->ring_ref[i] =3D ring_ref[i];
> > +    }
> > +
> > +    blkdev->protocol =3D protocol;
> > +
> > +    ring_size =3D XC_PAGE_SIZE * blkdev->nr_ring_ref;
> > +    switch (blkdev->protocol) {
> > +    case BLKIF_PROTOCOL_NATIVE:
> > +    {
> > +        blkdev->max_requests =3D __CONST_RING_SIZE(blkif, ring_size);
> > +        break;
> > +    }
> > +    case BLKIF_PROTOCOL_X86_32:
> > +    {
> > +        blkdev->max_requests =3D __CONST_RING_SIZE(blkif_x86_32,
> ring_size);
> > +        break;
> > +    }
> > +    case BLKIF_PROTOCOL_X86_64:
> > +    {
> > +        blkdev->max_requests =3D __CONST_RING_SIZE(blkif_x86_64,
> ring_size);
> > +        break;
> > +    }
> > +    default:
> > +        assert(false);
> > +        break;
>=20
> This should return rather than keep going.
> And maybe set an Error that could be added to the parameter of the
> function.
>=20
> > +    }
> > +
> > +    xen_device_set_max_grant_refs(xendev, blkdev->nr_ring_ref,
> > +                                  &error_fatal);
>=20
> Do we really want to exit() here if an error happen, rather than let the
> caller know? (Same question for other uses of error_fatal.)
>=20

Indeed. I added an error pointer to the function so it can bail cleanly.

> > diff --git a/hw/block/dataplane/xen-qdisk.h b/hw/block/dataplane/xen-
> qdisk.h
> > new file mode 100644
> > index 0000000000..16bcd500bf
> > --- /dev/null
> > +++ b/hw/block/dataplane/xen-qdisk.h
> > @@ -0,0 +1,25 @@
> > +/*
> > + * Copyright (c) Citrix Systems Inc.
> > + * All rights reserved.
> > + */
> > +
> > +#ifndef HW_BLOCK_DATAPLANE_QDISK_H
> > +#define HW_BLOCK_DATAPLANE_QDISK_H
> > +
> > +#include "hw/xen/xen-bus.h"
> > +#include "sysemu/iothread.h"
>=20
> I would add #include "hw/block/block.h" since it includes the definition
> of BlockConf.
>=20

Sure.

  Paul

> > +
> > +typedef struct XenBlkDev XenQdiskDataPlane;
> > +
> > +XenQdiskDataPlane *xen_qdisk_dataplane_create(XenDevice *xendev,
> > +                                              BlockConf *conf,
> > +                                              IOThread *iothread);
>=20
> Thanks,
>=20
> --
> Anthony PERARD
