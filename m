Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMCmw-0000vE-D7
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMCmu-0001iF-PU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:02:02 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 12 Nov 2018 16:00:32 +0200
Message-Id: <cover.1542031058.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v5 00/16] Don't pass flags to
 bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi all,

when reopening a BlockDriverState using bdrv_reopen() and friends the
new options can be specified either with a QDict or with flags. Both
methods overlap and that makes the semantics and the implementation
unnecessarily complicated.

This series removes the 'flags' parameter from these functions, so
from now on all option changes must be specified using a QDict. Apart
from simplifying the API, a few bugs are fixed along the way. See the
individual patches for more details.

This was tested with the current master (460f0236c12a86a38692c12d9bf).

Regards,

Berto

v5:
- Patch 14: Update commit message and add test for auto-read-only [Max]
- Patch 16: Fix update of BDRV_O_AUTO_RDONLY [Max]

v4: https://lists.gnu.org/archive/html/qemu-block/2018-11/msg00228.html
- Patch 14: Don't assert if BDRV_OPT_AUTO_READ_ONLY is missing, e.g.
  qemu-io -c 'reopen -o auto-read-only=foo' -f raw null-co://

v3: https://lists.gnu.org/archive/html/qemu-block/2018-10/msg00648.html
- Patch 1 [from v2] has been removed and all other patch numbers are
  shifted.
- Patches 10 and 13: Fixed rebase conflicts after the patch removal.
- Patch 14: Replacement for the removed patch using a different approach.
- Patch 15: Document a non-obvious call to update_flags_from_options()

v2: https://lists.gnu.org/archive/html/qemu-block/2018-10/msg00534.html
- Patches 4 and 9: Fixed trivial rebase conflict
- Patch 11: Update messages [Max]
- Patch 12: Add comment and use bdrv_is_read_only() instead of
            using the flags directly [Max]
- Patch 14: Remove inner block and move all variable declarations to
            the beginning of the function [Max]

v1: https://lists.gnu.org/archive/html/qemu-block/2018-09/msg00483.html
- Initial version

Output of backport-diff against v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/16:[----] [--] 'block: Add bdrv_reopen_set_read_only()'
002/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in bdrv_backing_update_filename()'
003/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in commit_start/complete()'
004/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in bdrv_commit()'
005/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in stream_start/complete()'
006/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in qmp_change_backing_file()'
007/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in external_snapshot_commit()'
008/16:[----] [--] 'block: Use bdrv_reopen_set_read_only() in the mirror driver'
009/16:[----] [--] 'block: Drop bdrv_reopen()'
010/16:[----] [--] 'qemu-io: Put flag changes in the options QDict in reopen_f()'
011/16:[----] [--] 'block: Clean up reopen_backing_file() in block/replication.c'
012/16:[----] [--] 'block: Remove flags parameter from bdrv_reopen_queue()'
013/16:[----] [--] 'block: Stop passing flags to bdrv_reopen_queue_child()'
014/16:[0002] [FC] 'block: Remove assertions from update_flags_from_options()'
015/16:[----] [--] 'block: Assert that flags are up-to-date in bdrv_reopen_prepare()'
016/16:[down] 'block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_options()'

Alberto Garcia (16):
  block: Add bdrv_reopen_set_read_only()
  block: Use bdrv_reopen_set_read_only() in
    bdrv_backing_update_filename()
  block: Use bdrv_reopen_set_read_only() in commit_start/complete()
  block: Use bdrv_reopen_set_read_only() in bdrv_commit()
  block: Use bdrv_reopen_set_read_only() in stream_start/complete()
  block: Use bdrv_reopen_set_read_only() in qmp_change_backing_file()
  block: Use bdrv_reopen_set_read_only() in external_snapshot_commit()
  block: Use bdrv_reopen_set_read_only() in the mirror driver
  block: Drop bdrv_reopen()
  qemu-io: Put flag changes in the options QDict in reopen_f()
  block: Clean up reopen_backing_file() in block/replication.c
  block: Remove flags parameter from bdrv_reopen_queue()
  block: Stop passing flags to bdrv_reopen_queue_child()
  block: Remove assertions from update_flags_from_options()
  block: Assert that flags are up-to-date in bdrv_reopen_prepare()
  block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_options()

 block.c                    | 93 ++++++++++++++++++++--------------------------
 block/commit.c             | 23 +++++-------
 block/mirror.c             | 19 ++++++----
 block/replication.c        | 43 ++++++++++-----------
 block/stream.c             | 20 +++++-----
 blockdev.c                 | 11 ++----
 include/block/block.h      |  6 +--
 qemu-io-cmds.c             | 29 ++++++++++++++-
 tests/qemu-iotests/133     | 18 +++++++++
 tests/qemu-iotests/133.out | 15 ++++++++
 10 files changed, 156 insertions(+), 121 deletions(-)

-- 
2.11.0
