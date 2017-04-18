Received: from eggs.gnu.org ([2001:4830:134:3::10]:33801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I1w-00050Y-Ht
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0I1v-0003Qq-7I
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:34:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Apr 2017 20:33:25 -0500
Message-Id: <20170418013356.3578-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 00/31] make bdrv_get_block_status byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@nongnu.org, jsnow@redhat.com

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

This is part three of that conversion: dirty-bitmap. Earlier parts
have been (mostly) reviewed, for bdrv_is_allocated and dirty-bitmaps.

Perhaps I could have split this in two; patches 1-10 vs. 11-31 make
a nice division of labor.

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v1

It requires the following (v1 of bdrv_is_allocated, v1 of dirty-bitmap,
v9 of blkdebug, and Max's block-next tree):
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01995.html
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01723.html
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02163.html

The diffstat shows no net change in total lines - but I know that the
new code has more lines of comments than the old ;)

I still haven't felt like tackling the task of rewriting migration/block.c
to use bytes (instead of sectors) everywhere - that might give another
net win in lines of code and legibility, but I also know it would
conflict with some of the refactoring work that Juan is currently
posting for review.

Eric Blake (31):
  block: Drop unused bdrv_round_sectors_to_clusters()
  block: Make bdrv_round_to_clusters() signature more useful
  qcow2: Switch is_zero_sectors() to byte-based
  block: Switch bdrv_make_zero() to byte-based
  qemu-img: Switch get_block_status() to byte-based
  block: Convert bdrv_get_block_status() to bytes
  block: Switch bdrv_co_get_block_status() to byte-based
  block: Switch BdrvCoGetBlockStatusData to byte-based
  block: Switch bdrv_co_get_block_status_above() to byte-based
  block: Convert bdrv_get_block_status_above() to bytes
  block: Add .bdrv_co_block_status() callback
  commit: Switch to .bdrv_co_block_status()
  file-posix: Switch to .bdrv_co_block_status()
  gluster: Switch to .bdrv_co_block_status()
  iscsi: Switch cluster_sectors to byte-based
  iscsi: Switch iscsi_allocmap_update() to byte-based
  iscsi: Switch to .bdrv_co_block_status()
  mirror: Switch to .bdrv_co_block_status()
  null: Switch to .bdrv_co_block_status()
  parallels: Switch to .bdrv_co_block_status()
  qcow: Switch to .bdrv_co_block_status()
  qcow2: Switch to .bdrv_co_block_status()
  qed: Switch to .bdrv_co_block_status()
  raw: Switch to .bdrv_co_block_status()
  sheepdog: Switch to .bdrv_co_block_status()
  vdi: Avoid bitrot of debugging code
  vdi: Switch to .bdrv_co_block_status()
  vmdk: Switch to .bdrv_co_block_status()
  vpc: Switch to .bdrv_co_block_status()
  vvfat: Switch to .bdrv_co_block_status()
  block: Drop unused .bdrv_co_get_block_status()

 include/block/block.h     |  33 +++----
 include/block/block_int.h |  13 ++-
 block/commit.c            |  10 +-
 block/file-posix.c        |  47 +++++----
 block/gluster.c           |  47 +++++----
 block/io.c                | 243 ++++++++++++++++++++++------------------------
 block/iscsi.c             | 144 ++++++++++++++-------------
 block/mirror.c            |  33 +++----
 block/null.c              |  21 ++--
 block/parallels.c         |  15 +--
 block/qcow.c              |  22 +++--
 block/qcow2-cluster.c     |   2 +-
 block/qcow2.c             |  51 +++++-----
 block/qed.c               |  22 ++---
 block/raw-format.c        |  16 +--
 block/sheepdog.c          |  23 +++--
 block/vdi.c               |  37 ++++---
 block/vmdk.c              |  24 ++---
 block/vpc.c               |  31 +++---
 block/vvfat.c             |  12 +--
 qemu-img.c                |  70 ++++++-------
 block/trace-events        |   2 +-
 22 files changed, 459 insertions(+), 459 deletions(-)

-- 
2.9.3
