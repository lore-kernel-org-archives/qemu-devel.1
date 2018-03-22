Received: from eggs.gnu.org ([2001:4830:134:3::10]:59165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ez298-0000MM-IO
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ez297-0008CA-QC
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 22 Mar 2018 15:28:31 +0000
Message-Id: <20180322152834.12656-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] coroutine: avoid co_queue_wakeup recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

co_queue_wakeup is currently implemented in a recursive fashion.  Pathological
patterns of aio_co_enter() between coroutines can cause stack exhaustion.

This patch series implements co_queue_wakeup iteratively and avoids stack
exhaustion.

This issue was originally reported with qemu-img convert but I don't have a
good reproducer.  See Patch 3 for a test-aio test case instead.

Stefan Hajnoczi (3):
  queue: add QSIMPLEQ_PREPEND()
  coroutine: avoid co_queue_wakeup recursion
  coroutine: add test-aio coroutine queue chaining test case

 include/qemu/coroutine_int.h |   1 -
 include/qemu/queue.h         |   8 ++++
 block/io.c                   |   3 +-
 tests/test-aio.c             |  65 ++++++++++++++++++++-----
 util/qemu-coroutine-lock.c   |  34 -------------
 util/qemu-coroutine.c        | 110 +++++++++++++++++++++++--------------------
 6 files changed, 120 insertions(+), 101 deletions(-)

-- 
2.14.3
