Received: from eggs.gnu.org ([2001:4830:134:3::10]:52156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clvvH-0001uy-QU
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clvvE-0003Q3-Le
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:07:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49503
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1clvvE-0003PQ-FT
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:07:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29B3VP5054374
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 06:07:50 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 292fxqa8gs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 06:07:50 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 9 Mar 2017 11:07:48 -0000
Date: Thu, 9 Mar 2017 12:07:34 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <a8f854b2-bbd3-1665-0b09-2abcad928b9d@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
	<cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
	<20170308101922.730b1579.cornelia.huck@de.ibm.com>
	<64df071f-27b0-9ee6-0b76-d8fa7a9cc8ec@redhat.com>
	<20170308111214.591b49fe.cornelia.huck@de.ibm.com>
	<a8f854b2-bbd3-1665-0b09-2abcad928b9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170309120734.390a7cda.cornelia.huck@de.ibm.com>
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com

On Thu, 9 Mar 2017 10:19:47 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 18:12, Cornelia Huck wrote:
> > On Wed, 8 Mar 2017 17:51:22 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> >> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:19, Cornelia Huck wrote:
> >>> On Wed, 8 Mar 2017 11:18:27 +0800
> >>> Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:16, Cornelia Huck wrote:
> >>>>> On Tue,  7 Mar 2017 16:47:58 +0800
> >>>>> Jason Wang <jasowang@redhat.com> wrote:
> >>>>>
> >>>>>> We don't destroy region cache during reset which can make the maps
> >>>>>> of previous driver leaked to a buggy or malicious driver that don't
> >>>>>> set vring address before starting to use the device. Fix this by
> >>>>>> destroy the region cache during reset and validate it before tryin=
g to
> >>>>>> use them. While at it, also validate address_space_cache_init() du=
ring
> >>>>>> virtio_init_region_cache() to make sure we have a correct region
> >>>>>> cache.
> >>>>>>
> >>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>> ---
> >>>>>>     hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++++++++++=
++++++++--------
> >>>>>>     1 file changed, 76 insertions(+), 12 deletions(-)
> >>>>>> @@ -190,6 +211,10 @@ static inline uint16_t vring_avail_flags(Virt=
Queue *vq)
> >>>>>>     {
> >>>>>>         VRingMemoryRegionCaches *caches =3D atomic_rcu_read(&vq->v=
ring.caches);
> >>>>>>         hwaddr pa =3D offsetof(VRingAvail, flags);
> >>>>>> +    if (!caches) {
> >>>>>> +        virtio_error(vq->vdev, "Cannot map avail flags");
> >>>>> I'm not sure that virtio_error is the right thing here; ending up in
> >>>>> this function with !caches indicates an error in our logic.
> >>>> Probably not, this can be triggered by buggy guest.
> >>> I would think that even a buggy guest should not be able to trigger
> >>> accesses to vring structures that have not yet been set up. What am I
> >>> missing?
> >> I think this may happen if a driver start the device without setting t=
he
> >> vring address. In this case, region caches cache the mapping of previo=
us
> >> driver. But maybe I was wrong.
> > So the sequence would be:
> >
> > - Driver #1 sets up the device, then abandons it without cleaning up
> > via reset
>=20
> If driver #1 reset the device in this case, the caches would be NULL.

Hm, how? Without your patch, the queue addresses are reset to 0 in that
case but the cache is not cleaned up.

>=20
> > - Driver #2 uses the device without doing a reset or proper setup
>=20
> Without this patch, even if driver #2 do a reset, it can still use the=20
> old map if it don't set queue pfn.

Yes, the cleanup-on-reset is definetly needed.

>=20
> >
> > ?
> >
> > I can't quite see why caches would be NULL in that case...
> >
> > Having reset clean up the caches as well (IOW, the other part of your
> > patch) should make sure that we always have a consistent view of
> > descriptors and their caches,
>=20
> And prevent it from being leaked to untrusted drivers.

And that as well, agreed.

I'm still not sure why the checks for !caches help, though...
