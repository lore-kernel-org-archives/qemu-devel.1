Received: from eggs.gnu.org ([2001:4830:134:3::10]:53740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrO-0002TE-Hs
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1euZrK-0000DA-8G
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 03:28:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Sat, 10 Mar 2018 03:27:25 -0500
Message-Id: <20180310082746.24198-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/21] blockjobs: add explicit job management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This series seeks to address two distinct but closely related issues
concerning the job management API.

(1) For jobs that complete when a monitor is not attached and receiving
    events or notifications, there's no way to discern the job's final
    return code. Jobs must remain in the query list until dismissed
    for reliable management.

(2) Jobs that change the block graph structure at an indeterminate point
    after the job starts compete with the management layer that relies
    on that graph structure to issue meaningful commands.

    This structure should change only at the behest of the management
    API, and not asynchronously at unknown points in time. Before a job
    issues such changes, it must rely on explicit and synchronous
    confirmation from the management API.

These changes are implemented by formalizing a State Transition Machine
for the BlockJob subsystem.

Job States:

UNDEFINED       Default state. Internal state only.
CREATED         Job has been created
RUNNING         Job has been started and is running
PAUSED          Job is not ready and has been paused
READY           Job is ready and is running
STANDBY         Job is ready and is paused

WAITING         Job is waiting on peers in transaction
PENDING         Job is waiting on ACK from QMP
ABORTING        Job is aborting or has been cancelled
CONCLUDED       Job has finished and has a retcode available
NULL            Job is being dismantled. Internal state only.

Job Verbs:

CANCEL          Instructs a running job to terminate with error,
                (Except when that job is READY, which produces no error.)
PAUSE           Request a job to pause.
RESUME          Request a job to resume from a pause.
SET-SPEED       Change the speed limiting parameter of a job.
COMPLETE        Ask a READY job to finish and exit.

FINALIZE        Ask a PENDING job to perform its graph finalization.
DISMISS         Finish cleaning up an empty job.

And here's my stab at a diagram:

                 +---------+
                 |UNDEFINED|
                 +--+------+
                    |
                 +--v----+
       +---------+CREATED+-----------------+
       |         +--+----+                 |
       |            |                      |
       |         +--+----+     +------+    |
       +---------+RUNNING<----->PAUSED|    |
       |         +--+-+--+     +------+    |
       |            | |                    |
       |            | +------------------+ |
       |            |                    | |
       |         +--v--+       +-------+ | |
       +---------+READY<------->STANDBY| | |
       |         +--+--+       +-------+ | |
       |            |                    | |
       |         +--v----+               | |
       +---------+WAITING+---------------+ |
       |         +--+----+                 |
       |            |                      |
       |         +--v----+                 |
       +---------+PENDING|                 |
       |         +--+----+                 |
       |            |                      |
    +--v-----+   +--v------+               |
    |ABORTING+--->CONCLUDED|               |
    +--------+   +--+------+               |
                    |                      |
                 +--v-+                    |
                 |NULL+--------------------+
                 +----+

v5:
001/21:[----] [--] 'blockjobs: fix set-speed kick'
002/21:[0001] [FC] 'blockjobs: model single jobs as transactions'
003/21:[down] 'Blockjobs: documentation touchup'
004/21:[0004] [FC] 'blockjobs: add status enum'
005/21:[0004] [FC] 'blockjobs: add state transition table'
006/21:[----] [--] 'iotests: add pause_wait'
007/21:[----] [--] 'blockjobs: add block_job_verb permission table'
008/21:[0004] [FC] 'blockjobs: add ABORTING state'
009/21:[0022] [FC] 'blockjobs: add CONCLUDED state'
010/21:[0025] [FC] 'blockjobs: add NULL state'
011/21:[0025] [FC] 'blockjobs: add block_job_dismiss'
012/21:[0002] [FC] 'blockjobs: ensure abort is called for cancelled jobs'
013/21:[----] [--] 'blockjobs: add commit, abort, clean helpers'
014/21:[0005] [FC] 'blockjobs: add block_job_txn_apply function'
015/21:[0006] [FC] 'blockjobs: add prepare callback'
016/21:[0031] [FC] 'blockjobs: add waiting status'
017/21:[0018] [FC] 'blockjobs: add PENDING status and event'
018/21:[0043] [FC] 'blockjobs: add block-job-finalize'
019/21:[0118] [FC] 'blockjobs: Expose manual property'
020/21:[0036] [FC] 'iotests: test manual job dismissal'
021/21:[down] 'tests/test-blockjob: test cancellations'

Big changes:
- Disallow implicit loopback transitions
- Allow CREATED-->ABORTING transitions; this is modeling how canceling
  jobs that aren't started already works.
- Use block_job_decommission to invalidate job objects instead of using
  a context-less 'unref'
- Add cancellation unit test.
- May have not added all the R-Bs I should have, and likely added some
  I shouldn't have.

02: Removed stale comment
03: New patch touching up comments, replacing the 'manual' property patch.
04: Contextual, removed doc touchup for comments previously added in 03
05: Disallow implicit loopback transitions
    Removed initial state assignment in create
08: Allow CREATED-->ABORTING transition.
    Removed forward reference to @concluded state
09: Re-added doc reference to @concluded
    Replaced block_job_event_concluded with block_job_conclude
    Fixed erroneous transition avoidance for internal jobs
    STM table change fallout from #08
10: Added assertion that jobs with no refcounts are in status NULL.
    Added block_job_decommission for the transition to the NULL state.
    block_job_create now uses block_job_early_fail on error pathways
    block_job_early_fail now uses block_job_decommission
11: block_job_do_dismiss now just calls block_job_decommission,
      see commit message
    added job->auto_dismiss property
    removed extra reference for dismiss functionality, it was an artifact
      of an older implementation and isn't needed
12: Allow ABORTING -> ABORTING transitions (kwolf)
14: Keep the assertion that completed jobs have an RC of 0.
15: Rewrote block_job_prepare to be 35% less stupid (by volume)
    Updated commit message, which is now 59% less wrong.
16: Fixed typos and diagram.
    Removed waiting event entirely.
    STM table change fallout from #08 and #12.
17: Touched up the diagram again.
    Added the MANUAL_FINALIZE and auto_finalize flag and property.
18: Changed commit message.
    Removed special casing for mixed-mode transactions for finalization step.
    block_job_cancel gets a new case for handling the cancellation of
    jobs deferred to the main loop.
19: Fallout from splitting property names, almost entirely different now.
20: Changed property names, job now tests 'dismiss' exclusively again.
21: New patch to test cancellation modes.

V4:
 - All jobs are now transactions.
 - All jobs now transition through states in a uniform way.
 - Verb permissions are now enforced.

V3:
 - Added WAITING and PENDING events
 - Added block_job_finalize verb
 - Added .pending() callback for jobs
 - Tweaked how .commit/.abort work

V2:
 - Added tests!
 - Changed property name (Jeff, Paolo)

RFC / Known problems:
- Still need more tests.
- STANDBY is still a dumb name. See v4's cover letter.
- Mirror needs to be refactored to use the commit/abort/pending/clean callbacks
  to fulfill the promise made by "no graph changes without user authorization"
  that PENDING is supposed to offer.

________________________________________________________________________________

For convenience, this branch is available at:
https://github.com/jnsnow/qemu.git branch block-job-reap
https://github.com/jnsnow/qemu/tree/block-job-reap

This version is tagged block-job-reap-v5:
https://github.com/jnsnow/qemu/releases/tag/block-job-reap-v5

John Snow (21):
  blockjobs: fix set-speed kick
  blockjobs: model single jobs as transactions
  Blockjobs: documentation touchup
  blockjobs: add status enum
  blockjobs: add state transition table
  iotests: add pause_wait
  blockjobs: add block_job_verb permission table
  blockjobs: add ABORTING state
  blockjobs: add CONCLUDED state
  blockjobs: add NULL state
  blockjobs: add block_job_dismiss
  blockjobs: ensure abort is called for cancelled jobs
  blockjobs: add commit, abort, clean helpers
  blockjobs: add block_job_txn_apply function
  blockjobs: add prepare callback
  blockjobs: add waiting status
  blockjobs: add PENDING status and event
  blockjobs: add block-job-finalize
  blockjobs: Expose manual property
  iotests: test manual job dismissal
  tests/test-blockjob: test cancellations

 block/backup.c                |   5 +-
 block/commit.c                |   2 +-
 block/mirror.c                |   2 +-
 block/stream.c                |   2 +-
 block/trace-events            |   7 +
 blockdev.c                    |  69 ++++++++-
 blockjob.c                    | 348 ++++++++++++++++++++++++++++++++++++------
 include/block/blockjob.h      |  61 +++++++-
 include/block/blockjob_int.h  |  17 ++-
 qapi/block-core.json          | 184 +++++++++++++++++++++-
 tests/qemu-iotests/030        |   6 +-
 tests/qemu-iotests/055        |  17 +--
 tests/qemu-iotests/056        | 187 +++++++++++++++++++++++
 tests/qemu-iotests/056.out    |   4 +-
 tests/qemu-iotests/109.out    |  24 +--
 tests/qemu-iotests/iotests.py |  12 +-
 tests/test-bdrv-drain.c       |   5 +-
 tests/test-blockjob-txn.c     |  19 +--
 tests/test-blockjob.c         | 233 +++++++++++++++++++++++++++-
 19 files changed, 1076 insertions(+), 128 deletions(-)

-- 
2.14.3
