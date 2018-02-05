Received: from eggs.gnu.org ([2001:4830:134:3::10]:52703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiXg-0007u1-CK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiiXe-00057d-Pq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:18:48 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  5 Feb 2018 16:18:09 +0100
Message-Id: <20180205151835.20812-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 00/26] block: Fix some filename generation
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

I'm sparing myself writing this cover letter again, and I'll just give
you a link to one of the previous versions:

http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html

The main difference is that I dropped patch 16 which added a QAPI
@base-directory option for any node that could be used to override the
base directory to be used for resolving relative filenames.  (Because
Berto and Kevin convinced me it's not that useful now -- and the patch
is pretty stand-alone, so we can always add it later if needed.)

In turn, I had to add patch 4 because test 191 was broken by this
series.


v8: Rebased, and:
- Patch 3: Actually just contextual difference
- Patch 4: Rebase conflict: 191 now filters its output a bit more, so
  there are differences in the reference output ("format-specific" is
  missing and %s/qcow2/IMGFMT/g)
- Patch 5:
  - Drop superfluous "&& !bs->backing" in one else branch following a
    "bs->backing" if [Berto]
  - Same 191.out conflicts as in patch 4
- Patch 18: Indentation conflicts in block/sheepdog.c
- Patch 20:
  - Dropped now-missing "base-directory" option from the global_options
    array [Berto]
  - Same old 191.out conflicts
- Patch 21:
  - Trivial rebase conflict because patch 5 has changed
  - For blkdebug, both "image" and "x-image" may contain child-related
    information, so we need to consider both in its
    .bdrv_refresh_filename implementation [Berto]
- Patch 24: Added [Berto]
- Patch 25: In curl, don't "silently" encode the default values in
            its .bdrv_refresh_filename(), but use explicit macros
            (except for "readahead" and "timeout", which we can ignore,
             and for everything that is a pointer, because the default
             value is rather obviously NULL; so that actually just
             leaves us with "sslverify") [Berto]


git-backport-diff against v7:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/26:[----] [--] 'block/mirror: Small absolute-paths simplification'
002/26:[----] [--] 'block: Use children list in bdrv_refresh_filename'
003/26:[0002] [FC] 'block: Add BDS.backing_overridden'
004/26:[0074] [FC] 'iotests: Drop explicit base blockdev in 191'
005/26:[0050] [FC] 'block: Respect backing bs in bdrv_refresh_filename'
006/26:[----] [--] 'block: Make path_combine() return the path'
007/26:[----] [--] 'block: bdrv_get_full_backing_filename_from_...'s ret. val.'
008/26:[----] [--] 'block: bdrv_get_full_backing_filename's ret. val.'
009/26:[----] [--] 'block: Add bdrv_make_absolute_filename()'
010/26:[----] [--] 'block: Fix bdrv_find_backing_image()'
011/26:[----] [--] 'block: Add bdrv_dirname()'
012/26:[----] [--] 'blkverify: Make bdrv_dirname() return NULL'
013/26:[----] [--] 'quorum: Make bdrv_dirname() return NULL'
014/26:[----] [-C] 'block/nbd: Make bdrv_dirname() return NULL'
015/26:[----] [--] 'block/nfs: Implement bdrv_dirname()'
016/26:[----] [--] 'block: Use bdrv_dirname() for relative filenames'
017/26:[----] [--] 'iotests: Add quorum case to test 110'
018/26:[0006] [FC] 'block: Add sgfnt_runtime_opts to BlockDriver'
019/26:[----] [--] 'block: Add BlockDriver.bdrv_gather_child_options'
020/26:[0050] [FC] 'block: Generically refresh runtime options'
021/26:[0005] [FC] 'block: Purify .bdrv_refresh_filename()'
022/26:[----] [--] 'block: Do not copy exact_filename from format file'
023/26:[----] [--] 'block: Fix FIXME from "Add BDS.backing_overridden"'
024/26:[down] 'block/curl: Harmonize option defaults'
025/26:[0007] [FC] 'block/curl: Implement bdrv_refresh_filename()'
026/26:[----] [--] 'block/null: Generate filename even with latency-ns'


Max Reitz (26):
  block/mirror: Small absolute-paths simplification
  block: Use children list in bdrv_refresh_filename
  block: Add BDS.backing_overridden
  iotests: Drop explicit base blockdev in 191
  block: Respect backing bs in bdrv_refresh_filename
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
  block: Add sgfnt_runtime_opts to BlockDriver
  block: Add BlockDriver.bdrv_gather_child_options
  block: Generically refresh runtime options
  block: Purify .bdrv_refresh_filename()
  block: Do not copy exact_filename from format file
  block: Fix FIXME from "Add BDS.backing_overridden"
  block/curl: Harmonize option defaults
  block/curl: Implement bdrv_refresh_filename()
  block/null: Generate filename even with latency-ns

 include/block/block.h         |  15 +-
 include/block/block_int.h     |  38 +++-
 block.c                       | 507 ++++++++++++++++++++++++++++--------------
 block/blkdebug.c              |  72 +++---
 block/blkverify.c             |  29 +--
 block/commit.c                |   3 +-
 block/crypto.c                |   8 +
 block/curl.c                  |  55 ++++-
 block/gluster.c               |  19 ++
 block/iscsi.c                 |  18 ++
 block/mirror.c                |  19 +-
 block/nbd.c                   |  50 +++--
 block/nfs.c                   |  53 ++---
 block/null.c                  |  33 ++-
 block/qapi.c                  |  12 +-
 block/qcow.c                  |   7 +
 block/qcow2.c                 |   7 +
 block/quorum.c                |  69 ++++--
 block/raw-format.c            |  10 +-
 block/rbd.c                   |  14 ++
 block/replication.c           |   8 +
 block/sheepdog.c              |  12 +
 block/ssh.c                   |  12 +
 block/throttle.c              |   7 +
 block/vmdk.c                  |  25 ++-
 block/vpc.c                   |   7 +
 block/vvfat.c                 |  12 +
 block/vxhs.c                  |  11 +
 blockdev.c                    |  16 ++
 tests/qemu-iotests/051.out    |   8 +-
 tests/qemu-iotests/051.pc.out |   8 +-
 tests/qemu-iotests/110        |  29 ++-
 tests/qemu-iotests/110.out    |   9 +-
 tests/qemu-iotests/191        |   3 +-
 tests/qemu-iotests/191.out    |  76 +++----
 35 files changed, 884 insertions(+), 397 deletions(-)

-- 
2.14.3
