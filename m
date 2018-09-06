Received: from eggs.gnu.org ([2001:4830:134:3::10]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxtvo-0006Z8-4G
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 09:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxtvh-0000gf-N7
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 09:02:43 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu,  6 Sep 2018 09:02:09 -0400
Message-Id: <20180906130225.5118-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/16] jobs: Job Exit Refactoring Pt 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This is part two of a two part series that refactors the exit logic
of jobs.

This series forces all jobs to use the "finalize" semantics that were
introduced previously, but only exposed via the backup jobs.

Patches 1-3 add plumbing for the auto-dismiss and auto-finalize flags
but do not expose these via QAPI/QMP.

Patches 4-7 refactor the .exit() callbacks into the component pieces
of .prepare(), .commit(), .abort() and .clean(). Except mirror, which
I cheat with.

Patches 8-10 remove the last usages of .exit in a test.
Patche 11 removes the .exit callback and the machinery to invoke it.

Patches 12-14 expose the new QMP options to all of the jobs.
Patch 15 is a doc fixup.

====
"V5"
====

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/16:[----] [--] 'block/commit: add block job creation flags'
002/16:[----] [--] 'block/mirror: add block job creation flags'
003/16:[----] [--] 'block/stream: add block job creation flags'
004/16:[0002] [FC] 'block/commit: refactor commit to use job callbacks'
005/16:[0005] [FC] 'block/mirror: don't install backing chain on abort'
006/16:[0005] [FC] 'block/mirror: conservative mirror_exit refactor'
007/16:[----] [--] 'block/stream: refactor stream to use job callbacks'
008/16:[----] [--] 'tests/blockjob: replace Blockjob with Job'
009/16:[----] [--] 'tests/test-blockjob: remove exit callback'
010/16:[----] [--] 'tests/test-blockjob-txn: move .exit to .clean'
011/16:[----] [--] 'jobs: remove .exit callback'
012/16:[----] [--] 'qapi/block-commit: expose new job properties'
013/16:[----] [--] 'qapi/block-mirror: expose new job properties'
014/16:[----] [--] 'qapi/block-stream: expose new job properties'
015/16:[----] [--] 'block/backup: qapi documentation fixup'
016/16:[down] 'blockdev: document transactional shortcomings'

004: Add FIXME comment (Jeff)
005: Update commit message, move ternary touchup to next patch (Max)
006: Adopt ternary fixup from previous patch (Max)
016: New, does what it says on the tin (Max)

====
"V4"
====

002, 003: Fix typo (Eric)
005: Don't not install the backing chain if
     we cancel a successful job (Max)
006: Fallout from 005
007: Fixed commit title. (Max)

====
"V3"
====

000: Fixed my cover letter subject. Phew!
004: Adjusted comment, added R-B
005: New; based on discussions from what is now 006 (was 005)
006: mirror_exit_common returns ret == 0 if we are aborting
     and it aborts successfully (Max)
     Added assertion that we aborted successfully (Max)
010: New, minor cleanup before we can actually remove .exit.
011: Removed what's now patch 10, added R-B per Max's comment.

=====
"V2":
=====
 - Split off the first part of the series to Pt.1
 - More aggressively refactored .commit()
 - Went all the way to deleting .exit() callback (Kevin)

John Snow (16):
  block/commit: add block job creation flags
  block/mirror: add block job creation flags
  block/stream: add block job creation flags
  block/commit: refactor commit to use job callbacks
  block/mirror: don't install backing chain on abort
  block/mirror: conservative mirror_exit refactor
  block/stream: refactor stream to use job callbacks
  tests/blockjob: replace Blockjob with Job
  tests/test-blockjob: remove exit callback
  tests/test-blockjob-txn: move .exit to .clean
  jobs: remove .exit callback
  qapi/block-commit: expose new job properties
  qapi/block-mirror: expose new job properties
  qapi/block-stream: expose new job properties
  block/backup: qapi documentation fixup
  blockdev: document transactional shortcomings

 block/commit.c            |  97 ++++++++++++++++++++++-----------------
 block/mirror.c            |  44 ++++++++++++------
 block/stream.c            |  28 ++++++++----
 blockdev.c                |  52 ++++++++++++++++++---
 hmp.c                     |   5 +-
 include/block/block_int.h |  15 ++++--
 include/qemu/job.h        |  11 -----
 job.c                     |  77 ++++++++++++++-----------------
 qapi/block-core.json      |  80 +++++++++++++++++++++++++++-----
 tests/test-blockjob-txn.c |   4 +-
 tests/test-blockjob.c     | 114 +++++++++++++++++++++++-----------------------
 11 files changed, 324 insertions(+), 203 deletions(-)

-- 
2.14.4
