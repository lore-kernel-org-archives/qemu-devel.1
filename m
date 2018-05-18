Received: from eggs.gnu.org ([2001:4830:134:3::10]:59165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfK5-0007la-PC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfK4-0005hA-BP
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:21:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:20:34 +0200
Message-Id: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/40] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Before we can make x-blockdev-create a background job, we need to
generalise the job infrastructure so that it can be used without any
associated block node.

This series extracts a Job object from the block job infrastructure,
which should contain everything related to jobs that doesn't require the
block layer to be involved.

Job creation with a centralised job-create command (if we even want
this) as well as the actual conversion of x-blockdev-create to Job is
left for another series.

v2:
- Already applied a small prefix of the series and rebased, so a few
  patches are missing compared to v1

- Fixed up forgotten renames of identifiers in comments (several
  patches all over the series) [Max]

- Patch 1 and 2 (new):
  QAPI documentation improvements for existing block-job-* commands

- Patch 5 (was patch 10; 'job: Add JobDriver.job_type'):
  Added 'const' to job_type()/job_type_str() parameter [Max]

- Patch 7 (was patch 12; 'job: Maintain a list of all jobs'):
  block_job_next(NULL) doesn't rely on BlockJob.job being the first
  field any more [Eric]

- Patch 8 (was patch 13; 'job: Move state transitions to Job'):
  Renamed JobVerb paramater from 'bv' to 'verb' [Eric]

- Patch 12 (was patch 17; 'job: Move defer_to_main_loop to Job'):
  Added commit message [Max, Eric, John]
  Removed stale comment [Max]

- Patch 26 (was patch 31; 'job: Move transactions to Job'):
  job_event_pending() can keep returning void [Max]

- Patch 27 (was patch 32; 'job: Move completion and cancellation to
  Job') and patch 28 (new):
  Added TODO in patch 27, and resolved it in patch 28 by moving the
  job_cancel_all() call out of bdrv_close_all() to the callers [Max]

- Patch 30 (was patch 34; 'job: Add job_dismiss()'):
  Fixed uninitialised use of 'job' [Max]

- Patch 33 (was patch 37; 'job: Move progress fields to Job'):
  Fixed documentation for job_progress_update/set_remaining() [Eric]

- Patch 34 (new):
  Separate patch for adding qapi/job.json that just moves the three
  Job-related enums JobType, JobStatus and JobVerb (without any commands
  or events) [Max]

- Patch 35 (was patch 38; 'job: Add JOB_STATUS_CHANGE QMP event'):
  Checking JOB_STATUS_CHANGE events more consistently in tests [Max]
  Updated qemu-iotests 094 reference output [Max]

- Patch 36 (was patch 39; 'job: Add lifecycle QMP commands'):
  Removed 'force' option from 'job-cancel' and make force=true the only
  behaviour. This makes mirror behave the same as other jobs in the
  context of 'job-cancel'. [Max]
  Fixed 'job-pause' documentation [Max]

- Patch 37 (was patch 40; 'job: Add query-jobs QMP command'):
  QAPI documentation improvements [Max]

- Patch 38 (new):
  Remove redundant BlockJob.driver [Max]

- Patch 40 (was patch 42; 'qemu-iotests: Test job-* with block jobs'):
  Filtered out progress in 'query-jobs' immediately after the job is
  started because on tmpfs the first request will already have
  completed. [Max]

Kevin Wolf (40):
  blockjob: Update block-job-pause/resume documentation
  blockjob: Improve BlockJobInfo.offset/len documentation
  job: Create Job, JobDriver and job_create()
  job: Rename BlockJobType into JobType
  job: Add JobDriver.job_type
  job: Add job_delete()
  job: Maintain a list of all jobs
  job: Move state transitions to Job
  job: Add reference counting
  job: Move cancelled to Job
  job: Add Job.aio_context
  job: Move defer_to_main_loop to Job
  job: Move coroutine and related code to Job
  job: Add job_sleep_ns()
  job: Move pause/resume functions to Job
  job: Replace BlockJob.completed with job_is_completed()
  job: Move BlockJobCreateFlags to Job
  blockjob: Split block_job_event_pending()
  job: Add job_event_*()
  job: Move single job finalisation to Job
  job: Convert block_job_cancel_async() to Job
  job: Add job_drain()
  job: Move .complete callback to Job
  job: Move job_finish_sync() to Job
  job: Switch transactions to JobTxn
  job: Move transactions to Job
  job: Move completion and cancellation to Job
  block: Cancel job in bdrv_close_all() callers
  job: Add job_yield()
  job: Add job_dismiss()
  job: Add job_is_ready()
  job: Add job_transition_to_ready()
  job: Move progress fields to Job
  job: Introduce qapi/job.json
  job: Add JOB_STATUS_CHANGE QMP event
  job: Add lifecycle QMP commands
  job: Add query-jobs QMP command
  blockjob: Remove BlockJob.driver
  iotests: Move qmp_to_opts() to VM
  qemu-iotests: Test job-* with block jobs

 qapi/block-core.json          |  116 +----
 qapi/job.json                 |  252 ++++++++++
 qapi/qapi-schema.json         |    1 +
 include/block/block_int.h     |    2 +-
 include/block/blockjob.h      |  324 +-----------
 include/block/blockjob_int.h  |  176 +------
 include/qemu/job.h            |  562 +++++++++++++++++++++
 block.c                       |    2 +-
 block/backup.c                |   59 ++-
 block/commit.c                |   44 +-
 block/mirror.c                |  113 +++--
 block/replication.c           |   10 +-
 block/stream.c                |   39 +-
 blockdev.c                    |   68 +--
 blockjob.c                    | 1094 ++++++-----------------------------------
 job-qmp.c                     |  188 +++++++
 job.c                         | 1000 +++++++++++++++++++++++++++++++++++++
 qemu-img.c                    |   22 +-
 qemu-nbd.c                    |    8 +-
 tests/test-bdrv-drain.c       |   63 +--
 tests/test-blockjob-txn.c     |   74 +--
 tests/test-blockjob.c         |  141 +++---
 vl.c                          |    1 +
 MAINTAINERS                   |    3 +
 Makefile                      |    9 +
 Makefile.objs                 |    7 +-
 block/trace-events            |    5 -
 tests/qemu-iotests/030        |   17 +-
 tests/qemu-iotests/040        |    2 +
 tests/qemu-iotests/041        |   23 +-
 tests/qemu-iotests/094.out    |    7 +
 tests/qemu-iotests/095        |    2 +-
 tests/qemu-iotests/095.out    |    6 +
 tests/qemu-iotests/109        |    2 +-
 tests/qemu-iotests/109.out    |  178 ++++++-
 tests/qemu-iotests/124        |    8 +
 tests/qemu-iotests/127.out    |    7 +
 tests/qemu-iotests/141        |   13 +-
 tests/qemu-iotests/141.out    |   29 ++
 tests/qemu-iotests/144        |    2 +-
 tests/qemu-iotests/144.out    |    7 +
 tests/qemu-iotests/155        |    2 +-
 tests/qemu-iotests/156        |    2 +-
 tests/qemu-iotests/156.out    |    7 +
 tests/qemu-iotests/185        |   12 +-
 tests/qemu-iotests/185.out    |   10 +
 tests/qemu-iotests/191        |    4 +-
 tests/qemu-iotests/191.out    |  132 +++++
 tests/qemu-iotests/219        |  209 ++++++++
 tests/qemu-iotests/219.out    |  327 ++++++++++++
 tests/qemu-iotests/group      |    1 +
 tests/qemu-iotests/iotests.py |   50 +-
 trace-events                  |   14 +
 53 files changed, 3578 insertions(+), 1878 deletions(-)
 create mode 100644 qapi/job.json
 create mode 100644 include/qemu/job.h
 create mode 100644 job-qmp.c
 create mode 100644 job.c
 create mode 100755 tests/qemu-iotests/219
 create mode 100644 tests/qemu-iotests/219.out

-- 
2.13.6
