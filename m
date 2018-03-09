Received: from eggs.gnu.org ([2001:4830:134:3::10]:33017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKke-0000ei-Go
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkd-0006TO-0G
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:37 +0100
Message-Id: <20180309161933.8168-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/56] Block layer patches
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

The following changes since commit d9bbfea646e86426d549bd612cd9f91e49aa50=
c2:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-upstream-v8=
.2' into staging (2018-03-09 10:58:57 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to a1be5921e35dcf84ce9e3c9a5c3029cea530a60b:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-03-09' into q=
ueue-block (2018-03-09 16:09:06 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (8):
      qcow2: Generalize validate_table_offset() into qcow2_validate_table=
()
      qcow2: Check L1 table offset in qcow2_snapshot_load_tmp()
      qcow2: Check L1 table parameters in qcow2_expand_zero_clusters()
      qcow2: Check snapshot L1 tables in qcow2_check_metadata_overlap()
      qcow2: Check snapshot L1 table in qcow2_snapshot_goto()
      qcow2: Check snapshot L1 table in qcow2_snapshot_delete()
      qcow2: Make qemu-img check detect corrupted L1 tables in snapshots
      iotests: Tweak 030 in order to trigger a race condition with parall=
el jobs

Daniel P. Berrang=C3=A9 (1):
      block: implement the bdrv_reopen_prepare helper for LUKS driver

Eric Blake (1):
      iotests: Mark all tests executable

Fam Zheng (2):
      iotests: Test creating overlay when guest running
      iotests: Skip test for ENOMEM error

Kevin Wolf (38):
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
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-03-09' in=
to queue-block

Paolo Bonzini (6):
      qcow2: introduce qcow2_write_caches and qcow2_flush_caches
      qcow2: fix flushing after dirty bitmap metadata writes
      qcow2: make qcow2_do_open a coroutine_fn
      qed: make bdrv_qed_do_open a coroutine_fn
      block: convert bdrv_invalidate_cache callback to coroutine_fn
      block: convert bdrv_check callback to coroutine_fn

Stefan Hajnoczi (1):
      qemu-iotests: fix 203 migration completion race

 qapi/block-core.json       | 326 +++++++++++++++++++++++++-
 block/qcow2.h              |  12 +-
 include/block/block.h      |   2 +
 include/block/block_int.h  |  13 +-
 include/qapi/qmp/qdict.h   |   6 +
 include/qemu/option.h      |   2 +
 block.c                    | 138 +++++++++++-
 block/create.c             |  76 +++++++
 block/crypto.c             |   7 +
 block/file-posix.c         |  93 +++++---
 block/file-win32.c         |  47 +++-
 block/gluster.c            | 135 +++++++----
 block/iscsi.c              |   6 +-
 block/nfs.c                | 244 +++++++++-----------
 block/parallels.c          |  17 +-
 block/qcow2-bitmap.c       |   4 +-
 block/qcow2-cluster.c      |  24 +-
 block/qcow2-refcount.c     |  52 ++++-
 block/qcow2-snapshot.c     |  24 +-
 block/qcow2.c              | 552 ++++++++++++++++++++++++++++-----------=
------
 block/qed-check.c          |   1 +
 block/qed-table.c          |  26 +--
 block/qed.c                |  66 ++++--
 block/rbd.c                | 403 +++++++++++++++++----------------
 block/sheepdog.c           | 321 ++++++++++++++++++--------
 block/ssh.c                | 290 +++++++++++++-----------
 block/vdi.c                |   6 +-
 block/vhdx.c               |   7 +-
 block/vmdk.c               |   7 +-
 qobject/qdict.c            |  34 +++
 tests/check-qdict.c        | 129 +++++++++++
 tests/test-qemu-opts.c     | 253 +++++++++++++++++++++
 util/qemu-option.c         |  42 +++-
 block/Makefile.objs        |   2 +-
 tests/qemu-iotests/030     |  52 ++++-
 tests/qemu-iotests/030.out |   4 +-
 tests/qemu-iotests/049.out |   8 +-
 tests/qemu-iotests/059     |   5 +-
 tests/qemu-iotests/080     |  22 +-
 tests/qemu-iotests/080.out |  58 ++++-
 tests/qemu-iotests/096     |   0
 tests/qemu-iotests/112.out |   4 +-
 tests/qemu-iotests/124     |   0
 tests/qemu-iotests/129     |   0
 tests/qemu-iotests/132     |   0
 tests/qemu-iotests/136     |   0
 tests/qemu-iotests/139     |   0
 tests/qemu-iotests/148     |   0
 tests/qemu-iotests/152     |   0
 tests/qemu-iotests/153     |   8 +-
 tests/qemu-iotests/153.out |   7 +-
 tests/qemu-iotests/163     |   0
 tests/qemu-iotests/203     |  15 +-
 tests/qemu-iotests/203.out |   5 +
 tests/qemu-iotests/205     |   0
 tests/qemu-iotests/206     | 436 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/206.out | 209 +++++++++++++++++
 tests/qemu-iotests/207     | 261 +++++++++++++++++++++
 tests/qemu-iotests/207.out |  75 ++++++
 tests/qemu-iotests/group   |   2 +
 60 files changed, 3574 insertions(+), 964 deletions(-)
 create mode 100644 block/create.c
 mode change 100644 =3D> 100755 tests/qemu-iotests/096
 mode change 100644 =3D> 100755 tests/qemu-iotests/124
 mode change 100644 =3D> 100755 tests/qemu-iotests/129
 mode change 100644 =3D> 100755 tests/qemu-iotests/132
 mode change 100644 =3D> 100755 tests/qemu-iotests/136
 mode change 100644 =3D> 100755 tests/qemu-iotests/139
 mode change 100644 =3D> 100755 tests/qemu-iotests/148
 mode change 100644 =3D> 100755 tests/qemu-iotests/152
 mode change 100644 =3D> 100755 tests/qemu-iotests/163
 mode change 100644 =3D> 100755 tests/qemu-iotests/205
 create mode 100755 tests/qemu-iotests/206
 create mode 100644 tests/qemu-iotests/206.out
 create mode 100755 tests/qemu-iotests/207
 create mode 100644 tests/qemu-iotests/207.out
