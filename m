Received: from eggs.gnu.org ([2001:4830:134:3::10]:55436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8Q-0005xk-Jj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8N-000614-0N
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:14 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:21 -0500
Message-Id: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 00/21] blockjobs: add explicit job management
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

This series is a rough sketch that solves these problems by adding three
new distinct job states, and two new job command verbs.

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
                 |CREATED+-----------------+
                 +--+----+                 |
                    |                      |
                 +--+----+     +------+    |
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
- I need a lot more tests, still...

- STANDBY is a dumb name, and maybe not even really needed or wanted.
  However, a Paused job will return to either READY or RUNNING depending on
  the state it was in when it was PAUSED. We can keep that in an internal
  variable, or we can make it explicit in the STM.

- is "manual" descriptive as a property name?
  Kevin conceives of the new workflow as
  "No automatic transitions, please." (i.e. automatic-transitions: False)
  Whereas I think of it more like:
  "Enable manual workflow mode, please." (manual-transitions: True)

  I like the idea of the new property defaulting to false and have coded
  in a way mindful of that.

- Mirror needs to be refactored to use the commit/abort/pending/clean callbacks
  to fulfill the promise made by "no graph changes without user authorization"
  that PENDING is supposed to offer

________________________________________________________________________________

For convenience, this branch is available at:
https://github.com/jnsnow/qemu.git branch block-job-reap
https://github.com/jnsnow/qemu/tree/block-job-reap

This version is tagged block-job-reap-v4:
https://github.com/jnsnow/qemu/releases/tag/block-job-reap-v4

John Snow (21):
  blockjobs: fix set-speed kick
  blockjobs: model single jobs as transactions
  blockjobs: add manual property
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
  blockjobs: add manual_mgmt option to transactions

 block/backup.c                |   5 +-
 block/commit.c                |   2 +-
 block/mirror.c                |   2 +-
 block/stream.c                |   2 +-
 block/trace-events            |   7 +
 blockdev.c                    |  64 ++++++--
 blockjob.c                    | 355 +++++++++++++++++++++++++++++++++++++-----
 include/block/blockjob.h      |  57 ++++++-
 include/block/blockjob_int.h  |  17 +-
 qapi/block-core.json          | 193 ++++++++++++++++++++++-
 qapi/transaction.json         |   3 +-
 tests/qemu-iotests/030        |   6 +-
 tests/qemu-iotests/055        |  17 +-
 tests/qemu-iotests/056        | 195 +++++++++++++++++++++++
 tests/qemu-iotests/056.out    |   4 +-
 tests/qemu-iotests/109.out    |  24 +--
 tests/qemu-iotests/iotests.py |  12 +-
 tests/test-bdrv-drain.c       |   5 +-
 tests/test-blockjob-txn.c     |  25 ++-
 tests/test-blockjob.c         |   2 +-
 20 files changed, 877 insertions(+), 120 deletions(-)

-- 
2.14.3
