Received: from eggs.gnu.org ([2001:4830:134:3::10]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fg9vJ-0000Ua-UB
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fg9vI-0000Pz-Dv
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:28:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 19 Jul 2018 15:28:43 +0100
Message-Id: <20180719142843.30230-2-stefanha@redhat.com>
In-Reply-To: <20180719142843.30230-1-stefanha@redhat.com>
References: <20180719142843.30230-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-v3.0 1/1] throttle-groups: fix hang when
 group member leaves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Throttle groups consist of members sharing one throttling state
(including bps/iops limits).  Round-robin scheduling is used to ensure
fairness.  If a group member already has a timer pending then other
groups members do not schedule their own timers.  The next group member
will have its turn when the existing timer expires.

A hang may occur when a group member leaves while it had a timer
scheduled.  Although the code carefully removes the group member from
the round-robin list, it does not schedule the next member.  Therefore
remaining members continue to wait for the removed member's timer to
expire.

This patch schedules the next request if a timer is pending.
Unfortunately the actual bug is a race condition that I've been unable
to capture in a test case.

Sometimes drive2 hangs when drive1 is removed from the throttling group:

  $ qemu ... -drive if=none,id=drive1,cache=none,format=qcow2,file=data1.qcow2,iops=100,group=foo \
             -device virtio-blk-pci,id=virtio-blk-pci0,drive=drive1 \
             -drive if=none,id=drive2,cache=none,format=qcow2,file=data2.qcow2,iops=10,group=foo \
             -device virtio-blk-pci,id=virtio-blk-pci1,drive=drive2
  (guest-console1)# fio -filename /dev/vda 4k-seq-read.job
  (guest-console2)# fio -filename /dev/vdb 4k-seq-read.job
  (qmp) {"execute": "block_set_io_throttle", "arguments": {"device": "drive1","bps": 0,"bps_rd": 0,"bps_wr": 0,"iops": 0,"iops_rd": 0,"iops_wr": 0}}

Reported-by: Nini Gu <ngu@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180704145410.794-1-stefanha@redhat.com
RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1535914
Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/throttle-groups.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 36cc0430c3..e297b04e17 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -564,6 +564,10 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
 
     qemu_mutex_lock(&tg->lock);
     for (i = 0; i < 2; i++) {
+        if (timer_pending(tgm->throttle_timers.timers[i])) {
+            tg->any_timer_armed[i] = false;
+            schedule_next_request(tgm, i);
+        }
         if (tg->tokens[i] == tgm) {
             token = throttle_group_next_tgm(tgm);
             /* Take care of the case where this is the last tgm in the group */
-- 
2.17.1
