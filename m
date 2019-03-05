Received: from eggs.gnu.org ([209.51.188.92]:40329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiv-0007GF-0N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1Jiq-0005jS-NK
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:43:47 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Mar 2019 18:43:32 -0500
Message-Id: <20190305234337.18353-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This series aims to enable block resizes when persistent bitmaps are
in use. The basic approach here is to recognize that we now load all
persistent bitmaps in memory, and so we can rely on in-memory resizes
and then flush the changed metadata back to disk.

One part that is potentially now quite strange is that bitmap resizes
may happen twice: once during the qcow2 resize event only if persistent
bitmaps are found, and then again as part of the generic resize callback
event whether or not we have any persistent bitmaps.

The second round is required if we are not using qcow2 or we have only
transient bitmaps. The first round is required as we wish to flush the
bitmaps back to disk atomically with the qcow2 resize to avoid violating
our invariants for the bitmap metadata which is checked in many places.

This is harmless; hbitmap_truncate will recognize the second round as
a no-op.

John Snow (5):
  block/qcow2-bitmap: Skip length check in some cases
  block/qcow2-bitmap: Allow bitmap flushing
  block/qcow2-bitmap: don't remove bitmaps on reopen
  block/qcow2-bitmap: Allow resizes with persistent bitmaps
  tests/qemu-iotests: add bitmap resize test 246

 block/qcow2.h              |   2 +
 block/qcow2-bitmap.c       | 123 +++++++++++----
 block/qcow2.c              |  27 +++-
 tests/qemu-iotests/246     | 114 ++++++++++++++
 tests/qemu-iotests/246.out | 296 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 528 insertions(+), 35 deletions(-)
 create mode 100755 tests/qemu-iotests/246
 create mode 100644 tests/qemu-iotests/246.out

-- 
2.17.2
