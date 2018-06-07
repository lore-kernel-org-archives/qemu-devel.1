Received: from eggs.gnu.org ([2001:4830:134:3::10]:55858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQlQp-0004jd-W0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQlQl-0004Bn-0V
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:17:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQlQk-00048o-QO
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:17:42 -0400
Date: Thu, 7 Jun 2018 11:17:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607031732.GG7815@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180606064315.GB7815@xz-mi> <5B17B366.5030802@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B17B366.5030802@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Wed, Jun 06, 2018 at 06:11:50PM +0800, Wei Wang wrote:
> On 06/06/2018 02:43 PM, Peter Xu wrote:
> > On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
> > 
> > [...]
> > 
> > +        if (elem->out_num) {
> > +            size = iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(id));
> > +            virtqueue_push(vq, elem, size);
> > Silly question: is this sending the same id back to guest?  Why?
> 
> No. It's just giving back the used buffer.

Oops, sorry!

> 
> > 
> > > +            g_free(elem);
> > > +
> > > +            virtio_tswap32s(vdev, &id);
> > > +            if (unlikely(size != sizeof(id))) {
> > > +                virtio_error(vdev, "received an incorrect cmd id");
> > Forgot to unlock?
> > 
> > Maybe we can just move the lock operations outside:
> > 
> >    mutex_lock();
> >    while (1) {
> >      ...
> >      if (block) {
> >        qemu_cond_wait();
> >      }
> >      ...
> >      if (skip) {
> >        continue;
> >      }
> >      ...
> >      if (error) {
> >        break;
> >      }
> >      ...
> >    }
> >    mutex_unlock();
> 
> 
> I got similar comments from Michael, and it will be
> while (1) {
> lock;
> func();
> unlock();
> }
> 
> All the unlock inside the body will be gone.

Ok I think I have more question on this part...

Actually AFAICT this new feature uses iothread in a way very similar
to the block layer, so I digged a bit on how block layer used the
iothreads.  I see that the block code is using something like
virtio_queue_aio_set_host_notifier_handler() to hook up the
iothread/aiocontext and the ioeventfd, however here you are manually
creating one QEMUBH and bound that to the new context.  Should you
also use something like the block layer?  Then IMHO you can avoid
using a busy loop there (assuming the performance does not really
matter that much here for page hintings), and all the packet handling
can again be based on interrupts from the guest (ioeventfd).

[1]

> 
> > [...]
> > > +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
> > > +    .name = "virtio-balloon-device/free-page-report",
> > > +    .version_id = 1,
> > > +    .minimum_version_id = 1,
> > > +    .needed = virtio_balloon_free_page_support,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> > > +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
> > (could we move all the poison-related lines into another patch or
> >   postpone?  after all we don't support it yet, do we?)
> > 
> 
>  We don't support migrating poison value, but guest maybe use it, so we are
> actually disabling this feature in that case. Probably good to leave the
> code together to handle that case.

Could we just avoid declaring that feature bit in emulation code
completely?  I mean, we support VIRTIO_BALLOON_F_FREE_PAGE_HINT first
as the first step (as you mentioned in commit message, the POISON is a
TODO).  Then when you really want to completely support the POISON
bit, you can put all that into a separate patch.  Would that work?

> 
> 
> > > +    if (virtio_has_feature(s->host_features,
> > > +                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > > +        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
> > > +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
> > > +        s->free_page_report_cmd_id =
> > > +                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;
> > Why explicitly -1?  I thought ID_MIN would be fine too?
> 
> Yes, that will also be fine. Since we states that the cmd id will be from
> [MIN, MAX], and we make s->free_page_report_cmd_id++ in start(), using
> VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN here will make it [MIN + 1, MAX].

Then I would prefer we just use the MIN value, otherwise IMO we'd
better have a comment mentioning about why that -1 is there.

> 
> > 
> > > +        if (s->iothread) {
> > > +            object_ref(OBJECT(s->iothread));
> > > +            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
> > > +                                       virtio_balloon_poll_free_page_hints, s);
> > Just to mention that now we can create internal iothreads.  Please
> > have a look at iothread_create().
> 
> Thanks. I noticed that, but I think configuring via the cmd line can let
> people share the iothread with other devices that need it.

Ok.  Please have a look at my previous comment at [1].  I'm not sure
whether my understanding is correct.  But in case if so, not sure
whether we can avoid this QEMUBH here.

Thanks,

-- 
Peter Xu
