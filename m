Received: from eggs.gnu.org ([2001:4830:134:3::10]:52713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYy-0001m5-Aj
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYs-0006sh-BZ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:09 +0200
Message-Id: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/46] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to bdebdc712b06ba82e103d617c335830682cde242:

  qemu-iotests: Test job-* with block jobs (2018-05-23 14:30:52 +0200)

----------------------------------------------------------------
Block layer patches:

- Generic background jobs
- qemu-iotests fixes for NFS and the 'migration' group
- sheepdog: Minor code simplification

----------------------------------------------------------------
Kevin Wolf (45):
      qemu-iotests: Fix paths for NFS
      qemu-iotests: Filter NFS paths
      qemu-iotests: 086 doesn't work with NFS
      qemu-iotests: Add more tests to "migration" group
      qemu-iotests: Remove MIG_SOCKET from non-migration tests
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

Peter Maydell (1):
      sheepdog: Remove unnecessary NULL check in sd_prealloc()

 qapi/block-core.json             |  116 +---
 qapi/job.json                    |  253 +++++++++
 qapi/qapi-schema.json            |    1 +
 include/block/block_int.h        |    2 +-
 include/block/blockjob.h         |  324 +----------
 include/block/blockjob_int.h     |  176 +-----
 include/qemu/job.h               |  562 ++++++++++++++++++++
 block.c                          |    2 +-
 block/backup.c                   |   59 +-
 block/commit.c                   |   44 +-
 block/mirror.c                   |  113 ++--
 block/replication.c              |   10 +-
 block/sheepdog.c                 |    4 +-
 block/stream.c                   |   39 +-
 blockdev.c                       |   68 +--
 blockjob.c                       | 1094 ++++++--------------------------------
 job-qmp.c                        |  188 +++++++
 job.c                            | 1000 ++++++++++++++++++++++++++++++++++
 qemu-img.c                       |   22 +-
 qemu-nbd.c                       |    8 +-
 tests/test-bdrv-drain.c          |   63 ++-
 tests/test-blockjob-txn.c        |   74 +--
 tests/test-blockjob.c            |  141 ++---
 vl.c                             |    1 +
 MAINTAINERS                      |    4 +
 Makefile                         |    9 +
 Makefile.objs                    |    7 +-
 block/trace-events               |    5 -
 tests/qemu-iotests/030           |   17 +-
 tests/qemu-iotests/040           |    2 +
 tests/qemu-iotests/041           |   23 +-
 tests/qemu-iotests/086           |    2 +-
 tests/qemu-iotests/094.out       |    7 +
 tests/qemu-iotests/095           |    2 +-
 tests/qemu-iotests/095.out       |    6 +
 tests/qemu-iotests/109           |    2 +-
 tests/qemu-iotests/109.out       |  178 ++++++-
 tests/qemu-iotests/124           |    8 +
 tests/qemu-iotests/126.out       |    2 +-
 tests/qemu-iotests/127.out       |    7 +
 tests/qemu-iotests/141           |   13 +-
 tests/qemu-iotests/141.out       |   29 +
 tests/qemu-iotests/144           |    2 +-
 tests/qemu-iotests/144.out       |    7 +
 tests/qemu-iotests/155           |    2 +-
 tests/qemu-iotests/156           |    2 +-
 tests/qemu-iotests/156.out       |    7 +
 tests/qemu-iotests/185           |   14 +-
 tests/qemu-iotests/185.out       |   10 +
 tests/qemu-iotests/191           |    6 +-
 tests/qemu-iotests/191.out       |  132 +++++
 tests/qemu-iotests/219           |  209 ++++++++
 tests/qemu-iotests/219.out       |  327 ++++++++++++
 tests/qemu-iotests/common.filter |    6 +-
 tests/qemu-iotests/common.rc     |   12 +-
 tests/qemu-iotests/group         |   11 +-
 tests/qemu-iotests/iotests.py    |   50 +-
 trace-events                     |   14 +
 58 files changed, 3601 insertions(+), 1897 deletions(-)
 create mode 100644 qapi/job.json
 create mode 100644 include/qemu/job.h
 create mode 100644 job-qmp.c
 create mode 100644 job.c
 create mode 100755 tests/qemu-iotests/219
 create mode 100644 tests/qemu-iotests/219.out
