Received: from eggs.gnu.org ([2001:4830:134:3::10]:33754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3V-0004cZ-5y
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3U-0005TF-F8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Nov 2017 16:43:46 +0100
Message-Id: <20171128154350.21504-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/4] Fix qemu-iotests failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This reverts the recent fix for the case of qemu-iotests 200 (block job
completion races when using a separate I/O thread) that only fixed a
symptom and caused many regressions, and replaces it with a new
solution that hopefully attacks the right root cause.

The series also contains a bonus fix for a bug that was uncovered by the
different timing with the patches that are reverted here.

Kevin Wolf (4):
  Revert "coroutine: abort if we try to schedule or enter a pending
    coroutine"
  Revert "blockjob: do not allow coroutine double entry or
    entry-after-completion"
  coroutine: Cancel aio_co_schedule() on direct entry
  block: Expect graph changes in bdrv_parent_drained_begin/end

 include/block/blockjob_int.h |  3 +--
 include/qemu/coroutine_int.h | 14 ++++----------
 block/io.c                   |  8 ++++----
 blockjob.c                   |  7 ++-----
 util/async.c                 | 26 +++++++++++++-------------
 util/qemu-coroutine-sleep.c  | 12 ------------
 util/qemu-coroutine.c        | 31 +++++++++++++++++--------------
 7 files changed, 41 insertions(+), 60 deletions(-)

-- 
2.13.6
