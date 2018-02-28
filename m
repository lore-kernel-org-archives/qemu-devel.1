Received: from eggs.gnu.org ([2001:4830:134:3::10]:58150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqr0p-0003NT-4V
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 20:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eqr0o-0007CV-Eq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 20:58:31 -0500
Date: Wed, 28 Feb 2018 09:58:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180228015813.GC21336@lemon.usersys.redhat.com>
References: <20180220131014.8998-1-stefanha@redhat.com>
	<20180223082044.GB31530@lemon.usersys.redhat.com>
	<20180227153025.GA32480@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227153025.GA32480@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, 02/27 15:30, Stefan Hajnoczi wrote:
> On Fri, Feb 23, 2018 at 04:20:44PM +0800, Fam Zheng wrote:
> > On Tue, 02/20 13:10, Stefan Hajnoczi wrote:
> > > 1. virtio_scsi_handle_cmd_vq() racing with iothread_stop_all() hits the
> > >    virtio_scsi_ctx_check() assertion failure because the BDS AioContext
> > >    has been modified by iothread_stop_all().
> > 
> > Does this patch fix the issue completely? IIUC virtio_scsi_handle_cmd can
> > already be entered at the time of main thread calling virtio_scsi_clear_aio(),
> > so this race condition still exists:
> > 
> >   main thread                           iothread
> > -----------------------------------------------------------------------------
> >   vm_shutdown
> >     ...
> >       virtio_bus_stop_ioeventfd
> >         virtio_scsi_dataplane_stop
> >                                         aio_poll()
> >                                           ...
> >                                             virtio_scsi_data_plane_handle_cmd()
> >           aio_context_acquire(s->ctx)
> >                                               virtio_scsi_acquire(s).enter
> >           virtio_scsi_clear_aio()
> >           aio_context_release(s->ctx)
> >                                               virtio_scsi_acquire(s).return
> >                                               virtio_scsi_handle_cmd_vq()
> >                                                 ...
> >                                                   virtqueue_pop()
> > 
> > Is it possible that the above virtqueue_pop() still returns one element that was
> > queued before vm_shutdown() was called?
> 
> No, it can't because virtio_scsi_clear_aio() invokes
> virtio_queue_host_notifier_aio_read(&vq->host_notifier) to process the
> virtqueue.  By the time we get back to iothread's
> virtio_scsi_data_plane_handle_cmd() the virtqueue is already empty.
> 
> Vcpus have been paused so no additional elements can slip into the
> virtqueue.

So there is:

static void virtio_queue_host_notifier_aio_read(EventNotifier *n)
{
    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
    if (event_notifier_test_and_clear(n)) {
        virtio_queue_notify_aio_vq(vq);
    }
}

Guest kicks after adding an element to VQ, but we check ioeventfd before trying
virtqueue_pop(). Is that a problem? If VCPUs are paused after enqueuing but
before kicking VQ, the ioeventfd is not set, the virtqueue is not processed
here.

Fam
