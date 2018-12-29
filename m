Received: from eggs.gnu.org ([208.118.235.92]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDv0-0002vG-S7
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gdDcB-0007tu-LT
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 07:21:26 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Dec 2018 15:20:16 +0300
Message-Id: <20181229122027.42245-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 00/11] backup-top filter driver for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

Hi all!

These series introduce backup-top driver. It's a filter-node, which
do copy-before-write operation. Mirror uses filter-node for handling
guest writes, let's move to filter-node (from write-notifiers) for
backup too

v5:

Now, based on John's bitmaps branch

patch "block: allow serialized reads to intersect" removed
03: reword comment (Kevin)
07: fix comments style
08: new
09: mostly rewritten
10: fix comment style
11: - fix comments style
    - fix uninitialized backup_top
    - fix return -> goto error if failed to
      append filter

v4:
fixes, rewrite driver to be implicit, drop new interfaces and
don't move to BdrvDirtyBitmap for now, as it's not obvious will
it be really needed and don't relate to these series more.

v3 was "[PATCH v3 00/18] fleecing-hook driver for backup"

v2 was "[RFC v2] new, node-graph-based fleecing and backup"

----

These series (v5) are based on John's bitmaps branch

Based-on: https://github.com/jnsnow/qemu bitmaps

Vladimir Sementsov-Ogievskiy (11):
  block/backup: simplify backup_incremental_init_copy_bitmap
  block/backup: move to copy_bitmap with granularity
  block: improve should_update_child
  iotests: handle -f argument correctly for qemu_io_silent
  iotests: allow resume_drive by node name
  iotests: prepare 055 to graph changes during backup job
  block: introduce backup-top filter driver
  block/io: refactor wait_serialising_requests
  block: add lock/unlock range functions
  block/backup: tiny refactor backup_job_create
  block/backup: use backup-top instead of write notifiers

 block/backup-top.h            |  43 ++++
 include/block/block_int.h     |   4 +
 block.c                       |  33 ++-
 block/backup-top.c            | 306 ++++++++++++++++++++++++
 block/backup.c                | 424 +++++++++++++++++-----------------
 block/io.c                    |  69 +++++-
 block/Makefile.objs           |   2 +
 tests/qemu-iotests/055        |  23 +-
 tests/qemu-iotests/iotests.py |  16 +-
 9 files changed, 682 insertions(+), 238 deletions(-)
 create mode 100644 block/backup-top.h
 create mode 100644 block/backup-top.c

-- 
2.18.0
