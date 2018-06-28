Received: from eggs.gnu.org ([2001:4830:134:3::10]:57469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTb-0004Le-RP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTa-0003jo-7h
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:07:55 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:14 +0200
Message-Id: <20180628000745.4477-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 00/31] block: Fix some filename generation
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Once more, I=E2=80=99ll spare both me and you another iteration of the co=
ver
letter, so see here:

http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html

(Although this series no longer includes a @base-directory option.)

In regards to the last version, the biggest change is that I dropped
backing_overridden and instead try to compare the filename from the
image header with the filename of the actual backing BDS to find out
whether the backing file has been overridden.

In order that this doesn=E2=80=99t break whenever the header contains a s=
lightly
unusual (=E2=80=9Cnon-canonical=E2=80=9D) backing filename (e.g. =E2=80=9C=
file:foo.qcow2=E2=80=9D or
=E2=80=9Cnbd:localhost:10809=E2=80=9D instead of =E2=80=9Cnbd://localhost=
:10809=E2=80=9D, i.e. something
different from what bdrv_refresh_filename() would generate), when the
reference filename in the BDS (auto_backing_file) is used to open the
backing file, it is updated from the backing BDS's resulting filename.


All (I hope) changes in v9:
- Rebase (warranting an NVME patch)

- Dropped backing_overridden, switched to the comparison described above
  (and dealt with the fallout, for example test 191 can now stay
  unchanged)

- Removed all existing bdrv_refresh_filename() calls and moved them to
  the users of BDS.filename (first patch) -- otherwise, I got iotest
  failure (because it's hard to reflect all graph changes properly with
  a =E2=80=9Cpushing=E2=80=9D bdrv_refresh_filename()), and I don't even =
want to
  remember how 191 broke without this change.

- Renamed =E2=80=9Csignificant options=E2=80=9D to =E2=80=9Cstrong option=
s=E2=80=9D

- Implicit nodes should be completely skipped in
  bdrv_refresh_filename(), including setting of bs->full_open_options
  (patch 3)

- vmdk_gather_child_options() failed to set backing=3Dnull when the image
  header asked for a backing file, but the user forbid its use

- Added the penultimate patch which makes json:{} filenames for explicit
  internal nodes kind of working?
  (When you specify @filter-node e.g. for block-commit, the node should
  be visible, so it may appear in a json:{} filename; but creating that
  node did not take a real options QDict, so it was lacking the @driver
  option, and that was a bit sad.)

- Dropped a superfluous =E2=80=9Csuspend.=E2=80=9D in blkdebug

- Dropped the first patch of v8

- Restyled some comments (=E2=80=9C/*=E2=80=9D on its own line where =E2=80=
=9C*/=E2=80=9D is on its own
  line)

- Fixed mention of "NBD" in the NFS patch (18)


git-backport-diff against v8:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/31:[down] 'block: Use bdrv_refresh_filename() to pull'
002/31:[----] [--] 'block: Use children list in bdrv_refresh_filename'
003/31:[down] 'block: Skip implicit nodes for filename info'
004/31:[down] 'block: Add BDS.auto_backing_file'
005/31:[0052] [FC] 'block: Respect backing bs in bdrv_refresh_filename'
006/31:[down] 'iotests.py: Add filter_imgfmt()'
007/31:[down] 'iotests.py: Add node_info()'
008/31:[down] 'iotests: Add test for backing file overrides'
009/31:[----] [--] 'block: Make path_combine() return the path'
010/31:[0016] [FC] 'block: bdrv_get_full_backing_filename_from_...'s ret.=
 val.'
011/31:[0001] [FC] 'block: bdrv_get_full_backing_filename's ret. val.'
012/31:[0022] [FC] 'block: Add bdrv_make_absolute_filename()'
013/31:[0003] [FC] 'block: Fix bdrv_find_backing_image()'
014/31:[0001] [FC] 'block: Add bdrv_dirname()'
015/31:[----] [--] 'blkverify: Make bdrv_dirname() return NULL'
016/31:[----] [-C] 'quorum: Make bdrv_dirname() return NULL'
017/31:[----] [-C] 'block/nbd: Make bdrv_dirname() return NULL'
018/31:[0003] [FC] 'block/nfs: Implement bdrv_dirname()'
019/31:[0014] [FC] 'block: Use bdrv_dirname() for relative filenames'
020/31:[----] [--] 'iotests: Add quorum case to test 110'
021/31:[down] 'block: Add strong_runtime_opts to BlockDriver'
022/31:[0037] [FC] 'block: Add BlockDriver.bdrv_gather_child_options'
023/31:[0084] [FC] 'block: Generically refresh runtime options'
024/31:[0076] [FC] 'block: Purify .bdrv_refresh_filename()'
025/31:[0005] [FC] 'block: Do not copy exact_filename from format file'
026/31:[down] 'block/nvme: Fix bdrv_refresh_filename()'
027/31:[----] [--] 'block/curl: Harmonize option defaults'
028/31:[----] [-C] 'block/curl: Implement bdrv_refresh_filename()'
029/31:[----] [--] 'block/null: Generate filename even with latency-ns'
030/31:[down] 'block: BDS options may lack the "driver" option'
031/31:[down] 'iotests: Test json:{} filenames of internal BDSs'


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
 block.c                       | 505 ++++++++++++++++++++++------------
 block/blkdebug.c              |  70 ++---
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
 block/vpc.c                   |  11 +-
 block/vvfat.c                 |  12 +
 block/vxhs.c                  |  11 +
 blockdev.c                    |   8 +
 qemu-img.c                    |  12 +-
 tests/qemu-iotests/051.out    |   8 +-
 tests/qemu-iotests/051.pc.out |   8 +-
 tests/qemu-iotests/110        |  29 +-
 tests/qemu-iotests/110.out    |   9 +-
 tests/qemu-iotests/223        | 235 ++++++++++++++++
 tests/qemu-iotests/223.out    |  84 ++++++
 tests/qemu-iotests/224        | 139 ++++++++++
 tests/qemu-iotests/224.out    |  18 ++
 tests/qemu-iotests/group      |   2 +
 tests/qemu-iotests/iotests.py |  10 +
 43 files changed, 1374 insertions(+), 390 deletions(-)
 create mode 100755 tests/qemu-iotests/223
 create mode 100644 tests/qemu-iotests/223.out
 create mode 100755 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out

--=20
2.17.1
