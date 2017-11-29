Received: from eggs.gnu.org ([2001:4830:134:3::10]:41142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3hR-00058S-Ku
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3hL-0005Rf-So
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:50:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:47 +0800
Message-Id: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/9] block: Rewrite block drain begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

While we look at the fixes for 2.11, I briefly prototyped this series to see if
it makes sense as a simplification of the drain API for 2.12.

The idea is to let AioContext manage quiesce callbacks, then the block layer
only needs to do the in-flight request waiting. This lets us get rid of the
callback recursion (both up and down).

Many commit logs and code comments are definitely missing, but it would be good
to get high level review and maybe some testing already.

Fam

Fam Zheng (9):
  block: Remove unused bdrv_requests_pending
  aio: Add drain begin/end API to AioContext
  blockjob: Implement AioContext drain ops
  throttle: Implement AioContext drain ops
  qed: Implement AioContext drain ops
  block: Use aio_context_drained_begin in bdrv_set_aio_context
  block: Switch to use AIO drained begin/end API
  block: Drop old drained_{begin,end} callbacks
  blockjob: Drop unused functions

 block.c                        |  30 +--------
 block/block-backend.c          |  22 -------
 block/io.c                     | 134 +++--------------------------------------
 block/qed.c                    |  34 ++++++++---
 block/throttle.c               |  34 ++++++++---
 blockjob.c                     |  67 ++++++++-------------
 include/block/aio.h            |  27 ++++++++-
 include/block/block.h          |  16 -----
 include/block/block_int.h      |  12 ----
 include/block/blockjob_int.h   |  14 -----
 include/sysemu/block-backend.h |   8 ---
 util/async.c                   |  73 ++++++++++++++++++++++
 12 files changed, 186 insertions(+), 285 deletions(-)

-- 
2.14.3
