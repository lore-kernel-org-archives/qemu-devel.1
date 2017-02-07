Received: from eggs.gnu.org ([2001:4830:134:3::10]:32840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe6-0007co-NA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe5-0002nI-JH
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe5-0002gg-D2
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:41 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdt-0005Td-4l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:18 +0000
Message-Id: <1486492645-27803-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 06/13] target/arm: Add cfgend parameter for ARM
 CPU selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julian Brown <julian@codesourcery.com>

Add a new "cfgend" property which selects whether the CPU resets into
big-endian mode or not.  This setting affects whether we reset with
SCTLR_B (ARMv6 and earlier) or SCTLR_EE (ARMv7 and later) set.

Signed-off-by: Julian Brown <julian@codesourcery.com>
Message-id: 11420d1c49636c1790e60578ee996e51f0f0b835.1484929304.git.julian@codesourcery.com
[PMM: use error_report_err() rather than error_report();
 move the integratorcp changes to their own patch;
 drop an unnecessary extra #include;
 rephrase commit message accordingly;
 move setting of reset_sctlr above registration of cpregs
 so it actually has an effect]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h |  7 +++++++
 target/arm/cpu.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39bff86..c0b3832 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -676,6 +676,13 @@ struct ARMCPU {
     int gic_vpribits; /* number of virtual priority bits */
     int gic_vprebits; /* number of virtual preemption bits */
 
+    /* Whether the cfgend input is high (i.e. this CPU should reset into
+     * big-endian mode).  This setting isn't used directly: instead it modifies
+     * the reset_sctlr value to have SCTLR_B or SCTLR_EE set, depending on the
+     * architecture version.
+     */
+    bool cfgend;
+
     ARMELChangeHook *el_change_hook;
     void *el_change_hook_opaque;
 };
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e9f10f7..a8cfd9d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -541,6 +541,9 @@ static Property arm_cpu_has_el2_property =
 static Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 
+static Property arm_cpu_cfgend_property =
+            DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
+
 /* use property name "pmu" to match other archs and virt tools */
 static Property arm_cpu_has_pmu_property =
             DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
@@ -608,6 +611,8 @@ static void arm_cpu_post_init(Object *obj)
         }
     }
 
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
+                             &error_abort);
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -728,6 +733,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             cpu->reset_sctlr |= (1 << 13);
     }
 
+    if (cpu->cfgend) {
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->reset_sctlr |= SCTLR_EE;
+        } else {
+            cpu->reset_sctlr |= SCTLR_B;
+        }
+    }
+
     if (!cpu->has_el3) {
         /* If the has_el3 CPU property is disabled then we need to disable the
          * feature.
-- 
2.7.4
