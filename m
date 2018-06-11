Received: from eggs.gnu.org ([2001:4830:134:3::10]:50470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSLr4-0007GF-Iv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fSLr3-0003Oj-ES
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:23:26 -0400
Date: Mon, 11 Jun 2018 14:23:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180611122314.GF15038@localhost.localdomain>
References: <20180529172156.29311-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529172156.29311-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/20] Drain fixes and cleanups, part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

ping?

Am 29.05.2018 um 19:21 hat Kevin Wolf geschrieben:
> This is the third and hopefully for now last part of my work to fix
> drain. The main goal of this series is to make drain robust against
> graph changes that happen in any callbacks of in-flight requests while
> we drain a block node.
> 
> The individual patches describe the details, but the rough plan is to
> change all three drain types (single node, subtree and all) to work like
> this:
> 
> 1. First call all the necessary callbacks to quiesce external sources
>    for new requests. This includes the block driver callbacks, the child
>    node callbacks and disabling external AioContext events. This is done
>    recursively.
> 
>    Much of the trouble we had with drain resulted from the fact that the
>    graph changed while we were traversing the graph recursively. None of
>    the callbacks called in this phase may change the graph.
> 
> 2. Then do a single AIO_WAIT_WHILE() to drain the requests of all
>    affected nodes. The aio_poll() called by it is where graph changes
>    can happen and we need to be careful.
> 
>    However, while evaluating the loop condition, the graph can't change,
>    so we can safely call all necessary callbacks, if needed recursively,
>    to determine whether there are still pending requests in any affected
>    nodes. We just need to make sure that we don't rely on the set of
>    nodes being the same between any two evaluation of the condition.
> 
> There are a few more smaller, mostly self-contained changes needed
> before we're actually safe, but this is the main mechanism that will
> help you understand what we're working towards during the series.
> 
> v2:
> 
> - Rebased on top of current master (e.g. including Job infrastructure)
> 
> - Avoid unnecessary parent callbacks for .drained_begin/poll/end:
>   * subtree drains: Don't propagate the drain to the parent that we came
>                     from recursively
>   * drain_all:      Don't propagate the drain to BDS parents (which are
>                     already separately drained), but only to non-BDS
>                     parents like BBs or Jobs
> 
> - Separate bdrv_drain_poll_top_level() function instead of having a
>   top_level parameter for bdrv_drain_poll().
> 
> - A few commit message and comment improvements
> 
> 
> Kevin Wolf (19):
>   test-bdrv-drain: bdrv_drain() works with cross-AioContext events
>   block: Use bdrv_do_drain_begin/end in bdrv_drain_all()
>   block: Remove 'recursive' parameter from bdrv_drain_invoke()
>   block: Don't manually poll in bdrv_drain_all()
>   tests/test-bdrv-drain: bdrv_drain_all() works in coroutines now
>   block: Avoid unnecessary aio_poll() in AIO_WAIT_WHILE()
>   block: Really pause block jobs on drain
>   block: Remove bdrv_drain_recurse()
>   block: Drain recursively with a single BDRV_POLL_WHILE()
>   test-bdrv-drain: Test node deletion in subtree recursion
>   block: Don't poll in parent drain callbacks
>   test-bdrv-drain: Graph change through parent callback
>   block: Defer .bdrv_drain_begin callback to polling phase
>   test-bdrv-drain: Test that bdrv_drain_invoke() doesn't poll
>   block: Allow AIO_WAIT_WHILE with NULL ctx
>   block: Move bdrv_drain_all_begin() out of coroutine context
>   block: ignore_bds_parents parameter for drain functions
>   block: Allow graph changes in bdrv_drain_all_begin/end sections
>   test-bdrv-drain: Test graph changes in drain_all section
> 
> Max Reitz (1):
>   test-bdrv-drain: Add test for node deletion
> 
>  include/block/aio-wait.h     |  25 +-
>  include/block/block.h        |  31 +-
>  include/block/block_int.h    |  14 +
>  include/block/blockjob_int.h |   8 +
>  block.c                      |  52 +++-
>  block/io.c                   | 332 ++++++++++++--------
>  block/mirror.c               |   8 +
>  block/vvfat.c                |   1 +
>  blockjob.c                   |  23 ++
>  tests/test-bdrv-drain.c      | 705 +++++++++++++++++++++++++++++++++++++++++--
>  10 files changed, 1032 insertions(+), 167 deletions(-)
> 
> -- 
> 2.13.6
> 
