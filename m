Received: from eggs.gnu.org ([2001:4830:134:3::10]:41509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66X-000451-P4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66W-00043A-96
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:25 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 19:04:51 +0100
Message-Id: <20180228180507.3964-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/16] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This series implements an active and synchronous mirroring mode.

Currently, the mirror block job is passive an asynchronous: Depending on
your start conditions, some part of the source disk starts as "dirty".
Then, the block job will (as a background operation) continuously copy
dirty parts to the target disk until all of the source disk is clean.
In the meantime, any write to the source disk dirties the affected area.

One effect of this operational mode is that the job may never converge:
If the writes to the source happen faster than the block job copies data
to the target, the job can never finish.

When the active mode implemented in this series is enabled, every write
request to the source will automatically trigger a synchronous write to
the target right afterwards.  Therefore, the source can never get dirty
faster than data is copied to the target.  Most importantly, once source
and target are in sync (BLOCK_JOB_READY is emitted), they will not
diverge (unless e.g. an I/O error occurs).

Active mirroring also improves on a second issue of the passive mode: We
do not have to read data from the source in order to write it to the
target.  When new data is written to the source in active mode, it is
automatically mirrored to the target, which saves us the superfluous
read from the source.


Things to do on top of this series:
- Allow switching between active and passive mode at runtime: Mainly
  hinges on the question of how to expose it to the user (ideally
  through a generic block-job-set-option command)

- Implement an asynchronous active mode (launch both write operations to
  the source and the target at the same time, and do not wait for the
  target operation to finish)

- Integrate the mirror BDS more tightly into the BDS graph:  Both source
  and target should be BdrvChildren (and the source should not be the
  "backing" child).  I'm working on this in a follow-up.

- Improve the mirror job coroutine use: Currently more of a hack, a
  follow-up will make this nicer.

- Add read-write-blocking mode: This series adds the write-blocking
  mode, where every write blocks until the data has been mirrored to the
  target.  read-write-blocking would also mirror data on reads from the
  source, which saves some performance (because that data does not have
  to be read twice) at the cost of latency on mirroring read operations.
  (Will be in the same follow-up.)


v3: [Fam]
- Patch 5: Drop shadowing ret declaration
- Patch 11: Added
- Patch 12: Add comment on how @iter is modified by
            bdrv_dirty_iter_next_area()
- Patch 14:
  - Squashed old patch 12 into this one
  - Don't forget write_zeroes and discard
- Patch 15: %s/passive/background/
- Patch 16: Write some zeroes so we can see those are actively copied,
            too (i.e. test the changes to patch 14 from v2)


git-backport-diff to v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/16:[----] [--] 'block: BDS deletion during bdrv_drain_recurse'
002/16:[----] [--] 'block: BDS deletion in bdrv_do_drained_begin()'
003/16:[----] [--] 'tests: Add bdrv-drain test for node deletion'
004/16:[----] [--] 'block/mirror: Pull out mirror_perform()'
005/16:[0002] [FC] 'block/mirror: Convert to coroutines'
006/16:[----] [--] 'block/mirror: Use CoQueue to wait on in-flight ops'
007/16:[----] [--] 'block/mirror: Wait for in-flight op conflicts'
008/16:[----] [--] 'block/mirror: Use source as a BdrvChild'
009/16:[----] [--] 'block: Generalize should_update_child() rule'
010/16:[----] [--] 'hbitmap: Add @advance param to hbitmap_iter_next()'
011/16:[down] 'test-hbitmap: Add non-advancing iter_next tests'
012/16:[0004] [FC] 'block/dirty-bitmap: Add bdrv_dirty_iter_next_area'
013/16:[----] [--] 'block/mirror: Add MirrorBDSOpaque'
014/16:[0114] [FC] 'block/mirror: Add active mirroring'
015/16:[0004] [FC] 'block/mirror: Add copy mode QAPI interface'
016/16:[0014] [FC] 'iotests: Add test for active mirroring'


Max Reitz (16):
  block: BDS deletion during bdrv_drain_recurse
  block: BDS deletion in bdrv_do_drained_begin()
  tests: Add bdrv-drain test for node deletion
  block/mirror: Pull out mirror_perform()
  block/mirror: Convert to coroutines
  block/mirror: Use CoQueue to wait on in-flight ops
  block/mirror: Wait for in-flight op conflicts
  block/mirror: Use source as a BdrvChild
  block: Generalize should_update_child() rule
  hbitmap: Add @advance param to hbitmap_iter_next()
  test-hbitmap: Add non-advancing iter_next tests
  block/dirty-bitmap: Add bdrv_dirty_iter_next_area
  block/mirror: Add MirrorBDSOpaque
  block/mirror: Add active mirroring
  block/mirror: Add copy mode QAPI interface
  iotests: Add test for active mirroring

 qapi/block-core.json         |  29 ++-
 include/block/block_int.h    |   6 +-
 include/block/dirty-bitmap.h |   2 +
 include/qemu/hbitmap.h       |   5 +-
 block.c                      |  44 +++-
 block/backup.c               |   2 +-
 block/dirty-bitmap.c         |  57 +++-
 block/io.c                   |  59 ++++-
 block/mirror.c               | 605 ++++++++++++++++++++++++++++++++++---------
 blockdev.c                   |   9 +-
 tests/test-bdrv-drain.c      | 165 ++++++++++++
 tests/test-hbitmap.c         |  38 ++-
 util/hbitmap.c               |  10 +-
 tests/qemu-iotests/151       | 120 +++++++++
 tests/qemu-iotests/151.out   |   5 +
 tests/qemu-iotests/group     |   1 +
 16 files changed, 995 insertions(+), 162 deletions(-)
 create mode 100755 tests/qemu-iotests/151
 create mode 100644 tests/qemu-iotests/151.out

-- 
2.14.3
