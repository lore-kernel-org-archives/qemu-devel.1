Received: from eggs.gnu.org ([2001:4830:134:3::10]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UTA-0002PW-2o
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2UT8-000792-OU
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:47:36 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 11 Oct 2017 22:46:56 -0500
Message-Id: <20171012034720.11947-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 00/24] make bdrv_get_block_status byte-based
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

Now that 2.11 is open, I'm rebasing/reposting the remaining patches.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (merged, commit 51b0a488)
part 2: dirty-bitmap (merged, commit ca759622)
part 3: bdrv_get_block_status (this series, v5 at [1])
part 4: .bdrv_co_block_status (v3 is posted [2], mostly reviewed, but needs rebase)

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v6

Based-on: <20171009215533.12530-1-mreitz@redhat.com>
([PATCH 0/3] qcow2: Fix preallocated truncation)
(or more precisely, based on Max' block branch that includes that
and other iotest patches, as I was hitting iotest failures without
that branch; however, I suspect that the dependency is weak enough
that this will apply just fine on master at the moment)

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00535.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03812.html

Since v5:
- rebase to master, since copy-on-read patches (commit 46174339) that
landed there conflict with v5
- tweak qcow2 is_zero() to not round unnecessarily [Kevin]
- major interface overhaul: instead of returning a sector-based
offset in a 64-bit return type (which then requires post-call
munging to get to byte offsets), return a byte-based offset via
a parameter. Lots of churn in the interdiff, but the end result
looks better [Kevin]
- other minor fixes pointed out during review, such as -O2 compilation,
improved comments, ...

001/24:[0031] [FC] 'block: Allow NULL file for bdrv_get_block_status()'
002/24:[0029] [FC] 'block: Add flag to avoid wasted work in bdrv_is_allocated()'
003/24:[----] [--] 'block: Make bdrv_round_to_clusters() signature more useful'
004/24:[0005] [FC] 'qcow2: Switch is_zero_sectors() to byte-based'
005/24:[----] [--] 'block: Switch bdrv_make_zero() to byte-based'
006/24:[----] [--] 'qemu-img: Switch get_block_status() to byte-based'
007/24:[0048] [FC] 'block: Convert bdrv_get_block_status() to bytes'
008/24:[0105] [FC] 'block: Switch bdrv_co_get_block_status() to byte-based'
009/24:[0037] [FC] 'block: Switch BdrvCoGetBlockStatusData to byte-based'
010/24:[0036] [FC] 'block: Switch bdrv_common_block_status_above() to byte-based'
011/24:[0056] [FC] 'block: Switch bdrv_co_get_block_status_above() to byte-based'
012/24:[0066] [FC] 'block: Convert bdrv_get_block_status_above() to bytes'
013/24:[----] [-C] 'qemu-img: Simplify logic in img_compare()'
014/24:[0002] [FC] 'qemu-img: Speed up compare on pre-allocated larger file'
015/24:[----] [--] 'qemu-img: Add find_nonzero()'
016/24:[----] [--] 'qemu-img: Drop redundant error message in compare'
017/24:[----] [--] 'qemu-img: Change check_empty_sectors() to byte-based'
018/24:[----] [--] 'qemu-img: Change compare_sectors() to be byte-based'
019/24:[----] [--] 'qemu-img: Change img_rebase() to be byte-based'
020/24:[0014] [FC] 'qemu-img: Change img_compare() to be byte-based'
021/24:[0055] [FC] 'block: Align block status requests'
022/24:[----] [--] 'block: Relax bdrv_aligned_preadv() assertion'
023/24:[down] 'qcow2: Relax is_zero() assertion'
024/24:[----] [--] 'qemu-io: Relax 'alloc' now that block-status doesn't assert'

Eric Blake (24):
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
  qcow2: Relax is_zero() assertion
  qemu-io: Relax 'alloc' now that block-status doesn't assert

 include/block/block.h      |  29 ++--
 include/block/block_int.h  |  11 +-
 block/io.c                 | 332 +++++++++++++++++++++++----------------
 block/blkdebug.c           |  13 +-
 block/mirror.c             |  26 ++--
 block/qcow2-cluster.c      |   2 +-
 block/qcow2.c              |  53 +++----
 qemu-img.c                 | 381 ++++++++++++++++++++-------------------------
 qemu-io-cmds.c             |  13 --
 block/trace-events         |   2 +-
 tests/qemu-iotests/074.out |   2 -
 tests/qemu-iotests/177     |  12 +-
 tests/qemu-iotests/177.out |  19 ++-
 13 files changed, 459 insertions(+), 436 deletions(-)

-- 
2.13.6
