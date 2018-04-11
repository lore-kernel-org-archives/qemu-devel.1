Received: from eggs.gnu.org ([2001:4830:134:3::10]:36059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6KtH-00032e-Iu
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6KtF-0005tC-Vd
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:54:43 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 11 Apr 2018 20:54:12 +0200
Message-Id: <20180411185425.2461-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.13 00/13] block/mirror: Add
 active-sync mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

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


v4:
- Dropped patches 1 through 3.  Kevin has taken the old patch 3 (a drain
  test case) into his lastest drain series ("Drain fixes and cleanups,
  part 3"), which to me implies that my preceding patches (the old 1 and
  2) may not have been enough.  As I explained in some older cover
  latter (it might have been v1...), all of those patches actually would
  have been only necessary for the follow-up (that is going to come
  along at some point...) where I plan to make the mirror target an
  immediate BdrvChild of the mirror node.
  This series does not make the mirror target such an immediate child,
  thus the mirror node continues to only have a single child, which
  means that those patches are actually not required for this series.  I
  only included them because they still made sense.
  However, now I am no longer convinced it makes sense to include them
  (because that would create a dependency on Kevin's series), so I'll
  push them off to the follow-up.

- Patch 12 (was: 15): Replaced "2.12" by "2.13" [Eric]

- Added Rb-s, rebased (with no effect, judging from
  git-backport-diff...)


git-backport-diff to v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/13:[----] [--] 'block/mirror: Pull out mirror_perform()'
002/13:[----] [--] 'block/mirror: Convert to coroutines'
003/13:[----] [--] 'block/mirror: Use CoQueue to wait on in-flight ops'
004/13:[----] [--] 'block/mirror: Wait for in-flight op conflicts'
005/13:[----] [--] 'block/mirror: Use source as a BdrvChild'
006/13:[----] [--] 'block: Generalize should_update_child() rule'
007/13:[----] [--] 'hbitmap: Add @advance param to hbitmap_iter_next()'
008/13:[----] [--] 'test-hbitmap: Add non-advancing iter_next tests'
009/13:[----] [--] 'block/dirty-bitmap: Add bdrv_dirty_iter_next_area'
010/13:[----] [--] 'block/mirror: Add MirrorBDSOpaque'
011/13:[----] [--] 'block/mirror: Add active mirroring'
012/13:[0004] [FC] 'block/mirror: Add copy mode QAPI interface'
013/13:[----] [--] 'iotests: Add test for active mirroring'


Max Reitz (13):
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
 block/mirror.c               | 605 ++++++++++++++++++++++++++++++++++---------
 blockdev.c                   |   9 +-
 tests/test-hbitmap.c         |  38 ++-
 util/hbitmap.c               |  10 +-
 tests/qemu-iotests/151       | 120 +++++++++
 tests/qemu-iotests/151.out   |   5 +
 tests/qemu-iotests/group     |   1 +
 14 files changed, 781 insertions(+), 152 deletions(-)
 create mode 100755 tests/qemu-iotests/151
 create mode 100644 tests/qemu-iotests/151.out

-- 
2.14.3
