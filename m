Received: from eggs.gnu.org ([2001:4830:134:3::10]:55711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQRDW-0001XF-Ib
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 01:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQRDT-0004j8-CQ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 01:42:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQRDT-0004ic-65
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 01:42:39 -0400
Date: Wed, 6 Jun 2018 13:42:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180606054227.GA7815@xz-mi>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi>
	<5B168EAB.7090607@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B168EAB.7090607@intel.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com

On Tue, Jun 05, 2018 at 09:22:51PM +0800, Wei Wang wrote:
> On 06/05/2018 02:58 PM, Peter Xu wrote:
> > On Mon, Jun 04, 2018 at 04:04:51PM +0800, Wei Wang wrote:
> > > On 05/30/2018 08:47 PM, Michael S. Tsirkin wrote:
> > > > On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
> > > > > On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
> > > > > > On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
> > > > > > > +/*
> > > > > > > + * Balloon will report pages which were free at the time of this call. As the
> > > > > > > + * reporting happens asynchronously, dirty bit logging must be enabled before
> > > > > > > + * this call is made.
> > > > > > > + */
> > > > > > > +void balloon_free_page_start(void)
> > > > > > > +{
> > > > > > > +    balloon_free_page_start_fn(balloon_opaque);
> > > > > > > +}
> > > > > > Please create notifier support, not a single global.
> > > > > OK. The start is called at the end of bitmap_sync, and the stop is called at
> > > > > the beginning of bitmap_sync. In this case, we will need to add two
> > > > > migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
> > > > > MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?
> > > Peter, do you have any thought about this?
> > > 
> > > Currently, the usage of free page optimization isn't limited to the first
> > > stage. It is used in each stage. A global call to start the free page
> > > optimization is made after bitmap sync, and another global call to stop the
> > > optimization is made before bitmap sync. It is simple to just use global
> > > calls.
> > > 
> > > If we change the implementation to use notifiers, I think we will need to
> > > add two new MigrationStatus as above. Would you think that is worthwhile for
> > > some reason?
> > I'm a bit confused.  Could you elaborate why we need those extra
> > states?
> 
> Sure. Notifiers are used when an event happens. In this case, it would be a
> state change, which invokes the state change callback. So I think we
> probably need to add 2 new states for the start and stop callback.

IMHO migration states do not suite here.  IMHO bitmap syncing is too
frequently an operation, especially at the end of a precopy migration.
If you really want to introduce some notifiers, I would prefer
something new rather than fiddling around with migration state.  E.g.,
maybe a new migration event notifiers, then introduce two new events
for both start/end of bitmap syncing.

> 
> 
> > Or, to ask a more general question - could you elaborate a bit on how
> > you order these operations?  I would be really glad if you can point
> > me to some documents for the feature.  Is there any latest virtio
> > document that I can refer to (or old cover letter links)?  It'll be
> > good if the document could mention about things like:
> 
> I haven't made documents to explain it yet. It's planed to be ready after
> this code series is done. But I'm glad to answer the questions below.

Ok, thanks.  If we are very sure we'll have a document, IMHO it'll be
very nice at least for reviewers to have the document as long as
prototyping is finished... But it's okay.

> 
> 
> > 
> > - why we need this feature? Is that purely for migration purpose?  Or
> >    it can be used somewhere else too?
> 
> Yes. Migration is the one that currently benefits a lot from this feature. I
> haven't thought of others so far. It is common that new features start with
> just 1 or 2 typical use cases.

Yes, it was a pure question actually; this is okay to me.

> 
> 
> > - high level stuff about how this is implemented, e.g.:
> >    - the protocol of the new virtio queues
> >    - how we should get the free page hints (please see below)
> 
> The high-level introduction would be
> 1. host sends a start cmd id to the guest;
> 2. the guest starts a new round of reporting by sending a cmd_id+free page
> hints to host;
> 3. QEMU side optimization code applies the free page hints (filter them from
> the dirty bitmap) only when the reported cmd id matches the one that was
> just sent.
> 
> The protocol was suggested by Michael and has been thoroughly discussed when
> upstreaming the kernel part. It might not be necessary to go over that again
> :)

I don't mean we should go back to review the content again; I mean we
still need to have such a knowledge on some of the details. Since
there is no document to properly define the interface between
migration code and the balloon API yet, IMHO it's still useful even
for a reviewer from migration pov to fully understand what's that
behind, especially this is quite low-level stuff to play around with
guest pages, and it contains some tricky points and potential
cross-over with e.g. dirty page trackings.

> I would suggest to focus on the supplied interface and its usage in live
> migration. That is, now we have two APIs, start() and stop(), to start and
> stop the optimization.
> 
> 1) where in the migration code should we use them (do you agree with the
> step (1), (2), (3) you concluded below?)
> 2) how should we use them, directly do global call or via notifiers?

I don't know how Dave and Juan might think; here I tend to agree with
Michael that some notifier framework should be nicer.

> 
> > 
> > For now, what I see is that we do:
> > 
> > (1) stop hinting
> > (2) sync bitmap
> > (3) start hinting
> > 
> > Why this order?
> 
> We start to filter out free pages from the dirty bitmap only when all the
> dirty bits are ready there, i.e. after sync bitmap. To some degree, the
> action of synchronizing bitmap indicates the end of the last round and the
> beginning of the new round, so we stop the free page optimization for the
> old round when the old round ends.

Yeh this looks sane to me.

> 
> 
> >   My understanding is that obviously there is a race
> > between the page hinting thread and the dirty bitmap tracking part
> > (which is done in KVM).  How do we make sure there is no race?
> 
> Could you please explain more about the race you saw? (free page is reported
> from the guest, and the bitmap is tracked in KVM)

It's the one I mentioned below...

> 
> 
> 
> > 
> > An direct question is that, do we need to make sure step (1) must be
> > before step (2)?  Asked since I see that currently step (1) is an
> > async operation (taking a lock, set status, then return).  Then would
> > such an async operation satisfy any ordering requirement after all?
> 
> Yes. Step(1) guarantees us that the QEMU side optimization call has exited
> (we don't need to rely on guest side ACK because the guest could be in any
> state).

This is not that obvious to me.  For now I think it's true, since when
we call stop() we'll take the mutex, meanwhile the mutex is actually
always held by the iothread (in the big loop in
virtio_balloon_poll_free_page_hints) until either:

- it sleeps in qemu_cond_wait() [1], or
- it leaves the big loop [2]

Since I don't see anyone who will set dev->block_iothread to true for
the balloon device, then [1] cannot happen; then I think when stop()
has taken the mutex then the thread must have quitted the big loop,
which goes to path [2].  I am not sure my understanding is correct,
but in all cases "Step(1) guarantees us that the QEMU side
optimization call has exited" is not obvious to me.  Would you add
some comment to the code (or even improve the code itself somehow) to
help people understand that?

For example, I saw that the old github code has a pthread_join() (in
that old code it was not using iothread at all).  That's a very good
code example so that people can understand that it's a synchronous
operations.

> This is enough. If the guest continues to report after that, that
> reported hints will be detected as stale hints and dropped in the next start
> of optimization.

This is not clear to me too.  Say, stop() only sets the balloon status
to STOP, AFAIU it does not really modify the cmd_id field immediately,
then how will the new coming hints be known as stale hints?

> 
> 
> > 
> > Btw, I would appreciate if you can push your new trees (both QEMU and
> > kernel) to the links you mentioned in the cover letter - I noticed
> > that they are not the same as what you have posted on the list.
> > 
> 
> Sure.
> For kernel part, you can get it from linux-next:
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> For the v7 QEMU part: git://github.com/wei-w-wang/qemu-free-page-hint.git
> (my connection to github is too slow, it would be ready in 24hours, I can
> also send you the raw patches via email if you need)

No need to post patches; I can read the ones on the list for sure.
It's just a reminder in case you forgot to push the tree when sending
new versions.  Thanks,

-- 
Peter Xu
