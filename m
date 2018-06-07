Received: from eggs.gnu.org ([2001:4830:134:3::10]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQoTe-0007Xa-Ds
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQoTb-0000hf-69
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:32:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQoTa-0000gO-U0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:32:51 -0400
Date: Thu, 7 Jun 2018 14:32:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607063241.GA750@xz-mi>
References: <20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi>
	<5B168EAB.7090607@intel.com> <20180606054227.GA7815@xz-mi>
	<5B17B1A7.8060307@intel.com> <20180606110217.GF7815@xz-mi>
	<5B18C18D.3070007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B18C18D.3070007@intel.com>
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

On Thu, Jun 07, 2018 at 01:24:29PM +0800, Wei Wang wrote:
> On 06/06/2018 07:02 PM, Peter Xu wrote:
> > On Wed, Jun 06, 2018 at 06:04:23PM +0800, Wei Wang wrote:
> > > On 06/06/2018 01:42 PM, Peter Xu wrote:
> > > > IMHO migration states do not suite here.  IMHO bitmap syncing is too
> > > > frequently an operation, especially at the end of a precopy migration.
> > > > If you really want to introduce some notifiers, I would prefer
> > > > something new rather than fiddling around with migration state.  E.g.,
> > > > maybe a new migration event notifiers, then introduce two new events
> > > > for both start/end of bitmap syncing.
> > > Please see if below aligns to what you meant:
> > > 
> > > MigrationState {
> > > ...
> > > + int ram_save_state;
> > > 
> > > }
> > > 
> > > typedef enum RamSaveState {
> > >      RAM_SAVE_BEGIN = 0,
> > >      RAM_SAVE_END = 1,
> > >      RAM_SAVE_MAX = 2
> > > }
> > > 
> > > then at the step 1) and 3) you concluded somewhere below, we change the
> > > state and invoke the callback.
> > I mean something like this:
> > 
> > 1693c64c27 ("postcopy: Add notifier chain", 2018-03-20)
> > 
> > That was a postcopy-only notifier.  Maybe we can generalize it into a
> > more common notifier for the migration framework so that we can even
> > register with non-postcopy events like bitmap syncing?
> 
> Precopy already has its own notifiers: git 99a0db9b
> If we want to reuse, that one would be more suitable. I think mixing
> non-related events into one notifier list isn't nice.

I think that's only for migration state changes?

> 
> > > 
> > > Btw, the migration_state_notifiers is already there, but seems not really
> > > used (I only tracked spice-core.c called
> > > add_migration_state_change_notifier). I thought adding new migration states
> > > can reuse all that we have.
> > > What's your real concern about that? (not sure how defining new events would
> > > make a difference)
> > Migration state is exposed via control path (QMP).  Adding new states
> > mean that the QMP clients will see more.  IMO that's not really
> > anything that a QMP client will need to know, instead we can keep it
> > internally.  That's a reason from compatibility pov.
> > 
> > Meanwhile, it's not really a state-thing at all for me.  It looks
> > really more like hook or event (start/stop of sync).
> 
> Thanks for sharing your concerns in detail, which are quite helpful for the
> discussion. To reuse 99a0db9b, we can also add sub-states (or say events),
> instead of new migration states.
> For example, we can still define "enum RamSaveState" as above, which can be
> an indication for the notifier queued on the 99a0db9b notider_list to decide
> whether to call start or stop.
> Does this solve your concern?

Frankly speaking I don't fully understand how you would add that
sub-state.  If you are confident with the idea, maybe you can post
your new version with the change, then I can read the code.

> 
> 
> > 
> > > > > I would suggest to focus on the supplied interface and its usage in live
> > > > > migration. That is, now we have two APIs, start() and stop(), to start and
> > > > > stop the optimization.
> > > > > 
> > > > > 1) where in the migration code should we use them (do you agree with the
> > > > > step (1), (2), (3) you concluded below?)
> > > > > 2) how should we use them, directly do global call or via notifiers?
> > > > I don't know how Dave and Juan might think; here I tend to agree with
> > > > Michael that some notifier framework should be nicer.
> > > > 
> > > What would be the advantages of using notifiers here?
> > Isolation of modules?  Then migration/ram.c at least won't need to
> > include something like "balloon.h".
> > 
> > And I think it's also possible too if some other modules would like to
> > hook at these places someday.
> 
> OK, I can implement it with notifiers, but this (framework) is usually added
> when someday there is a second user who needs a callback at the same place.
> 
> 
> 
> > > 
> > > 
> > > > This is not that obvious to me.  For now I think it's true, since when
> > > > we call stop() we'll take the mutex, meanwhile the mutex is actually
> > > > always held by the iothread (in the big loop in
> > > > virtio_balloon_poll_free_page_hints) until either:
> > > > 
> > > > - it sleeps in qemu_cond_wait() [1], or
> > > > - it leaves the big loop [2]
> > > > 
> > > > Since I don't see anyone who will set dev->block_iothread to true for
> > > > the balloon device, then [1] cannot happen;
> > > there is a case in virtio_balloon_set_status which sets dev->block_iothread
> > > to true.
> > > 
> > > Did you mean the free_page_lock mutex? it is released at the bottom of the
> > > while() loop in virtio_balloon_poll_free_page_hint. It's actually released
> > > for every hint. That is,
> > > 
> > > while(1){
> > >      take the lock;
> > >      process 1 hint from the vq;
> > >      release the lock;
> > > }
> > Ah, so now I understand why you need the lock to be inside the loop,
> > since the loop is busy polling actually.  Is it possible to do this in
> > an async way?
> 
> We need to use polling here because of some back story in the guest side
> (due to some locks being held) that makes it a barrier to sending
> notifications for each hints.

Any link to the "back story" that I can learn about? :) If it's too
complicated a problem and you think I don't need to understand at all,
please feel free to do so.  Then I would assume at least Michael has
fully acknowledged that idea, and I can just stop putting more time on
this part.

Besides, if you are going to use a busy loop, then I would be not
quite sure about whether you really want to share that iothread with
others, since AFAIU that's not how iothread is designed (which is
mostly event-based and should not welcome out-of-control blocking in
the handler of events).  Though I am not 100% confident about my
understaning on that, I only raise this question up.  Anyway you'll
just take over the thread for a while without sharing, and after the
burst IOs it's mostly never used (until the next bitmap sync).  Then
it seems a bit confusing to me on why you need to share that after
all.

> 
> > I'm a bit curious on how much time will it use to do
> > one round of the free page hints (e.g., an idle guest with 8G mem, or
> > any configuration you tested)?  I suppose during that time the
> > iothread will be held steady with 100% cpu usage, am I right?
> 
> Compared to the time spent by the legacy migration to send free pages, that
> small amount of CPU usage spent on filtering free pages could be neglected.
> Grinding a chopper will not hold up the work of cutting firewood :)

Sorry I didn't express myself clearly.

My question was that, have you measured how long time it will take
from starting of the free page hints (when balloon state is set to
FREE_PAGE_REPORT_S_REQUESTED), until it completes (when QEMU receives
the VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID, then set the status to
FREE_PAGE_REPORT_S_STOP)?

-- 
Peter Xu
