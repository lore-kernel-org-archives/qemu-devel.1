Received: from eggs.gnu.org ([2001:4830:134:3::10]:59526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRc1M-0004zS-A3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRc1L-00050W-Ci
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:54:44 -0500
References: <20171220103412.13048-1-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6e0eb49-de02-f109-8cd9-3d3768281eb7@redhat.com>
Date: Wed, 20 Dec 2017 11:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/19] Drain fixes and cleanups, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 20/12/2017 11:33, Kevin Wolf wrote:
> This is the second part of my work to fix drain and hopefully to prevent
> it from attracting bugs as much as it did in the past. There is
> definitely at least a third part coming after this, see below.
> 
> In this series, the following improvments are made:
> * Fix several bugs and inconsistencies
> * Create lots of unit tests for the drain functions
> * Introduce bdrv_subtree_drained_begin/end() to drain a whole subtree
>   rather than only a single node
> * Use this to make bdrv_reopen() safe (graph changes in callbacks
>   called during its internal bdrv_drain_all() frequently broke it)
> 
> Planned for part three: Make graph modifications in callbacks safe by
> avoiding BDRV_POLL_WHILE() calls while we're recursing through the
> graph. We can recurse before BDRV_POLL_WHILE(), after it or while
> evaluating its condition, but never call any callbacks while we're
> iterating child or parent lists.

This is very nice, thanks for it!  I only had two comments, one of them
pretty minor.

Paolo

> Fam Zheng (1):
>   block: Remove unused bdrv_requests_pending
> 
> Kevin Wolf (18):
>   block: Assert drain_all is only called from main AioContext
>   block: Make bdrv_drain() driver callbacks non-recursive
>   test-bdrv-drain: Test callback for bdrv_drain
>   test-bdrv-drain: Test bs->quiesce_counter
>   blockjob: Pause job on draining any job BDS
>   test-bdrv-drain: Test drain vs. block jobs
>   block: Don't block_job_pause_all() in bdrv_drain_all()
>   block: Nested drain_end must still call callbacks
>   test-bdrv-drain: Test nested drain sections
>   block: Don't notify parents in drain call chain
>   block: Add bdrv_subtree_drained_begin/end()
>   test-bdrv-drain: Tests for bdrv_subtree_drain
>   test-bdrv-drain: Test behaviour in coroutine context
>   test-bdrv-drain: Recursive draining with multiple parents
>   block: Allow graph changes in subtree drained section
>   test-bdrv-drain: Test graph changes in drained section
>   commit: Simplify reopen of base
>   block: Keep nodes drained between reopen_queue/multiple
> 
>  include/block/block.h     |  20 +-
>  include/block/block_int.h |   3 +-
>  block.c                   |  74 +++++--
>  block/commit.c            |   8 +-
>  block/io.c                | 128 ++++++++----
>  block/replication.c       |   6 +
>  blockjob.c                |  22 +-
>  qemu-io-cmds.c            |   3 +
>  tests/test-bdrv-drain.c   | 520 +++++++++++++++++++++++++++++++++++++++++++++-
>  9 files changed, 696 insertions(+), 88 deletions(-)
> 
