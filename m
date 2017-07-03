Received: from eggs.gnu.org ([2001:4830:134:3::10]:55008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30D-0006tc-Nj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30C-00082e-Ec
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:34 -0500
Message-Id: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/17] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com

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
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v4

Depends on Max's block branch and my v3 bdrv_is_allocated [1]

v4 is a major rebase: now that persistent dirty bitmaps have
landed, I had more client code to convert. As part of the
rebase, I also discovered that v3 did not correctly convert
the functions used for serializing a dirty bitmap (which
really didn't matter until qcow2-bitmap.c landed, anyways).
So the intra-version diffstat is huge, and a lot of patches
need re-review.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06077.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03859.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html

(git backport-diff doesn't like the rename in 5/17)

001/17:[----] [--] 'dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented'
002/17:[down] 'hbitmap: Rename serialization_granularity to serialization_align'
003/17:[down] 'qcow2: Ensure bitmap serialization is aligned'
004/17:[0006] [FC] 'dirty-bitmap: Drop unused functions'
005/17:[down] 'dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes'
006/17:[down] 'dirty-bitmap: Change bdrv_dirty_bitmap_*serialize*() to take bytes'
007/17:[down] 'qcow2: Switch sectors_covered_by_bitmap_cluster() to byte-based'
008/17:[0004] [FC] 'dirty-bitmap: Set iterator start by offset, not sector'
009/17:[0002] [FC] 'dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset'
010/17:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_count() to report bytes'
011/17:[----] [-C] 'dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes'
012/17:[----] [-C] 'dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes'
013/17:[----] [--] 'mirror: Switch mirror_dirty_init() to byte-based iteration'
014/17:[down] 'qcow2: Switch load_bitmap_data() to byte-based iteration'
015/17:[down] 'qcow2: Switch store_bitmap_data() to byte-based iteration'
016/17:[----] [-C] 'dirty-bitmap: Switch bdrv_set_dirty() to bytes'
017/17:[0031] [FC] 'dirty-bitmap: Convert internal hbitmap size/granularity'

Eric Blake (17):
  dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented
  hbitmap: Rename serialization_granularity to serialization_align
  qcow2: Ensure bitmap serialization is aligned
  dirty-bitmap: Drop unused functions
  dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes
  dirty-bitmap: Change bdrv_dirty_bitmap_*serialize*() to take bytes
  qcow2: Switch sectors_covered_by_bitmap_cluster() to byte-based
  dirty-bitmap: Set iterator start by offset, not sector
  dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset
  dirty-bitmap: Change bdrv_get_dirty_count() to report bytes
  dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes
  dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes
  mirror: Switch mirror_dirty_init() to byte-based iteration
  qcow2: Switch load_bitmap_data() to byte-based iteration
  qcow2: Switch store_bitmap_data() to byte-based iteration
  dirty-bitmap: Switch bdrv_set_dirty() to bytes
  dirty-bitmap: Convert internal hbitmap size/granularity

 include/block/block_int.h    |   2 +-
 include/block/dirty-bitmap.h |  41 +++++---------
 include/qemu/hbitmap.h       |   8 +--
 block/backup.c               |   7 +--
 block/dirty-bitmap.c         | 128 ++++++++++++++-----------------------------
 block/io.c                   |   6 +-
 block/mirror.c               |  73 +++++++++++-------------
 block/qcow2-bitmap.c         |  57 +++++++++----------
 migration/block.c            |  12 ++--
 tests/test-hbitmap.c         |  10 ++--
 util/hbitmap.c               |   8 +--
 11 files changed, 142 insertions(+), 210 deletions(-)

-- 
2.9.4
