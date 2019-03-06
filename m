Received: from eggs.gnu.org ([209.51.188.92]:59499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1e-0004D7-Ay
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b1a-0005tM-Vu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:12:17 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:00 +0200
Message-Id: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 00/13] Add a 'x-blockdev-reopen' QMP command
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

Hi,

here's a new version of the patches to add a new QMP command for
bdrv_reopen().

Refer to the cover letter of v1 for a complete description of the
feature:

   https://lists.gnu.org/archive/html/qemu-block/2019-01/msg00623.html

Regards,

Berto

v2:
- Patch 1: Update documentation, fix check in bdrv_drop_intermediate()
  and add a new one in bdrv_replace_node() [Kevin]
- Patch 2: Add a missing unfreeze call if commit_start() fails, and
  prevent a double unfreeze in commit_abort() [Kevin]
- Patch 4: Prevent double unfreeze in stream_abort() [Kevin]
- Patch 6: Update documentation and don't complain for a missing
  'backing' option if the driver does not support backing files [Kevin]
- Patch 7: Contextual differences due to changes in previous patches.
- Patch 8: Forbid changing the backing file if there are implicit
  nodes on the way. Simplify code and update the permission checks to
  handle a new backing file [Kevin, Berto]
- Patch 9: Remove BlockDriver.runtime_opts from the previous version
  and use only mutable_opts [Kevin]
- Patch 10: Compare bs->options with reopen_state->options to see what
  options the user is trying to reset [Kevin]
- Patch 13: Update the tests to reflect all the new changes.

v1: https://lists.gnu.org/archive/html/qemu-block/2019-01/msg00623.html
- Patch 10: forbid setting a new backing file with a different
  AioContext.
- Patch 13 (new): Remove unused parameter from bdrv_reopen_multiple.
- Patch 14: Acquire the AioContext before calling
  bdrv_reopen_multiple().
- Patch 15: More test cases.
- Patches 3, 8, 9, 11, 12: scripts/checkpatch.pl is more picky now
  with the format of multi-line comments, so correct them.

RFCv2: https://lists.gnu.org/archive/html/qemu-block/2018-11/msg00901.html

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/13:[0021] [FC] 'block: Allow freezing BdrvChild links'
002/13:[0010] [FC] 'block: Freeze the backing chain for the duration of the commit job'
003/13:[----] [--] 'block: Freeze the backing chain for the duration of the mirror job'
004/13:[0009] [FC] 'block: Freeze the backing chain for the duration of the stream job'
005/13:[----] [--] 'block: Add 'keep_old_opts' parameter to bdrv_reopen_queue()'
006/13:[0009] [FC] 'block: Handle child references in bdrv_reopen_queue()'
007/13:[0004] [FC] 'block: Allow omitting the 'backing' option in certain cases'
008/13:[0118] [FC] 'block: Allow changing the backing file on reopen'
009/13:[down] 'block: Add a 'mutable_opts' field to BlockDriver'
010/13:[0070] [FC] 'block: Add bdrv_reset_options_allowed()'
011/13:[----] [--] 'block: Remove the AioContext parameter from bdrv_reopen_multiple()'
012/13:[----] [--] 'block: Add an 'x-blockdev-reopen' QMP command'
013/13:[0036] [FC] 'qemu-iotests: Test the x-blockdev-reopen QMP command'

Alberto Garcia (13):
  block: Allow freezing BdrvChild links
  block: Freeze the backing chain for the duration of the commit job
  block: Freeze the backing chain for the duration of the mirror job
  block: Freeze the backing chain for the duration of the stream job
  block: Add 'keep_old_opts' parameter to bdrv_reopen_queue()
  block: Handle child references in bdrv_reopen_queue()
  block: Allow omitting the 'backing' option in certain cases
  block: Allow changing the backing file on reopen
  block: Add a 'mutable_opts' field to BlockDriver
  block: Add bdrv_reset_options_allowed()
  block: Remove the AioContext parameter from bdrv_reopen_multiple()
  block: Add an 'x-blockdev-reopen' QMP command
  qemu-iotests: Test the x-blockdev-reopen QMP command

 block.c                    | 390 ++++++++++++++++--
 block/commit.c             |  16 +
 block/file-posix.c         |   6 +
 block/mirror.c             |   8 +
 block/qcow2.c              |  25 ++
 block/raw-format.c         |   3 +
 block/replication.c        |   7 +-
 block/stream.c             |  21 +
 blockdev.c                 |  47 +++
 include/block/block.h      |  13 +-
 include/block/block_int.h  |  14 +
 qapi/block-core.json       |  42 ++
 qemu-io-cmds.c             |   4 +-
 tests/qemu-iotests/243     | 991 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/243.out |   5 +
 tests/qemu-iotests/group   |   1 +
 16 files changed, 1562 insertions(+), 31 deletions(-)
 create mode 100644 tests/qemu-iotests/243
 create mode 100644 tests/qemu-iotests/243.out

-- 
2.11.0
