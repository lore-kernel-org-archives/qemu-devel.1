Received: from eggs.gnu.org ([2001:4830:134:3::10]:51435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRNQ5-0004Ag-3L
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:14:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cRNQ3-0008RL-Qq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:14:45 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 11 Jan 2017 19:14:07 +0100
Message-Id: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/25] block: Fix some filename generation
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

[If you have read the cover letter in v2 or v3, there is nothing new
 here; feel free to skip to the bottom to read the changes from v3.]

There are some issues regarding filename generation right now:

- You always get a JSON filename if you set even a single qcow2-specific
  runtime options (as long as it does not have a dot in it, which is a
  bug, too, but here it is working in our favor...). That is not nice
  and actually breaks the usage of backing files with relative
  filenames with such qcow2 BDS.

- As hinted above, you cannot use relative backing filenames with BDS
  that have a JSON filename only, even though qemu might be able to
  obtain the directory name by walking through the BDS graph to the
  protocol level.

- Overriding the backing file at runtime should invalidate the filename
  because it actually changes the BDS's data.  Therefore, we need to
  force a JSON filename in that case, containing the backing file
  override.

- Much of our code assumes paths never to exceed PATH_MAX in length.
  This is wrong, at least because of JSON filenames. This should be
  fixed wherever the opportunity arises.

- If a driver decides to implement bdrv_refresh_filename(), that
  implementation has to not only refresh the filename (as one would
  think) but it must also refresh the runtime options
  (bs->full_open_options). That is stupid. (I'm allowed to say that
  because I'm to blame for it.)

This series is enclosed by four patches (two at the front, two at the
back) that fix more or less general issues. They are included because:
- Patch 1 is required so that in patch 3 it's obvious why we don't need
  to set backing_overriden there or call bdrv_refresh_filename()
- Patch 2 is already reviewed, so I might just as well keep it.
- Patches 24 and 25 are basically general bug fixes. Their connection to
  this series is obvious, however, I think, and they depend on the rest
  of the series, so I decided to just put them in.

Patches 3 and 4 address the third issue above, and patch 23 adds
something that's missing from patch 3. It cannot be squashed into patch
3, however, because it depends on functionality introduced by patches 18
to 22.
Consequently, patch 3 introduces a FIXME that is resolved by patch 23.

Patches 5 to 9 address the fourth issue above, and are also necessary
preparation for the following patches.

Patches 10 to 16 address the second issue above, patch 17 adds a test
case. They implement a bdrv_dirname() function that returns the base
directory of a BDS by walking through the BDS graph to the protocol
layer and then trying to obtain a path based on that BDS's
exact_filename. This obviously fails if exact_filename on the protocol
layer is not set.
This behavior can be overriden either by any block driver along the way
implementing bdrv_dirname() itself or by the user through the new
'base-directory' node option. This may allow us to resolve relative
filenames even if the reference BDS only has a JSON filename.

Patches 18 to 22 address both the first and last issues above. They add
a field called "sgfnt_runtime_opts" to the BlockDriver structure. Block
drivers may point this to an array containing all of the runtime options
they accept that may change their BDS's data (i.e. that are
"significant"). bdrv_refresh_filename() will use this list to generate
bs->full_open_options itself (with only a little help by the block
driver, if necessary, through the .bdrv_gather_child_options()
function). This not only simplifies the process significantly, but also
results in the default implementation generating JSON filenames only
when really necessary.


v4:
- Replaced the superfluous explicit setting of backing_filename to NULL
  in patch 7 by a comment [Berto]
- Fixed the protocol BDS test in patch 22


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/25:[----] [--] 'block/mirror: Small absolute-paths simplification'
002/25:[----] [--] 'block: Use children list in bdrv_refresh_filename'
003/25:[----] [--] 'block: Add BDS.backing_overridden'
004/25:[----] [--] 'block: Respect backing bs in bdrv_refresh_filename'
005/25:[----] [--] 'block: Make path_combine() return the path'
006/25:[----] [--] 'block: bdrv_get_full_backing_filename_from_...'s ret. val.'
007/25:[0002] [FC] 'block: bdrv_get_full_backing_filename's ret. val.'
008/25:[----] [--] 'block: Add bdrv_make_absolute_filename()'
009/25:[----] [--] 'block: Fix bdrv_find_backing_image()'
010/25:[----] [--] 'block: Add bdrv_dirname()'
011/25:[----] [-C] 'blkverify: Make bdrv_dirname() return NULL'
012/25:[----] [--] 'quorum: Make bdrv_dirname() return NULL'
013/25:[----] [--] 'block/nbd: Implement bdrv_dirname()'
014/25:[----] [--] 'block/nfs: Implement bdrv_dirname()'
015/25:[----] [--] 'block: Use bdrv_dirname() for relative filenames'
016/25:[----] [--] 'block: Add 'base-directory' BDS option'
017/25:[----] [--] 'iotests: Add quorum case to test 110'
018/25:[----] [--] 'block: Add sgfnt_runtime_opts to BlockDriver'
019/25:[----] [--] 'block: Add BlockDriver.bdrv_gather_child_options'
020/25:[----] [--] 'block: Generically refresh runtime options'
021/25:[----] [--] 'block: Purify .bdrv_refresh_filename()'
022/25:[0002] [FC] 'block: Do not copy exact_filename from format file'
023/25:[----] [-C] 'block: Fix FIXME from "Add BDS.backing_overridden"'
024/25:[----] [--] 'block/curl: Implement bdrv_refresh_filename()'
025/25:[----] [--] 'block/null: Generate filename even with latency-ns'



Max Reitz (25):
  block/mirror: Small absolute-paths simplification
  block: Use children list in bdrv_refresh_filename
  block: Add BDS.backing_overridden
  block: Respect backing bs in bdrv_refresh_filename
  block: Make path_combine() return the path
  block: bdrv_get_full_backing_filename_from_...'s ret. val.
  block: bdrv_get_full_backing_filename's ret. val.
  block: Add bdrv_make_absolute_filename()
  block: Fix bdrv_find_backing_image()
  block: Add bdrv_dirname()
  blkverify: Make bdrv_dirname() return NULL
  quorum: Make bdrv_dirname() return NULL
  block/nbd: Implement bdrv_dirname()
  block/nfs: Implement bdrv_dirname()
  block: Use bdrv_dirname() for relative filenames
  block: Add 'base-directory' BDS option
  iotests: Add quorum case to test 110
  block: Add sgfnt_runtime_opts to BlockDriver
  block: Add BlockDriver.bdrv_gather_child_options
  block: Generically refresh runtime options
  block: Purify .bdrv_refresh_filename()
  block: Do not copy exact_filename from format file
  block: Fix FIXME from "Add BDS.backing_overridden"
  block/curl: Implement bdrv_refresh_filename()
  block/null: Generate filename even with latency-ns

 qapi/block-core.json          |   9 +
 include/block/block.h         |  15 +-
 include/block/block_int.h     |  14 +-
 block.c                       | 491 ++++++++++++++++++++++++++++--------------
 block/blkdebug.c              |  50 ++---
 block/blkverify.c             |  30 +--
 block/curl.c                  |  38 ++++
 block/gluster.c               |  19 ++
 block/mirror.c                |  10 +-
 block/nbd.c                   |  54 +++--
 block/nfs.c                   |  50 ++---
 block/null.c                  |  33 ++-
 block/qapi.c                  |  12 +-
 block/quorum.c                |  62 +++---
 block/rbd.c                   |   2 +
 block/vmdk.c                  |  24 ++-
 block/vvfat.c                 |   4 +
 blockdev.c                    |  16 ++
 tests/qemu-iotests/051.out    |   8 +-
 tests/qemu-iotests/051.pc.out |   8 +-
 tests/qemu-iotests/110        |  51 ++++-
 tests/qemu-iotests/110.out    |  14 +-
 22 files changed, 678 insertions(+), 336 deletions(-)

-- 
2.11.0
