Received: from eggs.gnu.org ([2001:4830:134:3::10]:55717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cf-0007PY-Es
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9ce-0004JQ-6d
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:41 -0500
Message-Id: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/15] make bdrv_get_block_status byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr

There are patches floating around to add NBD_CMD_BLOCK_STATUS,
but NBD wants to report status on byte granularity (even if the
reporting will probably be naturally aligned to sectors or even
much higher levels).  I've therefore started the task of
converting our block status code to report at a byte granularity
rather than sectors.

The overall conversion currently looks like:
part 1: bdrv_is_allocated (v3 is reviewed [1], modulo vvfat whitespace changes)
part 2: dirty-bitmap (v4 is posted [2]; v2 was reviewed but rebase changes
mean more review is needed)
part 3: this series, for bdrv_get_block_status (first half of v1, at [3],
did not get much review)
part 4: upcoming series, for .bdrv_co_block_status (second half of v1 [3])

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v2

It is based on the union of Max's and Kevin's block branches,
plus posted fixes that make iotest 55 pass.

The diffstat shows a net growth in line count, but some of that is due
to better comments, and some because the code is a bit longer in order
to handle differing alignments between caller and driver.

I still haven't felt like tackling the task of rewriting migration/block.c
and qemu-img.c to use bytes (instead of sectors) everywhere - that might
give another net win in lines of code and legibility.

Patch 1/15 isn't really mine; Manos will probably be posting a v3
of his series, which should be committed before mine [4].

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06077.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00269.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html
[4] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06846.html

Since v1: rebase against lots of upstream churn; add patches to support
arbitrary alignments and test them. I also split the original v1 series
(31 patches) into two halves, where teaching the individual drivers
about byte-level granularity is now going to be a fourth series (I'll
post a 16/15 RFC patch to show the interface that will use)

001/15:[down] 'block: add default implementations for bdrv_co_get_block_status()'
002/15:[down] 'block: Allow NULL file for bdrv_get_block_status()'
003/15:[down] 'block: Add flag to avoid wasted work in bdrv_is_allocated()'
004/15:[0002] [FC] 'block: Make bdrv_round_to_clusters() signature more useful'
005/15:[0018] [FC] 'qcow2: Switch is_zero_sectors() to byte-based'
006/15:[0004] [FC] 'block: Switch bdrv_make_zero() to byte-based'
007/15:[----] [--] 'qemu-img: Switch get_block_status() to byte-based'
008/15:[0058] [FC] 'block: Convert bdrv_get_block_status() to bytes'
009/15:[0064] [FC] 'block: Switch bdrv_co_get_block_status() to byte-based'
010/15:[0001] [FC] 'block: Switch BdrvCoGetBlockStatusData to byte-based'
011/15:[down] 'block: Switch bdrv_common_block_status_above() to byte-based'
012/15:[0010] [FC] 'block: Switch bdrv_co_get_block_status_above() to byte-based'
013/15:[0063] [FC] 'block: Convert bdrv_get_block_status_above() to bytes'
014/15:[down] 'block: Align block status requests'
015/15:[down] 'qemu-io: Relax 'alloc' now that block-status doesn't assert'

Eric Blake (14):
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
  block: Align block status requests
  qemu-io: Relax 'alloc' now that block-status doesn't assert

Manos Pitsidianakis (1):
  block: add default implementations for bdrv_co_get_block_status()

 include/block/block.h      |  26 ++--
 include/block/block_int.h  |  27 +++-
 block/blkdebug.c           |   9 +-
 block/commit.c             |  12 +-
 block/io.c                 | 302 ++++++++++++++++++++++++++++-----------------
 block/mirror.c             |  32 ++---
 block/qcow2-cluster.c      |   2 +-
 block/qcow2.c              |  34 ++---
 qemu-img.c                 |  71 ++++++-----
 qemu-io-cmds.c             |  13 --
 block/trace-events         |   2 +-
 tests/qemu-iotests/177     |  11 +-
 tests/qemu-iotests/177.out |  18 ++-
 13 files changed, 317 insertions(+), 242 deletions(-)

-- 
2.9.4
