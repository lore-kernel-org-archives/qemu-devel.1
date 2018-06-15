Received: from eggs.gnu.org ([2001:4830:134:3::10]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbM-0005qK-37
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTpbK-0003TL-R1
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:21:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Jun 2018 16:20:42 +0200
Message-Id: <20180615142108.27814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/26] Block layer patches
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

The following changes since commit 91fe7a376ad46e3cc5e82d418aad22173c948a3c:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-06-15 11:41:44 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 6266e900b8083945cb766b45c124fb3c42932cb3:

  block: Remove dead deprecation warning code (2018-06-15 14:49:44 +0200)

----------------------------------------------------------------
Block layer patches:

- Fix options that work only with -drive or -blockdev, but not with
  both, because of QDict type confusion
- rbd: Add options 'auth-client-required' and 'key-secret'
- Remove deprecated -drive options serial/addr/cyls/heads/secs/trans
- rbd, iscsi: Remove deprecated 'filename' option
- Fix 'qemu-img map' crash with unaligned image size
- Improve QMP documentation for jobs

----------------------------------------------------------------
Eric Blake (2):
      qemu-img: Fix assert when mapping unaligned raw file
      iotests: Add test 221 to catch qemu-img map regression

John Snow (2):
      jobs: fix stale wording
      jobs: fix verb references in docs

Kevin Wolf (4):
      block: Remove deprecated -drive geometry options
      block: Remove deprecated -drive option addr
      block: Remove deprecated -drive option serial
      block: Remove dead deprecation warning code

Markus Armbruster (17):
      rbd: Drop deprecated -drive parameter "filename"
      iscsi: Drop deprecated -drive parameter "filename"
      qobject: Move block-specific qdict code to block-qdict.c
      block: Fix -blockdev for certain non-string scalars
      block: Fix -drive for certain non-string scalars
      block: Clean up a misuse of qobject_to() in .bdrv_co_create_opts()
      block: Factor out qobject_input_visitor_new_flat_confused()
      block: Make remaining uses of qobject input visitor more robust
      block-qdict: Simplify qdict_flatten_qdict()
      block-qdict: Tweak qdict_flatten_qdict(), qdict_flatten_qlist()
      block-qdict: Clean up qdict_crumple() a bit
      block-qdict: Simplify qdict_is_list() some
      check-block-qdict: Rename qdict_flatten()'s variables for clarity
      check-block-qdict: Cover flattening of empty lists and dictionaries
      block: Fix -blockdev / blockdev-add for empty objects and arrays
      rbd: New parameter auth-client-required
      rbd: New parameter key-secret

Max Reitz (1):
      block: Add block-specific QDict header

 qapi/block-core.json       |  19 ++
 qapi/job.json              |  23 +-
 include/block/qdict.h      |  34 +++
 include/hw/block/block.h   |   1 -
 include/qapi/qmp/qdict.h   |  17 --
 include/sysemu/blockdev.h  |   3 -
 block.c                    |   1 +
 block/block-backend.c      |   1 -
 block/crypto.c             |  12 +-
 block/gluster.c            |   1 +
 block/iscsi.c              |  24 +-
 block/nbd.c                |  16 +-
 block/nfs.c                |   8 +-
 block/parallels.c          |  11 +-
 block/qcow.c               |  11 +-
 block/qcow2.c              |  11 +-
 block/qed.c                |  11 +-
 block/quorum.c             |   1 +
 block/rbd.c                |  85 +++---
 block/sheepdog.c           |  23 +-
 block/snapshot.c           |   1 +
 block/ssh.c                |  16 +-
 block/vdi.c                |   8 +-
 block/vhdx.c               |  11 +-
 block/vpc.c                |  11 +-
 block/vvfat.c              |   1 +
 block/vxhs.c               |   1 +
 blockdev.c                 | 111 +------
 device-hotplug.c           |   4 -
 hw/block/block.c           |  27 --
 hw/block/nvme.c            |   1 -
 hw/block/virtio-blk.c      |   1 -
 hw/ide/qdev.c              |   1 -
 hw/scsi/scsi-disk.c        |   1 -
 hw/usb/dev-storage.c       |   1 -
 qemu-img.c                 |   2 +-
 qobject/block-qdict.c      | 722 +++++++++++++++++++++++++++++++++++++++++++++
 qobject/qdict.c            | 628 ---------------------------------------
 tests/ahci-test.c          |   6 +-
 tests/check-block-qdict.c  | 690 +++++++++++++++++++++++++++++++++++++++++++
 tests/check-qdict.c        | 641 ----------------------------------------
 tests/check-qobject.c      |   1 +
 tests/hd-geo-test.c        |  37 +--
 tests/ide-test.c           |   8 +-
 tests/test-replication.c   |   1 +
 util/qemu-config.c         |   1 +
 MAINTAINERS                |   2 +
 hmp-commands.hx            |   1 -
 qemu-doc.texi              |  15 -
 qemu-options.hx            |  14 +-
 qobject/Makefile.objs      |   1 +
 tests/Makefile.include     |   4 +
 tests/qemu-iotests/221     |  60 ++++
 tests/qemu-iotests/221.out |  16 +
 tests/qemu-iotests/group   |   1 +
 55 files changed, 1692 insertions(+), 1668 deletions(-)
 create mode 100644 include/block/qdict.h
 create mode 100644 qobject/block-qdict.c
 create mode 100644 tests/check-block-qdict.c
 create mode 100755 tests/qemu-iotests/221
 create mode 100644 tests/qemu-iotests/221.out
