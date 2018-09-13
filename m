Received: from eggs.gnu.org ([2001:4830:134:3::10]:46543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R6v-000226-BE
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R6u-0001aw-9T
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:00 +0200
Message-Id: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/17] Fix some jobs/drain/aio_poll related
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
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

Especially the combination of iothreads, block jobs and drain tends to
lead to hangs currently. This series fixes a few of these bugs, although
there are more of them, to be addressed in separate patches.

The primary goal of this series is to fix the scenario from:
https://bugzilla.redhat.com/show_bug.cgi?id=1601212

A simplified reproducer of the reported problem looks like this (two concurrent
commit block jobs for disks in an iothread):

$qemu -qmp stdio \
    -object iothread,id=iothread1 \
    -device virtio-scsi-pci,id=virtio_scsi_pci0,bus=pci.0,addr=0x6,iothread=iothread1 \
    -drive  id=drive_image1,if=none,snapshot=off,aio=threads,cache=none,format=qcow2,file=hd0 \
    -device scsi-hd,drive=drive_image1,id=image1,bootindex=1 \
    -drive  id=drive_image2,if=none,snapshot=off,aio=threads,cache=none,format=qcow2,file=hd1 \
    -device scsi-hd,drive=drive_image2,id=image2,bootindex=2

{"execute":"qmp_capabilities"}
{"execute":"blockdev-snapshot-sync","arguments":{"device":"drive_image1","snapshot-file":"sn1"}}
{"execute":"blockdev-snapshot-sync","arguments":{"device":"drive_image1","snapshot-file":"sn11"}}
{"execute":"blockdev-snapshot-sync","arguments":{"device":"drive_image1","snapshot-file":"sn111"}}
{"execute":"blockdev-snapshot-sync","arguments":{"device":"drive_image2","snapshot-file":"sn2"}}
{"execute":"blockdev-snapshot-sync","arguments":{"device":"drive_image2","snapshot-file":"sn22"}}
{"execute":"blockdev-snapshot-sync","arguments":{"device":"drive_image2","snapshot-file":"sn222"}}

{ "execute": "block-commit", "arguments": { "device": "drive_image2","base":"sn2","backing-file":"sn2","top":"sn22"}}
{ "execute": "block-commit", "arguments": { "device": "drive_image1","base":"sn1","backing-file":"sn1","top":"sn11"}}

{"execute":"quit"}

v2:
- Rebased on top of mreitz/block (including fixes for new bugs: patch 1 and 16)
- Patch 12: Added missing bdrv_unref() calls in error path [Fam]

Kevin Wolf (17):
  job: Fix missing locking due to mismerge
  blockjob: Wake up BDS when job becomes idle
  aio-wait: Increase num_waiters even in home thread
  test-bdrv-drain: Drain with block jobs in an I/O thread
  test-blockjob: Acquire AioContext around job_cancel_sync()
  job: Use AIO_WAIT_WHILE() in job_finish_sync()
  test-bdrv-drain: Test AIO_WAIT_WHILE() in completion callback
  block: Add missing locking in bdrv_co_drain_bh_cb()
  block-backend: Add .drained_poll callback
  block-backend: Fix potential double blk_delete()
  block-backend: Decrease in_flight only after callback
  mirror: Fix potential use-after-free in active commit
  blockjob: Lie better in child_job_drained_poll()
  block: Remove aio_poll() in bdrv_drain_poll variants
  test-bdrv-drain: Test nested poll in bdrv_drain_poll_top_level()
  job: Avoid deadlocks in job_completed_txn_abort()
  test-bdrv-drain: AIO_WAIT_WHILE() in job .commit/.abort

 include/block/aio-wait.h |   2 +
 include/block/blockjob.h |  13 +++
 include/qemu/coroutine.h |   5 ++
 include/qemu/job.h       |  12 +++
 block/block-backend.c    |  26 +++++-
 block/io.c               |  23 +++--
 block/mirror.c           |  11 +++
 blockjob.c               |  20 ++++-
 job.c                    |  50 ++++++++---
 tests/test-bdrv-drain.c  | 215 ++++++++++++++++++++++++++++++++++++++++++++---
 tests/test-blockjob.c    |   6 ++
 util/qemu-coroutine.c    |   5 ++
 12 files changed, 354 insertions(+), 34 deletions(-)

-- 
2.13.6
