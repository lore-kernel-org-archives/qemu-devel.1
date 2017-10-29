Received: from eggs.gnu.org ([2001:4830:134:3::10]:42974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e8fhI-00008c-Uq
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 00:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e8fhF-0006VR-TX
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 00:59:45 -0400
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Sun, 29 Oct 2017 10:29:25 +0530
Message-Id: <1509253165-7434-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu devel PATCH] msf2: Wire up SYSRESETREQ in SoC
 for system reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com, f4bug@amsat.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Implemented system reset by creating SYSRESETREQ gpio
out from nvic.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 hw/arm/msf2-soc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 6f97fa9..a8ec2cd 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -57,6 +57,13 @@ static const int spi_irq[MSF2_NUM_SPIS] = { 2, 3 };
 static const int uart_irq[MSF2_NUM_UARTS] = { 10, 11 };
 static const int timer_irq[MSF2_NUM_TIMERS] = { 14, 15 };
 
+static void do_sys_reset(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
 static void m2sxxx_soc_initfn(Object *obj)
 {
     MSF2State *s = MSF2_SOC(obj);
@@ -125,6 +132,10 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         error_append_hint(errp, "m3clk can not be zero\n");
         return;
     }
+
+    qdev_connect_gpio_out_named(DEVICE(&s->armv7m.nvic), "SYSRESETREQ", 0,
+                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
+
     system_clock_scale = NANOSECONDS_PER_SECOND / s->m3clk;
 
     for (i = 0; i < MSF2_NUM_UARTS; i++) {
-- 
2.5.0
