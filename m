Received: from eggs.gnu.org ([2001:4830:134:3::10]:37882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUr8-0000W7-4o
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUr6-0002WR-EL
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:54:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:28 +0100
Message-Id: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/36] x-blockdev-create for protocols and
 qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This series implements a minimal QMP command that allows to create an
image file on the protocol level or an image format on a given block
node.

Eventually, the interface is going to change to some kind of an async
command (possibly a (non-)block job), but that will require more work on
the job infrastructure first, so let's first QAPIfy image creation in
the block drivers. In this series, I'm going for a synchronous command
that is prefixed with x- for now.

This series converts qcow2 and all protocol drivers that allow an actual
image creation. This means that drivers which only check if the already
existing storage is good enough are not converted (e.g. host_device,
iscsi). The old behaviour was useful because 'qemu-img create' wants to
create both protocol and format layer, but with the separation in QMP,
you can just leave out the protocol layer creation when the device
already exists.

Please note that for some of the protocol drivers (gluster, rbd and
sheepdog) I don't have a test setup ready. For those, I only tested
with a fake server address to check that the option are parsed correctly
up to this point and an appropriate error is returned without crashing.

If you are a maintainer of one of these protocols and you are
interested in keeping image creation working for your protocol, you
probably want to test this series on a real setup and give me some
feedback. If you don't, I'll just merge the patches and hope that they
won't break anything.

v2:
- Patch 1 ('block/qapi: Introduce BlockdevCreateOptions'):
  Added nvme as unsupported driver

- Patch 8 ('util: Add qemu_opts_to_qdict_filtered'):
  Fixed use after free with QemuOpts that contained more than one option
  with the same name, documented the behaviour with them

- Patches 9 and 10 (new):
  Added unit tests for qemu_opts_append() and
  qemu_opts_to_qdict_filtered()

- Patch 11 ('qdict: Introduce qdict_rename_keys()'):
  Added unit test, improved documentation

- Patch 12 ('qcow2: Use visitor for options in qcow2_create()'):
  Improved commit message, removed unnecessary movement of declaration

- Patches 13 and 14 ('block: x-blockdev-create QMP command'):
  Move making bdrv_is_whitelisted() public into a separate patch,
  use read-write driver whitelist instead of read-only

- Patch 17 ('gluster: Support .bdrv_co_create'):
  Rebased on top of preallocated truncate

- Patches 18-24 ('rbd: Support .bdrv_co_create'):
  QAPIfied .bdrv_open() implementation so that it can be shared with
  .bdrv_co_create() and specified servers are actually used instead of
  silently ignored

- Patch 25 ('nfs: Use QAPI options in nfs_client_open()'):
  Fixed use of uninitialised variable in the error path

- Patch 27 ('sheepdog: QAPIfy "redundacy" create option'):
  Addressed FIXME to use qemu_strtol()

- Patch 28 ('sheepdog: Support .bdrv_co_create'):
  Renamed 'backing_file' to 'backing-file', rebased on top of
  preallocated truncate


git-backport-diff compared to v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/36:[0001] [FC] 'block/qapi: Introduce BlockdevCreateOptions'
002/36:[----] [-C] 'block/qapi: Add qcow2 create options to schema'
003/36:[----] [--] 'qcow2: Let qcow2_create() handle protocol layer'
004/36:[----] [--] 'qcow2: Pass BlockdevCreateOptions to qcow2_create2()'
005/36:[----] [-C] 'qcow2: Use BlockdevRef in qcow2_create2()'
006/36:[----] [--] 'qcow2: Use QCryptoBlockCreateOptions in qcow2_create2()'
007/36:[----] [--] 'qcow2: Handle full/falloc preallocation in qcow2_create2()'
008/36:[0007] [FC] 'util: Add qemu_opts_to_qdict_filtered()'
009/36:[down] 'test-qemu-opts: Test qemu_opts_append()'
010/36:[down] 'test-qemu-opts: Test qemu_opts_to_qdict_filtered()'
011/36:[0117] [FC] 'qdict: Introduce qdict_rename_keys()'
012/36:[0002] [FC] 'qcow2: Use visitor for options in qcow2_create()'
013/36:[down] 'block: Make bdrv_is_whitelisted() public'
014/36:[0006] [FC] 'block: x-blockdev-create QMP command'
015/36:[----] [-C] 'file-posix: Support .bdrv_co_create'
016/36:[----] [--] 'file-win32: Support .bdrv_co_create'
017/36:[0130] [FC] 'gluster: Support .bdrv_co_create'
018/36:[down] 'rbd: Fix use after free in qemu_rbd_set_keypairs() error path'
019/36:[down] 'rbd: Factor out qemu_rbd_connect()'
020/36:[down] 'rbd: Remove non-schema options from runtime_opts'
021/36:[down] 'rbd: Pass BlockdevOptionsRbd to qemu_rbd_connect()'
022/36:[0034] [FC] 'rbd: Support .bdrv_co_create'
023/36:[down] 'rbd: Assing s->snap/image_name in qemu_rbd_open()'
024/36:[down] 'rbd: Use qemu_rbd_connect() in qemu_rbd_do_create()'
025/36:[0002] [FC] 'nfs: Use QAPI options in nfs_client_open()'
026/36:[----] [-C] 'nfs: Support .bdrv_co_create'
027/36:[0013] [FC] 'sheepdog: QAPIfy "redundacy" create option'
028/36:[0049] [FC] 'sheepdog: Support .bdrv_co_create'
029/36:[----] [-C] 'ssh: Use QAPI BlockdevOptionsSsh object'
030/36:[----] [-C] 'ssh: QAPIfy host-key-check option'
031/36:[----] [--] 'ssh: Pass BlockdevOptionsSsh to connect_to_ssh()'
032/36:[----] [--] 'ssh: Support .bdrv_co_create'
033/36:[----] [--] 'file-posix: Fix no-op bdrv_truncate() with falloc preallocation'
034/36:[----] [--] 'block: Fail bdrv_truncate() with negative size'
035/36:[----] [--] 'qemu-iotests: Test qcow2 over file image creation with QMP'
036/36:[----] [--] 'qemu-iotests: Test ssh image creation over QMP'


Kevin Wolf (36):
  block/qapi: Introduce BlockdevCreateOptions
  block/qapi: Add qcow2 create options to schema
  qcow2: Let qcow2_create() handle protocol layer
  qcow2: Pass BlockdevCreateOptions to qcow2_create2()
  qcow2: Use BlockdevRef in qcow2_create2()
  qcow2: Use QCryptoBlockCreateOptions in qcow2_create2()
  qcow2: Handle full/falloc preallocation in qcow2_create2()
  util: Add qemu_opts_to_qdict_filtered()
  test-qemu-opts: Test qemu_opts_append()
  test-qemu-opts: Test qemu_opts_to_qdict_filtered()
  qdict: Introduce qdict_rename_keys()
  qcow2: Use visitor for options in qcow2_create()
  block: Make bdrv_is_whitelisted() public
  block: x-blockdev-create QMP command
  file-posix: Support .bdrv_co_create
  file-win32: Support .bdrv_co_create
  gluster: Support .bdrv_co_create
  rbd: Fix use after free in qemu_rbd_set_keypairs() error path
  rbd: Factor out qemu_rbd_connect()
  rbd: Remove non-schema options from runtime_opts
  rbd: Pass BlockdevOptionsRbd to qemu_rbd_connect()
  rbd: Support .bdrv_co_create
  rbd: Assing s->snap/image_name in qemu_rbd_open()
  rbd: Use qemu_rbd_connect() in qemu_rbd_do_create()
  nfs: Use QAPI options in nfs_client_open()
  nfs: Support .bdrv_co_create
  sheepdog: QAPIfy "redundacy" create option
  sheepdog: Support .bdrv_co_create
  ssh: Use QAPI BlockdevOptionsSsh object
  ssh: QAPIfy host-key-check option
  ssh: Pass BlockdevOptionsSsh to connect_to_ssh()
  ssh: Support .bdrv_co_create
  file-posix: Fix no-op bdrv_truncate() with falloc preallocation
  block: Fail bdrv_truncate() with negative size
  qemu-iotests: Test qcow2 over file image creation with QMP
  qemu-iotests: Test ssh image creation over QMP

 qapi/block-core.json       | 326 ++++++++++++++++++++++++++++++++-
 include/block/block.h      |   2 +
 include/block/block_int.h  |   2 +
 include/qapi/qmp/qdict.h   |   6 +
 include/qemu/option.h      |   2 +
 block.c                    |  54 +++++-
 block/create.c             |  76 ++++++++
 block/file-posix.c         |  91 +++++++---
 block/file-win32.c         |  45 ++++-
 block/gluster.c            | 135 +++++++++-----
 block/nfs.c                | 236 +++++++++++-------------
 block/qcow2.c              | 384 +++++++++++++++++++++++++--------------
 block/rbd.c                | 380 +++++++++++++++++++++------------------
 block/sheepdog.c           | 318 +++++++++++++++++++++++----------
 block/ssh.c                | 298 +++++++++++++++++--------------
 qobject/qdict.c            |  34 ++++
 tests/check-qdict.c        | 113 ++++++++++++
 tests/test-qemu-opts.c     | 253 ++++++++++++++++++++++++++
 util/qemu-option.c         |  42 ++++-
 block/Makefile.objs        |   2 +-
 tests/qemu-iotests/049.out |   8 +-
 tests/qemu-iotests/112.out |   4 +-
 tests/qemu-iotests/206     | 436 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/206.out | 209 ++++++++++++++++++++++
 tests/qemu-iotests/207     | 261 +++++++++++++++++++++++++++
 tests/qemu-iotests/207.out |  75 ++++++++
 tests/qemu-iotests/group   |   2 +
 27 files changed, 3030 insertions(+), 764 deletions(-)
 create mode 100644 block/create.c
 create mode 100755 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out
 create mode 100755 tests/qemu-iotests/207
 create mode 100644 tests/qemu-iotests/207.out

-- 
2.13.6
