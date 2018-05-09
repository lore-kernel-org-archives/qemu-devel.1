Received: from eggs.gnu.org ([2001:4830:134:3::10]:51762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvp-00054p-1q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvn-000194-Sr
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:09 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:25:55 +0200
Message-Id: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 00/42] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Before we can make x-blockdev-create a background job, we need to
generalise the job infrastructure so that it can be used without any
associated block node.

This series extracts a Job object from the block job infrastructure,
which should contain everything related to jobs that doesn't require the
block layer to be involved.

Job creation with a centralised job-create command (if we even want
this) as well as the actual conversion of x-blockdev-create to Job is
left for another series. With 42 patches, the series must be perfect and
I can't add any more patches.

Kevin Wolf (42):
  blockjob: Fix assertion in block_job_finalize()
  blockjob: Wrappers for progress counter access
  blockjob: Move RateLimit to BlockJob
  blockjob: Implement block_job_set_speed() centrally
  blockjob: Introduce block_job_ratelimit_get_delay()
  blockjob: Add block_job_driver()
  blockjob: Remove block_job_pause/resume_all()
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
  job: Add job_yield()
  job: Add job_dismiss()
  job: Add job_is_ready()
  job: Add job_transition_to_ready()
  job: Move progress fields to Job
  job: Add JOB_STATUS_CHANGE QMP event
  job: Add lifecycle QMP commands
  job: Add query-jobs QMP command
  iotests: Move qmp_to_opts() to VM
  qemu-iotests: Test job-* with block jobs

 qapi/block-core.json          |   81 +--
 qapi/job.json                 |  236 +++++++++
 qapi/qapi-schema.json         |    1 +
 include/block/block_int.h     |    2 +-
 include/block/blockjob.h      |  315 +-----------
 include/block/blockjob_int.h  |  187 +------
 include/qemu/job.h            |  561 +++++++++++++++++++++
 block.c                       |    2 +-
 block/backup.c                |  111 ++---
 block/commit.c                |   75 ++-
 block/mirror.c                |  139 +++---
 block/replication.c           |   10 +-
 block/stream.c                |   68 ++-
 blockdev.c                    |   66 +--
 blockjob.c                    | 1095 ++++++-----------------------------------
 job-qmp.c                     |  194 ++++++++
 job.c                         |  994 +++++++++++++++++++++++++++++++++++++
 qemu-img.c                    |   22 +-
 tests/test-bdrv-drain.c       |   63 +--
 tests/test-blockjob-txn.c     |   74 +--
 tests/test-blockjob.c         |  141 +++---
 MAINTAINERS                   |    3 +
 Makefile                      |    9 +
 Makefile.objs                 |    6 +-
 block/trace-events            |    5 -
 tests/qemu-iotests/030        |    6 +-
 tests/qemu-iotests/040        |    2 +
 tests/qemu-iotests/041        |   23 +-
 tests/qemu-iotests/095        |    2 +-
 tests/qemu-iotests/095.out    |    6 +
 tests/qemu-iotests/109        |    2 +-
 tests/qemu-iotests/109.out    |  178 ++++++-
 tests/qemu-iotests/124        |    8 +
 tests/qemu-iotests/127.out    |    7 +
 tests/qemu-iotests/141        |   10 +-
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
 tests/qemu-iotests/219        |  201 ++++++++
 tests/qemu-iotests/219.out    |  327 ++++++++++++
 tests/qemu-iotests/group      |    1 +
 tests/qemu-iotests/iotests.py |   45 +-
 trace-events                  |   14 +
 50 files changed, 3568 insertions(+), 1931 deletions(-)
 create mode 100644 qapi/job.json
 create mode 100644 include/qemu/job.h
 create mode 100644 job-qmp.c
 create mode 100644 job.c
 create mode 100755 tests/qemu-iotests/219
 create mode 100644 tests/qemu-iotests/219.out

-- 
2.13.6
