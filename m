Received: from eggs.gnu.org ([2001:4830:134:3::10]:47509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAzp1-0007mp-Fw
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAzoz-0007m6-2P
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 24 Apr 2018 17:24:42 +0200
Message-Id: <20180424152515.25664-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/33] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Before we can make x-blockdev-create a background job, we need to
generalise the job infrastructure so that it can be used without any
associated block node.

This series extracts a Job object from the block job infrastructure,
which should contain everything related to jobs that doesn't require the
block layer to be involved.

The split between BlockJob and Job is reasonably complete as of this RFC
(though there are still some rough edges). Missing are mainly:

* Some cleanups. This means mostly TODOs left for functions moved to
  job.c that should become static again, but were still called from
  blockjob.c. At this point, most of these public declarations aren't
  actually necessary any more, or very little is missing to make them
  unnecessary.

* A QMP interface that can be used with non-block job. The existing
  block-job-* QMP commands will tell the user that they don't know the
  job if you pass the ID of a non-block job.

* The actual conversion of x-blockdev-create to Job, as a proof of
  concept that the generalised infrastructure actually works.

Kevin Wolf (33):
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

 qapi/block-core.json         |   28 +-
 include/block/block_int.h    |    2 +-
 include/block/blockjob.h     |  306 ++----------
 include/block/blockjob_int.h |  179 +------
 include/qemu/job.h           |  513 ++++++++++++++++++++
 block.c                      |    2 +-
 block/backup.c               |  111 +++--
 block/commit.c               |   75 ++-
 block/mirror.c               |  131 +++---
 block/replication.c          |   10 +-
 block/stream.c               |   68 ++-
 blockdev.c                   |   66 +--
 blockjob.c                   | 1054 ++++++------------------------------------
 job.c                        |  950 +++++++++++++++++++++++++++++++++++++
 qemu-img.c                   |   14 +-
 tests/test-bdrv-drain.c      |   61 +--
 tests/test-blockjob-txn.c    |   74 +--
 tests/test-blockjob.c        |  137 +++---
 MAINTAINERS                  |    2 +
 Makefile.objs                |    2 +-
 block/trace-events           |    5 -
 trace-events                 |    5 +
 22 files changed, 2049 insertions(+), 1746 deletions(-)
 create mode 100644 include/qemu/job.h
 create mode 100644 job.c

-- 
2.13.6
