Received: from eggs.gnu.org ([2001:4830:134:3::10]:56420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebCve-0007Mm-R9
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebCva-000697-LE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 17:08:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 15 Jan 2018 23:08:18 +0100
Message-Id: <20180115220822.10156-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] coroutine-lock: polymorphic CoQueue
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

Paolo Bonzini (4):
  lockable: add QemuLockable
  coroutine-lock: convert CoQueue to use QemuLockable
  coroutine-lock: make qemu_co_enter_next thread-safe
  curl: convert to CoQueue

 block/curl.c                | 20 +++---------
 fsdev/qemu-fsdev-throttle.c |  4 +--
 include/qemu/compiler.h     | 40 ++++++++++++++++++++++++
 include/qemu/coroutine.h    | 25 ++++++++++-----
 include/qemu/lockable.h     | 75 +++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h       |  5 ++-
 include/qemu/typedefs.h     |  4 +++
 util/qemu-coroutine-lock.c  | 22 ++++++++-----
 8 files changed, 159 insertions(+), 36 deletions(-)
 create mode 100644 include/qemu/lockable.h

-- 
2.14.3
