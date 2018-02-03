Received: from eggs.gnu.org ([2001:4830:134:3::10]:48237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ehzun-0001f1-NK
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 10:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ehzuk-0003yW-Lo
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 10:39:41 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  3 Feb 2018 10:39:30 -0500
Message-Id: <20180203153935.8056-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/5] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

There are cases in which a queued coroutine must be restarted from
non-coroutine context (with qemu_co_enter_next).  In this cases,
qemu_co_enter_next also needs to be thread-safe, but it cannot use a
CoMutex and so cannot qemu_co_queue_wait.  This happens in curl (which
right now is rolling its own list of Coroutines) and will happen in
Fam's NVMe driver as well.

This series extracts the idea of a polymorphic lockable object
from my "scoped lock guard" proposal, and applies it to CoQueue.
The implementation of QemuLockable is similar to C11 _Generic, but
redone using the preprocessor and GCC builtins for compatibility.

In general, while a bit on the esoteric side, the functionality used
to emulate _Generic is fairly old in GCC, and the builtins are already
used by include/qemu/atomic.h; the series was tested with Fedora 27 (boot
Damn Small Linux via http) and CentOS 6 (compiled only).

Paolo

v4->v5: fix checkpatch complaints

v3->v4: fix -O0 compilation [Fam]
        typos and copyright dates [Eric, Fam]
        improve CoQueue comments [Stefan]

Paolo Bonzini (5):
  test-coroutine: add simple CoMutex test
  lockable: add QemuLockable
  coroutine-lock: convert CoQueue to use QemuLockable
  coroutine-lock: make qemu_co_enter_next thread-safe
  curl: convert to CoQueue

 block/curl.c                | 20 ++--------
 fsdev/qemu-fsdev-throttle.c |  4 +-
 include/qemu/compiler.h     | 40 +++++++++++++++++++
 include/qemu/coroutine.h    | 29 +++++++++-----
 include/qemu/lockable.h     | 96 +++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h       |  5 +--
 include/qemu/typedefs.h     |  4 ++
 tests/test-coroutine.c      | 75 ++++++++++++++++++++++++++++++++++-
 util/qemu-coroutine-lock.c  | 22 +++++++----
 9 files changed, 256 insertions(+), 39 deletions(-)
 create mode 100644 include/qemu/lockable.h

-- 
2.14.3
