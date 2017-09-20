Received: from eggs.gnu.org ([2001:4830:134:3::10]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufoC-0005hp-V0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufo6-00063j-Qo
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:17:00 -0400
Date: Wed, 20 Sep 2017 15:16:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170920141643.GB9409@stefanha-x1.localdomain>
References: <20170920101740.12490-1-stefanha@redhat.com>
	<w51fubh1vaz.fsf@maestria.local.igalia.com>
	<20170920113902.ljcsl3y5c6kvo4eq@postretch>
	<w51d16l1s40.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51d16l1s40.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2] throttle-groups: update
 tg->any_timer_armed[] on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Wed, Sep 20, 2017 at 02:17:51PM +0200, Alberto Garcia wrote:
> On Wed 20 Sep 2017 01:39:02 PM CEST, Manos Pitsidianakis wrote:
> >>>  void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
> >>>  {
> >>>      ThrottleTimers *tt = &tgm->throttle_timers;
> >>> +    ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
> >>> +
> >>> +    qemu_mutex_lock(&tg->lock);
> >>> +    if (timer_pending(tt->timers[0])) {
> >>> +        tg->any_timer_armed[0] = false;
> >>> +    }
> >>> +    if (timer_pending(tt->timers[1])) {
> >>> +        tg->any_timer_armed[1] = false;
> >>> +    }
> >>> +    qemu_mutex_unlock(&tg->lock);
> >>> +
> >>>      throttle_timers_detach_aio_context(tt);
> >>>      tgm->aio_context = NULL;
> >>>  }
> >>
> >>I'm sorry that I didn't noticed this in my previous e-mail, but after
> >>this call you might have destroyed the timer that was set for that
> >>throttling group, so if there are pending requests waiting it can
> >>happen that no one wakes them up.
> >>
> >>I think that the queue needs to be restarted after this, probably
> >>after having reattached the context (or actually after detaching it
> >>already, but then what happens if you try to restart the queue while
> >>aio_context is NULL?).
> >
> > aio_co_enter in the restart queue function requires that aio_context
> > is non-NULL. Perhaps calling throttle_group_restart_tgm in
> > throttle_group_attach_aio_context will suffice.
> 
> But can we guarantee that everything is safe between the _detach() and
> _attach() calls?

Here is a second patch that I didn't send because I was unsure whether it's
needed.

The idea is to move the throttle_group_detach/attach_aio_context() into
bdrv_set_aio_context() so it becomes part of the bdrv_drained_begin/end()
region.

The guarantees we have inside the drained region:

1. Throttling has been temporarily disabled.
2. throttle_group_restart_tgm() has been called to kick throttled reqs.
3. All requests are completed.

This is a nice, controlled environment to do the detach/attach.  That said,
Berto's point still stands: what about other ThrottleGroupMembers who have
throttled requests queued?

The main reason I didn't publish this patch is because Manos' "block: remove
legacy I/O throttling" series ought to remove this code anyway soon.

diff --git a/block/block-backend.c b/block/block-backend.c
index 45d9101be3..624eb3dc15 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1747,10 +1747,6 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
 
     if (bs) {
-        if (tgm->throttle_state) {
-            throttle_group_detach_aio_context(tgm);
-            throttle_group_attach_aio_context(tgm, new_context);
-        }
         bdrv_set_aio_context(bs, new_context);
     }
 }
@@ -2029,6 +2025,13 @@ static void blk_root_drained_end(BdrvChild *child)
     BlockBackend *blk = child->opaque;
     assert(blk->quiesce_counter);
 
+    if (tgm->throttle_state) {
+        AioContext *new_context = bdrv_aio_context(blk_bs(blk));
+
+        throttle_group_detach_aio_context(tgm);
+        throttle_group_attach_aio_context(tgm, new_context);
+    }
+
     assert(blk->public.throttle_group_member.io_limits_disabled);
     atomic_dec(&blk->public.throttle_group_member.io_limits_disabled);
