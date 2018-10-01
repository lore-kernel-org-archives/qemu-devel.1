Received: from eggs.gnu.org ([2001:4830:134:3::10]:57397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qs-0002Ep-Qt
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g71qk-0006uZ-A0
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 13:19:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  1 Oct 2018 19:18:38 +0200
Message-Id: <20181001171901.11004-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/23] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 07f426c35eddd79388a23d11cb278600d7e3831d:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180926' into staging (2018-09-28 18:56:09 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to dd353157942a59c21da07da5ac8749a871f7c3ed:

  tests/test-bdrv-drain: Fix too late qemu_event_reset() (2018-10-01 19:13:55 +0200)

----------------------------------------------------------------
Block layer patches:

- qcow2 cache option default changes (Linux: 32 MB maximum, limited by
  whatever cache size can be made use of with the specific image;
  default cache-clean-interval of 10 minutes)
- reopen: Allow specifying unchanged child node references, and changing
  a few generic options (discard, detect-zeroes)
- Fix werror/rerror defaults for -device drive=<node-name>
- Test case fixes

----------------------------------------------------------------
Alberto Garcia (9):
      qemu-io: Fix writethrough check in reopen
      file-posix: x-check-cache-dropped should default to false on reopen
      block: Remove child references from bs->{options,explicit_options}
      block: Don't look for child references in append_open_options()
      block: Allow child references on reopen
      block: Forbid trying to change unsupported options during reopen
      file-posix: Forbid trying to change unsupported options during reopen
      block: Allow changing 'discard' on reopen
      block: Allow changing 'detect-zeroes' on reopen

Fam Zheng (1):
      file-posix: Include filename in locking error message

Kevin Wolf (3):
      block-backend: Set werror/rerror defaults in blk_new()
      test-replication: Lock AioContext around blk_unref()
      tests/test-bdrv-drain: Fix too late qemu_event_reset()

Leonid Bloch (10):
      qcow2: Options' documentation fixes
      include: Add a lookup table of sizes
      qcow2: Make sizes more humanly readable
      qcow2: Avoid duplication in setting the refcount cache size
      qcow2: Assign the L2 cache relatively to the image size
      qcow2: Increase the default upper limit on the L2 cache size
      qcow2: Resize the cache upon image resizing
      qcow2: Set the default cache-clean-interval to 10 minutes
      qcow2: Explicit number replaced by a constant
      qcow2: Fix cache-clean-interval documentation

 qapi/block-core.json       |   4 +-
 docs/qcow2-cache.txt       |  59 ++++++++++++--------
 block/qcow2.h              |  19 ++++---
 include/block/block.h      |   1 +
 include/qemu/units.h       |  55 ++++++++++++++++++
 block.c                    | 135 +++++++++++++++++++++++++++++----------------
 block/block-backend.c      |   3 +
 block/file-posix.c         |  19 +++++--
 block/qcow2.c              |  43 +++++++++------
 qemu-io-cmds.c             |   2 +-
 tests/test-bdrv-drain.c    |   4 +-
 tests/test-replication.c   |  11 ++++
 qemu-options.hx            |  12 ++--
 tests/qemu-iotests/067.out |   1 +
 tests/qemu-iotests/137     |   8 ++-
 tests/qemu-iotests/137.out |   4 +-
 tests/qemu-iotests/153.out |  76 ++++++++++++-------------
 tests/qemu-iotests/182.out |   2 +-
 18 files changed, 307 insertions(+), 151 deletions(-)
