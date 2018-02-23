Received: from eggs.gnu.org ([2001:4830:134:3::10]:49902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIz0-0000aB-Ss
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epIyz-00049H-6p
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:26:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Feb 2018 20:25:13 +0100
Message-Id: <20180223192549.26666-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/36] x-blockdev-create for protocols and
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


v3:
- Patch 11 ('qdict: Introduce qdict_rename_keys()'):
  Additional assertion in each test case [Eric]
  Fixed typo in comment [Max]

- Patch 21 ('rbd: Pass BlockdevOptionsRbd to qemu_rbd_connect()'):
  Removed NULL check that is redundant with schema validation [Max]
  Fixed memory leaks on the error path [Max]

- Patch 23 ('rbd: Assing s->snap/image_name in qemu_rbd_open()'):
  Fixed typo in the subject line

- Patch 24 ('rbd: Use qemu_rbd_connect() in qemu_rbd_do_create()'):
  Don't ignore password_secret, but pass it to qemu_rbd_connect() [Max]

- Patch 27 ('sheepdog: QAPIfy "redundacy" create option'):
  Fixed typo in the subject line and commit message

- Patch 28 ('sheepdog: Support .bdrv_co_create'):
  Set the 'driver' option for bdrv_open() [Max]


git-backport-diff compared to v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/36:[----] [--] 'block/qapi: Introduce BlockdevCreateOptions'
002/36:[----] [--] 'block/qapi: Add qcow2 create options to schema'
003/36:[----] [--] 'qcow2: Let qcow2_create() handle protocol layer'
004/36:[----] [--] 'qcow2: Pass BlockdevCreateOptions to qcow2_create2()'
005/36:[----] [--] 'qcow2: Use BlockdevRef in qcow2_create2()'
006/36:[----] [--] 'qcow2: Use QCryptoBlockCreateOptions in qcow2_create2()'
007/36:[----] [--] 'qcow2: Handle full/falloc preallocation in qcow2_create2()'
008/36:[----] [--] 'util: Add qemu_opts_to_qdict_filtered()'
009/36:[----] [--] 'test-qemu-opts: Test qemu_opts_append()'
010/36:[----] [--] 'test-qemu-opts: Test qemu_opts_to_qdict_filtered()'
011/36:[0018] [FC] 'qdict: Introduce qdict_rename_keys()'
012/36:[----] [--] 'qcow2: Use visitor for options in qcow2_create()'
013/36:[----] [--] 'block: Make bdrv_is_whitelisted() public'
014/36:[----] [--] 'block: x-blockdev-create QMP command'
015/36:[----] [--] 'file-posix: Support .bdrv_co_create'
016/36:[----] [--] 'file-win32: Support .bdrv_co_create'
017/36:[----] [--] 'gluster: Support .bdrv_co_create'
018/36:[----] [--] 'rbd: Fix use after free in qemu_rbd_set_keypairs() error path'
019/36:[----] [--] 'rbd: Factor out qemu_rbd_connect()'
020/36:[----] [--] 'rbd: Remove non-schema options from runtime_opts'
021/36:[0013] [FC] 'rbd: Pass BlockdevOptionsRbd to qemu_rbd_connect()'
022/36:[----] [--] 'rbd: Support .bdrv_co_create'
023/36:[down] 'rbd: Assign s->snap/image_name in qemu_rbd_open()'
024/36:[0002] [FC] 'rbd: Use qemu_rbd_connect() in qemu_rbd_do_create()'
025/36:[----] [--] 'nfs: Use QAPI options in nfs_client_open()'
026/36:[----] [--] 'nfs: Support .bdrv_co_create'
027/36:[down] 'sheepdog: QAPIfy "redundancy" create option'
028/36:[0002] [FC] 'sheepdog: Support .bdrv_co_create'
029/36:[----] [--] 'ssh: Use QAPI BlockdevOptionsSsh object'
030/36:[----] [--] 'ssh: QAPIfy host-key-check option'
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
  rbd: Assign s->snap/image_name in qemu_rbd_open()
  rbd: Use qemu_rbd_connect() in qemu_rbd_do_create()
  nfs: Use QAPI options in nfs_client_open()
  nfs: Support .bdrv_co_create
  sheepdog: QAPIfy "redundancy" create option
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
 block/rbd.c                | 387 +++++++++++++++++++++-------------------
 block/sheepdog.c           | 320 +++++++++++++++++++++++----------
 block/ssh.c                | 298 +++++++++++++++++--------------
 qobject/qdict.c            |  34 ++++
 tests/check-qdict.c        | 129 ++++++++++++++
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
 27 files changed, 3049 insertions(+), 770 deletions(-)
 create mode 100644 block/create.c
 create mode 100755 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out
 create mode 100755 tests/qemu-iotests/207
 create mode 100644 tests/qemu-iotests/207.out

-- 
2.13.6
