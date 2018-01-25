Received: from eggs.gnu.org ([2001:4830:134:3::10]:44359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eelob-0000Al-Op
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeloY-0004NI-Mm
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eeloY-0004My-Gx
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:59:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2A1C8FABD
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 17:59:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2018 18:59:44 +0100
Message-Id: <20180125175949.7780-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

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

v1->v2: fix typos and copyright year

v2->v3: add tests, fix brown paper bag bug, avoid -Waddress errors

Paolo Bonzini (5):
  test-coroutine: add simple CoMutex test
  lockable: add QemuLockable
  coroutine-lock: convert CoQueue to use QemuLockable
  coroutine-lock: make qemu_co_enter_next thread-safe
  curl: convert to CoQueue

 block/curl.c                | 20 +++--------
 fsdev/qemu-fsdev-throttle.c |  4 +--
 include/qemu/compiler.h     | 40 +++++++++++++++++++++
 include/qemu/coroutine.h    | 25 ++++++++-----
 include/qemu/lockable.h     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h       |  5 ++-
 include/qemu/typedefs.h     |  4 +++
 tests/test-coroutine.c      | 75 ++++++++++++++++++++++++++++++++++++--
 util/qemu-coroutine-lock.c  | 22 ++++++++----
 9 files changed, 245 insertions(+), 38 deletions(-)
 create mode 100644 include/qemu/lockable.h

-- 
2.14.3
