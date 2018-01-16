Received: from eggs.gnu.org ([2001:4830:134:3::10]:52405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebS97-0007qb-Cn
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebS91-0007cS-Ll
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebS91-0007c9-Fh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:23:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 948D9796E5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:23:18 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-234.ams2.redhat.com
	[10.36.116.234])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D8F345C260
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 14:23:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:23:12 +0100
Message-Id: <20180116142316.30486-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] coroutine-lock: polymorphic CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
