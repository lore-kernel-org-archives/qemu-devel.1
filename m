Received: from eggs.gnu.org ([2001:4830:134:3::10]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCh-0001yn-Mf
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCf-0008SS-2h
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:51 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36253
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCe-0008SC-Oa
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:48 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:23 +0000
Message-Id: <20180203103727.26457-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 06/10] cuda: minor cosmetic tidy-ups to
 get_next_irq_time()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index a200320e7d..3336ed46b2 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -184,36 +184,37 @@ static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
     cuda_timer_update(s, ti, ti->load_time);
 }
 
-static int64_t get_next_irq_time(CUDATimer *s, int64_t current_time)
+static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
 {
     int64_t d, next_time;
     unsigned int counter;
 
     /* current counter value */
-    d = muldiv64(current_time - s->load_time,
+    d = muldiv64(current_time - ti->load_time,
                  CUDA_TIMER_FREQ, NANOSECONDS_PER_SECOND);
     /* the timer goes down from latch to -1 (period of latch + 2) */
-    if (d <= (s->counter_value + 1)) {
-        counter = (s->counter_value - d) & 0xffff;
+    if (d <= (ti->counter_value + 1)) {
+        counter = (ti->counter_value - d) & 0xffff;
     } else {
-        counter = (d - (s->counter_value + 1)) % (s->latch + 2);
-        counter = (s->latch - counter) & 0xffff;
+        counter = (d - (ti->counter_value + 1)) % (ti->latch + 2);
+        counter = (ti->latch - counter) & 0xffff;
     }
 
     /* Note: we consider the irq is raised on 0 */
     if (counter == 0xffff) {
-        next_time = d + s->latch + 1;
+        next_time = d + ti->latch + 1;
     } else if (counter == 0) {
-        next_time = d + s->latch + 2;
+        next_time = d + ti->latch + 2;
     } else {
         next_time = d + counter;
     }
     CUDA_DPRINTF("latch=%d counter=%" PRId64 " delta_next=%" PRId64 "\n",
-                 s->latch, d, next_time - d);
+                 ti->latch, d, next_time - d);
     next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, CUDA_TIMER_FREQ) +
-        s->load_time;
-    if (next_time <= current_time)
+                         ti->load_time;
+    if (next_time <= current_time) {
         next_time = current_time + 1;
+    }
     return next_time;
 }
 
-- 
2.11.0
