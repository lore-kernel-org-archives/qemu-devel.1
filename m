Received: from eggs.gnu.org ([209.51.188.92]:36384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYp-0001He-NO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYo-0003gx-MI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYo-0003eZ-F5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:06 -0500
Received: by mail-wr1-x436.google.com with SMTP id o17so21490247wrw.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:26 +0000
Message-Id: <20190228110835.16159-8-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/16] hw/arm/iotkit-sysctl: Implement CPUWAIT
 and INITSVTOR*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The CPUWAIT register acts as a sort of power-control: if a bit
in it is 1 then the CPU will have been forced into waiting
when the system was reset (which in QEMU we model as the
CPU starting powered off). Writing a 0 to the register will
allow the CPU to boot (for QEMU, we model this as powering
it on). Note that writing 0 to the register does not power
off a CPU.

For this to work correctly we need to also honour the
INITSVTOR* registers, which let the guest control where the
CPU will load its SP and PC from when it comes out of reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-8-peter.maydell@linaro.org
---
 hw/misc/iotkit-sysctl.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index 05606017fc2..e333c8169a3 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -25,6 +25,8 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/misc/iotkit-sysctl.h"
+#include "target/arm/arm-powerctl.h"
+#include "target/arm/cpu.h"
 
 REG32(SECDBGSTAT, 0x0)
 REG32(SECDBGSET, 0x4)
@@ -69,6 +71,21 @@ static const int sysctl_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+/*
+ * Set the initial secure vector table offset address for the core.
+ * This will take effect when the CPU next resets.
+ */
+static void set_init_vtor(uint64_t cpuid, uint32_t vtor)
+{
+    Object *cpuobj = OBJECT(arm_get_cpu_by_id(cpuid));
+
+    if (cpuobj) {
+        if (object_property_find(cpuobj, "init-svtor", NULL)) {
+            object_property_set_uint(cpuobj, vtor, "init-svtor", &error_abort);
+        }
+    }
+}
+
 static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -229,11 +246,18 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
         s->gretreg = value;
         break;
     case A_INITSVTOR0:
-        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl INITSVTOR0 unimplemented\n");
         s->initsvtor0 = value;
+        set_init_vtor(0, s->initsvtor0);
         break;
     case A_CPUWAIT:
-        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CPUWAIT unimplemented\n");
+        if ((s->cpuwait & 1) && !(value & 1)) {
+            /* Powering up CPU 0 */
+            arm_set_cpu_on_and_reset(0);
+        }
+        if ((s->cpuwait & 2) && !(value & 2)) {
+            /* Powering up CPU 1 */
+            arm_set_cpu_on_and_reset(1);
+        }
         s->cpuwait = value;
         break;
     case A_WICCTRL:
@@ -287,8 +311,8 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
         if (!s->is_sse200) {
             goto bad_offset;
         }
-        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl INITSVTOR1 unimplemented\n");
         s->initsvtor1 = value;
+        set_init_vtor(1, s->initsvtor1);
         break;
     case A_EWCTRL:
         if (!s->is_sse200) {
@@ -382,7 +406,16 @@ static void iotkit_sysctl_reset(DeviceState *dev)
     s->gretreg = 0;
     s->initsvtor0 = 0x10000000;
     s->initsvtor1 = 0x10000000;
-    s->cpuwait = 0;
+    if (s->is_sse200) {
+        /*
+         * CPU 0 starts on, CPU 1 starts off. In real hardware this is
+         * configurable by the SoC integrator as a verilog parameter.
+         */
+        s->cpuwait = 2;
+    } else {
+        /* CPU 0 starts on */
+        s->cpuwait = 0;
+    }
     s->wicctrl = 0;
     s->scsecctrl = 0;
     s->fclk_div = 0;
-- 
2.20.1
