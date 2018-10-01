Received: from eggs.gnu.org ([2001:4830:134:3::10]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSN-0004qf-MS
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002Lp-RX
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:10 +0300
Message-Id: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 00/18] fleecing-hook driver for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

v2 was "[RFC v2] new, node-graph-based fleecing and backup"

Hi all!

These series introduce fleecing-hook driver. It's a filter-node, which
do copy-before-write operation. Mirror uses filter-node for handling
guest writes, let's move to filter-node (from write-notifiers) for
backup too (patch 18)

Proposed filter driver is complete and separate: it can be used
standalone, as fleecing provider (instead of backup(sync=none)).
(old-style fleecing based on backup(sync=none) is supported too),
look at patch 16.

There a lot of other ideas and improvements which can be achieved
basing on these series which were discussed on v2 thread, for the
beginning I want to concentrate on the following:

done in these series:
 1. use filter node instead of write notifiers in backup
 2. filter-based fleecing scheme, without a job

near to be done (a test is needed and may be tiny adjustment)
 3. backup scheme for push backup with fleecing, to no disturb
    the guest with long handling of its writes (if target is far
    from remote NBD): just start fleecing to local qcow2 temp
    node and start a backup job (or mirror, why not?) from temp
    node to remote target. These series provide a possibility
    to share dirty bitmap between fleecing-hook and backup job
    to create efficient scenarios.

These series are based on
 [PATCH v4 0/8] dirty-bitmap: rewrite bdrv_dirty_iter_next_area
and
 [PATCH 0/2] replication: drop extra sync

Based-on: <20180919124343.28206-1-vsementsov@virtuozzo.com>
Based-on: <20180917145732.48590-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (18):
  block/dirty-bitmap: allow set/reset bits in disabled bitmaps
  block/io: allow BDRV_REQ_SERIALISING for read
  block/backup: simplify backup_incremental_init_copy_bitmap
  block/backup: move from HBitmap to BdrvDirtyBitmap
  util/id: add block-bitmap subsystem
  block/backup: give a name to copy-bitmap
  block/backup: allow use existent copy-bitmap
  block: allow serialized reads to intersect
  block: improve should_update_child
  iotests: handle -f argument correctly for qemu_io_silent
  iotests: allow resume_drive by node name
  iotests: prepare 055 to graph changes during backup job
  block: introduce new filter driver: fleecing-hook
  block/fleecing-hook: internal api
  qapi: add x-drop-fleecing qmp command
  iotests: test new fleecing-hook driver in context of 222 iotest
  block/backup: tiny refactor backup_job_create
  block/backup: use fleecing-hook instead of write notifiers

 qapi/block-core.json          |  57 +++++-
 include/block/block.h         |   9 +
 include/block/block_int.h     |   2 +-
 include/qemu/id.h             |   1 +
 block.c                       |  32 +++-
 block/backup.c                | 320 ++++++++++++++-----------------
 block/dirty-bitmap.c          |   2 -
 block/fleecing-hook.c         | 349 ++++++++++++++++++++++++++++++++++
 block/io.c                    |  16 +-
 block/replication.c           |   2 +-
 blockdev.c                    |  49 ++++-
 util/id.c                     |   1 +
 block/Makefile.objs           |   2 +
 tests/qemu-iotests/055        |  23 ++-
 tests/qemu-iotests/222        |  59 ++++--
 tests/qemu-iotests/222.out    |  66 +++++++
 tests/qemu-iotests/iotests.py |  16 +-
 17 files changed, 778 insertions(+), 228 deletions(-)
 create mode 100644 block/fleecing-hook.c

-- 
2.18.0
