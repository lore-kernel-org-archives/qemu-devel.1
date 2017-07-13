Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgKu-0004ZE-OU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVgKt-0005ew-HJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:47:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 13 Jul 2017 10:46:48 -0500
Message-Id: <20170713154711.32374-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/23] make bdrv_get_block_status byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488)
part 2: dirty-bitmap (v5 is posted [1], mostly reviewed)
part 3: bdrv_get_block_status (this series, v2 at [2])
part 4: upcoming series, for .bdrv_co_block_status (second half of v1 [3])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v3

It depends on my dirty-bitmap patches [1] and Manos' filter cleanups (I
tested against v5 [4], but see that v6 was just posted).

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03512.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00427.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03610.html

Since v2:
- Lots of rebase changes, including removing TODOs added during
the first series for bdrv_is_allocated
- change hint parameter 'allocated=false' to 'mapping=true' [Fam]
- fix bugs related to shoe-horning 64-bit bytes into 32-bit sectors
- lots of new patches to convert qemu-img to be byte-based
- a cool order-of-magnitude speedup for a rather simple-to-write
testcase of 'qemu-img compare'

I still haven't felt like tackling the task of rewriting migration/block.c
to use bytes (instead of sectors) everywhere - that might give another net
win in lines of code and legibility.

001/23:[0004] [FC] 'block: Allow NULL file for bdrv_get_block_status()'
002/23:[0033] [FC] 'block: Add flag to avoid wasted work in bdrv_is_allocated()'
003/23:[----] [--] 'block: Make bdrv_round_to_clusters() signature more useful'
004/23:[----] [--] 'qcow2: Switch is_zero_sectors() to byte-based'
005/23:[----] [--] 'block: Switch bdrv_make_zero() to byte-based'
006/23:[----] [--] 'qemu-img: Switch get_block_status() to byte-based'
007/23:[0002] [FC] 'block: Convert bdrv_get_block_status() to bytes'
008/23:[0017] [FC] 'block: Switch bdrv_co_get_block_status() to byte-based'
009/23:[----] [-C] 'block: Switch BdrvCoGetBlockStatusData to byte-based'
010/23:[0011] [FC] 'block: Switch bdrv_common_block_status_above() to byte-based'
011/23:[0008] [FC] 'block: Switch bdrv_co_get_block_status_above() to byte-based'
012/23:[0027] [FC] 'block: Convert bdrv_get_block_status_above() to bytes'
013/23:[down] 'qemu-img: Simplify logic in img_compare()'
014/23:[down] 'qemu-img: Speed up compare on pre-allocated larger file'
015/23:[down] 'qemu-img: Add find_nonzero()'
016/23:[down] 'qemu-img: Drop redundant error message in compare'
017/23:[down] 'qemu-img: Change check_empty_sectors() to byte-based'
018/23:[down] 'qemu-img: Change compare_sectors() to be byte-based'
019/23:[down] 'qemu-img: Change img_rebase() to be byte-based'
020/23:[down] 'qemu-img: Change img_compare() to be byte-based'
021/23:[0004] [FC] 'block: Align block status requests'
022/23:[down] 'block: Relax bdrv_aligned_preadv() assertion'
023/23:[0004] [FC] 'qemu-io: Relax 'alloc' now that block-status doesn't assert'

Eric Blake (23):
  block: Allow NULL file for bdrv_get_block_status()
  block: Add flag to avoid wasted work in bdrv_is_allocated()
  block: Make bdrv_round_to_clusters() signature more useful
  qcow2: Switch is_zero_sectors() to byte-based
  block: Switch bdrv_make_zero() to byte-based
  qemu-img: Switch get_block_status() to byte-based
  block: Convert bdrv_get_block_status() to bytes
  block: Switch bdrv_co_get_block_status() to byte-based
  block: Switch BdrvCoGetBlockStatusData to byte-based
  block: Switch bdrv_common_block_status_above() to byte-based
  block: Switch bdrv_co_get_block_status_above() to byte-based
  block: Convert bdrv_get_block_status_above() to bytes
  qemu-img: Simplify logic in img_compare()
  qemu-img: Speed up compare on pre-allocated larger file
  qemu-img: Add find_nonzero()
  qemu-img: Drop redundant error message in compare
  qemu-img: Change check_empty_sectors() to byte-based
  qemu-img: Change compare_sectors() to be byte-based
  qemu-img: Change img_rebase() to be byte-based
  qemu-img: Change img_compare() to be byte-based
  block: Align block status requests
  block: Relax bdrv_aligned_preadv() assertion
  qemu-io: Relax 'alloc' now that block-status doesn't assert

 include/block/block.h      |  26 ++--
 include/block/block_int.h  |  11 +-
 block/io.c                 | 287 ++++++++++++++++++++---------------
 block/blkdebug.c           |  13 +-
 block/mirror.c             |  24 +--
 block/qcow2-cluster.c      |   2 +-
 block/qcow2.c              |  53 +++----
 qemu-img.c                 | 365 ++++++++++++++++++++-------------------------
 qemu-io-cmds.c             |  13 --
 block/trace-events         |   2 +-
 tests/qemu-iotests/074.out |   2 -
 tests/qemu-iotests/177     |  12 +-
 tests/qemu-iotests/177.out |  19 ++-
 13 files changed, 420 insertions(+), 409 deletions(-)

-- 
2.9.4
