Received: from eggs.gnu.org ([2001:4830:134:3::10]:33029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cD-0006i0-2y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cB-0005sm-K0
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:43:56 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:17 +0100
Message-Id: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 00/31] block: Fix some filename generation
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Once more, I=E2=80=99ll spare both me and you another iteration of the co=
ver
letter, so I direct you to the previous version=E2=80=99s cover letter (w=
hich
will direct you further):

http://lists.nongnu.org/archive/html/qemu-block/2018-10/msg00229.html

There are only minor changes in this version.  Provided no major
complaints arise, I intend to merge this series in the next month.


git-backport-diff against v11:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/31:[0015] [FC] 'block: Use bdrv_refresh_filename() to pull'
002/31:[----] [--] 'block: Use children list in bdrv_refresh_filename'
003/31:[----] [--] 'block: Skip implicit nodes for filename info'
004/31:[----] [--] 'block: Add BDS.auto_backing_file'
005/31:[----] [--] 'block: Respect backing bs in bdrv_refresh_filename'
006/31:[----] [--] 'iotests.py: Add filter_imgfmt()'
007/31:[----] [--] 'iotests.py: Add node_info()'
008/31:[0072] [FC] 'iotests: Add test for backing file overrides'
009/31:[----] [--] 'block: Make path_combine() return the path'
010/31:[----] [-C] 'block: bdrv_get_full_backing_filename_from_...'s ret.=
 val.'
011/31:[----] [--] 'block: bdrv_get_full_backing_filename's ret. val.'
012/31:[----] [--] 'block: Add bdrv_make_absolute_filename()'
013/31:[----] [--] 'block: Fix bdrv_find_backing_image()'
014/31:[----] [--] 'block: Add bdrv_dirname()'
015/31:[----] [--] 'blkverify: Make bdrv_dirname() return NULL'
016/31:[----] [--] 'quorum: Make bdrv_dirname() return NULL'
017/31:[----] [--] 'block/nbd: Make bdrv_dirname() return NULL'
018/31:[----] [--] 'block/nfs: Implement bdrv_dirname()'
019/31:[----] [--] 'block: Use bdrv_dirname() for relative filenames'
020/31:[----] [--] 'iotests: Add quorum case to test 110'
021/31:[----] [--] 'block: Add strong_runtime_opts to BlockDriver'
022/31:[----] [--] 'block: Add BlockDriver.bdrv_gather_child_options'
023/31:[----] [--] 'block: Generically refresh runtime options'
024/31:[----] [--] 'block: Purify .bdrv_refresh_filename()'
025/31:[----] [--] 'block: Do not copy exact_filename from format file'
026/31:[----] [--] 'block/nvme: Fix bdrv_refresh_filename()'
027/31:[----] [--] 'block/curl: Harmonize option defaults'
028/31:[----] [--] 'block/curl: Implement bdrv_refresh_filename()'
029/31:[----] [--] 'block/null: Generate filename even with latency-ns'
030/31:[----] [--] 'block: BDS options may lack the "driver" option'
031/31:[0024] [FC] 'iotests: Test json:{} filenames of internal BDSs'


v12:
- Patch 1:
  - Due to rebase, one hunk was dropped (vpc has one instance of
    "bs->filename" less)
  - I grepped through everything ("->filename") again and noticed I did
    not refresh the filename before qemu-img.c's accesses to
    bs->filename.  Now it probably isn't necessary to do this (because
    we don't use complex graph features there, and even more so no graph
    modifications can occur at runtime), but then again I believe it
    doesn't hurt to refresh the filename even here.
    So there are four additional hunks in qemu-img.c now.
- Patches 8 and 31:
  Had to adjust the reference output due to the Python2/3 compatibility
  patches (kept the R-b, because the changes are obvious, I believe)


Max Reitz (31):
  block: Use bdrv_refresh_filename() to pull
  block: Use children list in bdrv_refresh_filename
  block: Skip implicit nodes for filename info
  block: Add BDS.auto_backing_file
  block: Respect backing bs in bdrv_refresh_filename
  iotests.py: Add filter_imgfmt()
  iotests.py: Add node_info()
  iotests: Add test for backing file overrides
  block: Make path_combine() return the path
  block: bdrv_get_full_backing_filename_from_...'s ret. val.
  block: bdrv_get_full_backing_filename's ret. val.
  block: Add bdrv_make_absolute_filename()
  block: Fix bdrv_find_backing_image()
  block: Add bdrv_dirname()
  blkverify: Make bdrv_dirname() return NULL
  quorum: Make bdrv_dirname() return NULL
  block/nbd: Make bdrv_dirname() return NULL
  block/nfs: Implement bdrv_dirname()
  block: Use bdrv_dirname() for relative filenames
  iotests: Add quorum case to test 110
  block: Add strong_runtime_opts to BlockDriver
  block: Add BlockDriver.bdrv_gather_child_options
  block: Generically refresh runtime options
  block: Purify .bdrv_refresh_filename()
  block: Do not copy exact_filename from format file
  block/nvme: Fix bdrv_refresh_filename()
  block/curl: Harmonize option defaults
  block/curl: Implement bdrv_refresh_filename()
  block/null: Generate filename even with latency-ns
  block: BDS options may lack the "driver" option
  iotests: Test json:{} filenames of internal BDSs

 include/block/block.h         |  16 +-
 include/block/block_int.h     |  48 +++-
 block.c                       | 503 ++++++++++++++++++++++------------
 block/blkdebug.c              |  70 ++---
 block/blklogwrites.c          |  34 +--
 block/blkverify.c             |  29 +-
 block/commit.c                |   3 +-
 block/crypto.c                |   8 +
 block/curl.c                  |  55 +++-
 block/gluster.c               |  19 ++
 block/iscsi.c                 |  18 ++
 block/mirror.c                |   3 +-
 block/nbd.c                   |  46 ++--
 block/nfs.c                   |  54 ++--
 block/null.c                  |  32 ++-
 block/nvme.c                  |  27 +-
 block/qapi.c                  |  16 +-
 block/qcow.c                  |  14 +-
 block/qcow2.c                 |  17 +-
 block/qed.c                   |   7 +-
 block/quorum.c                |  71 +++--
 block/raw-format.c            |  11 +-
 block/rbd.c                   |  14 +
 block/replication.c           |  10 +-
 block/sheepdog.c              |  12 +
 block/ssh.c                   |  12 +
 block/throttle.c              |   7 +
 block/vhdx-log.c              |   1 +
 block/vmdk.c                  |  43 ++-
 block/vpc.c                   |   7 +
 block/vvfat.c                 |  12 +
 block/vxhs.c                  |  11 +
 blockdev.c                    |   8 +
 qemu-img.c                    |  23 +-
 tests/qemu-iotests/051.out    |   8 +-
 tests/qemu-iotests/051.pc.out |   8 +-
 tests/qemu-iotests/110        |  29 +-
 tests/qemu-iotests/110.out    |   9 +-
 tests/qemu-iotests/224        | 139 ++++++++++
 tests/qemu-iotests/224.out    |  18 ++
 tests/qemu-iotests/228        | 235 ++++++++++++++++
 tests/qemu-iotests/228.out    |  84 ++++++
 tests/qemu-iotests/group      |   2 +
 tests/qemu-iotests/iotests.py |  10 +
 44 files changed, 1398 insertions(+), 405 deletions(-)
 create mode 100755 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out
 create mode 100755 tests/qemu-iotests/228
 create mode 100644 tests/qemu-iotests/228.out

--=20
2.19.2
