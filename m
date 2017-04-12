Received: from eggs.gnu.org ([2001:4830:134:3::10]:44978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMOt-0003cQ-9O
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMOs-00071f-5H
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:49:51 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Apr 2017 12:49:08 -0500
Message-Id: <20170412174920.8744-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 00/12] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

This is part two of that conversion: dirty-bitmap. Other parts
include bdrv_is_allocated (previously submitted) and replacing
bdrv_get_block_status with a byte based callback in all the
drivers (still being written).

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v1

It requires the following (v1 of bdrv_is_allocated, v9 of
blkdebug, and Max's block-next tree):
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01995.html
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01723.html
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html

Eric Blake (12):
  dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
  migration: Don't lose errno across aio context changes
  dirty-bitmap: Drop unused functions
  dirty-bitmap: Track size in bytes
  dirty-bitmap: Set iterator start by offset, not sector
  dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset
  dirty-bitmap: Change bdrv_get_dirty_count() to report bytes
  dirty-bitmap: Change bdrv_get_dirty() to take bytes
  dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes
  mirror: Switch mirror_dirty_init() to byte-based iteration
  dirty-bitmap: Switch bdrv_set_dirty() to bytes
  dirty-bitmap: Convert internal hbitmap size/granularity

 include/block/block_int.h    |  2 +-
 include/block/dirty-bitmap.h | 21 ++++-------
 block/backup.c               |  7 ++--
 block/dirty-bitmap.c         | 83 ++++++++++++--------------------------------
 block/io.c                   |  6 ++--
 block/mirror.c               | 73 +++++++++++++++++---------------------
 migration/block.c            | 14 ++++----
 7 files changed, 74 insertions(+), 132 deletions(-)

-- 
2.9.3
