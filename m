Received: from eggs.gnu.org ([2001:4830:134:3::10]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=486789cf2=Paul.Durrant@citrix.com>)
	id 1eFGj3-0000dY-SG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=486789cf2=Paul.Durrant@citrix.com>)
	id 1eFGj0-0007sp-Ko
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:44:49 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:47864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=486789cf2=Paul.Durrant@citrix.com>)
	id 1eFGj0-0007nU-6z
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:44:46 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 16 Nov 2017 09:44:41 +0000
Message-ID: <d2c234eee779486c962106143ead8eb3@AMSPEX02CL03.citrite.net>
References: <20171107104653.8913-1-paul.durrant@citrix.com>
	<88c9ab0549a8456e8305353134e099ca@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1711151709140.12676@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1711151709140.12676@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 16 November 2017 01:11
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>; Anthony Perard
> <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>
> Subject: RE: [PATCH v3] xen-disk: use an IOThread per instance
>=20
> On Wed, 15 Nov 2017, Paul Durrant wrote:
> > Anthony, Stefano,
> >
> >   Ping?
>=20
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
>=20
> Unless Anthony or somebody else object, I'll queue it up in my "next"
> branch (which I'll send upstream after 2.11 is out).

Great. Thanks,

  Paul

>=20
> Cheers,
>=20
> Stefano
>=20
>=20
> > > -----Original Message-----
> > > From: Paul Durrant [mailto:paul.durrant@citrix.com]
> > > Sent: 07 November 2017 10:47
> > > To: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org
> > > Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini
> > > <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>;
> > > Kevin Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> > > Subject: [PATCH v3] xen-disk: use an IOThread per instance
> > >
> > > This patch allocates an IOThread object for each xen_disk instance an=
d
> > > sets the AIO context appropriately on connect. This allows processing
> > > of I/O to proceed in parallel.
> > >
> > > The patch also adds tracepoints into xen_disk to make it possible to
> > > follow the state transtions of an instance in the log.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > Cc: Kevin Wolf <kwolf@redhat.com>
> > > Cc: Max Reitz <mreitz@redhat.com>
> > >
> > > v3:
> > >  - Use new iothread_create/destroy() functions
> > >
> > > v2:
> > >  - explicitly acquire and release AIO context in qemu_aio_complete() =
and
> > >    blk_bh()
> > > ---
> > >  hw/block/trace-events |  7 +++++++
> > >  hw/block/xen_disk.c   | 53
> > > ++++++++++++++++++++++++++++++++++++++++++++-------
> > >  2 files changed, 53 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > > index cb6767b3ee..962a3bfa24 100644
> > > --- a/hw/block/trace-events
> > > +++ b/hw/block/trace-events
> > > @@ -10,3 +10,10 @@ virtio_blk_submit_multireq(void *vdev, void *mrb,
> int
> > > start, int num_reqs, uint6
> > >  # hw/block/hd-geometry.c
> > >  hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "bl=
k %p
> > > LCHS %d %d %d"
> > >  hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32_t
> secs,
> > > int trans) "blk %p CHS %u %u %u trans %d"
> > > +
> > > +# hw/block/xen_disk.c
> > > +xen_disk_alloc(char *name) "%s"
> > > +xen_disk_init(char *name) "%s"
> > > +xen_disk_connect(char *name) "%s"
> > > +xen_disk_disconnect(char *name) "%s"
> > > +xen_disk_free(char *name) "%s"
> > > diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> > > index e431bd89e8..f74fcd42d1 100644
> > > --- a/hw/block/xen_disk.c
> > > +++ b/hw/block/xen_disk.c
> > > @@ -27,10 +27,12 @@
> > >  #include "hw/xen/xen_backend.h"
> > >  #include "xen_blkif.h"
> > >  #include "sysemu/blockdev.h"
> > > +#include "sysemu/iothread.h"
> > >  #include "sysemu/block-backend.h"
> > >  #include "qapi/error.h"
> > >  #include "qapi/qmp/qdict.h"
> > >  #include "qapi/qmp/qstring.h"
> > > +#include "trace.h"
> > >
> > >  /* ------------------------------------------------------------- */
> > >
> > > @@ -125,6 +127,9 @@ struct XenBlkDev {
> > >      DriveInfo           *dinfo;
> > >      BlockBackend        *blk;
> > >      QEMUBH              *bh;
> > > +
> > > +    IOThread            *iothread;
> > > +    AioContext          *ctx;
> > >  };
> > >
> > >  /* ------------------------------------------------------------- */
> > > @@ -596,9 +601,12 @@ static int ioreq_runio_qemu_aio(struct ioreq
> > > *ioreq);
> > >  static void qemu_aio_complete(void *opaque, int ret)
> > >  {
> > >      struct ioreq *ioreq =3D opaque;
> > > +    struct XenBlkDev *blkdev =3D ioreq->blkdev;
> > > +
> > > +    aio_context_acquire(blkdev->ctx);
> > >
> > >      if (ret !=3D 0) {
> > > -        xen_pv_printf(&ioreq->blkdev->xendev, 0, "%s I/O error\n",
> > > +        xen_pv_printf(&blkdev->xendev, 0, "%s I/O error\n",
> > >                        ioreq->req.operation =3D=3D BLKIF_OP_READ ? "r=
ead" : "write");
> > >          ioreq->aio_errors++;
> > >      }
> > > @@ -607,10 +615,10 @@ static void qemu_aio_complete(void *opaque,
> int
> > > ret)
> > >      if (ioreq->presync) {
> > >          ioreq->presync =3D 0;
> > >          ioreq_runio_qemu_aio(ioreq);
> > > -        return;
> > > +        goto done;
> > >      }
> > >      if (ioreq->aio_inflight > 0) {
> > > -        return;
> > > +        goto done;
> > >      }
> > >
> > >      if (xen_feature_grant_copy) {
> > > @@ -647,16 +655,19 @@ static void qemu_aio_complete(void *opaque,
> int
> > > ret)
> > >          }
> > >      case BLKIF_OP_READ:
> > >          if (ioreq->status =3D=3D BLKIF_RSP_OKAY) {
> > > -            block_acct_done(blk_get_stats(ioreq->blkdev->blk), &iore=
q-
> >acct);
> > > +            block_acct_done(blk_get_stats(blkdev->blk), &ioreq->acct=
);
> > >          } else {
> > > -            block_acct_failed(blk_get_stats(ioreq->blkdev->blk), &io=
req-
> >acct);
> > > +            block_acct_failed(blk_get_stats(blkdev->blk), &ioreq->ac=
ct);
> > >          }
> > >          break;
> > >      case BLKIF_OP_DISCARD:
> > >      default:
> > >          break;
> > >      }
> > > -    qemu_bh_schedule(ioreq->blkdev->bh);
> > > +    qemu_bh_schedule(blkdev->bh);
> > > +
> > > +done:
> > > +    aio_context_release(blkdev->ctx);
> > >  }
> > >
> > >  static bool blk_split_discard(struct ioreq *ioreq, blkif_sector_t
> > > sector_number,
> > > @@ -913,17 +924,29 @@ static void blk_handle_requests(struct
> XenBlkDev
> > > *blkdev)
> > >  static void blk_bh(void *opaque)
> > >  {
> > >      struct XenBlkDev *blkdev =3D opaque;
> > > +
> > > +    aio_context_acquire(blkdev->ctx);
> > >      blk_handle_requests(blkdev);
> > > +    aio_context_release(blkdev->ctx);
> > >  }
> > >
> > >  static void blk_alloc(struct XenDevice *xendev)
> > >  {
> > >      struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkD=
ev,
> > > xendev);
> > > +    Error *err =3D NULL;
> > > +
> > > +    trace_xen_disk_alloc(xendev->name);
> > >
> > >      QLIST_INIT(&blkdev->inflight);
> > >      QLIST_INIT(&blkdev->finished);
> > >      QLIST_INIT(&blkdev->freelist);
> > > -    blkdev->bh =3D qemu_bh_new(blk_bh, blkdev);
> > > +
> > > +    blkdev->iothread =3D iothread_create(xendev->name, &err);
> > > +    assert(!err);
> > > +
> > > +    blkdev->ctx =3D iothread_get_aio_context(blkdev->iothread);
> > > +    blkdev->bh =3D aio_bh_new(blkdev->ctx, blk_bh, blkdev);
> > > +
> > >      if (xen_mode !=3D XEN_EMULATE) {
> > >          batch_maps =3D 1;
> > >      }
> > > @@ -950,6 +973,8 @@ static int blk_init(struct XenDevice *xendev)
> > >      int info =3D 0;
> > >      char *directiosafe =3D NULL;
> > >
> > > +    trace_xen_disk_init(xendev->name);
> > > +
> > >      /* read xenstore entries */
> > >      if (blkdev->params =3D=3D NULL) {
> > >          char *h =3D NULL;
> > > @@ -1062,6 +1087,8 @@ static int blk_connect(struct XenDevice
> *xendev)
> > >      unsigned int i;
> > >      uint32_t *domids;
> > >
> > > +    trace_xen_disk_connect(xendev->name);
> > > +
> > >      /* read-only ? */
> > >      if (blkdev->directiosafe) {
> > >          qflags =3D BDRV_O_NOCACHE | BDRV_O_NATIVE_AIO;
> > > @@ -1287,6 +1314,8 @@ static int blk_connect(struct XenDevice
> *xendev)
> > >          blkdev->persistent_gnt_count =3D 0;
> > >      }
> > >
> > > +    blk_set_aio_context(blkdev->blk, blkdev->ctx);
> > > +
> > >      xen_be_bind_evtchn(&blkdev->xendev);
> > >
> > >      xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %u,=
 "
> > > @@ -1300,13 +1329,20 @@ static void blk_disconnect(struct XenDevice
> > > *xendev)
> > >  {
> > >      struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkD=
ev,
> > > xendev);
> > >
> > > +    trace_xen_disk_disconnect(xendev->name);
> > > +
> > > +    aio_context_acquire(blkdev->ctx);
> > > +
> > >      if (blkdev->blk) {
> > > +        blk_set_aio_context(blkdev->blk, qemu_get_aio_context());
> > >          blk_detach_dev(blkdev->blk, blkdev);
> > >          blk_unref(blkdev->blk);
> > >          blkdev->blk =3D NULL;
> > >      }
> > >      xen_pv_unbind_evtchn(&blkdev->xendev);
> > >
> > > +    aio_context_release(blkdev->ctx);
> > > +
> > >      if (blkdev->sring) {
> > >          xengnttab_unmap(blkdev->xendev.gnttabdev, blkdev->sring,
> > >                          blkdev->nr_ring_ref);
> > > @@ -1345,6 +1381,8 @@ static int blk_free(struct XenDevice *xendev)
> > >      struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBlkD=
ev,
> > > xendev);
> > >      struct ioreq *ioreq;
> > >
> > > +    trace_xen_disk_free(xendev->name);
> > > +
> > >      blk_disconnect(xendev);
> > >
> > >      while (!QLIST_EMPTY(&blkdev->freelist)) {
> > > @@ -1360,6 +1398,7 @@ static int blk_free(struct XenDevice *xendev)
> > >      g_free(blkdev->dev);
> > >      g_free(blkdev->devtype);
> > >      qemu_bh_delete(blkdev->bh);
> > > +    iothread_destroy(blkdev->iothread);
> > >      return 0;
> > >  }
> > >
> > > --
> > > 2.11.0
> >
