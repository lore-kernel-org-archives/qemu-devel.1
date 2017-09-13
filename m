Received: from eggs.gnu.org ([2001:4830:134:3::10]:36357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCG0-0007Yc-Oq
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCFz-0004Zh-6v
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:18:52 +0200
Message-Id: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 00/18] block/mirror: Add active-sync mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

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
(Optionally, one can choose to also mirror data read from the source.
This does not necessarily help with convergence, but it saves an extra
read operation (in exchange for slower read access to the source because
this mirroring is implemented synchronously).)


There may be a couple of things to do on top of this series:
- Allow switching between active and passive mode at runtime: This
  should not be too difficult to implement, the main question is how to
  expose it to the user.
  (I seem to recall we wanted some form of block-job-set-option
  command...?)

- Implement an asynchronous active mode: May be detrimental when it
  comes to convergence, but it might be nice to have anyway.  May or may
  not be complicated to implement.

- Make the target a BdrvChild of the mirror BDS: This series does some
  work to make the mirror BDS a more integral part of the block job (see
  below for more).  One of the things I wanted to do is to make both the
  source and the target plain children of that BDS, and I did have
  patches to do this.  However, at some point continuing to do this for
  the target seemed rather difficult, and also a bit pointless, so I
  decided to keep it for later.
  (To be specific, that "some point" was exactly when I tried to rebase
  onto 045a2f8254c.)


=== Structure of this series ===

The first half (up until patch 10) restructures parts of the mirror
block job:

- Patches 4/5:
  The job is converted to use coroutines instead of AIO.
  (because this is probably where we want to go, and also because active
   mirroring will need to wait on conflicting in-flight operations, and
   I really don't want to wait on in-flight AIO requests)

  This is done primarily by patch 5, with patch 4 being necessary
  beforehand.

- Patches 6/7:
  Every in-flight operation gets a CoQueue so it can be waited on
  (because this allows active mirroring operations to wait for
  conflicting writes)

  This is started by patch 6, and with patch 7, every bit in the
  in-flight bitmap has at least one  corresponding operation in the
  MirrorBlockJob.ops_in_flight list that can be waited on.

- Patches 1/2/3/8/9/10:
  The source node is now no longer used through a BlockBackend (patch 8)
  and also it is now attached to the mirror BDS as the "file" child
  instead of the "backing" child (patch 10).
  This is mostly because I'd personally like the mirror BDS to be a real
  filter BDS instead of some technicality that needs to be there to
  solve op blocker issues.

  Patches 3 and 9 are necessary for patch 10.

  Patches 1 and 2 were necessary for this when I decided to include
  another patch to make the target node an immediate child of the mirror
  BDS, too.  However, as I wrote above, I later decided to put this idea
  off until later, and as long as the mirror BDS only has a single
  child, those patches are not strictly necessary.
  However, I think that those patches are good to have anyway, so I
  decided to keep them.


The second half (patches 11 to 18) implement active mirroring:
- Patch 11 is required by patch 12.  This in turn is required by the
  active-sync mode when mirroring data read from the source to the
  target, because that functionality needs to be able to find all the
  parts of the data read which are actually dirty so we don't copy clean
  data.

- Patches 13 and 14 prepare for the job for active operations.

- Patch 15 implements active mirroring.

- Patch 16 allows it to be used (by adding a parameter to
  blockdev-mirror and drive-mirror).

- Patch 18 adds an iotest which relies on functionality introduced by
  patch 17.



Max Reitz (18):
  block: Add BdrvDeletedStatus
  block: BDS deletion during bdrv_drain_recurse
  blockjob: Make drained_{begin,end} public
  block/mirror: Pull out mirror_perform()
  block/mirror: Convert to coroutines
  block/mirror: Use CoQueue to wait on in-flight ops
  block/mirror: Wait for in-flight op conflicts
  block/mirror: Use source as a BdrvChild
  block: Generalize should_update_child() rule
  block/mirror: Make source the file child
  hbitmap: Add @advance param to hbitmap_iter_next()
  block/dirty-bitmap: Add bdrv_dirty_iter_next_area
  block/mirror: Keep write perm for pending writes
  block/mirror: Distinguish active from passive ops
  block/mirror: Add active mirroring
  block/mirror: Add copy mode QAPI interface
  qemu-io: Add background write
  iotests: Add test for active mirroring

 qapi/block-core.json         |  34 ++-
 include/block/block_int.h    |  18 +-
 include/block/blockjob.h     |  15 +
 include/block/dirty-bitmap.h |   2 +
 include/qemu/hbitmap.h       |   4 +-
 block.c                      |  50 +++-
 block/dirty-bitmap.c         |  54 +++-
 block/io.c                   |  72 +++--
 block/mirror.c               | 633 +++++++++++++++++++++++++++++++++----------
 block/qapi.c                 |  25 +-
 blockdev.c                   |   9 +-
 blockjob.c                   |  20 +-
 qemu-io-cmds.c               |  83 +++++-
 tests/test-hbitmap.c         |  26 +-
 util/hbitmap.c               |  10 +-
 tests/qemu-iotests/141.out   |   4 +-
 tests/qemu-iotests/151       | 111 ++++++++
 tests/qemu-iotests/151.out   |   5 +
 tests/qemu-iotests/group     |   1 +
 19 files changed, 964 insertions(+), 212 deletions(-)
 create mode 100755 tests/qemu-iotests/151
 create mode 100644 tests/qemu-iotests/151.out

-- 
2.13.5
