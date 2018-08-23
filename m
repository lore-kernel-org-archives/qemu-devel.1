Received: from eggs.gnu.org ([2001:4830:134:3::10]:59251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0M-0005cV-Jo
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsy0L-0001Fe-69
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:23:02 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:22:36 -0400
Message-Id: <20180823222249.13518-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/13] jobs: jobs: Job Exit Refactoring Pt 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>

This is part two of a two part series that refactors the exit logic
of jobs.

This series forces all jobs to use the "finalize" semantics that were
introduced previously, but only exposed via the backup jobs.

Patches 1-3 add plumbing for the auto-dismiss and auto-finalize flags
but do not expose these via QAPI/QMP.

Patches 4-7 refactor the .exit() callbacks into the component pieces
of .prepare(), .commit(), .abort() and .clean(). Except mirror, which
I cheat with.

Patch 8 removes the last usage of .exit() in a test.
Patch 9 removes the callback and the machinery to invoke it.

Patches 10-12 expose the new QMP options to all of the jobs.
Patch 13 is a doc fixup.

"V2":
 - Split off the first part of the series to Pt.1
 - More aggressively refactored .commit()
 - Went all the way to deleting .exit() callback (Kevin)

John Snow (13):
  block/commit: add block job creation flags
  block/mirror: add block job creation flags
  block/stream: add block job creation flags
  block/commit: refactor commit to use job callbacks
  block/mirror: conservative mirror_exit refactor
  block/commit: refactor stream to use job callbacks
  tests/blockjob: replace Blockjob with Job
  tests/test-blockjob: remove exit callback
  jobs: remove .exit callback
  qapi/block-commit: expose new job properties
  qapi/block-mirror: expose new job properties
  qapi/block-stream: expose new job properties
  block/backup: qapi documentation fixup

 block/commit.c            |  95 +++++++++++++++++++++-----------------
 block/mirror.c            |  31 ++++++++++---
 block/stream.c            |  28 ++++++++----
 blockdev.c                |  44 ++++++++++++++++--
 hmp.c                     |   5 +-
 include/block/block_int.h |  15 ++++--
 include/qemu/job.h        |  11 -----
 job.c                     |  77 ++++++++++++++-----------------
 qapi/block-core.json      |  80 +++++++++++++++++++++++++++-----
 tests/test-blockjob-txn.c |   4 +-
 tests/test-blockjob.c     | 114 +++++++++++++++++++++++-----------------------
 11 files changed, 309 insertions(+), 195 deletions(-)

-- 
2.14.4
