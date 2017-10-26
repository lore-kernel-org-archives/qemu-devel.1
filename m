Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2l-0008WN-0T
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2j-0001WY-Oy
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:17:54 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:06 +0200
Message-Id: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/35] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit ae49fbbcd8e4e9d8bf7131add34773f579e1aff7:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171025' into staging (2017-10-25 16:38:57 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4254d01ce4eec9a3ccf320d14e2da132b8ad4a51:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-10-26' into queue-block (2017-10-26 15:02:40 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Use BDRV_SECTOR_BITS instead of its literal value

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
      block: Reduce bdrv_aligned_preadv() rounding
      qcow2: Reduce is_zero() rounding
      qemu-io: Relax 'alloc' now that block-status doesn't assert

Kevin Wolf (2):
      qemu-iotests: Test backing_fmt with backing node reference
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-10-26' into queue-block

Max Reitz (8):
      qemu-img.1: Image invalidation on qemu-img commit
      iotests: Add test for dataplane mirroring
      iotests: Pull _filter_actual_image_size from 67/87
      iotests: Filter actual image size in 184 and 191
      qcow2: Emit errp when truncating the image tail
      qcow2: Fix unaligned preallocated truncation
      qcow2: Always execute preallocate() in a coroutine
      iotests: Add cluster_size=64k to 125

Peter Krempa (1):
      block: don't add 'driver' to options when referring to backing via node name

 include/block/block.h            |  29 ++-
 include/block/block_int.h        |  11 +-
 block.c                          |   3 +-
 block/blkdebug.c                 |  13 +-
 block/io.c                       | 334 ++++++++++++++++-----------
 block/mirror.c                   |  26 +--
 block/qcow2-cluster.c            |   2 +-
 block/qcow2.c                    | 116 ++++++----
 qemu-img.c                       | 381 ++++++++++++++-----------------
 qemu-io-cmds.c                   |  13 --
 block/trace-events               |   2 +-
 qemu-img.texi                    |   9 +-
 tests/qemu-iotests/067           |   2 +-
 tests/qemu-iotests/074.out       |   2 -
 tests/qemu-iotests/087           |   2 +-
 tests/qemu-iotests/125           |   7 +-
 tests/qemu-iotests/125.out       | 480 +++++++++++++++++++++++++++++++++++----
 tests/qemu-iotests/127           |  97 ++++++++
 tests/qemu-iotests/127.out       |  14 ++
 tests/qemu-iotests/177           |  12 +-
 tests/qemu-iotests/177.out       |  19 +-
 tests/qemu-iotests/184           |   3 +-
 tests/qemu-iotests/184.out       |   6 +-
 tests/qemu-iotests/191           |   7 +-
 tests/qemu-iotests/191.out       |  48 ++--
 tests/qemu-iotests/common.filter |   6 +
 tests/qemu-iotests/group         |   1 +
 27 files changed, 1102 insertions(+), 543 deletions(-)
 create mode 100755 tests/qemu-iotests/127
 create mode 100644 tests/qemu-iotests/127.out
