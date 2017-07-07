Received: from eggs.gnu.org ([2001:4830:134:3::10]:58197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTbOy-0004Ge-Ss
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTbOx-0000ec-20
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:07:04 -0400
Date: Fri, 7 Jul 2017 15:06:53 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <3b55bff7d41d4b37b52a8ec96d88677a@AMSPEX02CL01.citrite.net>
Message-ID: <alpine.DEB.2.10.1707071452400.2919@sstabellini-ThinkPad-X260>
References: <20170621125249.8805-1-paul.durrant@citrix.com>
	<20170621125249.8805-4-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706221410580.12819@sstabellini-ThinkPad-X260>
	<3b55bff7d41d4b37b52a8ec96d88677a@AMSPEX02CL01.citrite.net>
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.10.1707071453550.2919@sstabellini-ThinkPad-X260>
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen-disk: use an IOThread per
 instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "afaerber@suse.de" <afaerber@suse.de>, armbru@redhat.com

On Fri, 7 Jul 2017, Paul Durrant wrote:
> > -----Original Message-----
> > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > Sent: 22 June 2017 23:15
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; qemu-
> > block@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; Anthon=
y
> > Perard <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>;
> > Max Reitz <mreitz@redhat.com>; afaerber@suse.de
> > Subject: Re: [PATCH v2 3/3] xen-disk: use an IOThread per instance
> >=20
> > CC'ing Andreas F=C3=A4rber. Could you please give a quick look below =
at the
> > way the iothread object is instantiate and destroyed? I am no object
> > model expert and would appreaciate a second opinion.
> >=20
>=20
> I have not seen any response so far.
>=20
> >=20
> > On Wed, 21 Jun 2017, Paul Durrant wrote:
> > > This patch allocates an IOThread object for each xen_disk instance =
and
> > > sets the AIO context appropriately on connect. This allows processi=
ng
> > > of I/O to proceed in parallel.
> > >
> > > The patch also adds tracepoints into xen_disk to make it possible t=
o
> > > follow the state transtions of an instance in the log.
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > Cc: Kevin Wolf <kwolf@redhat.com>
> > > Cc: Max Reitz <mreitz@redhat.com>
> > >
> > > v2:
> > >  - explicitly acquire and release AIO context in qemu_aio_complete(=
) and
> > >    blk_bh()
> > > ---
> > >  hw/block/trace-events |  7 ++++++
> > >  hw/block/xen_disk.c   | 69
> > ++++++++++++++++++++++++++++++++++++++++++++-------
> > >  2 files changed, 67 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > > index 65e83dc258..608b24ba66 100644
> > > --- a/hw/block/trace-events
> > > +++ b/hw/block/trace-events
> > > @@ -10,3 +10,10 @@ virtio_blk_submit_multireq(void *mrb, int start,=
 int
> > num_reqs, uint64_t offset,
> > >  # hw/block/hd-geometry.c
> > >  hd_geometry_lchs_guess(void *blk, int cyls, int heads, int secs) "=
blk %p
> > LCHS %d %d %d"
> > >  hd_geometry_guess(void *blk, uint32_t cyls, uint32_t heads, uint32=
_t
> > secs, int trans) "blk %p CHS %u %u %u trans %d"
> > > +
> > > +# hw/block/xen_disk.c
> > > +xen_disk_alloc(char *name) "%s"
> > > +xen_disk_init(char *name) "%s"
> > > +xen_disk_connect(char *name) "%s"
> > > +xen_disk_disconnect(char *name) "%s"
> > > +xen_disk_free(char *name) "%s"
> > > diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> > > index 0e6513708e..8548195195 100644
> > > --- a/hw/block/xen_disk.c
> > > +++ b/hw/block/xen_disk.c
> > > @@ -27,10 +27,13 @@
> > >  #include "hw/xen/xen_backend.h"
> > >  #include "xen_blkif.h"
> > >  #include "sysemu/blockdev.h"
> > > +#include "sysemu/iothread.h"
> > >  #include "sysemu/block-backend.h"
> > >  #include "qapi/error.h"
> > >  #include "qapi/qmp/qdict.h"
> > >  #include "qapi/qmp/qstring.h"
> > > +#include "qom/object_interfaces.h"
> > > +#include "trace.h"
> > >
> > >  /* ------------------------------------------------------------- *=
/
> > >
> > > @@ -128,6 +131,9 @@ struct XenBlkDev {
> > >      DriveInfo           *dinfo;
> > >      BlockBackend        *blk;
> > >      QEMUBH              *bh;
> > > +
> > > +    IOThread            *iothread;
> > > +    AioContext          *ctx;
> > >  };
> > >
> > >  /* ------------------------------------------------------------- *=
/
> > > @@ -599,9 +605,12 @@ static int ioreq_runio_qemu_aio(struct ioreq
> > *ioreq);
> > >  static void qemu_aio_complete(void *opaque, int ret)
> > >  {
> > >      struct ioreq *ioreq =3D opaque;
> > > +    struct XenBlkDev *blkdev =3D ioreq->blkdev;
> > > +
> > > +    aio_context_acquire(blkdev->ctx);
> >=20
> > I think that Paolo was right that we need a aio_context_acquire here,
> > however the issue is that with the current code:
> >=20
> >   blk_handle_requests -> ioreq_runio_qemu_aio -> qemu_aio_complete
> >=20
> > leading to aio_context_acquire being called twice on the same lock,
> > which I don't think is allowed?
>=20
> It resolves to a qemu_rec_mutex_lock() which I believed is a recursive =
lock, so I think that's ok.

On Linux it becomes pthread_mutex_lock. The lock is created by
qemu_rec_mutex_init which specifies PTHREAD_MUTEX_RECURSIVE, so yes, it
should be recursive. Good.


> >=20
> > I think we need to get rid of the qemu_aio_complete call from
> > ioreq_runio_qemu_aio, but to do that we need to be careful with the
> > accounting of aio_inflight (today it's incremented unconditionally at
> > the beginning of ioreq_runio_qemu_aio, I think we would have to chang=
e
> > that to increment it only if presync).
> >=20
>=20
> If the lock is indeed recursive then I think we can avoid this complica=
tion.

OK


> >=20
> > >      if (ret !=3D 0) {
> > > -        xen_pv_printf(&ioreq->blkdev->xendev, 0, "%s I/O error\n",
> > > +        xen_pv_printf(&blkdev->xendev, 0, "%s I/O error\n",
> > >                        ioreq->req.operation =3D=3D BLKIF_OP_READ ? =
"read" : "write");
> > >          ioreq->aio_errors++;
> > >      }
> > > @@ -610,13 +619,13 @@ static void qemu_aio_complete(void *opaque, i=
nt
> > ret)
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
> > > -    if (ioreq->blkdev->feature_grant_copy) {
> > > +    if (blkdev->feature_grant_copy) {
> > >          switch (ioreq->req.operation) {
> > >          case BLKIF_OP_READ:
> > >              /* in case of failure ioreq->aio_errors is increased *=
/
> > > @@ -638,7 +647,7 @@ static void qemu_aio_complete(void *opaque, int
> > ret)
> > >      }
> > >
> > >      ioreq->status =3D ioreq->aio_errors ? BLKIF_RSP_ERROR :
> > BLKIF_RSP_OKAY;
> > > -    if (!ioreq->blkdev->feature_grant_copy) {
> > > +    if (!blkdev->feature_grant_copy) {
> > >          ioreq_unmap(ioreq);
> > >      }
> > >      ioreq_finish(ioreq);
> > > @@ -650,16 +659,19 @@ static void qemu_aio_complete(void *opaque, i=
nt
> > ret)
> > >          }
> > >      case BLKIF_OP_READ:
> > >          if (ioreq->status =3D=3D BLKIF_RSP_OKAY) {
> > > -            block_acct_done(blk_get_stats(ioreq->blkdev->blk), &io=
req->acct);
> > > +            block_acct_done(blk_get_stats(blkdev->blk), &ioreq->ac=
ct);
> > >          } else {
> > > -            block_acct_failed(blk_get_stats(ioreq->blkdev->blk), &=
ioreq->acct);
> > > +            block_acct_failed(blk_get_stats(blkdev->blk), &ioreq->=
acct);
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
> > sector_number,
> > > @@ -917,17 +929,40 @@ static void blk_handle_requests(struct XenBlk=
Dev
> > *blkdev)
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
> > >      struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBl=
kDev,
> > xendev);
> > > +    Object *obj;
> > > +    char *name;
> > > +    Error *err =3D NULL;
> > > +
> > > +    trace_xen_disk_alloc(xendev->name);
> > >
> > >      QLIST_INIT(&blkdev->inflight);
> > >      QLIST_INIT(&blkdev->finished);
> > >      QLIST_INIT(&blkdev->freelist);
> > > -    blkdev->bh =3D qemu_bh_new(blk_bh, blkdev);
> > > +
> > > +    obj =3D object_new(TYPE_IOTHREAD);
> > > +    name =3D g_strdup_printf("iothread-%s", xendev->name);
> > > +
> > > +    object_property_add_child(object_get_objects_root(), name, obj=
,
> > &err);
> > > +    assert(!err);
> >=20
> > Would it be enough to call object_ref?
> >=20
>=20
> You mean to avoid the assert? I guess so but I think any failure here w=
ould be indicative of a larger problem.

No, I meant calling object_ref instead of object_property_add_child.


> >=20
> > > +    g_free(name);
> > > +
> > > +    user_creatable_complete(obj, &err);
> >=20
> > Why do we need to call this?
> >=20
>=20
> I'm not entirely sure but looking around the object code it seemed to b=
e a necessary part of instantiation. Maybe it is not required for iothrea=
d objects, but I could not figure that out from looking at the code and c=
omments in the header suggest it is harmless if it is not required.
>
> > > +    assert(!err);
> > > +
> > > +    blkdev->iothread =3D (IOThread *)object_dynamic_cast(obj,
> > TYPE_IOTHREAD);
> > > +    blkdev->ctx =3D iothread_get_aio_context(blkdev->iothread);
> > > +    blkdev->bh =3D aio_bh_new(blkdev->ctx, blk_bh, blkdev);
> > > +
> > >      if (xen_mode !=3D XEN_EMULATE) {
> > >          batch_maps =3D 1;
> > >      }
> > > @@ -1288,6 +1327,8 @@ static int blk_connect(struct XenDevice *xend=
ev)
> > >          blkdev->persistent_gnt_count =3D 0;
> > >      }
> > >
> > > +    blk_set_aio_context(blkdev->blk, blkdev->ctx);
> > > +
> > >      xen_be_bind_evtchn(&blkdev->xendev);
> > >
> > >      xen_pv_printf(&blkdev->xendev, 1, "ok: proto %s, nr-ring-ref %=
u, "
> > > @@ -1301,13 +1342,20 @@ static void blk_disconnect(struct XenDevice
> > *xendev)
> > >  {
> > >      struct XenBlkDev *blkdev =3D container_of(xendev, struct XenBl=
kDev,
> > xendev);
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
> > > @@ -1358,6 +1408,7 @@ static int blk_free(struct XenDevice *xendev)
> > >      g_free(blkdev->dev);
> > >      g_free(blkdev->devtype);
> > >      qemu_bh_delete(blkdev->bh);
> > > +    object_unparent(OBJECT(blkdev->iothread));
> >=20
> > Shouldn't this be object_unref?
> >=20
>=20
> I don't think so. I think this is required to undo what was done by cal=
ling object_property_add_child() on the root object.

Right, so if object_property_add_child is not actually required, then
you might be able to turn object_unparent into object_unref.

Unfortunately I don't know enough about QOM to be able to tell which is
the right way of doing things, but looking at
hw/block/dataplane/virtio-blk.c, it would seem that only object_ref and
object_unref are required?


> Looking at other code such as object_new_with_propv() it looks like the=
 right thing to do is to call object_unref() after calling object_propert=
y_add_child() to drop the implicit ref taken by object_new() so I'd need =
to add the call in blk_alloc().
