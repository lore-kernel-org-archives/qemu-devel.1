Received: from eggs.gnu.org ([2001:4830:134:3::10]:39063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUxVp-0003Id-Iq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUxVo-0007CA-Ms
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:55:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 16:53:28 +0100
Message-Id: <1499788408-10096-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] target/arm: Make Cortex-M3 and M4 default
 to 8 PMSA regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The Cortex-M3 and M4 CPUs always have 8 PMSA MPU regions (this isn't
a configurable option for the hardware).  Make the default value of
the pmsav7-dregion property be set per-cpu, so we don't need to have
every user of these CPUs set it manually.  (The existing default of
16 is correct for the other PMSAv7 core, the Cortex-R5.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 28a9141..96d1f84 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -543,8 +543,15 @@ static Property arm_cpu_has_pmu_property =
 static Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
+/* This is like DEFINE_PROP_UINT32 but it doesn't set the default value,
+ * because the CPU initfn will have already set cpu->pmsav7_dregion to
+ * the right value for that particular CPU type, and we don't want
+ * to override that with an incorrect constant value.
+ */
 static Property arm_cpu_pmsav7_dregion_property =
-            DEFINE_PROP_UINT32("pmsav7-dregion", ARMCPU, pmsav7_dregion, 16);
+            DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
+                                           pmsav7_dregion,
+                                           qdev_prop_uint32, uint32_t);
 
 static void arm_cpu_post_init(Object *obj)
 {
@@ -1054,6 +1061,7 @@ static void cortex_m3_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_M);
     cpu->midr = 0x410fc231;
+    cpu->pmsav7_dregion = 8;
 }
 
 static void cortex_m4_initfn(Object *obj)
@@ -1064,6 +1072,7 @@ static void cortex_m4_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fc240; /* r0p0 */
+    cpu->pmsav7_dregion = 8;
 }
 static void arm_v7m_class_init(ObjectClass *oc, void *data)
 {
@@ -1112,6 +1121,7 @@ static void cortex_r5_initfn(Object *obj)
     cpu->id_isar4 = 0x0010142;
     cpu->id_isar5 = 0x0;
     cpu->mp_is_up = true;
+    cpu->pmsav7_dregion = 16;
     define_arm_cp_regs(cpu, cortexr5_cp_reginfo);
 }
 
-- 
2.7.4
