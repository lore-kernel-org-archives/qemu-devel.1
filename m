Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ee74K-00034G-Qy
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ee74G-0000C1-KX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:28 -0500
Received: from mail-by2nam01on0087.outbound.protection.outlook.com
	([104.47.34.87]:49255
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ee74G-0000Am-8i
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:24 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:24:47 -0800
Message-ID: <29c39a6f9ce3734bf693581348ed78f4bff3e0ef.1516746211.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1516746211.git.alistair.francis@xilinx.com>
References: <cover.1516746211.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/3] xlnx-zynqmp-rtc: Add basic time support
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
V5:
 - Recalculate tick_offset after migration
V4:
 - Use the .unimp property
V3:
 - Store an offset value
 - Use mktimegm()
 - Log unimplemented writes
V2:
 - Convert DB_PRINT() macro to trace

 include/hw/timer/xlnx-zynqmp-rtc.h |  3 +++
 hw/timer/xlnx-zynqmp-rtc.c         | 52 ++++++++++++++++++++++++++++++++++=
++++
 hw/timer/trace-events              |  3 +++
 3 files changed, 58 insertions(+)

diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zyn=
qmp-rtc.h
index 87649836cc..2867563bdd 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -79,6 +79,9 @@ typedef struct XlnxZynqMPRTC {
     qemu_irq irq_rtc_int;
     qemu_irq irq_addr_error_int;
=20
+    struct tm current_tm;
+    uint32_t tick_offset;
+
     uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
 } XlnxZynqMPRTC;
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index 707f145027..1d229870c5 100644
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
=20
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
@@ -47,6 +51,19 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
     qemu_set_irq(s->irq_addr_error_int, pending);
 }
=20
+static uint32_t rtc_get_count(XlnxZynqMPRTC *s)
+{
+    int64_t now =3D qemu_clock_get_ns(rtc_clock);
+    return s->tick_offset + now / NANOSECONDS_PER_SECOND;
+}
+
+static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+
+    return rtc_get_count(s);
+}
+
 static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
 {
     XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
@@ -97,13 +114,17 @@ static uint64_t addr_error_int_dis_prew(RegisterInfo *=
reg, uint64_t val64)
=20
 static const RegisterAccessInfo rtc_regs_info[] =3D {
     {   .name =3D "SET_TIME_WRITE",  .addr =3D A_SET_TIME_WRITE,
+        .unimp =3D MAKE_64BIT_MASK(0, 32),
     },{ .name =3D "SET_TIME_READ",  .addr =3D A_SET_TIME_READ,
         .ro =3D 0xffffffff,
+        .post_read =3D current_time_postr,
     },{ .name =3D "CALIB_WRITE",  .addr =3D A_CALIB_WRITE,
+        .unimp =3D MAKE_64BIT_MASK(0, 32),
     },{ .name =3D "CALIB_READ",  .addr =3D A_CALIB_READ,
         .ro =3D 0x1fffff,
     },{ .name =3D "CURRENT_TIME",  .addr =3D A_CURRENT_TIME,
         .ro =3D 0xffffffff,
+        .post_read =3D current_time_postr,
     },{ .name =3D "CURRENT_TICK",  .addr =3D A_CURRENT_TICK,
         .ro =3D 0xffff,
     },{ .name =3D "ALARM",  .addr =3D A_ALARM,
@@ -143,6 +164,10 @@ static void rtc_reset(DeviceState *dev)
         register_reset(&s->regs_info[i]);
     }
=20
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
@@ -178,14 +203,41 @@ static void rtc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq_rtc_int);
     sysbus_init_irq(sbd, &s->irq_addr_error_int);
+
+    qemu_get_timedate(&s->current_tm, 0);
+    s->tick_offset =3D mktimegm(&s->current_tm) -
+        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+}
+
+static int rtc_post_load(void *opaque, int version_id)
+{
+    XlnxZynqMPRTC *s =3D opaque;
+
+    /* The tick_offset is added to the current time to determine the guest
+     * time. After migration we don't want to use the original time as tha=
t
+     * will indicate to the guest that time has passed, so we need to
+     * recalculate the tick_offset here.
+     */
+    s->tick_offset =3D mktimegm(&s->current_tm) -
+        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
+
+    return 0;
 }
=20
 static const VMStateDescription vmstate_rtc =3D {
     .name =3D TYPE_XLNX_ZYNQMP_RTC,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .post_load =3D rtc_post_load,
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
--=20
2.14.1
