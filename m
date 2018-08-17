Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk90-0001Dr-LY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk3i-0006mA-0i
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:05:19 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 17 Aug 2018 15:04:50 -0400
Message-Id: <20180817190457.8292-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] jobs: remove job_defer_to_main_loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

First, it's redundant to have each job manage this itself.
Second, doing so allows us to remove a tricky case where the completion
code is called under an aio_context lock, which then calls the
finalization code which is itself executed under a second aio_context
lock.

Removing this recursive lock acquisition is necessary for converting
mirror to only modify its graph post-finalization, but it's also just
safer and will bite us less in the future.

This series introduces a .job_exit callback, but after jobs are
fully transitioned to using the .commit/.abort callbacks, this new
completion callback will be removed.

John Snow (7):
  jobs: change start callback to run callback
  jobs: canonize Error object
  jobs: add exit shim
  block/commit: utilize job_exit shim
  block/mirror: utilize job_exit shim
  jobs: utilize job_exit shim
  jobs: remove job_defer_to_main_loop

 block/backup.c            | 23 +++-------------
 block/commit.c            | 27 ++++++-------------
 block/create.c            | 19 +++++--------
 block/mirror.c            | 35 +++++++++++-------------
 block/stream.c            | 29 ++++++++------------
 include/qemu/job.h        | 36 +++++++++----------------
 job-qmp.c                 |  5 ++--
 job.c                     | 68 +++++++++++++++--------------------------------
 tests/test-bdrv-drain.c   | 13 +++------
 tests/test-blockjob-txn.c | 25 +++++++----------
 tests/test-blockjob.c     | 17 ++++++------
 11 files changed, 102 insertions(+), 195 deletions(-)

-- 
2.14.4
