Received: from eggs.gnu.org ([2001:4830:134:3::10]:43489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmJ-0001Mw-5U
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDmI-0004gf-7K
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:52:07 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:35 +0000
Message-Id: <20180209185142.17151-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 05/12] cuda: rename frequency property to
 tb_frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

This allows us to more easily differentiate between the timebase frequency used
to calibrate the MacOS timers and the actual frequency of the hardware clock as
indicated by CUDA_TIMER_FREQ.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/macio/cuda.c  | 10 +++++-----
 hw/misc/macio/macio.c |  2 +-
 hw/ppc/mac.h          |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index a88535fa66..232b7f61aa 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -158,8 +158,8 @@ static unsigned int get_counter(CUDAState *s, CUDATimer *ti)
     uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     /* Reverse of the tb calculation algorithm that Mac OS X uses on bootup. */
-    tb_diff = get_tb(current_time, ti->frequency) - ti->load_time;
-    d = (tb_diff * 0xBF401675E5DULL) / (ti->frequency << 24);
+    tb_diff = get_tb(current_time, ti->tb_frequency) - ti->load_time;
+    d = (tb_diff * 0xBF401675E5DULL) / (ti->tb_frequency << 24);
 
     if (ti->index == 0) {
         /* the timer goes down from latch to -1 (period of latch + 2) */
@@ -179,7 +179,7 @@ static void set_counter(CUDAState *s, CUDATimer *ti, unsigned int val)
 {
     CUDA_DPRINTF("T%d.counter=%d\n", 1 + ti->index, val);
     ti->load_time = get_tb(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                           s->frequency);
+                           s->tb_frequency);
     ti->counter_value = val;
     cuda_timer_update(s, ti, ti->load_time);
 }
@@ -878,7 +878,7 @@ static void cuda_realizefn(DeviceState *dev, Error **errp)
     struct tm tm;
 
     s->timers[0].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer1, s);
-    s->timers[0].frequency = s->frequency;
+    s->timers[0].frequency = s->tb_frequency;
     s->timers[1].timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_timer2, s);
     s->timers[1].frequency = (SCALE_US * 6000) / 4700;
 
@@ -909,7 +909,7 @@ static void cuda_initfn(Object *obj)
 }
 
 static Property cuda_properties[] = {
-    DEFINE_PROP_UINT64("frequency", CUDAState, frequency, 0),
+    DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 44f91d1e7f..a639b09e00 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -451,7 +451,7 @@ void macio_init(PCIDevice *d,
     macio_state->escc_mem = escc_mem;
     /* Note: this code is strongly inspirated from the corresponding code
        in PearPC */
-    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "frequency",
+    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency",
                          macio_state->frequency);
 
     qdev_init_nofail(DEVICE(d));
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index b501af1653..fa78115c95 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -99,7 +99,7 @@ typedef struct CUDAState {
     CUDATimer timers[2];
 
     uint32_t tick_offset;
-    uint64_t frequency;
+    uint64_t tb_frequency;
 
     uint8_t last_b;
     uint8_t last_acr;
-- 
2.11.0
