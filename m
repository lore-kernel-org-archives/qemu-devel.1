Received: from eggs.gnu.org ([2001:4830:134:3::10]:36783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa1-0004oB-J0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa0-0001X1-AQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:37 -0500
Message-Id: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/18] make dirty-bitmap byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488)
part 2: dirty-bitmap (this series, v4 was here [1])
part 3: bdrv_get_block_status (v2 is posted [2] and is mostly reviewed, but
needs a rebase)
part 4: upcoming series, for .bdrv_co_block_status (second half of v1 [3])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v5

Depends on Max's block branch

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00269.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00427.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html

Differences in v5:
- add R-b as appropriate
- rebase to recent block commits (patch 13)
- fix bug in bdrv_measure that I found during the rebase (patch 14)
- fix botched rebase that messed up bdrv_dirty_bitmap_truncate (patch 5,
18) [John]
- tweak commit message of patch 9 to point out a temporary condition of
not being strict to C99 shift semantics (it goes away in 15)

001/18:[----] [--] 'dirty-bitmap: Report BlockDirtyInfo.count in bytes, as documented'
002/18:[----] [--] 'hbitmap: Rename serialization_granularity to serialization_align'
003/18:[----] [--] 'qcow2: Ensure bitmap serialization is aligned'
004/18:[----] [--] 'dirty-bitmap: Drop unused functions'
005/18:[0003] [FC] 'dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes'
006/18:[----] [--] 'dirty-bitmap: Change bdrv_dirty_bitmap_*serialize*() to take bytes'
007/18:[----] [--] 'qcow2: Switch sectors_covered_by_bitmap_cluster() to byte-based'
008/18:[----] [--] 'dirty-bitmap: Set iterator start by offset, not sector'
009/18:[----] [--] 'dirty-bitmap: Change bdrv_dirty_iter_next() to report byte offset'
010/18:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_count() to report bytes'
011/18:[----] [--] 'dirty-bitmap: Change bdrv_get_dirty_locked() to take bytes'
012/18:[----] [-C] 'dirty-bitmap: Change bdrv_[re]set_dirty_bitmap() to use bytes'
013/18:[0007] [FC] 'mirror: Switch mirror_dirty_init() to byte-based iteration'
014/18:[down] 'qcow2: Switch qcow2_measure() to byte-based iteration'
015/18:[----] [--] 'qcow2: Switch load_bitmap_data() to byte-based iteration'
016/18:[----] [--] 'qcow2: Switch store_bitmap_data() to byte-based iteration'
017/18:[----] [--] 'dirty-bitmap: Switch bdrv_set_dirty() to bytes'
018/18:[0003] [FC] 'dirty-bitmap: Convert internal hbitmap size/granularity'

Eric Blake (18):
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
  qcow2: Switch qcow2_measure() to byte-based iteration
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
 block/mirror.c               |  76 +++++++++++--------------
 block/qcow2-bitmap.c         |  57 +++++++++----------
 block/qcow2.c                |  22 ++++----
 migration/block.c            |  12 ++--
 tests/test-hbitmap.c         |  10 ++--
 util/hbitmap.c               |   8 +--
 12 files changed, 152 insertions(+), 225 deletions(-)

-- 
2.9.4
