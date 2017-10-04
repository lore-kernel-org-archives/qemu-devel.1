Received: from eggs.gnu.org ([2001:4830:134:3::10]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzYrB-0005j0-6U
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzYrA-0000Hu-GX
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:52:17 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  3 Oct 2017 21:52:01 -0400
Message-Id: <20171004015205.20724-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] blockjobs: add explicit job reaping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

For jobs that complete when a monitor isn't looking, there's no way to
tell what the job's final return code was. We need to allow jobs to
remain in the list until queried for reliable management.

V2:
 - Added tests!
 - Changed property name (Jeff, Paolo)

RFC:
The next version will add tests for transactions.
Kevin, can you please take a look at bdrv_is_root_node and how it is
used with respect to do_drive_backup? I suspect that in this case that
"is root" should actually be "true", but a node in use by a job has
two roles; child_root and child_job, so it starts returning false here.

That's fine because we prevent a collision that way, but it makes the
error messages pretty bad and misleading. Do you have a quick suggestion?
(Should I just amend the loop to allow non-root nodes as long as they
happen to be jobs so that the job creation code can check permissions?)

John Snow (4):
  blockjob: add persistent property
  qmp: add block-job-reap command
  blockjob: expose persistent property
  iotests: test manual job reaping

 block/backup.c               |  20 ++--
 block/commit.c               |   2 +-
 block/mirror.c               |   2 +-
 block/replication.c          |   5 +-
 block/stream.c               |   2 +-
 block/trace-events           |   1 +
 blockdev.c                   |  28 +++++-
 blockjob.c                   |  46 ++++++++-
 include/block/block_int.h    |   8 +-
 include/block/blockjob.h     |  21 ++++
 include/block/blockjob_int.h |   2 +-
 qapi/block-core.json         |  49 ++++++++--
 tests/qemu-iotests/056       | 227 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/056.out   |   4 +-
 tests/test-blockjob-txn.c    |   2 +-
 tests/test-blockjob.c        |   2 +-
 16 files changed, 384 insertions(+), 37 deletions(-)

-- 
2.9.5
