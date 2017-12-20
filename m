Received: from eggs.gnu.org ([2001:4830:134:3::10]:54011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eRdte-0000x7-3a
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eRdtY-0008Eh-QP
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:54:54 -0500
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:56937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eRdtY-00082I-H5
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 07:54:48 -0500
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7046EB5355
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 13:54:37 +0100 (CET)
Date: Wed, 20 Dec 2017 13:54:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171220135431.36992600@bahia.lan>
In-Reply-To: <alpine.DEB.2.10.1712121508370.8052@sstabellini-ThinkPad-X260>
References: <20171204203619.GA16349@juliacomputing.com>
	<20171207180424.4592e144@bahia.lan>
	<20171208075740.7f87a491@bahia.lan>
	<alpine.DEB.2.10.1712121508370.8052@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: Correctly handle cancelled
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Keno Fischer <keno@juliacomputing.com>, stefano@aporeto.com, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com

On Tue, 12 Dec 2017 15:14:06 -0800 (PST)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Fri, 8 Dec 2017, Greg Kurz wrote:
> > Cc'ing Stefano using a more appropriate address :)  
> 
> Thanks Greg for the ping, one comment inline below.
> 
> 
> > On Thu, 7 Dec 2017 18:04:24 +0100
> > Greg Kurz <groug@kaod.org> wrote:
> >   
> > > On Mon, 4 Dec 2017 15:36:19 -0500
> > > Keno Fischer <keno@juliacomputing.com> wrote:
> > >   
> > > >  # Background
> > > > 
> > > > I was investigating spurious non-deterministic EINTR returns from
> > > > various 9p file system operations in a Linux guest served from the
> > > > qemu 9p server.
> > > > 
> > > >  ## EINTR, ERESTARTSYS and the linux kernel
> > > > 
> > > > When a signal arrives that the Linux kernel needs to deliver to user-space
> > > > while a given thread is blocked (in the 9p case waiting for a reply to its
> > > > request in 9p_client_rpc -> wait_event_interruptible), it asks whatever
> > > > driver is currently running to abort its current operation (in the 9p case
> > > > causing the submission of a TFLUSH message) and return to user space.
> > > > In these situations, the error message reported is generally ERESTARTSYS.
> > > > If the userspace processes specified SA_RESTART, this means that the
> > > > system call will get restarted upon completion of the signal handler
> > > > delivery (assuming the signal handler doesn't modify the process state
> > > > in complicated ways not relevant here). If SA_RESTART is not specified,
> > > > ERESTARTSYS gets translated to EINTR and user space is expected to handle
> > > > the restart itself.
> > > > 
> > > >  ## The 9p TFLISH command    
> > >                ^^^
> > > I'll fix this before pushing to my tree in case there's no v3.
> > >   
> > > > 
> > > > The 9p TFLUSH commands requests that the server abort an ongoing operation.
> > > > The man page [1] specifies:
> > > > 
> > > > ```
> > > > If it recognizes oldtag as the tag of a pending transaction, it should abort any
> > > > pending response and discard that tag.
> > > > [...]
> > > > When the client sends a Tflush, it must wait to receive the corresponding Rflush
> > > > before reusing oldtag for subsequent messages. If a response to the flushed request
> > > > is received before the Rflush, the client must honor the response as if it had not
> > > > been flushed, since the completed request may signify a state change in the server
> > > > ```
> > > > 
> > > > In particular, this means that the server must not send a reply with the orignal
> > > > tag in response to the cancellation request, because the client is obligated
> > > > to interpret such a reply as a coincidental reply to the original request.
> > > > 
> > > >  # The bug
> > > > 
> > > > When qemu receives a TFlush request, it sets the `cancelled` flag on the relevant
> > > > pdu. This flag is periodically checked, e.g. in `v9fs_co_name_to_path`, and if
> > > > set, the operation is aborted and the error is set to EINTR. However, the server
> > > > then violates the spec, by returning to the client an Rerror response, rather
> > > > than discarding the message entirely. As a result, the client is required
> > > > to assume that said Rerror response is a result of the original request, not
> > > > a result of the cancellation and thus passes the EINTR error back to user space.
> > > > This is not the worst thing it could do, however as discussed above, the correct
> > > > error code would have been ERESTARTSYS, such that user space programs with
> > > > SA_RESTART set get correctly restarted upon completion of the signal handler.
> > > > Instead, such programs get spurious EINTR results that they were not expecting
> > > > to handle.
> > > > 
> > > > It should be noted that there are plenty of user space programs that do not
> > > > set SA_RESTART and do not correctly handle EINTR either. However, that is then
> > > > a userspace bug. It should also be noted that this bug has been mitigated by
> > > > a recent commit to the Linux kernel [2], which essentially prevents the kernel
> > > > from sending Tflush requests unless the process is about to die (in which case
> > > > the process likely doesn't care about the response). Nevertheless, for older
> > > > kernels and to comply with the spec, I believe this change is beneficial.
> > > > 
> > > >  # Implementation
> > > > 
> > > > The fix is fairly simple, just skipping notification of a reply if
> > > > the pdu was previously cancelled. We do however, also notify the transport
> > > > layer that we're doing this, so it can clean up any resources it may be
> > > > holding. I also added a new trace event to distinguish
> > > > operations that caused an error reply from those that were cancelled.
> > > > 
> > > > One complication is that we only omit sending the message on EINTR errors in
> > > > order to avoid confusing the rest of the code (which may assume that a
> > > > client knows about a fid if it sucessfully passed it off to pud_complete
> > > > without checking for cancellation status). This does mean that if the server
> > > > acts upon the cancellation flag, it always needs to set err to EINTR. I believe
> > > > this is true of the current code.
> > > > 
> > > > [1] https://9fans.github.io/plan9port/man/man9/flush.html
> > > > [2] https://github.com/torvalds/linux/commit/9523feac272ccad2ad8186ba4fcc89103754de52
> > > > 
> > > > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > > > ---
> > > >     
> > > 
> > > It looks good. I could come up with a new qtest for TFLUSH and validate it
> > > behaves as expected. I'll post that soon.
> > > 
> > > For the 9p and virtio parts.
> > > 
> > > Reviewed-by: Greg Kurz <groug@kaod.org>
> > > 
> > > Now I'd need an ack from Stefano for the xen bits before I push it to my tree.
> > > 
> > > Thanks,
> > > 
> > > --
> > > Greg
> > >   
> > > > Changes from v1:
> > > >  - In reponse to review by Greg Kurz, add a new transport
> > > >    layer operation to discard the buffer. I also attempted
> > > >    an implementation for xen, but I have done no verification
> > > >    on that beyond making sure it compiles, since I don't know
> > > >    how to use xen. Please review closely.
> > > > 
> > > >  hw/9pfs/9p.c               | 18 ++++++++++++++++++
> > > >  hw/9pfs/9p.h               |  1 +
> > > >  hw/9pfs/trace-events       |  1 +
> > > >  hw/9pfs/virtio-9p-device.c | 14 ++++++++++++++
> > > >  hw/9pfs/xen-9p-backend.c   | 11 +++++++++++
> > > >  5 files changed, 45 insertions(+)
> > > > 
> > > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > > index 710cd91..daa8519 100644
> > > > --- a/hw/9pfs/9p.c
> > > > +++ b/hw/9pfs/9p.c
> > > > @@ -648,6 +648,23 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
> > > >      V9fsState *s = pdu->s;
> > > >      int ret;
> > > >  
> > > > +    /*
> > > > +     * The 9p spec requires that successfully cancelled pdus receive no reply.
> > > > +     * Sending a reply would confuse clients because they would
> > > > +     * assume that any EINTR is the actual result of the operation,
> > > > +     * rather than a consequence of the cancellation. However, if
> > > > +     * the operation completed (succesfully or with an error other
> > > > +     * than caused be cancellation), we do send out that reply, both
> > > > +     * for efficiency and to avoid confusing the rest of the state machine
> > > > +     * that assumes passing a non-error here will mean a successful
> > > > +     * transmission of the reply.
> > > > +     */
> > > > +    if (pdu->cancelled && len == -EINTR) {
> > > > +        trace_v9fs_rcancel(pdu->tag, pdu->id);
> > > > +        pdu->s->transport->discard(pdu);
> > > > +        goto out_wakeup;
> > > > +    }
> > > > +
> > > >      if (len < 0) {
> > > >          int err = -len;
> > > >          len = 7;
> > > > @@ -690,6 +707,7 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
> > > >  out_notify:
> > > >      pdu->s->transport->push_and_notify(pdu);
> > > >  
> > > > +out_wakeup:
> > > >      /* Now wakeup anybody waiting in flush for this request */
> > > >      if (!qemu_co_queue_next(&pdu->complete)) {
> > > >          pdu_free(pdu);
> > > > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > > > index d1cfeaf..3c1b0b5 100644
> > > > --- a/hw/9pfs/9p.h
> > > > +++ b/hw/9pfs/9p.h
> > > > @@ -365,6 +365,7 @@ struct V9fsTransport {
> > > >      void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> > > >                                           unsigned int *pniov, size_t size);
> > > >      void        (*push_and_notify)(V9fsPDU *pdu);
> > > > +    void        (*discard)(V9fsPDU *pdu);
> > > >  };
> > > >  
> > > >  static inline int v9fs_register_transport(V9fsState *s,
> > > > diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> > > > index 08a4abf..1aee350 100644
> > > > --- a/hw/9pfs/trace-events
> > > > +++ b/hw/9pfs/trace-events
> > > > @@ -1,6 +1,7 @@
> > > >  # See docs/devel/tracing.txt for syntax documentation.
> > > >  
> > > >  # hw/9pfs/virtio-9p.c
> > > > +v9fs_rcancel(uint16_t tag, uint8_t id) "tag %d id %d"
> > > >  v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id %d err %d"
> > > >  v9fs_version(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
> > > >  v9fs_version_return(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
> > > > diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> > > > index 62650b0..2510329 100644
> > > > --- a/hw/9pfs/virtio-9p-device.c
> > > > +++ b/hw/9pfs/virtio-9p-device.c
> > > > @@ -37,6 +37,19 @@ static void virtio_9p_push_and_notify(V9fsPDU *pdu)
> > > >      virtio_notify(VIRTIO_DEVICE(v), v->vq);
> > > >  }
> > > >  
> > > > +
> > > > +static void virtio_pdu_discard(V9fsPDU *pdu)
> > > > +{
> > > > +    V9fsState *s = pdu->s;
> > > > +    V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
> > > > +    VirtQueueElement *elem = v->elems[pdu->idx];
> > > > +
> > > > +    /* discard element from the queue */
> > > > +    virtqueue_detach_element(v->vq, elem, pdu->size);
> > > > +    g_free(elem);
> > > > +    v->elems[pdu->idx] = NULL;
> > > > +}
> > > > +
> > > >  static void handle_9p_output(VirtIODevice *vdev, VirtQueue *vq)
> > > >  {
> > > >      V9fsVirtioState *v = (V9fsVirtioState *)vdev;
> > > > @@ -221,6 +234,7 @@ static const struct V9fsTransport virtio_9p_transport = {
> > > >      .init_in_iov_from_pdu = virtio_init_in_iov_from_pdu,
> > > >      .init_out_iov_from_pdu = virtio_init_out_iov_from_pdu,
> > > >      .push_and_notify = virtio_9p_push_and_notify,
> > > > +    .discard = virtio_pdu_discard,
> > > >  };
> > > >  
> > > >  /* virtio-9p device */
> > > > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > > > index ee87f08..7208ce6 100644
> > > > --- a/hw/9pfs/xen-9p-backend.c
> > > > +++ b/hw/9pfs/xen-9p-backend.c
> > > > @@ -233,12 +233,23 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
> > > >      qemu_bh_schedule(ring->bh);
> > > >  }
> > > >  
> > > > +static void xen_9pfs_discard(V9fsPDU *pdu)
> > > > +{
> > > > +    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
> > > > +    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
> > > > +
> > > > +    g_free(ring->sg);
> > > > +    ring->sg = NULL;
> > > > +    ring->inprogress = false;  
> 
> I think we also need to:
> 
>     /* this is required to consume the request */
>     ring->intf->out_cons = ring->out_cons;
>     xen_wmb();
> 
>     /* this is required to complete the cancellation of the pdu operation */
>     ring->inprogress = false;
> 
>     /* this is required to let the other end know that there is more
>      * space on the ring available */
>     xenevtchn_notify(ring->evtchndev, ring->local_port);
> 

Actually I'm not sure you should notify the other end. The 9p client in linux
already has a 'cancelled' transport callback for this exact purpose. It is
currently implemented by the rdma and fd transports only, but I have a working
prototype with virtio I expect to send soon. I guess xen should go that way
too.

>     /* trigger the read of the next request */
>     qemu_bh_schedule(ring->bh);
> 
> 
> Which is basically almost everything else from xen_9pfs_push_and_notify,
> except the modification of in_prod, because we are not going to write
> back anything to the ring.
> 
> 
> 
> > > > +}
> > > > +
> > > >  static const struct V9fsTransport xen_9p_transport = {
> > > >      .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
> > > >      .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
> > > >      .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
> > > >      .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
> > > >      .push_and_notify = xen_9pfs_push_and_notify,
> > > > +    .discard = xen_9pfs_discard,
> > > >  };
> > > >  
> > > >  static int xen_9pfs_init(struct XenDevice *xendev)    
> 
