Received: from eggs.gnu.org ([2001:4830:134:3::10]:43654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJzYV-0006vw-3i
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJzYU-000533-1I
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:25:26 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 29 Nov 2017 11:25:09 +0100
Message-Id: <20171129102513.9153-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] blockjob: reinstate busy=false/busy=true
 in block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com

In order to avoid reentering a scheduled coroutine this series uses
a QEMUTimer outside co_aio_sleep_ns.  The timer callback just calls
block_job_enter, and can be easily cancelled with timer_del.

This fixes the outstanding issues with block jobs, without reverting
the new checks that Jeff added.

I have not run the full qemu-iotests suite, but the main affected
tests (030, 041, 055, 097, 176, 200) work fine.

Paolo

Kevin Wolf (1):
  block: Expect graph changes in bdrv_parent_drained_begin/end

Paolo Bonzini (3):
  blockjob: remove clock argument from block_job_sleep_ns
  blockjob: introduce block_job_do_yield
  blockjob: reimplement block_job_sleep_ns to allow cancellation

 block/backup.c               |  4 +--
 block/commit.c               |  2 +-
 block/io.c                   |  8 ++---
 block/mirror.c               |  6 ++--
 block/stream.c               |  2 +-
 blockjob.c                   | 76 ++++++++++++++++++++++++++++++++++----------
 include/block/blockjob.h     |  5 ++-
 include/block/blockjob_int.h |  7 ++--
 tests/test-blockjob-txn.c    |  2 +-
 9 files changed, 79 insertions(+), 33 deletions(-)

-- 
2.14.3
