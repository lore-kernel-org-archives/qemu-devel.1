Received: from eggs.gnu.org ([2001:4830:134:3::10]:58617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqi9M-0002ge-3N
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqi9L-0002Cc-5O
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:02:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Aug 2018 19:02:41 +0200
Message-Id: <20180817170246.14641-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/5] Fix some jobs/drain/aio_poll related
 hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

I'm running out of time and will be offline for the next two weeks, so
I'm just sending out what I have right now. This is probably not ready
to be merged yet, but if need be, someone else can pick it up. Otherwise
I'll do that myself when I return.

This is related to the following bug reports:
https://bugzilla.redhat.com/show_bug.cgi?id=1614623
https://bugzilla.redhat.com/show_bug.cgi?id=1601212

Essentially it tries to fix a few deadlocks into which we run when
running two commit jobs (probably just one example for problematic
scenarios) on nodes that are in a non-mainloop AioContext (i.e. with
dataplane).

Obviously, besides verifying that the code changes are actually correct
as they are, we also want to add some test cases for this. I suppose
test-bdrv-drain should test for the individual bugs, and a qemu-iotests
case could try the higher level scenario of multiple commit jobs with
dataplane.

Kevin Wolf (5):
  blockjob: Wake up BDS when job becomes idle
  tests: Acquire AioContext around job_finish_sync()
  job: Drop AioContext lock around aio_poll()
  block: Drop AioContext lock in bdrv_drain_poll_top_level()
  [WIP] Lock AioContext in bdrv_co_drain_bh_cb()

 include/block/blockjob.h | 13 +++++++++++++
 include/qemu/job.h       |  9 +++++++++
 block/io.c               | 31 ++++++++++++++++++++++++++++++-
 blockjob.c               | 18 ++++++++++++++++++
 job.c                    | 10 ++++++++++
 tests/test-bdrv-drain.c  |  6 ++++++
 tests/test-blockjob.c    |  6 ++++++
 7 files changed, 92 insertions(+), 1 deletion(-)

-- 
2.13.6
