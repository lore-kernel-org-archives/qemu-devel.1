Received: from eggs.gnu.org ([2001:4830:134:3::10]:45062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zP-0007kp-HN
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006CM-O4
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:52 +1100
Message-Id: <20180212034054.23441-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/12] cuda: set timer 1 frequency property to
 CUDA_TIMER_FREQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Now that we have successfully decoupled the timebase frequency and the hardware
timer frequency, set the timer 1 frequency property to CUDA_TIMER_FREQ and alter
get_next_irq_time() to use it rather than the hard-coded constant.

In addition to this we must now switch the tb_diff calculation over to use the
timebase frequency now that the hardware clock frequency and the timebase
frequency are different.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
[dwg: Correct a conflict due to a bug in an earlier patch]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 355a2f2262..e00df4a21a 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -158,8 +158,8 @@ static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
     uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup. */
-    tb_diff = get_tb(current_time, ti->frequency) - ti->load_time;
-    d = (tb_diff * 0xBF401675E5DULL) / (ti->frequency << 24);
+    tb_diff = get_tb(current_time, s->tb_frequency) - ti->load_time;
+    d = (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
 
     if (ti->index == 0) {
         /* the timer goes down from latch to -1 (period of latch + 2) */
@@ -191,7 +191,7 @@ static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
 
     /* current counter value */
     d = muldiv64(current_time - ti->load_time,
-                 CUDA_TIMER_FREQ, NANOSECONDS_PER_SECOND);
+                 ti->frequency, NANOSECONDS_PER_SECOND);
     /* the timer goes down from latch to -1 (period of latch + 2) */
     if (d <= (ti->counter_value + 1)) {
         counter = (ti->counter_value - d) & 0xffff;
@@ -210,7 +210,7 @@ static int64_t get_next_irq_time(CUDATimer *ti, int64_t current_time)
     }
     CUDA_DPRINTF("latch=%d counter=%" PRId64 " delta_next=%" PRId64 "\n",
                  ti->latch, d, next_time - d);
-    next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, CUDA_TIMER_FREQ) +
+    next_time = muldiv64(next_time, NANOSECONDS_PER_SECOND, ti->frequency) +
                          ti->load_time;
     if (next_time <= current_time) {
         next_time = current_time + 1;
@@ -879,7 +879,7 @@ static void cuda_realizefn(DeviceState *dev, Error **errp)
     struct tm tm;
 
     s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer1, s);
-    s->timers[0].frequency = s->tb_frequency;
+    s->timers[0].frequency = CUDA_TIMER_FREQ;
     s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer2, s);
     s->timers[1].frequency = (SCALE_US * 6000) / 4700;
 
-- 
2.14.3
