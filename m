Received: from eggs.gnu.org ([2001:4830:134:3::10]:36269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbVVV-0000wX-Ne
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fbVVQ-0002P6-Q2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:31:01 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  6 Jul 2018 21:30:47 +0300
Message-Id: <20180706183051.197403-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/4] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all.

This fixes image fleecing scheme for 3.0, details are in 04 patch.
01 is a significant fix too.

v4:
01: fix copy_range architecture here too
02: rebase on 01
03: rebase

v3:
02: fix typo in assert, to fix build

v2:
01,02: new patches

03: - improve comment
    - fix assert in bdrv_aligned_pwritev
    - add asserts to not use the flag on read requests
    - support copy_range

04: - expand "detected cases" range 
    - s/fleecing/serialize_target_writes
    - support backup_cow_with_offload
    - drop restriction on compressed writes


v1 cover:

It's a continuation of discussion under
"[PATCH v2 2/3] block/fleecing-filter: new filter driver for fleecing" [1].

Here is my try to implement Kevin's idea, that all backup writes (for
fleecing case) should be serialized. (However, I've skipped for now
fixing related permissions).

Looks like these patches may replace patch [1], to make fleecing scheme
safe. But I'm not sure, a look by Kevin is necessary.

A test is still needed, to prove that this patch is necessary and that it
works..

Vladimir Sementsov-Ogievskiy (4):
  block/io: fix copy_range
  block: split flags in copy_range
  block: add BDRV_REQ_SERIALISING flag
  block/backup: fix fleecing scheme: use serialized writes

 include/block/block.h          |  31 ++++++++-
 include/block/block_int.h      |  14 ++--
 include/sysemu/block-backend.h |   3 +-
 block/backup.c                 |  20 ++++--
 block/block-backend.c          |   5 +-
 block/file-posix.c             |  21 +++---
 block/io.c                     | 147 ++++++++++++++++++++++++++++-------------
 block/iscsi.c                  |   9 ++-
 block/qcow2.c                  |  20 +++---
 block/raw-format.c             |  24 ++++---
 qemu-img.c                     |   2 +-
 11 files changed, 207 insertions(+), 89 deletions(-)

-- 
2.11.1
