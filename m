Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0S-0001d2-Jd
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrup-00076W-VM
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:28:52 -0400
Message-Id: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/15] jobs: Job Exit Refactoring Pt 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

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
"V3"
====

001/15:[----] [--] 'block/commit: add block job creation flags'
002/15:[----] [--] 'block/mirror: add block job creation flags'
003/15:[----] [--] 'block/stream: add block job creation flags'
004/15:[0006] [FC] 'block/commit: refactor commit to use job callbacks'
005/15:[down] 'block/mirror: don't install backing chain on abort'
006/15:[0011] [FC] 'block/mirror: conservative mirror_exit refactor'
007/15:[----] [--] 'block/commit: refactor stream to use job callbacks'
008/15:[----] [--] 'tests/blockjob: replace Blockjob with Job'
009/15:[----] [--] 'tests/test-blockjob: remove exit callback'
010/15:[down] 'tests/test-blockjob-txn: move .exit to .clean'
011/15:[0004] [FC] 'jobs: remove .exit callback'
012/15:[----] [--] 'qapi/block-commit: expose new job properties'
013/15:[----] [--] 'qapi/block-mirror: expose new job properties'
014/15:[----] [--] 'qapi/block-stream: expose new job properties'
015/15:[----] [--] 'block/backup: qapi documentation fixup'

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

John Snow (15):
  block/commit: add block job creation flags
  block/mirror: add block job creation flags
  block/stream: add block job creation flags
  block/commit: refactor commit to use job callbacks
  block/mirror: don't install backing chain on abort
  block/mirror: conservative mirror_exit refactor
  block/commit: refactor stream to use job callbacks
  tests/blockjob: replace Blockjob with Job
  tests/test-blockjob: remove exit callback
  tests/test-blockjob-txn: move .exit to .clean
  jobs: remove .exit callback
  qapi/block-commit: expose new job properties
  qapi/block-mirror: expose new job properties
  qapi/block-stream: expose new job properties
  block/backup: qapi documentation fixup

 block/commit.c            |  95 +++++++++++++++++++++-----------------
 block/mirror.c            |  63 ++++++++++++++++---------
 block/stream.c            |  28 ++++++++----
 blockdev.c                |  44 ++++++++++++++++--
 hmp.c                     |   5 +-
 include/block/block_int.h |  15 ++++--
 include/qemu/job.h        |  11 -----
 job.c                     |  77 ++++++++++++++-----------------
 qapi/block-core.json      |  80 +++++++++++++++++++++++++++-----
 tests/test-blockjob-txn.c |   4 +-
 tests/test-blockjob.c     | 114 +++++++++++++++++++++++-----------------------
 11 files changed, 326 insertions(+), 210 deletions(-)

-- 
2.14.4
