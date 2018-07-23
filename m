Received: from eggs.gnu.org ([2001:4830:134:3::10]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJk-0002wf-D7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJi-0004ix-Kc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:28 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:02 -0500
Message-Id: <20180723201748.25573-54-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/99] block/mirror: honor ratelimit again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Liang Li <liliang.opensource@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit b76e4458b1eb3c32e9824fe6aa51f67d2b251748 ("block/mirror: change
the semantic of 'force' of block-job-cancel") accidentally removed the
ratelimit in the mirror job.

Reintroduce the ratelimit but keep the block-job-cancel force=true
behavior that was added in commit
b76e4458b1eb3c32e9824fe6aa51f67d2b251748.

Note that block_job_sleep_ns() returns immediately when the job is
cancelled.  Therefore it's safe to unconditionally call
block_job_sleep_ns() - a cancelled job does not sleep.

This commit fixes the non-deterministic qemu-iotests 185 output.  The
test relies on the ratelimit to make the job sleep until the 'quit'
command is processed.  Previously the job could complete before the
'quit' command was received since there was no ratelimit.

Cc: Liang Li <liliang.opensource@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180424123527.19168-1-stefanha@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit ddc4115efdfa6619689fe18871aa2d37890b3463)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/mirror.c             | 8 +++++---
 tests/qemu-iotests/185.out | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 820f512c7b..9436a8d5ee 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -868,12 +868,14 @@ static void coroutine_fn mirror_run(void *opaque)
         }
 
         ret = 0;
+
+        if (s->synced && !should_complete) {
+            delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
+        }
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
+        block_job_sleep_ns(&s->common, delay_ns);
         if (block_job_is_cancelled(&s->common) && s->common.force) {
             break;
-        } else if (!should_complete) {
-            delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
-            block_job_sleep_ns(&s->common, delay_ns);
         }
         s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     }
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 2c4b04de73..992162f418 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -36,9 +36,9 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 {"return": {}}
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len": 4194304, "offset": 4194304, "speed": 65536, "type": "mirror"}}
 
 === Start backup job and exit qemu ===
-- 
2.17.1
