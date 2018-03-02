Received: from eggs.gnu.org ([2001:4830:134:3::10]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWT-0002kq-Qv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWS-0004kV-D7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWS-0004jE-40
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWQ-0001Ij-Hd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:03 +0000
Message-Id: <20180302110640.28004-3-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/39] xlnx-zynqmp-rtc: Add basic time support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Allow the guest to determine the time set from the QEMU command line.

This includes adding a trace event to debug the new time.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/xlnx-zynqmp-rtc.h |  2 ++
 hw/timer/xlnx-zynqmp-rtc.c         | 58 ++++++++++++++++++++++++++++++++++++++
 hw/timer/trace-events              |  3 ++
 3 files changed, 63 insertions(+)

diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
index 87649836cc..5ba4d8bc4a 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -79,6 +79,8 @@ typedef struct XlnxZynqMPRTC {
     qemu_irq irq_rtc_int;
     qemu_irq irq_addr_error_int;
 
+    uint32_t tick_offset;
+
     uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
 } XlnxZynqMPRTC;
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index 707f145027..c98dc3d94e 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -29,6 +29,10 @@
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "hw/ptimer.h"
+#include "qemu/cutils.h"
+#include "sysemu/sysemu.h"
+#include "trace.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
 
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
@@ -47,6 +51,19 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
     qemu_set_irq(s->irq_addr_error_int, pending);
 }
 
+static uint32_t rtc_get_count(XlnxZynqMPRTC *s)
+{
+    int64_t now = qemu_clock_get_ns(rtc_clock);
+    return s->tick_offset + now / NANOSECONDS_PER_SECOND;
+}
+
+static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+
+    return rtc_get_count(s);
+}
+
 static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
 {
     XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
@@ -97,13 +114,17 @@ static uint64_t addr_error_int_dis_prew(RegisterInfo *reg, uint64_t val64)
 
 static const RegisterAccessInfo rtc_regs_info[] = {
     {   .name = "SET_TIME_WRITE",  .addr = A_SET_TIME_WRITE,
+        .unimp = MAKE_64BIT_MASK(0, 32),
     },{ .name = "SET_TIME_READ",  .addr = A_SET_TIME_READ,
         .ro = 0xffffffff,
+        .post_read = current_time_postr,
     },{ .name = "CALIB_WRITE",  .addr = A_CALIB_WRITE,
+        .unimp = MAKE_64BIT_MASK(0, 32),
     },{ .name = "CALIB_READ",  .addr = A_CALIB_READ,
         .ro = 0x1fffff,
     },{ .name = "CURRENT_TIME",  .addr = A_CURRENT_TIME,
         .ro = 0xffffffff,
+        .post_read = current_time_postr,
     },{ .name = "CURRENT_TICK",  .addr = A_CURRENT_TICK,
         .ro = 0xffff,
     },{ .name = "ALARM",  .addr = A_ALARM,
@@ -162,6 +183,7 @@ static void rtc_init(Object *obj)
     XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     RegisterInfoArray *reg_array;
+    struct tm current_tm;
 
     memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_RTC,
                        XLNX_ZYNQMP_RTC_R_MAX * 4);
@@ -178,14 +200,50 @@ static void rtc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq_rtc_int);
     sysbus_init_irq(sbd, &s->irq_addr_error_int);
+
+    qemu_get_timedate(&current_tm, 0);
+    s->tick_offset = mktimegm(&current_tm) -
+        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+
+    trace_xlnx_zynqmp_rtc_gettime(current_tm.tm_year, current_tm.tm_mon,
+                                  current_tm.tm_mday, current_tm.tm_hour,
+                                  current_tm.tm_min, current_tm.tm_sec);
+}
+
+static int rtc_pre_save(void *opaque)
+{
+    XlnxZynqMPRTC *s = opaque;
+    int64_t now = qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+
+    /* Add the time at migration */
+    s->tick_offset = s->tick_offset + now;
+
+    return 0;
+}
+
+static int rtc_post_load(void *opaque, int version_id)
+{
+    XlnxZynqMPRTC *s = opaque;
+    int64_t now = qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+
+    /* Subtract the time after migration. This combined with the pre_save
+     * action results in us having subtracted the time that the guest was
+     * stopped to the offset.
+     */
+    s->tick_offset = s->tick_offset - now;
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_rtc = {
     .name = TYPE_XLNX_ZYNQMP_RTC,
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_save = rtc_pre_save,
+    .post_load = rtc_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
+        VMSTATE_UINT32(tick_offset, XlnxZynqMPRTC),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 640722b5d1..e6e042fddb 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -60,3 +60,6 @@ systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr
 cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
+
+# hw/timer/xlnx-zynqmp-rtc.c
+xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
-- 
2.16.2
