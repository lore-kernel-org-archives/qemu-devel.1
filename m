Received: from eggs.gnu.org ([2001:4830:134:3::10]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc6x-0000Xe-CS
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc6w-0008Io-FX
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:03 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Sun, 19 Nov 2017 21:46:41 -0500
Message-Id: <cover.1511145863.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Fix segfault in blockjob race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com

This series fixes a race condition segfault when using iothreads with
blockjobs.

The qemu iotest in this series is a reproducer, as is the reproducer
script attached in this bug report:

https://bugzilla.redhat.com/show_bug.cgi?id=1508708

There are two additional patches to try and catch this sort of scenario
with an abort, before a segfault or memory corruption occurs.

Jeff Cody (5):
  blockjob: do not allow coroutine double entry or
    entry-after-completion
  coroutine: abort if we try to enter coroutine scheduled for another
    ctx
  coroutines: abort if we try to enter a still-sleeping coroutine
  qemu-iotests: add option in common.qemu for mismatch only
  qemu-iotest: add test for blockjob coroutine race condition

 blockjob.c                     |  9 ++--
 include/qemu/coroutine_int.h   |  5 +++
 tests/qemu-iotests/200         | 99 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/200.out     | 14 ++++++
 tests/qemu-iotests/common.qemu |  8 +++-
 tests/qemu-iotests/group       |  1 +
 util/async.c                   |  7 +++
 util/qemu-coroutine-sleep.c    |  3 ++
 util/qemu-coroutine.c          | 14 ++++++
 9 files changed, 156 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/200
 create mode 100644 tests/qemu-iotests/200.out

-- 
2.9.5
