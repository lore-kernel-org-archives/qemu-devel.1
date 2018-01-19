Received: from eggs.gnu.org ([2001:4830:134:3::10]:46291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkd-0001Wl-8K
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkc-0005v9-CC
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:03 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:34 -0500
Message-Id: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/13] blockjob: refactor mirror_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

mirror_throttle attempts to make sure we yield every so often when we're
doing operations that may not otherwise be as cooperative as we'd like.

This pattern is useful to other jobs like commit as well; if commit
continuously decides not to copy data (and calculates delay_ns to be 0),
we'll frequently and aggressively yield, only to be rescheduled immediately.

This causes those "WARNING: I/O thread spun for 1000 iterations"
warnings that everyone loves so much.

Split out the mirror_throttle function to become a new internal
BlockJob API function, block_job_throttle; then use it for all
the other jobs in their runtime loops.

I decided to use it in stream and backup as well, so that regardless of if the
loop structure has the chance to be greedy or not (I did not audit this), the
BlockJob has some kind of failsafe that will occasionally perform a 0ns sleep
every SLICE_TIME.

v2:
 - Fixed spacing consistency (Paolo)
 - Renamed last_yield_ns to last_enter_ns (Stefan)
 - Renamed block_job_throttle to block_job_relax (Stefan)
 - Removed external usages of block_job_pause_point and
   block_job_sleep_ns (Paolo)
 - Further cut down block/backup code to use block_job_relax

________________________________________________________________________________

For convenience, this branch is available at:
https://github.com/jnsnow/qemu.git branch block-job-yield
https://github.com/jnsnow/qemu/tree/block-job-yield

This version is tagged block-job-yield-v2:
https://github.com/jnsnow/qemu/releases/tag/block-job-yield-v2

John Snow (13):
  blockjob: record time of last entrance
  blockjob: consolidate SLICE_TIME definition
  blockjob: create block_job_relax
  blockjob: allow block_job_throttle to take delay_ns
  block/commit: use block_job_relax
  block/stream: use block_job_relax
  block/backup: use block_job_relax
  allow block_job_relax to return -ECANCELED
  block/backup: remove yield_and_check
  block/mirror: condense cancellation and relax calls
  block/mirror: remove block_job_sleep_ns calls
  blockjob: privatize block_job_sleep_ns
  blockjob: remove block_job_pause_point from interface

 block/backup.c               | 27 ++++++-----------------
 block/commit.c               |  4 +---
 block/mirror.c               | 52 +++++++++++++++-----------------------------
 block/stream.c               |  4 +---
 block/trace-events           |  2 +-
 blockjob.c                   | 51 ++++++++++++++++++++++++++++++++++++-------
 include/block/blockjob.h     |  5 +++++
 include/block/blockjob_int.h | 37 +++++++++++++++----------------
 tests/test-bdrv-drain.c      |  2 +-
 tests/test-blockjob-txn.c    |  2 +-
 10 files changed, 94 insertions(+), 92 deletions(-)

-- 
2.14.3
