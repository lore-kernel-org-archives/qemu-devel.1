Received: from eggs.gnu.org ([2001:4830:134:3::10]:56807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zi4-0002sM-6I
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zi2-0007r6-F4
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:40:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:39:52 +0200
Message-Id: <20181005234023.8104-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 00/31] block: Fix some filename generation
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

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


Changes in v10:
- Rebased

- Patch 5: Dropped parentheses in return statement, because the one
           thing I hate even more than syntax I don't like is patchew
           complaining about my syntax
           (kept the R-b, because it's an obvious and simple change)

- Patch 7: Dropped @require_existence [Berto]

- Patch 24: Rebase conflict in code removed; Berto changed bs->options
            not to include child options, so append_open_options() no
            longer had to actively exclude those.  Now the new code
            works the other way around (including specific strong
            options instead of excluding anything that seems generic and
            concerns child nodes), so the new code is not affected.  But
            the old code that's removed is changed, so there's a rebase
            conflict here that was simple to resolve.

- Patch 31: Wrongly had some code commented out in the last version.
            Sorry.  [Berto]


Backport-diff:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/31:[----] [-C] 'block: Use bdrv_refresh_filename() to pull'
002/31:[----] [--] 'block: Use children list in bdrv_refresh_filename'
003/31:[----] [--] 'block: Skip implicit nodes for filename info'
004/31:[----] [--] 'block: Add BDS.auto_backing_file'
005/31:[0002] [FC] 'block: Respect backing bs in bdrv_refresh_filename'
006/31:[----] [--] 'iotests.py: Add filter_imgfmt()'
007/31:[0007] [FC] 'iotests.py: Add node_info()'
008/31:[----] [-C] 'iotests: Add test for backing file overrides'
009/31:[----] [--] 'block: Make path_combine() return the path'
010/31:[----] [--] 'block: bdrv_get_full_backing_filename_from_...'s ret.=
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
024/31:[0016] [FC] 'block: Purify .bdrv_refresh_filename()'
025/31:[----] [--] 'block: Do not copy exact_filename from format file'
026/31:[----] [-C] 'block/nvme: Fix bdrv_refresh_filename()'
027/31:[----] [--] 'block/curl: Harmonize option defaults'
028/31:[----] [--] 'block/curl: Implement bdrv_refresh_filename()'
029/31:[----] [--] 'block/null: Generate filename even with latency-ns'
030/31:[----] [--] 'block: BDS options may lack the "driver" option'
031/31:[0030] [FC] 'iotests: Test json:{} filenames of internal BDSs'


Previous history:
v10: http://lists.nongnu.org/archive/html/qemu-block/2018-08/msg00234.htm=
l
v9: http://lists.nongnu.org/archive/html/qemu-block/2018-06/msg01291.html
v8: http://lists.nongnu.org/archive/html/qemu-block/2018-02/msg00157.html
v7: http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00831.html
v6: http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html
[...]
v1: http://lists.nongnu.org/archive/html/qemu-block/2016-04/msg00740.html


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
 block/vpc.c                   |  11 +-
 block/vvfat.c                 |  12 +
 block/vxhs.c                  |  11 +
 blockdev.c                    |   8 +
 qemu-img.c                    |  12 +-
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
 44 files changed, 1392 insertions(+), 404 deletions(-)
 create mode 100755 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out
 create mode 100755 tests/qemu-iotests/228
 create mode 100644 tests/qemu-iotests/228.out

--=20
2.17.1
