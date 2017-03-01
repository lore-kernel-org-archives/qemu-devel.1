Received: from eggs.gnu.org ([2001:4830:134:3::10]:44916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7gV-0000mb-AG
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7gS-0003dR-4Q
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:05:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj7gR-0003d1-Ss
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 12:05:00 -0500
Date: Wed, 1 Mar 2017 19:04:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301190237-mutt-send-email-mst@kernel.org>
References: <20170228152411.81609-1-cornelia.huck@de.ibm.com>
	<20170301174738-mutt-send-email-mst@kernel.org>
	<20170301171554.1bd4107b.cornelia.huck@de.ibm.com>
	<20170301184527-mutt-send-email-mst@kernel.org>
	<20170301180044.507969c9.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170301180044.507969c9.cornelia.huck@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: guard vring access when setting
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, borntraeger@de.ibm.com

On Wed, Mar 01, 2017 at 06:00:44PM +0100, Cornelia Huck wrote:
> On Wed, 1 Mar 2017 18:50:34 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Mar 01, 2017 at 05:15:54PM +0100, Cornelia Huck wrote:
> > > On Wed, 1 Mar 2017 17:55:24 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >=20
> > > > On Tue, Feb 28, 2017 at 04:24:11PM +0100, Cornelia Huck wrote:
> > > > > Switching to vring caches exposed an existing bug in
> > > > > virtio_queue_set_notification(): We can't access vring structur=
es
> > > > > if they have not been set up yet. This may happen, for example,
> > > > > for virtio-blk devices with multiple queues: The code will try =
to
> > > > > switch notifiers for every queue, but the guest may have only s=
et up
> > > > > a subset of them.
> > > > >=20
> > > > > Fix this by (1) guarding access to the vring memory by checking
> > > > > for vring.desc and (2) triggering an update to the vring flags
> > > > > for consistency with the configured notification state once the
> > > > > queue is actually configured.
> > > > >=20
> > > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > > > ---
> > > > >  hw/virtio/virtio.c | 16 +++++++++++++---
> > > > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index e487e36..d2ecd64 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -284,10 +284,11 @@ static inline void vring_set_avail_event(=
VirtQueue *vq, uint16_t val)
> > > > >      virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
> > > > >  }
> > > > > =20
> > > > > -void virtio_queue_set_notification(VirtQueue *vq, int enable)
> > > > > +static void vring_set_notification(VirtQueue *vq, int enable)
> > > > >  {
> > > > > -    vq->notification =3D enable;
> > > > > -
> > > > > +    if (!vq->vring.desc) {
> > > > > +        return;
> > > > > +    }
> > > > >      rcu_read_lock();
> > > > >      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_=
IDX)) {
> > > > >          vring_set_avail_event(vq, vring_avail_idx(vq));
> > > > > @@ -303,6 +304,13 @@ void virtio_queue_set_notification(VirtQue=
ue *vq, int enable)
> > > > >      rcu_read_unlock();
> > > > >  }
> > > > > =20
> > > > > +void virtio_queue_set_notification(VirtQueue *vq, int enable)
> > > > > +{
> > > > > +    vq->notification =3D enable;
> > > > > +
> > > > > +    vring_set_notification(vq, enable);
> > > > > +}
> > > > > +
> > > > >  int virtio_queue_ready(VirtQueue *vq)
> > > > >  {
> > > > >      return vq->vring.avail !=3D 0;
> > > > > @@ -1348,6 +1356,7 @@ void virtio_queue_set_addr(VirtIODevice *=
vdev, int n, hwaddr addr)
> > > > >  {
> > > > >      vdev->vq[n].vring.desc =3D addr;
> > > > >      virtio_queue_update_rings(vdev, n);
> > > > > +    vring_set_notification(&vdev->vq[n], vdev->vq[n].notificat=
ion);
> > > > >  }
> > > > > =20
> > > > >  hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
> > > > > @@ -1362,6 +1371,7 @@ void virtio_queue_set_rings(VirtIODevice =
*vdev, int n, hwaddr desc,
> > > > >      vdev->vq[n].vring.avail =3D avail;
> > > > >      vdev->vq[n].vring.used =3D used;
> > > > >      virtio_init_region_cache(vdev, n);
> > > > > +    vring_set_notification(&vdev->vq[n], vdev->vq[n].notificat=
ion);
> > > > >  }
> > > > > =20
> > > > >  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> > > >=20
> > > > There's a problem here, this violates the spec:
> > > > - for legacy devices, we shouldn't touch rings until we get a fir=
st kick
> > > > - for virtio 1 devices, we should not do it until DRIVER_OK
> > > >=20
> > > > This is the real problem therefore: aio poll should not even
> > > > start before these events. Pls fix that and then you will not
> > > > need to call vring_set_notification from set rings.
> > >=20
> > > Hooking into set_status for virtio-1 devices should not be a proble=
m.
> > >=20
> > > For legacy, we probably need to track and do a delayed switch.  Let=
 me
> > > see what I can come up with.
> >=20
> >=20
> > Yes all these callbacks complicate code to the point it's barely
> > readable. I really don't see why are we poking at device beforehand a=
t
> > all. IMHO this is closer to the root of the problem. Don't do it.  On=
e
> > way to look at it is to say that we start aio too early. Do it at
> > driver_ok for virtio 1 and on kick for virtio 0 and problems will go
> > away.
>=20
> The problem exists for the case where the guest sets up only the first
> queue, but the host has more than one queue. The guest setting up other
> queues later is probably patholotical, but not really forbidden by the
> spec (I think).

I think it's forbidden.  spec explains how queues are set up:

1. Reset the device.
2. Set the ACKNOWLEDGE status bit: the guest OS has notice the device.
3. Set the DRIVER status bit: the guest OS knows how to drive the device.
4. Read device feature bits, and write the subset of feature bits underst=
ood by the OS and driver to the
device. During this step the driver MAY read (but MUST NOT write) the dev=
ice-specific configuration
fields to check that it can support the device before accepting it.
5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature=
 bits after this step.
6. Re-read device status to ensure the FEATURES_OK bit is still set: othe=
rwise, the device does not
support our subset of features and the device is unusable.
7. Perform device-specific setup, including discovery of virtqueues for t=
he device, optional per-bus setup,
reading and possibly writing the device=E2=80=99s virtio configuration sp=
ace, and population of virtqueues.
8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cliv=
e=E2=80=9D.

And it goes on to mention a bug in legacy drivers:
Legacy driver implementations often used the device before setting the DR=
IVER_OK bit, and sometimes
even before writing the feature bits to the device.



> >=20
> > In fact, is there even a need to call vring_set_notification that ear=
ly?
> > queues are initialized by guest to 0 so you get a notification on fir=
st
> > buffer unconditionally.
> >=20
> > Would just
> > +    if (!vq->vring.desc) {
> > +        return;
> > +    }
> > be enough?
> >=20
