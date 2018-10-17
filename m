Received: from eggs.gnu.org ([2001:4830:134:3::10]:52331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005IA-70
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006Xm-35
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:16 +0300
Message-Id: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 00/14] Don't pass flags to
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

This was tested with the current master (09558375a634e17cea6cfbfec88).

Regards,

Berto

v2:
- Patches 4 and 9: Fixed trivial rebase conflict
- Patch 11: Update messages [Max]
- Patch 12: Add comment and use bdrv_is_read_only() instead of
            using the flags directly [Max]
- Patch 14: Remove inner block and move all variable declarations to
            the beginning of the function [Max]

v1: https://lists.gnu.org/archive/html/qemu-block/2018-09/msg00483.html
- Initial version

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/14:[----] [--] 'block: Don't call update_flags_from_options() if the options are wrong'
002/14:[----] [--] 'block: Add bdrv_reopen_set_read_only()'
003/14:[----] [--] 'block: Use bdrv_reopen_set_read_only() in bdrv_backing_update_filename()'
004/14:[0006] [FC] 'block: Use bdrv_reopen_set_read_only() in commit_start/complete()'
005/14:[----] [--] 'block: Use bdrv_reopen_set_read_only() in bdrv_commit()'
006/14:[----] [-C] 'block: Use bdrv_reopen_set_read_only() in stream_start/complete()'
007/14:[----] [--] 'block: Use bdrv_reopen_set_read_only() in qmp_change_backing_file()'
008/14:[----] [--] 'block: Use bdrv_reopen_set_read_only() in external_snapshot_commit()'
009/14:[0003] [FC] 'block: Use bdrv_reopen_set_read_only() in the mirror driver'
010/14:[----] [--] 'block: Drop bdrv_reopen()'
011/14:[0018] [FC] 'qemu-io: Put flag changes in the options QDict in reopen_f()'
012/14:[0011] [FC] 'block: Clean up reopen_backing_file() in block/replication.c'
013/14:[----] [--] 'block: Remove flags parameter from bdrv_reopen_queue()'
014/14:[0042] [FC] 'block: Stop passing flags to bdrv_reopen_queue_child()'

Alberto Garcia (14):
  block: Don't call update_flags_from_options() if the options are wrong
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

 block.c                    | 86 +++++++++++++++++++++-------------------------
 block/commit.c             | 23 +++++--------
 block/mirror.c             | 19 ++++++----
 block/replication.c        | 43 ++++++++++-------------
 block/stream.c             | 20 +++++------
 blockdev.c                 | 11 ++----
 include/block/block.h      |  6 ++--
 qemu-io-cmds.c             | 29 ++++++++++++++--
 tests/qemu-iotests/133     | 15 ++++++++
 tests/qemu-iotests/133.out | 12 +++++++
 10 files changed, 150 insertions(+), 114 deletions(-)

-- 
2.11.0
