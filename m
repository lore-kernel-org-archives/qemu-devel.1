Received: from eggs.gnu.org ([2001:4830:134:3::10]:47323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJhUz-0005yN-NK
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJhUv-00013G-U8
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:04:05 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Dec 2016 15:03:41 +0100
Message-Id: <20161221140351.30652-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] aio_context_acquire/release pushdown,
 part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is the first step of pushing down the AioContext lock.  Bottom halves
are already protected by their own lock, use it also for walking_bh
and for the handlers list (including walking_handlers).  The (lock,
walking_foo) pair is wrapped into the QemuLockCnt primitive.

Paolo

v1->v2:
        rebased on top of polling patches
        moved documentation to include/
        new patch "aio-posix: split aio_dispatch_handlers out of aio_dispatch"
        replaced atomic_read with atomic_mb_read in qemu_lockcnt_inc
        replaced futex* function and macro names with qemu_futex*
        removed atomic access to node->pfd.revents (because there is no
          concurrent aio_poll anymore after the BDRV_POLL_WHILE series)
        left "aio: push aio_context_acquire/release down to dispatching"
          to a later series

Paolo Bonzini (10):
  aio: rename bh_lock to list_lock
  qemu-thread: introduce QemuLockCnt
  aio: make ctx->list_lock a QemuLockCnt, subsuming ctx->walking_bh
  qemu-thread: optimize QemuLockCnt with futexes on Linux
  aio-posix: split aio_dispatch_handlers out of aio_dispatch
  aio: tweak walking in dispatch phase
  aio-posix: remove walking_handlers, protecting AioHandler list with
    list_lock
  aio-win32: remove walking_handlers, protecting AioHandler list with
    list_lock
  aio: document locking
  async: optimize aio_bh_poll

 aio-posix.c                 | 115 +++++++------
 aio-win32.c                 |  83 ++++++----
 async.c                     |  45 ++---
 docs/lockcnt.txt            | 277 +++++++++++++++++++++++++++++++
 docs/multiple-iothreads.txt |  13 +-
 include/block/aio.h         |  38 ++---
 include/qemu/futex.h        |  36 ++++
 include/qemu/thread.h       | 111 +++++++++++++
 util/Makefile.objs          |   1 +
 util/lockcnt.c              | 395 ++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c    |  35 +---
 util/qemu-thread-win32.c    |   2 +-
 util/trace-events           |  10 ++
 13 files changed, 1002 insertions(+), 159 deletions(-)
 create mode 100644 docs/lockcnt.txt
 create mode 100644 include/qemu/futex.h
 create mode 100644 util/lockcnt.c

-- 
2.9.3
