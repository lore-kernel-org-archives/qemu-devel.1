Received: from eggs.gnu.org ([2001:4830:134:3::10]:53017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2Su-0003GH-5B
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2St-0007b9-4G
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:16 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:49 +0200
Message-Id: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 00/17] mirror: Mainly coroutine refinements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

This series is based on v2 of my "block: Deal with filters" series:

Based-on: <20180809223117.7846-1-mreitz@redhat.com>


The bulk of this series (14 of the patches here, in fact) makes more of
the coroutined mirror I started with my active mirror series.  For this,
mirror_perform() is translated into a coroutine version that actually
looks like coroutines are a nice thing to have (a single AioContext
lock, a common clean-up path, and a mirror_co_copy() that does both read
and write in a single function (like it is supposed to)).

Another thing I have wanted to implement is a read-write-blocking mode.
write-blocking (active mirror) copies data to the target whenever you
write data to the mirror node -- so once the mirror bitmap is clean, it
will stay clean, and completing the job is guaranteed to be basically
instantenous.  read-write-blocking would also copy data whenever you
read from the mirror node, because we have already read the data right
now, so we might as well copy it to the target now.

Instead of implementing it actually as a new copy-mode (which is how I
used to do, but I decided that was boring), I opted for implementing an
interesting .bdrv_co_block_status() function that allows using COR for
the purpose: You simply put a COR node on top of your write-blocking
mirror node, and then all the data read will be copied to the target
through COR (as long as it is not already cleanly mirrored).

The benefit I see with this approach is that is just looks nice.  Why
implement an actual new copy-mode when we can just an existing block
layer function for the purpose?

The drawbacks I see are these:
(1) mirror in write-blocking mode has to interpret
    BDRV_REQ_WRITE_UNCHANGED in a special manner, or this doesn't really
    work.  With patch 16 of this series, such requests are not written
    to the source, but only to the target.  You might find that weird.

(2) We currently don't have a good way of inserting a COR node at
    runtime...

(3) You may break your data if you do funny stuff.  Now this is of
    course the interesting point.
    Mirror works (by design) even when you attach a parent to the source
    directly, i.e., not going through the mirror node.  That is because
    mirror uses the source's dirty bitmap functionality and does not
    build its own.  But if you do this with COR/write-blocking, then the
    COR driver may issue a request while some other parent is issuing
    another request immediately to the source, which may cause source
    and target to go out of sync.
    But...  Technically this is already an issue with write-blocking
    alone.  We reset the bitmap only in do_sync_target_write(), after we
    have already written to the source.  So if another of source's
    parents writes to source between our write and the bitmap reset, we
    lose that information.
    So I suppose when using write-blocking, the mirror driver may not
    share the WRITE permission?

(4) The same issue exists with COR itself, actually...  It can only
    share the WRITE permission because COR requests are serializing, but
    that only works on a single layer.  With a filter between COR and
    the allocating node, you get the same issue of someone being able to
    slip in a request between the COR read and the COR allocation.
    Maybe we actually want COR not to share WRITE either?

So in my opinion the main drawback is that this design reveals current
weaknesses and bugs of the block layer.


Max Reitz (17):
  iotests: Try reading while mirroring in 156
  mirror: Make wait_for_any_operation() coroutine_fn
  mirror: Pull *_align_for_copy() from *_co_read()
  mirror: Remove bytes_handled, part 1
  mirror: Remove bytes_handled, part 2
  mirror: Create mirror_co_perform()
  mirror: Make mirror_co_zero() nicer
  mirror: Make mirror_co_discard() nicer
  mirror: Lock AioContext in mirror_co_perform()
  mirror: Create mirror_co_alloc_qiov()
  mirror: Inline mirror_write_complete(), part 1
  mirror: Put QIOV locally into mirror_co_read
  mirror: Linearize mirror_co_read()
  mirror: Inline mirror_iteration_done()
  mirror: Release AioCtx before queue_restart_all()
  mirror: Support COR with write-blocking
  iotests: Add test for active mirror with COR

 block/mirror.c             | 483 ++++++++++++++++++++-----------------
 tests/qemu-iotests/151     |  56 +++++
 tests/qemu-iotests/151.out |   4 +-
 tests/qemu-iotests/156     |   7 +
 tests/qemu-iotests/156.out |   3 +
 5 files changed, 334 insertions(+), 219 deletions(-)

-- 
2.17.1
