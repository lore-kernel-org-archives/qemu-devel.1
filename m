Received: from eggs.gnu.org ([2001:4830:134:3::10]:40034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsh-0001Nj-Qk
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsg-0002wI-VR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:11 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Dec 2017 19:59:46 -0500
Message-Id: <20171214005953.8898-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] blockjob: refactor mirror_throttle
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

________________________________________________________________________________

For convenience, this branch is available at:
https://github.com/jnsnow/qemu.git branch block-job-yield
https://github.com/jnsnow/qemu/tree/block-job-yield

This version is tagged block-job-yield-v1:
https://github.com/jnsnow/qemu/releases/tag/block-job-yield-v1

John Snow (7):
  blockjob: record time of last yield
  blockjob: consolidate SLICE_TIME definition
  blockjob: create block_job_throttle
  blockjob: allow block_job_throttle to take delay_ns
  block/commit: use block_job_throttle
  block/stream: use block_job_throttle
  block/backup: use block_job_throttle

 block/backup.c               | 12 ++++++------
 block/commit.c               |  5 ++---
 block/mirror.c               | 22 +++-------------------
 block/stream.c               |  4 +---
 blockjob.c                   | 12 ++++++++++++
 include/block/blockjob.h     |  5 +++++
 include/block/blockjob_int.h | 15 +++++++++++++++
 7 files changed, 44 insertions(+), 31 deletions(-)

-- 
2.14.3
