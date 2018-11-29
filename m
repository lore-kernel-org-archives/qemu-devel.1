Received: from eggs.gnu.org ([2001:4830:134:3::10]:35175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86498fae2=Paul.Durrant@citrix.com>)
	id 1gSIhD-0008DC-LM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86498fae2=Paul.Durrant@citrix.com>)
	id 1gSIhC-0006Fh-7J
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:33:19 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 29 Nov 2018 09:33:06 +0000
Message-ID: <bdee6326dd3041f58202220a50abf9c8@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-15-paul.durrant@citrix.com>
	<20181128163447.GF4222@dhcp-200-186.str.redhat.com>
	<a2cd391e72a24547a3565515e8d39d27@AMSPEX02CL03.citrite.net>
	<20181129090046.GA4797@linux.fritz.box>
In-Reply-To: <20181129090046.GA4797@linux.fritz.box>
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
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Max
	Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Sent: 29 November 2018 09:01
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>;
> Anthony Perard <anthony.perard@citrix.com>; Max Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH 14/18] xen: add implementations of xen-qdisk connect
> and disconnect functions...
>=20
> Am 28.11.2018 um 17:40 hat Paul Durrant geschrieben:
> > > -----Original Message-----
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Sent: 28 November 2018 16:35
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> > > devel@lists.xenproject.org; Stefano Stabellini
> <sstabellini@kernel.org>;
> > > Anthony Perard <anthony.perard@citrix.com>; Max Reitz
> <mreitz@redhat.com>
> > > Subject: Re: [PATCH 14/18] xen: add implementations of xen-qdisk
> connect
> > > and disconnect functions...
> > >
> > > Am 21.11.2018 um 16:12 hat Paul Durrant geschrieben:
> > > > ...and wire in the dataplane.
> > > >
> > > > This patch adds the remaining code to make the xen-qdisk XenDevice
> > > > functional. The parameters that a block frontend expects to find ar=
e
> > > > populated in the backend xenstore area, and the 'ring-ref' and
> > > > 'event-channel' values specified in the frontend xenstore area are
> > > > mapped/bound and used to set up the dataplane.
> > > >
> > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > > ---
> > > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > > Cc: Kevin Wolf <kwolf@redhat.com>
> > > > Cc: Max Reitz <mreitz@redhat.com>
> > > > ---
> > > >  hw/block/xen-qdisk.c       | 140
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > > >  hw/xen/xen-bus.c           |  12 ++--
> > > >  include/hw/xen/xen-bus.h   |   8 +++
> > > >  include/hw/xen/xen-qdisk.h |  12 ++++
> > > >  4 files changed, 166 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> > > > index 35f7b70480..8c88393832 100644
> > > > --- a/hw/block/xen-qdisk.c
> > > > +++ b/hw/block/xen-qdisk.c
> > > > @@ -9,6 +9,10 @@
> > > >  #include "qapi/visitor.h"
> > > >  #include "hw/hw.h"
> > > >  #include "hw/xen/xen-qdisk.h"
> > > > +#include "sysemu/blockdev.h"
> > > > +#include "sysemu/block-backend.h"
> > > > +#include "sysemu/iothread.h"
> > > > +#include "dataplane/xen-qdisk.h"
> > > >  #include "trace.h"
> > > >
> > > >  static char *xen_qdisk_get_name(XenDevice *xendev, Error **errp)
> > > > @@ -23,6 +27,11 @@ static void xen_qdisk_realize(XenDevice *xendev,
> > > Error **errp)
> > > >  {
> > > >      XenQdiskDevice *qdiskdev =3D XEN_QDISK_DEVICE(xendev);
> > > >      XenQdiskVdev *vdev =3D &qdiskdev->vdev;
> > > > +    BlockConf *conf =3D &qdiskdev->conf;
> > > > +    DriveInfo *dinfo;
> > > > +    bool is_cdrom;
> > > > +    unsigned int info;
> > > > +    int64_t size;
> > > >
> > > >      if (!vdev->valid) {
> > > >          error_setg(errp, "vdev property not set");
> > > > @@ -30,13 +39,134 @@ static void xen_qdisk_realize(XenDevice
> *xendev,
> > > Error **errp)
> > > >      }
> > > >
> > > >      trace_xen_qdisk_realize(vdev->disk, vdev->partition);
> > > > +
> > > > +    if (!conf->blk) {
> > > > +        error_setg(errp, "drive property not set");
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (!blk_is_inserted(conf->blk)) {
> > > > +        error_setg(errp, "device needs media, but drive is empty")=
;
> > > > +        return;
> > > > +    }
> > >
> > > Hm, the code below suggests that you support CD-ROMs. Don't you want
> to
> > > support media change as well then? Which would mean that you need to
> > > support empty drives.
> >
> > Yes, that's a good point. I should get rid of that check.
>=20
> Or rather apply it only to hard disks. And for empty CDs, you'll
> probably need to create an empty BlockBackend (the !conf->blk case).
> Just check the IDE and/or SCSI code for comparison.
>=20
> > >
> > > > +    if (!blkconf_apply_backend_options(conf, blk_is_read_only(conf=
-
> > > >blk),
> > > > +                                       false, errp)) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (!blkconf_geometry(conf, NULL, 65535, 255, 255, errp)) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    dinfo =3D blk_legacy_dinfo(conf->blk);
> > > > +    is_cdrom =3D (dinfo && dinfo->media_cd);
> > >
> > > It's called legacy for a reason. Don't use this in new devices.
> > >
> > > The proper way is to have two different devices for hard disks and CD=
s
> > > (like scsi-hd and scsi-cd).
> >
> > ...or presumably I could have a property? The legacy init code could
> > then set it based on the drive info.
>=20
> Technically yes, but why would that be a good way to model things? I
> mean, it's true that xen-qdisk is not real hardware, but I've never seen
> any hardware that has a switch to decide whether it should behave as a
> CD drive or a hard disk.
>=20
> Both have very different characteristics (read-only with removable
> media, or a single read-write disk), and the existing implementations
> use two separate devices. So even if you're not convinced that users
> will consider them different concepts (I am; and if they weren't
> different concepts, you wouldn't need an is_cdrom variable), consistency
> is still a good thing.

Ok. I'll split the device as you suggest... it may mean duplicated code, bu=
t the datapath can still be common.

  Paul

>=20
> Kevin
