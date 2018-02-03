Received: from eggs.gnu.org ([2001:4830:134:3::10]:50440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCi-0001zz-Eb
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCg-0008TD-Fj
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:52 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36256
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCg-0008So-4j
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:50 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:24 +0000
Message-Id: <20180203103727.26457-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 07/10] cuda: set timer 1 frequency property to
 CUDA_TIMER_FREQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

Now that we have successfully decoupled the timebase frequency and the hardware
timer frequency, set the timer 1 frequency property to CUDA_TIMER_FREQ and alter
get_next_irq_time() to use it rather than the hard-coded constant.

In addition to this we must now switch the tb_diff calculation over to use the
timebase frequency now that the hardware clock frequency and the timebase
frequency are different.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 3336ed46b2..00e71fcd5e 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -158,8 +158,8 @@ static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
     uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup. */
-    tb_diff = get_tb(current_time, ti->tb_frequency) - ti->load_time;
-    d = (tb_diff * 0xBF401675E5DULL) / (ti->tb_frequency << 24);
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
2.11.0
