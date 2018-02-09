Received: from eggs.gnu.org ([2001:4830:134:3::10]:43450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmI-0001Lc-20
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmG-0004fA-Jl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:06 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:38 +0000
Message-Id: <20180209185142.17151-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 08/12] cuda: factor out timebase-derived
 counter value and load time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Commit b981289c49 "PPC: Cuda: Use cuda timer to expose tbfreq to guest" altered
the timer calculations from those based upon the hardware CUDA clock frequency
to those based upon the CPU timebase frequency.

In fact we can isolate the differences to 2 simple changes: one to the counter
read value and another to the counter load time. Move these changes into
separate functions so the implementation can be swapped later.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/cuda.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e00df4a21a..a185252144 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -145,21 +145,29 @@ static void cuda_update_irq(CUDAState *s)
     }
 }
 
-static uint64_t get_tb(uint64_t time, uint64_t freq)
+static uint64_t get_counter_value(CUDAState *s, CUDATimer *ti)
 {
-    return muldiv64(time, freq, NANOSECONDS_PER_SECOND);
+    /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup */
+    uint64_t tb_diff = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                                s->tb_frequency, NANOSECONDS_PER_SECOND) -
+                           ti->load_time;
+
+    return (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
+}
+
+static uint64_t get_counter_load_time(CUDAState *s, CUDATimer *ti)
+{
+    uint64_t load_time = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                                  s->tb_frequency, NANOSECONDS_PER_SECOND);
+    return load_time;
 }
 
 static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
 {
     int64_t d;
     unsigned int counter;
-    uint64_t tb_diff;
-    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup. */
-    tb_diff = get_tb(current_time, s->tb_frequency) - ti->load_time;
-    d = (tb_diff * 0xBF401675E5DULL) / (s->tb_frequency << 24);
+    d = get_counter_value(s, ti);
 
     if (ti->index == 0) {
         /* the timer goes down from latch to -1 (period of latch + 2) */
@@ -178,8 +186,7 @@ static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
 static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
 {
     CUDA_DPRINTF("T%d.counter=%d\n", 1 + ti->index, val);
-    ti->load_time = get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           s->tb_frequency);
+    ti->load_time = get_counter_load_time(s, ti);
     ti->counter_value = val;
     cuda_timer_update(s, ti, ti->load_time);
 }
-- 
2.11.0
