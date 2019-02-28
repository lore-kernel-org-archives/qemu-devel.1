Received: from eggs.gnu.org ([209.51.188.92]:36409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYs-0001Ks-OI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYr-0003m3-Fz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYr-0003ko-6P
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id g20so7734345wmh.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:27 +0000
Message-Id: <20190228110835.16159-9-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/16] hw/arm/armsse: Unify init-svtor and
 cpuwait handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

At the moment the handling of init-svtor and cpuwait initial
values is split between armsse.c and iotkit-sysctl.c:
the code in armsse.c sets the initial state of the CPU
object by setting the init-svtor and start-powered-off
properties, but the iotkit-sysctl.c code has its own
code setting the reset values of its registers (which are
then used when updating the CPU when the guest makes
runtime changes).

Clean this up by making the armsse.c code set properties on the
iotkit-sysctl object to define the initial values of the
registers, so they always match the initial CPU state,
and update the comments in armsse.c accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-9-peter.maydell@linaro.org
---
 include/hw/misc/iotkit-sysctl.h |  3 ++
 hw/arm/armsse.c                 | 49 +++++++++++++++++++++------------
 hw/misc/iotkit-sysctl.c         | 20 ++++++--------
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
index 9c2f23ecd28..601c8ecc0d0 100644
--- a/include/hw/misc/iotkit-sysctl.h
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -62,6 +62,9 @@ typedef struct IoTKitSysCtl {
 
     /* Properties */
     uint32_t sys_version;
+    uint32_t cpuwait_rst;
+    uint32_t initsvtor0_rst;
+    uint32_t initsvtor1_rst;
 
     bool is_sse200;
 } IoTKitSysCtl;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 6eed2ecf809..76cc6905798 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
@@ -29,6 +30,7 @@ struct ARMSSEInfo {
     int sram_banks;
     int num_cpus;
     uint32_t sys_version;
+    uint32_t cpuwait_rst;
     SysConfigFormat sys_config_format;
     bool has_mhus;
     bool has_ppus;
@@ -43,6 +45,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .sram_banks = 1,
         .num_cpus = 1,
         .sys_version = 0x41743,
+        .cpuwait_rst = 0,
         .sys_config_format = IoTKitFormat,
         .has_mhus = false,
         .has_ppus = false,
@@ -55,6 +58,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .sram_banks = 4,
         .num_cpus = 2,
         .sys_version = 0x22041743,
+        .cpuwait_rst = 2,
         .sys_config_format = SSE200Format,
         .has_mhus = true,
         .has_ppus = true,
@@ -495,30 +499,33 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_uint32(cpudev, "num-irq", s->exp_numirq + 32);
         /*
-         * In real hardware the initial Secure VTOR is set from the INITSVTOR0
-         * register in the IoT Kit System Control Register block, and the
-         * initial value of that is in turn specifiable by the FPGA that
-         * instantiates the IoT Kit. In QEMU we don't implement this wrinkle,
-         * and simply set the CPU's init-svtor to the IoT Kit default value.
-         * In SSE-200 the situation is similar, except that the default value
-         * is a reset-time signal input. Typically a board using the SSE-200
-         * will have a system control processor whose boot firmware initializes
-         * the INITSVTOR* registers before powering up the CPUs in any case,
-         * so the hardware's default value doesn't matter. QEMU doesn't emulate
+         * In real hardware the initial Secure VTOR is set from the INITSVTOR*
+         * registers in the IoT Kit System Control Register block. In QEMU
+         * we set the initial value here, and also the reset value of the
+         * sysctl register, from this object's QOM init-svtor property.
+         * If the guest changes the INITSVTOR* registers at runtime then the
+         * code in iotkit-sysctl.c will update the CPU init-svtor property
+         * (which will then take effect on the next CPU warm-reset).
+         *
+         * Note that typically a board using the SSE-200 will have a system
+         * control processor whose boot firmware initializes the INITSVTOR*
+         * registers before powering up the CPUs. QEMU doesn't emulate
          * the control processor, so instead we behave in the way that the
-         * firmware does. The initial value is configurable by the board code
-         * to match whatever its firmware does.
+         * firmware does: the initial value should be set by the board code
+         * (using the init-svtor property on the ARMSSE object) to match
+         * whatever its firmware does.
          */
         qdev_prop_set_uint32(cpudev, "init-svtor", s->init_svtor);
         /*
-         * Start all CPUs except CPU0 powered down. In real hardware it is
-         * a configurable property of the SSE-200 which CPUs start powered up
-         * (via the CPUWAIT0_RST and CPUWAIT1_RST parameters), but since all
-         * the boards we care about start CPU0 and leave CPU1 powered off,
-         * we hard-code that for now. We can add QOM properties for this
+         * CPUs start powered down if the corresponding bit in the CPUWAIT
+         * register is 1. In real hardware the CPUWAIT register reset value is
+         * a configurable property of the SSE-200 (via the CPUWAIT0_RST and
+         * CPUWAIT1_RST parameters), but since all the boards we care about
+         * start CPU0 and leave CPU1 powered off, we hard-code that in
+         * info->cpuwait_rst for now. We can add QOM properties for this
          * later if necessary.
          */
-        if (i > 0) {
+        if (extract32(info->cpuwait_rst, i, 1)) {
             object_property_set_bool(cpuobj, true, "start-powered-off", &err);
             if (err) {
                 error_propagate(errp, err);
@@ -999,6 +1006,12 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* System control registers */
     object_property_set_int(OBJECT(&s->sysctl), info->sys_version,
                             "SYS_VERSION", &err);
+    object_property_set_int(OBJECT(&s->sysctl), info->cpuwait_rst,
+                            "CPUWAIT_RST", &err);
+    object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
+                            "INITSVTOR0_RST", &err);
+    object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
+                            "INITSVTOR1_RST", &err);
     object_property_set_bool(OBJECT(&s->sysctl), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index e333c8169a3..54064a31ef0 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -404,18 +404,9 @@ static void iotkit_sysctl_reset(DeviceState *dev)
     s->reset_syndrome = 1;
     s->reset_mask = 0;
     s->gretreg = 0;
-    s->initsvtor0 = 0x10000000;
-    s->initsvtor1 = 0x10000000;
-    if (s->is_sse200) {
-        /*
-         * CPU 0 starts on, CPU 1 starts off. In real hardware this is
-         * configurable by the SoC integrator as a verilog parameter.
-         */
-        s->cpuwait = 2;
-    } else {
-        /* CPU 0 starts on */
-        s->cpuwait = 0;
-    }
+    s->initsvtor0 = s->initsvtor0_rst;
+    s->initsvtor1 = s->initsvtor1_rst;
+    s->cpuwait = s->cpuwait_rst;
     s->wicctrl = 0;
     s->scsecctrl = 0;
     s->fclk_div = 0;
@@ -500,6 +491,11 @@ static const VMStateDescription iotkit_sysctl_vmstate = {
 
 static Property iotkit_sysctl_props[] = {
     DEFINE_PROP_UINT32("SYS_VERSION", IoTKitSysCtl, sys_version, 0),
+    DEFINE_PROP_UINT32("CPUWAIT_RST", IoTKitSysCtl, cpuwait_rst, 0),
+    DEFINE_PROP_UINT32("INITSVTOR0_RST", IoTKitSysCtl, initsvtor0_rst,
+                       0x10000000),
+    DEFINE_PROP_UINT32("INITSVTOR1_RST", IoTKitSysCtl, initsvtor1_rst,
+                       0x10000000),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.20.1
