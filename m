Received: from eggs.gnu.org ([2001:4830:134:3::10]:53221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OD-0008J8-UT
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OA-00053a-NZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:22 +0300
Message-Id: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 00/11] backup-top filter driver for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

Hi all!

These series introduce backup-top driver. It's a filter-node, which
do copy-before-write operation. Mirror uses filter-node for handling
guest writes, let's move to filter-node (from write-notifiers) for
backup too (patch 16)

v4:
fixes, rewrite driver to be implicit, drop new interfaces and
don't move to BdrvDirtyBitmap for now, as it's not obvious will
it be really needed and don't relate to these series more.

v3 was "[PATCH v3 00/18] fleecing-hook driver for backup"

v2 was "[RFC v2] new, node-graph-based fleecing and backup"

These series are based on
 [PATCH v4 0/8] dirty-bitmap: rewrite bdrv_dirty_iter_next_area
and
 [PATCH 0/2] replication: drop extra sync

Based-on: <20180919124343.28206-1-vsementsov@virtuozzo.com>
Based-on: <20180917145732.48590-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (11):
  block/backup: simplify backup_incremental_init_copy_bitmap
  block/backup: move to copy_bitmap with granularity
  block: allow serialized reads to intersect
  block: improve should_update_child
  iotests: handle -f argument correctly for qemu_io_silent
  iotests: allow resume_drive by node name
  iotests: prepare 055 to graph changes during backup job
  block: introduce backup-top filter driver
  block: add lock/unlock range functions
  block/backup: tiny refactor backup_job_create
  block/backup: use backup-top instead of write notifiers

 block/backup-top.h            |  44 ++++
 include/block/block_int.h     |   3 +
 block.c                       |  32 ++-
 block/backup-top.c            | 298 ++++++++++++++++++++++++
 block/backup.c                | 415 +++++++++++++++++-----------------
 block/io.c                    |  38 +++-
 block/Makefile.objs           |   2 +
 tests/qemu-iotests/055        |  23 +-
 tests/qemu-iotests/iotests.py |  16 +-
 9 files changed, 641 insertions(+), 230 deletions(-)
 create mode 100644 block/backup-top.h
 create mode 100644 block/backup-top.c

-- 
2.18.0
