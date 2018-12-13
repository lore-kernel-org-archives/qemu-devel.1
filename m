Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXPzM-0007lP-Eu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXPzE-0003ih-Gi
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:21:09 -0500
Date: Thu, 13 Dec 2018 13:20:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213122039.GC5427@linux.fritz.box>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
	<20181207122647.GE5119@linux.fritz.box>
	<bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
	<20181212122457.GB5415@linux.fritz.box>
	<d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] blk: postpone request execution on a
 context protected with "drained section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: "keith.busch@intel.com" <keith.busch@intel.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>, "famz@redhat.com" <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 13.12.2018 um 12:07 hat Denis Plotnikov geschrieben:
> On 12.12.2018 15:24, Kevin Wolf wrote:
> > Am 11.12.2018 um 17:55 hat Denis Plotnikov geschrieben:
> >>> Why involve the AioContext at all? This could all be kept at the
> >>> BlockBackend level without extending the layering violation that
> >>> aio_disable_external() is.
> >>>
> >>> BlockBackends get notified when their root node is drained, so hooking
> >>> things up there should be as easy, if not even easier than in
> >>> AioContext.
> >>
> >> Just want to make sure that I understood correctly what you meant by
> >> "BlockBackends get notified". Did you mean that bdrv_drain_end calls
> >> child's role callback blk_root_drained_end by calling
> >> bdrv_parent_drained_end?
> > 
> > Yes, blk_root_drained_begin/end calls are all you need. Specifically,
> > their adjustments to blk->quiesce_counter that are already there, and in
> > the 'if (--blk->quiesce_counter == 0)' block of blk_root_drained_end()
> > we can resume the queued requests.
> Sounds it should be so, but it doesn't work that way and that's why:
> when doing mirror we may resume postponed coroutines too early when the 
> underlying bs is protected from writing at and thus we encounter the 
> assert on a write request execution at bdrv_co_write_req_prepare when 
> resuming the postponed coroutines.
> 
> The thing is that the bs is protected for writing before execution of 
> bdrv_replace_node at mirror_exit_common and bdrv_replace_node calls 
> bdrv_replace_child_noperm which, in turn, calls child->role->drained_end 
> where one of the callbacks is blk_root_drained_end which check 
> if(--blk->quiesce_counter == 0) and runs the postponed requests 
> (coroutines) if the coundition is true.

Hm, so something is messed up with the drain sections in the mirror
driver. We have:

    bdrv_drained_begin(target_bs);
    bdrv_replace_node(to_replace, target_bs, &local_err);
    bdrv_drained_end(target_bs);

Obviously, the intention was to keep the BlockBackend drained during
bdrv_replace_node(). So how could blk->quiesce_counter ever get to 0
inside bdrv_replace_node() when target_bs is drained?

Looking at bdrv_replace_child_noperm(), it seems that the function has
a bug: Even if old_bs and new_bs are both drained, the quiesce_counter
for the parent reaches 0 for a moment because we call .drained_end for
the old child first and .drained_begin for the new one later.

So it seems the fix would be to reverse the order and first call
.drained_begin for the new child and then .drained_end for the old
child. Sounds like a good new testcase for tests/test-bdrv-drain.c, too.

> In seems that if the external requests disabled on the context we can't 
> rely on anything or should check where the underlying bs and its 
> underlying nodes are ready to receive requests which sounds quite 
> complicated.
> Please correct me if still don't understand something in that routine.

I think the reason why reyling on aio_disable_external() works is simply
because src is also drained, which keeps external events in the
AioContext disabled despite the bug in draining the target node.

The bug would become apparent even with aio_disable_external() if we
didn't drain src, or even if we just supported src and target being in
different AioContexts.

Kevin
