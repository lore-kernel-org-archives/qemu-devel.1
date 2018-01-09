Received: from eggs.gnu.org ([2001:4830:134:3::10]:46676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eYz3Z-0005Pe-Cl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eYz3V-0000kf-2K
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:55:29 -0500
Received: from mail-by2nam01on0061.outbound.protection.outlook.com
	([104.47.34.61]:2493
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eYz3U-0000jO-KD
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:55:24 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 9 Jan 2018 10:50:54 -0800
Message-ID: <ed917e0eb352563c4598e367d363fc90e9bc020a.1515523657.git.alistair.francis@xilinx.com>
In-Reply-To: <b799d9d21170a492c54fb2c4eaf8326b06e0bdf6.1515523657.git.alistair.francis@xilinx.com>
References: <b799d9d21170a492c54fb2c4eaf8326b06e0bdf6.1515523657.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/3] xlnx-zynqmp-rtc: Add basic time support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

Allow the guest to determine the time set from the QEMU command line.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/timer/xlnx-zynqmp-rtc.c         | 24 ++++++++++++++++++++++++
 include/hw/timer/xlnx-zynqmp-rtc.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index 40533220fc..eed17805ac 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -29,6 +29,7 @@
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "hw/ptimer.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
 
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
@@ -55,6 +56,13 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
     qemu_set_irq(s->irq_addr_error_int, pending);
 }
 
+static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+
+    return mktime(&s->current_tm);
+}
+
 static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
 {
     XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
@@ -111,11 +119,13 @@ static const RegisterAccessInfo rtc_regs_info[] = {
     {   .name = "SET_TIME_WRITE",  .addr = A_SET_TIME_WRITE,
     },{ .name = "SET_TIME_READ",  .addr = A_SET_TIME_READ,
         .ro = 0xffffffff,
+        .post_read = current_time_postr,
     },{ .name = "CALIB_WRITE",  .addr = A_CALIB_WRITE,
     },{ .name = "CALIB_READ",  .addr = A_CALIB_READ,
         .ro = 0x1fffff,
     },{ .name = "CURRENT_TIME",  .addr = A_CURRENT_TIME,
         .ro = 0xffffffff,
+        .post_read = current_time_postr,
     },{ .name = "CURRENT_TICK",  .addr = A_CURRENT_TICK,
         .ro = 0xffff,
     },{ .name = "ALARM",  .addr = A_ALARM,
@@ -155,6 +165,13 @@ static void rtc_reset(DeviceState *dev)
         register_reset(&s->regs_info[i]);
     }
 
+    qemu_get_timedate(&s->current_tm, 0);
+
+    DB_PRINT("Get time from host: %d-%d-%d %2d:%02d:%02d\n",
+             s->current_tm.tm_year, s->current_tm.tm_mon,
+             s->current_tm.tm_mday, s->current_tm.tm_hour,
+             s->current_tm.tm_min, s->current_tm.tm_sec);
+
     rtc_int_update_irq(s);
     addr_error_int_update_irq(s);
 }
@@ -203,6 +220,13 @@ static const VMStateDescription vmstate_rtc = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
+        VMSTATE_INT32(current_tm.tm_sec, XlnxZynqMPRTC),
+        VMSTATE_INT32(current_tm.tm_min, XlnxZynqMPRTC),
+        VMSTATE_INT32(current_tm.tm_hour, XlnxZynqMPRTC),
+        VMSTATE_INT32(current_tm.tm_wday, XlnxZynqMPRTC),
+        VMSTATE_INT32(current_tm.tm_mday, XlnxZynqMPRTC),
+        VMSTATE_INT32(current_tm.tm_mon, XlnxZynqMPRTC),
+        VMSTATE_INT32(current_tm.tm_year, XlnxZynqMPRTC),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
index 87649836cc..51a49094ad 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -79,6 +79,8 @@ typedef struct XlnxZynqMPRTC {
     qemu_irq irq_rtc_int;
     qemu_irq irq_addr_error_int;
 
+    struct tm current_tm;
+
     uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
 } XlnxZynqMPRTC;
-- 
2.14.1
