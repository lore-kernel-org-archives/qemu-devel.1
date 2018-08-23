Received: from eggs.gnu.org ([2001:4830:134:3::10]:55642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsxn0-0001ca-3M
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsxmy-0001y5-Qt
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:09:14 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:08:47 -0400
Message-Id: <20180823220856.10094-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/9] jobs: Job Exit Refactoring Pt 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

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

V2:

001/9:[----] [--] 'jobs: change start callback to run callback'
002/9:[0003] [FC] 'jobs: canonize Error object'
003/9:[0005] [FC] 'jobs: add exit shim'
004/9:[0002] [FC] 'block/commit: utilize job_exit shim'
005/9:[----] [--] 'block/mirror: utilize job_exit shim'
006/9:[----] [--] 'jobs: utilize job_exit shim'
007/9:[down] 'block/backup: make function variables consistently named'
008/9:[down] 'jobs: remove ret argument to job_completed; privatize it'
009/9:[----] [--] 'jobs: remove job_defer_to_main_loop'

002: Update commit message
     Remove errant space (Eric, Max)
     Update error message setting (Kevin)
003: Add comment clarifying that .exit is temporary/transitional (Max, Eric)
004: change reference from `ret` to `job->ret`
     (Note: most of these references go away in Pt 2 of the series,
            except for those in mirror_exit.) (for Max.)
007: Added, at Eric's suggestion.
008: Moved forward from Pt 2 of the series. (Max.)

Hopefully this version makes the trajectory clearer.
--js

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
 block/mirror.c            | 35 +++++++++-----------
 block/stream.c            | 29 +++++++----------
 include/qemu/job.h        | 62 +++++++++++++++---------------------
 job-qmp.c                 |  5 +--
 job.c                     | 73 +++++++++++++++---------------------------
 tests/test-bdrv-drain.c   | 13 +++-----
 tests/test-blockjob-txn.c | 25 ++++++---------
 tests/test-blockjob.c     | 17 +++++-----
 trace-events              |  2 +-
 12 files changed, 150 insertions(+), 240 deletions(-)

-- 
2.14.4
