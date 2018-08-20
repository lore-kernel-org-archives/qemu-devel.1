Received: from eggs.gnu.org ([2001:4830:134:3::10]:41873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frku4-0003T9-9k
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frku3-0007Fk-7A
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:32 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:10:55 +0100
Message-Id: <20180820141116.9118-2-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/22] hw/misc/mps2-fpgaio: Implement 1Hz and
 100Hz counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The MPS2 FPGAIO block includes some simple free-running counters.
Implement these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/mps2-fpgaio.h |  4 +++
 hw/misc/mps2-fpgaio.c         | 53 ++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
index eedf17ebc6d..ec057d38c76 100644
--- a/include/hw/misc/mps2-fpgaio.h
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -38,6 +38,10 @@ typedef struct {
     uint32_t misc;
 
     uint32_t prescale_clk;
+
+    /* These hold the CLOCK_VIRTUAL ns tick when the CLK1HZ/CLK100HZ was zero */
+    int64_t clk1hz_tick_offset;
+    int64_t clk100hz_tick_offset;
 } MPS2FPGAIO;
 
 #endif
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 7394a057d82..bbc28f641f0 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -22,6 +22,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "qemu/timer.h"
 
 REG32(LED0, 0)
 REG32(BUTTON, 8)
@@ -32,10 +33,21 @@ REG32(PRESCALE, 0x1c)
 REG32(PSCNTR, 0x20)
 REG32(MISC, 0x4c)
 
+static uint32_t counter_from_tickoff(int64_t now, int64_t tick_offset, int frq)
+{
+    return muldiv64(now - tick_offset, frq, NANOSECONDS_PER_SECOND);
+}
+
+static int64_t tickoff_from_counter(int64_t now, uint32_t count, int frq)
+{
+    return now - muldiv64(count, NANOSECONDS_PER_SECOND, frq);
+}
+
 static uint64_t mps2_fpgaio_read(void *opaque, hwaddr offset, unsigned size)
 {
     MPS2FPGAIO *s = MPS2_FPGAIO(opaque);
     uint64_t r;
+    int64_t now;
 
     switch (offset) {
     case A_LED0:
@@ -54,10 +66,15 @@ static uint64_t mps2_fpgaio_read(void *opaque, hwaddr offset, unsigned size)
         r = s->misc;
         break;
     case A_CLK1HZ:
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        r = counter_from_tickoff(now, s->clk1hz_tick_offset, 1);
+        break;
     case A_CLK100HZ:
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        r = counter_from_tickoff(now, s->clk100hz_tick_offset, 100);
+        break;
     case A_COUNTER:
     case A_PSCNTR:
-        /* These are all upcounters of various frequencies. */
         qemu_log_mask(LOG_UNIMP, "MPS2 FPGAIO: counters unimplemented\n");
         r = 0;
         break;
@@ -76,6 +93,7 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
     MPS2FPGAIO *s = MPS2_FPGAIO(opaque);
+    int64_t now;
 
     trace_mps2_fpgaio_write(offset, value, size);
 
@@ -100,6 +118,14 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
                       "MPS2 FPGAIO: MISC control bits unimplemented\n");
         s->misc = value;
         break;
+    case A_CLK1HZ:
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->clk1hz_tick_offset = tickoff_from_counter(now, value, 1);
+        break;
+    case A_CLK100HZ:
+        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->clk100hz_tick_offset = tickoff_from_counter(now, value, 100);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "MPS2 FPGAIO write: bad offset 0x%x\n", (int) offset);
@@ -116,11 +142,14 @@ static const MemoryRegionOps mps2_fpgaio_ops = {
 static void mps2_fpgaio_reset(DeviceState *dev)
 {
     MPS2FPGAIO *s = MPS2_FPGAIO(dev);
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
     trace_mps2_fpgaio_reset();
     s->led0 = 0;
     s->prescale = 0;
     s->misc = 0;
+    s->clk1hz_tick_offset = tickoff_from_counter(now, 0, 1);
+    s->clk100hz_tick_offset = tickoff_from_counter(now, 0, 100);
 }
 
 static void mps2_fpgaio_init(Object *obj)
@@ -133,6 +162,24 @@ static void mps2_fpgaio_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static bool mps2_fpgaio_counters_needed(void *opaque)
+{
+    /* Currently vmstate.c insists all subsections have a 'needed' function */
+    return true;
+}
+
+static const VMStateDescription mps2_fpgaio_counters_vmstate = {
+    .name = "mps2-fpgaio/counters",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mps2_fpgaio_counters_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT64(clk1hz_tick_offset, MPS2FPGAIO),
+        VMSTATE_INT64(clk100hz_tick_offset, MPS2FPGAIO),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription mps2_fpgaio_vmstate = {
     .name = "mps2-fpgaio",
     .version_id = 1,
@@ -142,6 +189,10 @@ static const VMStateDescription mps2_fpgaio_vmstate = {
         VMSTATE_UINT32(prescale, MPS2FPGAIO),
         VMSTATE_UINT32(misc, MPS2FPGAIO),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &mps2_fpgaio_counters_vmstate,
+        NULL
     }
 };
 
-- 
2.18.0
