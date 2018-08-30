Received: from eggs.gnu.org ([2001:4830:134:3::10]:51122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCIO-0005xP-7w
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 22:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCIK-00015E-CF
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 22:02:51 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Aug 2018 21:57:25 -0400
Message-Id: <20180830015734.19765-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/9] jobs: Job Exit Refactoring Pt 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, John Snow <jsnow@redhat.com>

This is part one of a two part series that refactors the exit logic
of jobs.

Part one removes job_defer_to_main_loop.
Part two removes the job->exit() callback introduced in part one.

It's redundant to have each job manage deferring to the main loop
itself. Unifying this makes sense from an API standpoint.
Doing so also allows us to remove a tricky case where the completion
code is called under an aio_context lock, which then calls the
finalization code which is itself executed under a second aio_context
lock, leading to deadlocks.

Removing this recursive lock acquisition is necessary for converting
mirror to only modify its graph post-finalization, but it's also just
safer and will bite us less in the future.

This series introduces a job->exit callback, but after jobs are
fully transitioned to using the .commit/.abort callbacks in Pt 2,
this new completion callback will be removed again. It's only here
as a crutch to let us investigate the completion refactoring in Pt 2
more carefully.

====
V3:
====

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[----] [--] 'jobs: change start callback to run callback'
002/9:[0006] [FC] 'jobs: canonize Error object'
003/9:[----] [--] 'jobs: add exit shim'
004/9:[----] [--] 'block/commit: utilize job_exit shim'
005/9:[0004] [FC] 'block/mirror: utilize job_exit shim'
006/9:[----] [--] 'jobs: utilize job_exit shim'
007/9:[----] [--] 'block/backup: make function variables consistently named'
008/9:[0006] [FC] 'jobs: remove ret argument to job_completed; privatize it'
009/9:[----] [--] 'jobs: remove job_defer_to_main_loop'

002: Adjusted Error *err comment to clarify when it is expected to be set.
     (I could not implement all of Max's suggestions for when job_update_rc
     should be called, in his responses to patches 002 and 008.)

005: Confirmed the reason why we need to bdrv_ref(src),
     and updated comment accordingly.

008: Clarified the meaning of the job->ret property.

001, 003-004, 006-007, 009: Added R-B (Max)

====
V2:
====

002: Update commit message
     Remove errant space (Eric, Max)
     Update error message setting (Kevin)
003: Add comment clarifying that .exit is temporary/transitional (Max, Eric)
004: change reference from `ret` to `job->ret`
     (Note: most of these references go away in Pt 2 of the series,
            except for those in mirror_exit.) (for Max.)
007: Added, at Eric's suggestion.
008: Moved forward from Pt 2 of the series. (Max.)

John Snow (9):
  jobs: change start callback to run callback
  jobs: canonize Error object
  jobs: add exit shim
  block/commit: utilize job_exit shim
  block/mirror: utilize job_exit shim
  jobs: utilize job_exit shim
  block/backup: make function variables consistently named
  jobs: remove ret argument to job_completed; privatize it
  jobs: remove job_defer_to_main_loop

 block/backup.c            | 81 +++++++++++++++++++----------------------------
 block/commit.c            | 29 ++++++-----------
 block/create.c            | 19 ++++-------
 block/mirror.c            | 39 ++++++++++-------------
 block/stream.c            | 29 +++++++----------
 include/qemu/job.h        | 70 ++++++++++++++++++++--------------------
 job-qmp.c                 |  5 +--
 job.c                     | 73 +++++++++++++++---------------------------
 tests/test-bdrv-drain.c   | 13 +++-----
 tests/test-blockjob-txn.c | 25 ++++++---------
 tests/test-blockjob.c     | 17 +++++-----
 trace-events              |  2 +-
 12 files changed, 160 insertions(+), 242 deletions(-)

-- 
2.14.4
