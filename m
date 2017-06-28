Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBt-0000V0-C2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBs-0002Gq-DE
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 28 Jun 2017 12:55:23 -0500
Message-Id: <20170628175534.14295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/11] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

This is part two of that conversion: dirty-bitmap. Other parts
include bdrv_is_allocated (at v3 [1]) and replacing
bdrv_get_block_status with a byte based callback in all the
drivers (at v1, needs a rebase [3]).

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v3

Depends on Kevin's block branch and my v3 bdrv_is_allocated [1]

Since v2 [2], I had to rebase on top of Paolo's locking fixes;
patch v2 2/12 is gone, and many of the others had a lot of
context conflicts. But I felt the resolution was simple enough
that I kept R-b on all but patch 8.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06077.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03859.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html

(git backport-diff doesn't like the rename in 7/11)

001/11:[----] [--] 'dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented'
002/11:[0024] [FC] 'dirty-bitmap: Drop unused functions'
003/11:[----] [-C] 'dirty-bitmap: Track size in bytes'
004/11:[----] [-C] 'dirty-bitmap: Set iterator start by offset, not sector'
005/11:[----] [-C] 'dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset'
006/11:[----] [-C] 'dirty-bitmap: Change bdrv_get_dirty_count() to report bytes'
007/11:[down] 'dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes'
008/11:[0036] [FC] 'dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes'
009/11:[----] [--] 'mirror: Switch mirror_dirty_init() to byte-based iteration'
010/11:[0001] [FC] 'dirty-bitmap: Switch bdrv_set_dirty() to bytes'
011/11:[----] [-C] 'dirty-bitmap: Convert internal hbitmap size/granularity'

Eric Blake (11):
  dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
  dirty-bitmap: Drop unused functions
  dirty-bitmap: Track size in bytes
  dirty-bitmap: Set iterator start by offset, not sector
  dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset
  dirty-bitmap: Change bdrv_get_dirty_count() to report bytes
  dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes
  dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes
  mirror: Switch mirror_dirty_init() to byte-based iteration
  dirty-bitmap: Switch bdrv_set_dirty() to bytes
  dirty-bitmap: Convert internal hbitmap size/granularity

 include/block/block_int.h    |   2 +-
 include/block/dirty-bitmap.h |  28 ++++--------
 block/backup.c               |   7 ++-
 block/dirty-bitmap.c         | 105 +++++++++++--------------------------------
 block/io.c                   |   6 +--
 block/mirror.c               |  73 +++++++++++++-----------------
 migration/block.c            |  12 +++--
 7 files changed, 79 insertions(+), 154 deletions(-)

-- 
2.9.4
