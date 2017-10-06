Received: from eggs.gnu.org ([2001:4830:134:3::10]:55316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UxR-0008VV-GX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UxP-0002OL-Tt
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:28 +0200
Message-Id: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/54] Block layer patches
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

The following changes since commit a26a98dfb9d448d7234d931ae3720feddf6f0651:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20171006' into staging (2017-10-06 13:19:03 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to fc3fd63fc0573ffd2ee569591a2e7f6c7310fd18:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-10-06' into queue-block (2017-10-06 16:32:08 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Daniel P. Berrange (6):
      block: use 1 MB bounce buffers for crypto instead of 16KB
      crypto: expose encryption sector size in APIs
      block: fix data type casting for crypto payload offset
      block: convert crypto driver to bdrv_co_preadv|pwritev
      block: convert qcrypto_block_encrypt|decrypt to take bytes offset
      block: support passthrough of BDRV_REQ_FUA in crypto driver

Eric Blake (27):
      block: Typo fix in copy_on_readv()
      block: Make bdrv_img_create() size selection easier to read
      hbitmap: Rename serialization_granularity to serialization_align
      qcow2: Ensure bitmap serialization is aligned
      dirty-bitmap: Drop unused functions
      dirty-bitmap: Avoid size query failure during truncate
      dirty-bitmap: Change bdrv_dirty_bitmap_size() to report bytes
      dirty-bitmap: Track bitmap size by bytes
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
      qemu-io: Add -C for opening with copy-on-read
      block: Uniform handling of 0-length bdrv_get_block_status()
      iotests: Restore stty settings on completion
      block: Add blkdebug hook for copy-on-read
      block: Perform copy-on-read in loop
      iotests: Add test 197 for covering copy-on-read

Kevin Wolf (6):
      block: Introduce BdrvChildRole.update_filename
      commit: Support multiple roots above top node
      qemu-iotests: Allow QMP pretty printing in common.qemu
      qemu-iotests: Test commit block job where top has two parents
      commit: Remove overlay_bs
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-10-06' into queue-block

Max Reitz (1):
      iotests: Fix 195 if IMGFMT is part of TEST_DIR

Paolo Bonzini (10):
      qemu-iotests: remove dead code
      qemu-iotests: get rid of AWK_PROG
      qemu-iotests: move "check" code out of common.rc
      qemu-iotests: cleanup and fix search for programs
      qemu-iotests: limit non-_PROG-suffixed variables to common.rc
      qemu-iotests: do not include common.rc in "check"
      qemu-iotests: disintegrate more parts of common.config
      qemu-iotests: fix uninitialized variable
      qemu-iotests: get rid of $iam
      qemu-iotests: merge "check" and "common"

Pavel Butsykin (2):
      qcow2: fix return error code in qcow2_truncate()
      qcow2: truncate the tail of the image file after shrinking the image

Thomas Huth (1):
      hw/block/onenand: Remove dead code block

Vladimir Sementsov-Ogievskiy (2):
      block/mirror: check backing in bdrv_mirror_top_refresh_filename
      block/mirror: check backing in bdrv_mirror_top_flush

 qapi/block-core.json             |   5 +-
 block/qcow2.h                    |   1 +
 crypto/blockpriv.h               |   5 +-
 include/block/block.h            |   3 +-
 include/block/block_int.h        |   8 +-
 include/block/dirty-bitmap.h     |  43 +-
 include/crypto/block.h           |  29 +-
 include/qemu/hbitmap.h           |   8 +-
 block.c                          | 109 ++++--
 block/backup.c                   |   7 +-
 block/commit.c                   |  64 +--
 block/crypto.c                   | 130 +++---
 block/dirty-bitmap.c             | 134 ++-----
 block/io.c                       | 131 +++++--
 block/mirror.c                   |  88 ++---
 block/qcow.c                     |  11 +-
 block/qcow2-bitmap.c             |  62 +--
 block/qcow2-cluster.c            |   8 +-
 block/qcow2-refcount.c           |  22 ++
 block/qcow2.c                    |  53 ++-
 crypto/block-luks.c              |  18 +-
 crypto/block-qcow.c              |  13 +-
 crypto/block.c                   |  26 +-
 hw/block/onenand.c               |   4 -
 migration/block.c                |  12 +-
 qemu-io.c                        |  15 +-
 tests/test-hbitmap.c             |  10 +-
 util/hbitmap.c                   |   8 +-
 tests/qemu-iotests/030           |   4 -
 tests/qemu-iotests/039.out       |  10 +-
 tests/qemu-iotests/061.out       |   4 +-
 tests/qemu-iotests/137.out       |   2 +-
 tests/qemu-iotests/165           |   2 +-
 tests/qemu-iotests/191           | 153 ++++++++
 tests/qemu-iotests/191.out       | 827 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/195           |   7 +-
 tests/qemu-iotests/197           | 109 ++++++
 tests/qemu-iotests/197.out       |  26 ++
 tests/qemu-iotests/check         | 585 ++++++++++++++++++++++++---
 tests/qemu-iotests/common        | 459 ----------------------
 tests/qemu-iotests/common.config | 206 +---------
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/common.qemu   |  15 +-
 tests/qemu-iotests/common.rc     | 205 +++++-----
 tests/qemu-iotests/group         |   2 +
 45 files changed, 2333 insertions(+), 1311 deletions(-)
 create mode 100755 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out
 create mode 100755 tests/qemu-iotests/197
 create mode 100644 tests/qemu-iotests/197.out
 delete mode 100644 tests/qemu-iotests/common
