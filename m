Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clXku-0004gX-JP
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clXkq-0003Co-HZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:19:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59582
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1clXkq-0003Ci-AP
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:19:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v289DtGd144218
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 04:19:30 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292f2kgccq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 04:19:29 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 8 Mar 2017 09:19:27 -0000
Date: Wed, 8 Mar 2017 10:19:22 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
	<cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170308101922.730b1579.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com

On Wed, 8 Mar 2017 11:18:27 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:16, Cornelia Huck wrote:
> > On Tue,  7 Mar 2017 16:47:58 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> >> We don't destroy region cache during reset which can make the maps
> >> of previous driver leaked to a buggy or malicious driver that don't
> >> set vring address before starting to use the device. Fix this by
> >> destroy the region cache during reset and validate it before trying to
> >> use them. While at it, also validate address_space_cache_init() during
> >> virtio_init_region_cache() to make sure we have a correct region
> >> cache.
> >>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> ---
> >>   hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++++++++++++++++=
++--------
> >>   1 file changed, 76 insertions(+), 12 deletions(-)

> >> @@ -190,6 +211,10 @@ static inline uint16_t vring_avail_flags(VirtQueu=
e *vq)
> >>   {
> >>       VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->vring.c=
aches);
> >>       hwaddr pa =3D offsetof(VRingAvail, flags);
> >> +    if (!caches) {
> >> +        virtio_error(vq->vdev, "Cannot map avail flags");
> > I'm not sure that virtio_error is the right thing here; ending up in
> > this function with !caches indicates an error in our logic.
>=20
> Probably not, this can be triggered by buggy guest.

I would think that even a buggy guest should not be able to trigger
accesses to vring structures that have not yet been set up. What am I
missing?

>=20
> > An assert
> > might be better (and I hope we can sort out all of those errors exposed
> > by the introduction of region caches for 2.9...)
>=20
> I thought we should avoid assert as much as possible in this case. But=20
> if you and maintainer want an assert, it's also fine.

My personal rule-of-thumb:
- If it is something that can be triggered by the guest, or it is
something that is easily recovered, set the device to broken.
- If it is something that indicates that we messed up our internal
logic, use an assert.

I think arriving here with !caches indicates the second case; but if
there is a way for a guest to trigger this, setting the device to
broken would certainly be better.

>=20
> >
> >> +        return 0;
> >> +    }
> >>       return virtio_lduw_phys_cached(vq->vdev, &caches->avail, pa);
> >>   }
> >>

> >> @@ -1117,6 +1174,15 @@ static enum virtio_device_endian virtio_current=
_cpu_endian(void)
> >>       }
> >>   }
> >>
> >> +static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
> >> +{
> >> +    VRingMemoryRegionCaches *caches;
> >> +
> >> +    caches =3D atomic_read(&vq->vring.caches);
> >> +    atomic_set(&vq->vring.caches, NULL);
> >> +    virtio_free_region_cache(caches);
> > Shouldn't this use rcu to free it? Unconditionally setting caches to
> > NULL feels wrong...
>=20
> Right, will switch to use rcu.
>=20
> >> +}
> >> +
> >>   void virtio_reset(void *opaque)
> >>   {
> >>       VirtIODevice *vdev =3D opaque;
> >> @@ -1157,6 +1223,7 @@ void virtio_reset(void *opaque)
> >>           vdev->vq[i].notification =3D true;
> >>           vdev->vq[i].vring.num =3D vdev->vq[i].vring.num_default;
> >>           vdev->vq[i].inuse =3D 0;
> >> +        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> > ...especially as you call it in a reset context here.
> >
> >>       }
> >>   }
> >>
> >> @@ -2451,13 +2518,10 @@ static void virtio_device_free_virtqueues(Virt=
IODevice *vdev)
> >>       }
> >>
> >>       for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> >> -        VRingMemoryRegionCaches *caches;
> >>           if (vdev->vq[i].vring.num =3D=3D 0) {
> >>               break;
> >>           }
> >> -        caches =3D atomic_read(&vdev->vq[i].vring.caches);
> >> -        atomic_set(&vdev->vq[i].vring.caches, NULL);
> >> -        virtio_free_region_cache(caches);
> >> +        virtio_virtqueue_reset_region_cache(&vdev->vq[i]);
> > OTOH, immediate destruction may still be called for during device
> > finalization.
> >
>=20
> Right but to avoid code duplication, use rcu unconditionally should be=20
> no harm here.

Yes, this should be fine.
