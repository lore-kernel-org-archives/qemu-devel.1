Received: from eggs.gnu.org ([2001:4830:134:3::10]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cihDE-0007N2-Iy
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cihDB-0002PO-Gz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:49:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39078
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cihDB-0002Ow-B2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:49:01 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SChw68034700
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:49:00 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28w2v0jqna-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:48:59 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 28 Feb 2017 12:48:58 -0000
Date: Tue, 28 Feb 2017 13:48:54 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <a5ada7c2-4166-1cdf-a4e0-7c49a68374f9@redhat.com>
References: <baa954b4-53fc-2b4e-b79c-917ba9171a60@de.ibm.com>
	<20170227160609.0d49a87d.cornelia.huck@de.ibm.com>
	<20170227163708.796ab27f.cornelia.huck@de.ibm.com>
	<a5ada7c2-4166-1cdf-a4e0-7c49a68374f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170228134854.141a10e6.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] segfault use VRingMemoryRegionCaches for avail and
 used ring vs num-queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Mon, 27 Feb 2017 16:41:09 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 27/02/2017 16:37, Cornelia Huck wrote:
> > With the following applied (probably whitespace damaged), my guest
> > starts:
> > 
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index e487e36..28906e5 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -287,6 +287,9 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
> >  void virtio_queue_set_notification(VirtQueue *vq, int enable)
> >  {
> >      vq->notification = enable;
> > +    if (!vq->vring.desc) {
> > +        return;
> > +    }
> >  
> >      rcu_read_lock();
> >      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> > 
> > Maybe introduction of caches just exposed bugs that were already there
> > (trying to muck with vring state for queues that have not been setup?)
> 
> Yes, it did.  I had caught a few while writing the patches, but it does
> feel like whack-a-mole...
> 
> Paolo
> 
> > Should we stick some asserts into the respective functions to help
> > flush out the remaining bugs?

I've been staring at the code some more and I'm not really sure how to
fix this properly.

The dataplane code tries to switch handlers for all virtqueues,
regardless whether they are configured or not. My hack above leaves the
notification in a bit of an ambiguous state, as it cannot
enable/disable notifications on the real queues.

This is ok for this particular case, where we hand over from the bios
(which only enables the first queue) to the Linux kernel (which uses
multiple queues) - but with a virtio reset before additional queues are
configured. I don't think the spec prohibits configuring extra queues
(if present) on the fly, however...
