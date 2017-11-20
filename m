Received: from eggs.gnu.org ([2001:4830:134:3::10]:34678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOb-0007ng-08
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsOY-0006io-Vj
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:20 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:39 +0100
Message-Id: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 00/25] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

I'm sparing myself writing this cover letter again, and I'll just give
you a link to the previous version:

http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html

The only difference is that I dropped patch 16 which added a QAPI
@base-directory option for any node that could be used to override the
base directory to be used for resolving relative filenames.  (Because
Berto and Kevin convinced me it's not that useful now -- and the patch
is pretty stand-alone, so we can always add it later if needed.)

In turn, I had to add patch 4 because test 191 was broken by this
series.


v7: Rebased on block-next, and:
- Patch 4: Added (iotest 191 tries to both override a node's backing
           file and use filenames for node identification at the same
           time -- not a very good idea, but with a simple modification
           we can still get away with it)
- Patch 5: Changes 191's output now
- Patch 10 (was 9): Shorten the code [Berto]
- Old patch 16: Dropped [Berto/Kevin]
- Patch 17: Remove test case for @base-directory
- Patch 18:
  - Never use inline definition of the significant runtime options array
    [Kevin]
  - Add encrypt.key-secret options for qcow/qcow2
  - Add transfer limit options for blkdebug
  - s/uid/user/ and s/gid/group/ for NFS
  - Add offset/size for raw
- Patch 19: Sprinkle a couple of notes in about how we actually don't
            want this new function [Kevin, kind of]
- Patch 20: Changes 191's output now (and also, there is a rebase
            conflict for 110 due to patch 16 being removed and thus
            patch 17 having been modified)


git-backport-diff against v6:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/25:[----] [--] 'block/mirror: Small absolute-paths simplification'
002/25:[----] [--] 'block: Use children list in bdrv_refresh_filename'
003/25:[----] [--] 'block: Add BDS.backing_overridden'
004/25:[down] 'iotests: Drop explicit base blockdev in 191'
005/25:[0024] [FC] 'block: Respect backing bs in bdrv_refresh_filename'
006/25:[----] [--] 'block: Make path_combine() return the path'
007/25:[----] [-C] 'block: bdrv_get_full_backing_filename_from_...'s ret. val.'
008/25:[----] [--] 'block: bdrv_get_full_backing_filename's ret. val.'
009/25:[----] [--] 'block: Add bdrv_make_absolute_filename()'
010/25:[0014] [FC] 'block: Fix bdrv_find_backing_image()'
011/25:[----] [--] 'block: Add bdrv_dirname()'
012/25:[----] [--] 'blkverify: Make bdrv_dirname() return NULL'
013/25:[----] [--] 'quorum: Make bdrv_dirname() return NULL'
014/25:[----] [--] 'block/nbd: Make bdrv_dirname() return NULL'
015/25:[----] [--] 'block/nfs: Implement bdrv_dirname()'
016/25:[----] [--] 'block: Use bdrv_dirname() for relative filenames'
017/25:[0027] [FC] 'iotests: Add quorum case to test 110'
018/25:[0188] [FC] 'block: Add sgfnt_runtime_opts to BlockDriver'
019/25:[0044] [FC] 'block: Add BlockDriver.bdrv_gather_child_options'
020/25:[0026] [FC] 'block: Generically refresh runtime options'
021/25:[----] [-C] 'block: Purify .bdrv_refresh_filename()'
022/25:[----] [--] 'block: Do not copy exact_filename from format file'
023/25:[----] [-C] 'block: Fix FIXME from "Add BDS.backing_overridden"'
024/25:[----] [--] 'block/curl: Implement bdrv_refresh_filename()'
025/25:[----] [--] 'block/null: Generate filename even with latency-ns'


Max Reitz (25):
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
  block/curl: Implement bdrv_refresh_filename()
  block/null: Generate filename even with latency-ns

 include/block/block.h         |  15 +-
 include/block/block_int.h     |  38 +++-
 block.c                       | 507 ++++++++++++++++++++++++++++--------------
 block/blkdebug.c              |  69 +++---
 block/blkverify.c             |  29 +--
 block/commit.c                |   3 +-
 block/crypto.c                |   8 +
 block/curl.c                  |  39 ++++
 block/gluster.c               |  19 ++
 block/iscsi.c                 |  18 ++
 block/mirror.c                |  19 +-
 block/nbd.c                   |  46 ++--
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
 tests/qemu-iotests/191.out    |  94 ++++----
 35 files changed, 877 insertions(+), 399 deletions(-)

-- 
2.13.6
