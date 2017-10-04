Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ08-0000nn-1Y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzZ06-00060A-Fm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:01:32 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  3 Oct 2017 21:00:25 -0500
Message-Id: <20171004020048.26379-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/23] make bdrv_get_block_status byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

Now that 2.11 is open, I'm rebasing/reposting the remaining patches.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488)
part 2: dirty-bitmap (v10 is queued [1])
part 3: bdrv_get_block_status (this series, v4 at [2])
part 4: .bdrv_co_block_status (v3 is posted [4], mostly reviewed)

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v4

Based-on: <20170925145526.32690-1-eblake@redhat.com>
([PATCH v10 00/20] make dirty-bitmap byte-based)
Based-on: <20171004014347.25099-1-eblake@redhat.com>
([PATCH v2 0/5] block: Avoid copy-on-read assertions)

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06848.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03543.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03812.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00524.html

Since v4:
- rebase to fixes for copy-on-read
- tweak bdrv_co_block_status goto/label usage for easier reading [John]
- more added comments and improved commit messages
- fix a couple of bugs, such as wrong trace-events usage
- add R-b where things didn't change drastically

001/23:[0042] [FC] 'block: Allow NULL file for bdrv_get_block_status()'
002/23:[0006] [FC] 'block: Add flag to avoid wasted work in bdrv_is_allocated()'
003/23:[0003] [FC] 'block: Make bdrv_round_to_clusters() signature more useful'
004/23:[----] [--] 'qcow2: Switch is_zero_sectors() to byte-based'
005/23:[----] [--] 'block: Switch bdrv_make_zero() to byte-based'
006/23:[----] [--] 'qemu-img: Switch get_block_status() to byte-based'
007/23:[0010] [FC] 'block: Convert bdrv_get_block_status() to bytes'
008/23:[0042] [FC] 'block: Switch bdrv_co_get_block_status() to byte-based'
009/23:[----] [--] 'block: Switch BdrvCoGetBlockStatusData to byte-based'
010/23:[----] [--] 'block: Switch bdrv_common_block_status_above() to byte-based'
011/23:[----] [-C] 'block: Switch bdrv_co_get_block_status_above() to byte-based'
012/23:[0019] [FC] 'block: Convert bdrv_get_block_status_above() to bytes'
013/23:[0008] [FC] 'qemu-img: Simplify logic in img_compare()'
014/23:[----] [--] 'qemu-img: Speed up compare on pre-allocated larger file'
015/23:[----] [--] 'qemu-img: Add find_nonzero()'
016/23:[----] [--] 'qemu-img: Drop redundant error message in compare'
017/23:[----] [--] 'qemu-img: Change check_empty_sectors() to byte-based'
018/23:[----] [--] 'qemu-img: Change compare_sectors() to be byte-based'
019/23:[----] [--] 'qemu-img: Change img_rebase() to be byte-based'
020/23:[0005] [FC] 'qemu-img: Change img_compare() to be byte-based'
021/23:[0061] [FC] 'block: Align block status requests'
022/23:[----] [--] 'block: Relax bdrv_aligned_preadv() assertion'
023/23:[----] [--] 'qemu-io: Relax 'alloc' now that block-status doesn't assert'

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
 block/io.c                 | 303 +++++++++++++++++++++----------------
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
 13 files changed, 431 insertions(+), 414 deletions(-)

-- 
2.13.6
