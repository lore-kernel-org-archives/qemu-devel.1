Received: from eggs.gnu.org ([2001:4830:134:3::10]:42285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8l4-0000tu-6R
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8l3-0002LW-5y
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:57:34 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 13:57:07 -0400
Message-Id: <20170808175711.12203-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] IDE: Do not flush empty drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com, John Snow <jsnow@redhat.com>

Patches one and two here are a 2.10 bandaid that avoids a crash.
Patches three and four are a more comprehensive fix as written by
Kevin in another discussion and are being posted here for the sake
of a discussion.

Patch three as written causes hangs in iotests 20, 39, 97, 98, 129,
153, 176, and 185. 124 actually segfaults.

For the purposes of 2.10, we'll likely just want patches 1 and 2
for now.

The problem in a nutshell: incrementing the in-flight counter of the
BDS from the BB layer assumes that every BB always has a BDS. That's
not true; and some devices like IDE have not in the past checked to
see if a given blk_ operation WOULD fail.

This culminates in a new regression where issuing a cache flush to a
CDROM (which is, for some reason, specification valid) will crash QEMU
due to a null dereference when attempting to atomically increment that
backend's in-flight counter.

John Snow (1):
  IDE: Do not flush empty CDROM drives

Kevin Wolf (3):
  IDE: test flush on empty CDROM
  block-backend: shift in-flight counter to BB from BDS
  block-backend: test flush op on empty backend

 block.c                    |  2 +-
 block/block-backend.c      | 40 +++++++++++++++++++++++++-----
 hw/ide/core.c              | 11 +++++---
 tests/Makefile.include     |  2 ++
 tests/ide-test.c           | 19 ++++++++++++++
 tests/test-block-backend.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 11 deletions(-)
 create mode 100644 tests/test-block-backend.c

-- 
2.9.4
