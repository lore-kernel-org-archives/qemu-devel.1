Received: from eggs.gnu.org ([2001:4830:134:3::10]:50386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didichuxing.com>) id 1eeEtz-0005Mi-VF
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 01:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didichuxing.com>) id 1eeEtz-0004O0-22
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 01:51:20 -0500
Date: Wed, 24 Jan 2018 14:17:29 +0800
From: Liang Li <liliangleo@didichuxing.com>
Message-ID: <20180124061728.GA99621@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] block/mirror: fix fail to cancel when VM has
 heavy BLK IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Huaitong Han <hanhuaitong@didichuxing.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

We found that when doing drive mirror to a low speed shared storage,
if there was heavy BLK IO write workload in VM after the 'ready' event,
drive mirror block job can't be canceled immediately, it would keep
running until the heavy BLK IO workload stopped in the VM. This patch
fixed this issue.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Huaitong Han <hanhuaitong@didichuxing.com>
Signed-off-by: Liang Li <liliangleo@didichuxing.com>
---
 block/mirror.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c9badc1..3bc49a5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -869,11 +869,9 @@ static void coroutine_fn mirror_run(void *opaque)
 
         ret = 0;
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
-        if (!s->synced) {
-            block_job_sleep_ns(&s->common, delay_ns);
-            if (block_job_is_cancelled(&s->common)) {
-                break;
-            }
+
+        if (block_job_is_cancelled(&s->common)) {
+            break;
         } else if (!should_complete) {
             delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
             block_job_sleep_ns(&s->common, delay_ns);
@@ -887,7 +885,7 @@ immediate_exit:
          * or it was cancelled prematurely so that we do not guarantee that
          * the target is a copy of the source.
          */
-        assert(ret < 0 || (!s->synced && block_job_is_cancelled(&s->common)));
+        assert(ret < 0 || block_job_is_cancelled(&s->common));
         assert(need_drain);
         mirror_wait_for_all_io(s);
     }
-- 
1.8.3.1
