Received: from eggs.gnu.org ([2001:4830:134:3::10]:53942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth3-0004gS-MM
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth1-0001HB-5R
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:01 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:28 -0400
Message-Id: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 00/21] jobs: defer graph changes until finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This series forces all jobs to use the "finalize" semantics that were
introduced previously, but only exposed via the backup jobs.
This series looks huge, but it's mostly mechanical changes broken out
into a series of much smaller commits so that the changes are easier
to follow at each step.

Patches one and two refactor jobs to allow a centralized call to
job_completed, which allows us to avoid calling this function from
underneath job_defer_to_main_loop_bh, which takes the aio_context lock.

Patches 3-10 take advantage of the new centralized job exit code, one
job at a time. This should be a net reduction in SLOC.

Patch 11 removes the old job_defer_to_main_loop code. If it wasn't a net
reduction in SLOC before, it is now.

Patch 12 is not necessary, but changes job entry routines to return
a status code instead of asking you to store the retcode in the job
object, so that coroutine functions read more like standard ones.
SLOC balance is a wash slightly against my favor.

Patches 13-15 add job creation flags to the commit, mirror, and stream
jobs respectively which previously did not filter these flags down to
job creation time.

Patches 16-18 refactor the completion code for commit, mirror and stream
respectively to allow graph manipulations to happen exclusively after the
finalization step instead of immediately.

Patches 19-21 expose the new job creation flags to users via QMP.

John Snow (21):
  jobs: canonize Error object
  jobs: add exit shim
  block/backup: utilize job_exit shim
  block/commit: utilize job_exit shim
  block/mirror: utilize job_exit shim
  block/stream: utilize job_exit shim
  block/create: utilize job_exit shim
  tests/test-blockjob-txn: utilize job_exit shim
  tests/test-blockjob: utilize job_exit shim
  tests/test-bdrv-drain: utilize job_exit shim
  jobs: remove job_defer_to_main_loop
  jobs: allow entrypoints to return status code
  block/commit: add block job creation flags
  block/mirror: add block job creation flags
  block/stream: add block job creation flags
  block/commit: refactor commit to use job callbacks
  block/mirror: conservative mirror_exit refactor
  block/commit: refactor stream to use job callbacks
  qapi/block-commit: expose new job properties
  qapi/block-mirror: expose new job properties
  qapi/block-stream: expose new job properties

 block/backup.c            |  21 ++-------
 block/commit.c            | 116 +++++++++++++++++++++++++++-------------------
 block/create.c            |  16 ++-----
 block/mirror.c            |  54 +++++++++++++--------
 block/stream.c            |  43 ++++++++---------
 blockdev.c                |  44 ++++++++++++++++--
 hmp.c                     |   5 +-
 include/block/block_int.h |  15 ++++--
 include/qemu/job.h        |  36 +++++---------
 job-qmp.c                 |   5 +-
 job.c                     |  64 ++++++++-----------------
 qapi/block-core.json      |  12 +++--
 tests/test-bdrv-drain.c   |  11 ++---
 tests/test-blockjob-txn.c |  23 ++++-----
 tests/test-blockjob.c     |  16 +++----
 15 files changed, 247 insertions(+), 234 deletions(-)

-- 
2.14.4
