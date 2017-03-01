Received: from eggs.gnu.org ([2001:4830:134:3::10]:47760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj6v7-0004pL-CQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cj6v3-0005Qb-Tj
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:16:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35209
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cj6v3-0005Q6-Nq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:16:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21GFQQm099314
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 11:15:59 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28x139syty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:15:59 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 1 Mar 2017 16:15:57 -0000
Date: Wed, 1 Mar 2017 17:15:54 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170301174738-mutt-send-email-mst@kernel.org>
References: <20170228152411.81609-1-cornelia.huck@de.ibm.com>
	<20170301174738-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170301171554.1bd4107b.cornelia.huck@de.ibm.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, borntraeger@de.ibm.com

On Wed, 1 Mar 2017 17:55:24 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Feb 28, 2017 at 04:24:11PM +0100, Cornelia Huck wrote:
> > Switching to vring caches exposed an existing bug in
> > virtio_queue_set_notification(): We can't access vring structures
> > if they have not been set up yet. This may happen, for example,
> > for virtio-blk devices with multiple queues: The code will try to
> > switch notifiers for every queue, but the guest may have only set up
> > a subset of them.
> > 
> > Fix this by (1) guarding access to the vring memory by checking
> > for vring.desc and (2) triggering an update to the vring flags
> > for consistency with the configured notification state once the
> > queue is actually configured.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/virtio/virtio.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index e487e36..d2ecd64 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -284,10 +284,11 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
> >      virtio_stw_phys_cached(vq->vdev, &caches->used, pa, val);
> >  }
> >  
> > -void virtio_queue_set_notification(VirtQueue *vq, int enable)
> > +static void vring_set_notification(VirtQueue *vq, int enable)
> >  {
> > -    vq->notification = enable;
> > -
> > +    if (!vq->vring.desc) {
> > +        return;
> > +    }
> >      rcu_read_lock();
> >      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> >          vring_set_avail_event(vq, vring_avail_idx(vq));
> > @@ -303,6 +304,13 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
> >      rcu_read_unlock();
> >  }
> >  
> > +void virtio_queue_set_notification(VirtQueue *vq, int enable)
> > +{
> > +    vq->notification = enable;
> > +
> > +    vring_set_notification(vq, enable);
> > +}
> > +
> >  int virtio_queue_ready(VirtQueue *vq)
> >  {
> >      return vq->vring.avail != 0;
> > @@ -1348,6 +1356,7 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
> >  {
> >      vdev->vq[n].vring.desc = addr;
> >      virtio_queue_update_rings(vdev, n);
> > +    vring_set_notification(&vdev->vq[n], vdev->vq[n].notification);
> >  }
> >  
> >  hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
> > @@ -1362,6 +1371,7 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
> >      vdev->vq[n].vring.avail = avail;
> >      vdev->vq[n].vring.used = used;
> >      virtio_init_region_cache(vdev, n);
> > +    vring_set_notification(&vdev->vq[n], vdev->vq[n].notification);
> >  }
> >  
> >  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
> 
> There's a problem here, this violates the spec:
> - for legacy devices, we shouldn't touch rings until we get a first kick
> - for virtio 1 devices, we should not do it until DRIVER_OK
> 
> This is the real problem therefore: aio poll should not even
> start before these events. Pls fix that and then you will not
> need to call vring_set_notification from set rings.

Hooking into set_status for virtio-1 devices should not be a problem.

For legacy, we probably need to track and do a delayed switch.  Let me
see what I can come up with.
