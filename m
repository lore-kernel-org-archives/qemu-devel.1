Received: from eggs.gnu.org ([2001:4830:134:3::10]:50715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOlaK-0000vF-Dm
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cOlaH-0006Xq-BH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:26:32 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cOlaH-0006Xc-29
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:26:29 -0500
Received: by mail-wm0-x242.google.com with SMTP id u144so91505530wmu.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 05:26:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  4 Jan 2017 14:26:15 +0100
Message-Id: <20170104132625.28059-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/10] aio_context_acquire/release pushdown,
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
Cc: stefanha@redhat.com, famz@redhat.com

This is the first step of pushing down the AioContext lock.  Bottom halves
are already protected by their own lock, use it also for walking_bh
and for the handlers list (including walking_handlers).  The (lock,
walking_foo) pair is wrapped into the QemuLockCnt primitive.

Paolo

v2->v3:
        fix missing unlock

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

 aio-posix.c                 | 116 +++++++------
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
 13 files changed, 1003 insertions(+), 159 deletions(-)
 create mode 100644 docs/lockcnt.txt
 create mode 100644 include/qemu/futex.h
 create mode 100644 util/lockcnt.c

-- 
2.9.3
