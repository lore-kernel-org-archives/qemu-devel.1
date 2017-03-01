Received: from eggs.gnu.org ([2001:4830:134:3::10]:39564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7Vo-0002U5-Hq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj7Vl-0007a6-9f
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:54:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj7Vl-0007Zs-0m
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:53:57 -0500
Date: Wed, 1 Mar 2017 18:53:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301185117-mutt-send-email-mst@kernel.org>
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
	<331bf747-0c32-0f1a-eda0-40e6fa507494@redhat.com>
	<e78274bf-ed9b-3358-0a5d-271854247da1@linux.vnet.ibm.com>
	<b24ba9f9-11f4-d17f-1973-b94e82316518@redhat.com>
	<08ca0c91-4a6d-1750-ed79-a0f6e2ca7eaf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ca0c91-4a6d-1750-ed79-a0f6e2ca7eaf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fallback from irqfd to
 non-irqfd notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Mar 01, 2017 at 05:08:39PM +0100, Halil Pasic wrote:
> 
> 
> On 03/01/2017 03:29 PM, Paolo Bonzini wrote:
> > 
> > 
> > On 01/03/2017 14:22, Halil Pasic wrote:
> >> Here a trace:
> >>
> >> 135871@1488304024.512533:virtio_blk_req_complete req 0x2aa6b117e10 status 0
> >> 135871@1488304024.512541:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
> >> 135871@1488304024.522607:virtio_blk_req_complete req 0x2aa6b118980 status 0
> >> 135871@1488304024.522616:virtio_blk_req_complete req 0x2aa6b119260 status 0
> >> 135871@1488304024.522627:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
> >> 135871@1488304024.527386:virtio_blk_req_complete req 0x2aa6b118980 status 0
> >> 135871@1488304024.527431:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
> >> 135871@1488304024.528611:virtio_guest_notifier_read vdev 0x2aa6b0e61c8 vq 0x2aa6b4de880
> >> 135871@1488304024.528628:virtio_guest_notifier_read vdev 0x2aa6b0e61c8 vq 0x2aa6b4de8f8
> >> 135871@1488304024.528753:virtio_blk_data_plane_stop dataplane 0x2aa6b0e5540
> >>                          ^== DATAPLANE STOP  
> >> 135871@1488304024.530709:virtio_blk_req_complete req 0x2aa6b117e10 status 0
> >> 135871@1488304024.530752:virtio_guest_notifier_read vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
> >>                          ^== comes from k->set_guest_notifiers(qbus->parent, nvqs, false);
> >>                              in virtio_blk_data_plane_stop and done immediately after
> >>                              irqfd is cleaned up by the transport
> >> 135871@1488304024.530836:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2aa6b4c0870
> >> halil: error in event_notifier_set: Bad file descriptor
> >>                          ^== here we have the problem
> >>
> >> If you want a stacktrace that can be arranged to.
> >>
> >>> like a reset should cause it (the only call in virtio-blk is from
> >>> virtio_blk_data_plane_stop), and then the guest doesn't care anymore
> >>> about interrupts.
> >> I do not understand this with 'doesn't care anymore about interrupts'.
> >> I was debugging a virtio-blk device being stuck waiting for a host
> >> notification (interrupt) after migration.
> > 
> > Ok, this explains it better then.  The issue is that
> > virtio_blk_data_plane_stop doesn't flush the bottom half, which you want
> > to do when the caller is, for example, virtio_ccw_vmstate_change.
> > 
> > Does it work if you call to qemu_bh_cancel(s->bh) and notify_guest_bh(s)
> > after
> > 
> >     blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
> > 
> > ?
> > 
> 
> With
> 
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -260,6 +260,8 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
>  
>      /* Drain and switch bs back to the QEMU main loop */
>      blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
> +    qemu_bh_cancel(s->bh);
> +    notify_guest_bh(s);
>  
> applied I do not see the problem any more. I will most likely
> turn this into a patch tomorrow. I would like to give it some more testing and
> thinking (see questions below) until tomorrow.
> 
> I should probably cc stable, or?
> 
> I would also like to do some diagnostic stuff if virtio_notify_irqfd fails.
> Maybe assert success for event_notifier_set. Would that be OK with you?

Main reason it can't fail is because we don't close the fd.
Given no callers check the return status, I'd be inclined to go further
and stick that assert into event_notifier_set, convert that
function to int.

> I have a couple of questions about the ways of the dataplane code. If
> you are too busy, feel free to not answer -- I will keep thinking myself.
> 
> Q1. For this to work correctly, it seems to me, we need to be sure that
> virtio_blk_req_complete can not be happen between the newly added
> notify_guest_bh(s);
> and 
> vblk->dataplane_started = false; 
> becomes visible. How is this ensured?
> Q2. The virtio_blk_data_plane_stop should be from the thread/context
> associated with the main event loop, and with that
> vblk->dataplane_started = false too. But I think dataplane_started
> may end up being used form a different thread (e.g. req_complete).
> How does the sequencing work there and/or is it even important?
> 
> Regards,
> Halil
