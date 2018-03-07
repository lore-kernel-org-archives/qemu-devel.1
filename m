Received: from eggs.gnu.org ([2001:4830:134:3::10]:57415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eteIQ-0004Uq-Q0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eteIP-0004MO-D1
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 14:00:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Mar 2018 19:59:09 +0100
Message-Id: <20180307185946.29366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/37] x-blockdev-create for protocols and
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


v4:
- Rebased on top of a few conflicting series that have hit master
  meanwhile
- qcow2: Renamed qcow2_create2() to qcow2_co_create() while resolving
  the conflict from Paolo's series that renamed it to qcow2_co_create2()
- rbd: Further simplified qemu_rbd_mon_host() [Max]


git-backport-diff compared to v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/37:[----] [--] 'block/qapi: Introduce BlockdevCreateOptions'
002/37:[----] [--] 'block/qapi: Add qcow2 create options to schema'
003/37:[down] 'qcow2: Rename qcow2_co_create2() to qcow2_co_create()'
	-> this one is actually new
004/37:[0012] [FC] 'qcow2: Let qcow2_create() handle protocol layer'
005/37:[down] 'qcow2: Pass BlockdevCreateOptions to qcow2_co_create()'
006/37:[down] 'qcow2: Use BlockdevRef in qcow2_co_create()'
007/37:[down] 'qcow2: Use QCryptoBlockCreateOptions in qcow2_co_create()'
008/37:[down] 'qcow2: Handle full/falloc preallocation in qcow2_co_create()'
	-> just rebase with subject line changes
009/37:[----] [--] 'util: Add qemu_opts_to_qdict_filtered()'
010/37:[----] [--] 'test-qemu-opts: Test qemu_opts_append()'
011/37:[----] [--] 'test-qemu-opts: Test qemu_opts_to_qdict_filtered()'
012/37:[----] [--] 'qdict: Introduce qdict_rename_keys()'
013/37:[0005] [FC] 'qcow2: Use visitor for options in qcow2_create()'
014/37:[----] [--] 'block: Make bdrv_is_whitelisted() public'
015/37:[0011] [FC] 'block: x-blockdev-create QMP command'
016/37:[0006] [FC] 'file-posix: Support .bdrv_co_create'
017/37:[0006] [FC] 'file-win32: Support .bdrv_co_create'
018/37:[0018] [FC] 'gluster: Support .bdrv_co_create'
019/37:[----] [--] 'rbd: Fix use after free in qemu_rbd_set_keypairs() error path'
020/37:[----] [--] 'rbd: Factor out qemu_rbd_connect()'
021/37:[----] [--] 'rbd: Remove non-schema options from runtime_opts'
022/37:[0008] [FC] 'rbd: Pass BlockdevOptionsRbd to qemu_rbd_connect()'
023/37:[0022] [FC] 'rbd: Support .bdrv_co_create'
024/37:[----] [--] 'rbd: Assign s->snap/image_name in qemu_rbd_open()'
025/37:[----] [--] 'rbd: Use qemu_rbd_connect() in qemu_rbd_do_create()'
026/37:[----] [-C] 'nfs: Use QAPI options in nfs_client_open()'
027/37:[0006] [FC] 'nfs: Support .bdrv_co_create'
028/37:[----] [-C] 'sheepdog: QAPIfy "redundancy" create option'
029/37:[0009] [FC] 'sheepdog: Support .bdrv_co_create'
030/37:[0001] [FC] 'ssh: Use QAPI BlockdevOptionsSsh object'
031/37:[----] [--] 'ssh: QAPIfy host-key-check option'
032/37:[----] [-C] 'ssh: Pass BlockdevOptionsSsh to connect_to_ssh()'
033/37:[0035] [FC] 'ssh: Support .bdrv_co_create'
034/37:[----] [--] 'file-posix: Fix no-op bdrv_truncate() with falloc preallocation'
035/37:[----] [--] 'block: Fail bdrv_truncate() with negative size'
036/37:[----] [--] 'qemu-iotests: Test qcow2 over file image creation with QMP'
037/37:[----] [--] 'qemu-iotests: Test ssh image creation over QMP'Key:


Kevin Wolf (37):
  block/qapi: Introduce BlockdevCreateOptions
  block/qapi: Add qcow2 create options to schema
  qcow2: Rename qcow2_co_create2() to qcow2_co_create()
  qcow2: Let qcow2_create() handle protocol layer
  qcow2: Pass BlockdevCreateOptions to qcow2_co_create()
  qcow2: Use BlockdevRef in qcow2_co_create()
  qcow2: Use QCryptoBlockCreateOptions in qcow2_co_create()
  qcow2: Handle full/falloc preallocation in qcow2_co_create()
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
 include/block/block_int.h  |   5 +-
 include/qapi/qmp/qdict.h   |   6 +
 include/qemu/option.h      |   2 +
 block.c                    |  54 +++++-
 block/create.c             |  76 ++++++++
 block/file-posix.c         |  93 +++++++---
 block/file-win32.c         |  47 ++++-
 block/gluster.c            | 135 +++++++++-----
 block/nfs.c                | 238 +++++++++++--------------
 block/qcow2.c              | 383 +++++++++++++++++++++++++--------------
 block/rbd.c                | 397 ++++++++++++++++++++++-------------------
 block/sheepdog.c           | 321 +++++++++++++++++++++++----------
 block/ssh.c                | 290 ++++++++++++++++--------------
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
 27 files changed, 3056 insertions(+), 774 deletions(-)
 create mode 100644 block/create.c
 create mode 100755 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out
 create mode 100755 tests/qemu-iotests/207
 create mode 100644 tests/qemu-iotests/207.out

-- 
2.13.6
