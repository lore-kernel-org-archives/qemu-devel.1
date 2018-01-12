Received: from eggs.gnu.org ([2001:4830:134:3::10]:60347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ea81A-0000Rc-7m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ea816-0003RU-3L
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:41:44 -0500
Received: from mail-by2nam03on0066.outbound.protection.outlook.com
	([104.47.42.66]:32800
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ea815-0003Q1-Qz
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:41:40 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 12 Jan 2018 14:37:02 -0800
Message-ID: <9443d0cbb39ca4173d40b4116655c0309cc05983.1515796549.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1515796549.git.alistair.francis@xilinx.com>
References: <cover.1515796549.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] xlnx-zynqmp-rtc: Add basic time support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, f4bug@amsat.org

Allow the guest to determine the time set from the QEMU command line.

This includes adding a trace event to debug the new time.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
 - Convert DB_PRINT() macro to trace

 hw/timer/trace-events              |  3 +++
 hw/timer/xlnx-zynqmp-rtc.c         | 23 +++++++++++++++++++++++
 include/hw/timer/xlnx-zynqmp-rtc.h |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 640722b5d1..e6e042fddb 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -60,3 +60,6 @@ systick_write(uint64_t addr, uint32_t value, unsigned siz=
e) "systick write addr
 cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK=
 APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSD=
K APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
+
+# hw/timer/xlnx-zynqmp-rtc.c
+xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, i=
nt sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index ead40fc42d..4adcc4701a 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -29,6 +29,7 @@
 #include "hw/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
+#include "hw/ptimer.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"

 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
@@ -47,6 +48,13 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
     qemu_set_irq(s->irq_addr_error_int, pending);
 }

+static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+
+    return mktime(&s->current_tm);
+}
+
 static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
 {
     XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
@@ -103,11 +111,13 @@ static const RegisterAccessInfo rtc_regs_info[] =3D {
     {   .name =3D "SET_TIME_WRITE",  .addr =3D A_SET_TIME_WRITE,
     },{ .name =3D "SET_TIME_READ",  .addr =3D A_SET_TIME_READ,
         .ro =3D 0xffffffff,
+        .post_read =3D current_time_postr,
     },{ .name =3D "CALIB_WRITE",  .addr =3D A_CALIB_WRITE,
     },{ .name =3D "CALIB_READ",  .addr =3D A_CALIB_READ,
         .ro =3D 0x1fffff,
     },{ .name =3D "CURRENT_TIME",  .addr =3D A_CURRENT_TIME,
         .ro =3D 0xffffffff,
+        .post_read =3D current_time_postr,
     },{ .name =3D "CURRENT_TICK",  .addr =3D A_CURRENT_TICK,
         .ro =3D 0xffff,
     },{ .name =3D "ALARM",  .addr =3D A_ALARM,
@@ -147,6 +157,12 @@ static void rtc_reset(DeviceState *dev)
         register_reset(&s->regs_info[i]);
     }

+    qemu_get_timedate(&s->current_tm, 0);
+
+    trace_xlnx_zynqmp_rtc_gettime(s->current_tm.tm_year, s->current_tm.tm_=
mon,
+                                  s->current_tm.tm_mday, s->current_tm.tm_=
hour,
+                                  s->current_tm.tm_min, s->current_tm.tm_s=
ec);
+
     rtc_int_update_irq(s);
     addr_error_int_update_irq(s);
 }
@@ -190,6 +206,13 @@ static const VMStateDescription vmstate_rtc =3D {
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
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
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zyn=
qmp-rtc.h
index 87649836cc..daecb646f0 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -25,6 +25,7 @@
  */

 #include "hw/register.h"
+#include "trace.h"

 #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"

@@ -79,6 +80,8 @@ typedef struct XlnxZynqMPRTC {
     qemu_irq irq_rtc_int;
     qemu_irq irq_addr_error_int;

+    struct tm current_tm;
+
     uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
 } XlnxZynqMPRTC;
--
2.14.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
