Received: from eggs.gnu.org ([2001:4830:134:3::10]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBwKK-0007WO-Qa
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 00:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eBwKH-0002OG-RZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 00:21:31 -0500
Date: Tue, 7 Nov 2017 13:21:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107052111.GB16355@lemon>
References: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a184b91-49ef-bb52-d190-053c4c0861a1@redhat.com>
Subject: Re: [Qemu-devel] Drainage in bdrv_replace_child_noperm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Qemu-devel <qemu-devel@nongnu.org>

On Mon, 11/06 19:49, Max Reitz wrote:
> Hi everyone,
> 
> On my quest to fix some flaky iotests, I came to a bit of a halt on 129.
>  (Details: Its issue is that block jobs now generally ignore throttling
> in a BB (because they use their own), so we have to add a throttle node
> instead.  However, when I added it, I got an abort.)
> 
> My issue can be reproduced as follows:
> 
> $ x86_64-softmmu/qemu-system-x86_64 \
>     -qmp stdio \
>     -object throttle-group,id=tg0 \
>     -blockdev "{'driver':'throttle','node-name':'drive0',
>                 'throttle-group':'tg0','file':{'driver':'null-co'}}" \
>     -blockdev node-name=target,driver=null-co
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 10, "major": 2},
> "package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'blockdev-mirror','arguments':{
>     'device':'drive0','job-id':'job0','target':'target','sync':'full',
>     'filter-node-name':'mirror-node' }}
> qemu-system-x86_64: block/throttle.c:213: throttle_co_drain_end:
> Assertion `tgm->io_limits_disabled' failed.
> [1]    3524 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
> stdio -object throttle-group,id=tg0
> 
> Here's what happens:
> 
> (1) bdrv_drained_begin(bs) in mirror_start_job() starts draining drive0.
> 
> (2) bdrv_append(...) puts mirror-node above drive0.  Through
> bdrv_replace_child_noperm(), this will invoke
> bdrv_child_cb_drained_begin() on mirror-node.  This is necessary because
> drive0 is drained, so the new parent needs to be drained as well.
> However, note that drive0 is not yet attached to mirror-node.
> Therefore, mirror-node cannot drain drive0 recursively.
> 
> This is seemingly fine because drive0 is drained anyway.  However, this
> is different from what would happen if we would have drained drive0 with
> mirror-node already attached to it as its parent: Then, we would have
> drained drive0 twice; once by itself, and another time recursively
> through mirror-node.
> 
> This will be important in a second...
> 
> (3) ...and this second is now: We invoke bdrv_drained_end() on drive0.
> Now, through bdrv_parent_drained_end() and bdrv_child_cb_drained_end()
> that goes up to mirror-node which recursively un-drains drive0.  Fine so
> far.  But once that parent un-drain is done, we un-drain drive0 by
> itself: And this fails the assertion in the throttle driver because we
> attempt to un-drain it twice, although we've drained it only once.

So it is not a problem specific to throttle, but it's a problem that
drain/undrain pairs in bdrv_drained_begin and bdrv_drained_end are uneven.
Throttle filter just happens to assert it's even, so we get an abort.

> 
> 
> So the issue has two parts:
> 
> (A) (Un-)Draining a parent from a child will always (?[1]) (un-)drain
> that child, too.  This seems a bit superfluous to me and I would guess
> that it results in worst-case O(n^2) function calls to drain a block
> graph consisting of n nodes.
> 
> (B) In bdrv_replace_child_noperm() we try to drain the parent if the new
> child is drained; specifically, we want it to be in a state as if it had
> been a parent when the child was originally drained.  However, we fail
> at this because we drain the parent without the child attached, so we
> don't drain the child twice.  This bites us when we undrain everything.
> 
> (Most importantly, ideally we'd want to attach the new child to the
> parent and then drain the parent: This would give us exactly the state
> we want.  However, attaching the child first and then draining the
> parent is unsafe, so we cannot do it...)
> 
> [1] Whether the parent (un-)drains the child depends on the
> BdrvChildRole.drained_{begin,end}() implementation, strictly speaking.
> We cannot say it generally.
> 
> OK, so how to fix it?  I don't know, so I'm asking you. :-)
> 
> I have two ideas:
> 
> One is to assume that (un-)draining a parent will always (un-)drain all
> children, including the one the (un-)drain comes from.  This assumption
> seems wrong, see [1], but maybe it isn't.  Anyway, if so, we could just
> explicitly drain the new child in bdrv_replace_child_noperm() after
> having drained the parent and thus get a consistent state again.
> 
> The other is to declare (A) wrong.  Maybe when
> BdrvChildRole.drained_{begin,end}() is invoked, we should not drain that
> child because we can declare it the caller's responsibility to make sure
> it's drained.  This seems logical to me because usually those methods
> are invoked when the child is drained anyway.  But maybe I'm wrong. :-)

I'm in favor of asking the caller to make sure all nodes involved in the graph
manupulation are drained, it feels comparably easier to do, than fixing the
problem in bdrv_append().

Fam
