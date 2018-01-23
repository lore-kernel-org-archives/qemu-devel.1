Received: from eggs.gnu.org ([2001:4830:134:3::10]:43220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpep-0001t2-Dd
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edpeo-00047V-G4
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:59 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:42916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edpeo-00046l-Aq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:53:58 -0500
Received: by mail-pg0-x243.google.com with SMTP id q67so8762871pga.9
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:53:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 19:53:47 -0800
Message-Id: <20180123035349.24538-4-richard.henderson@linaro.org>
In-Reply-To: <20180123035349.24538-1-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 3/5] target/arm: Add SVE to migration state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Save the high parts of the Zregs and all of the Pregs.
The ZCR_ELx registers are migrated via the CP mechanism.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/machine.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index cb0e1c92bb..2c8b43062f 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -122,6 +122,56 @@ static const VMStateDescription vmstate_iwmmxt = {
     }
 };
 
+#ifdef TARGET_AARCH64
+/* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
+ * and ARMPredicateReg is actively empty.  This triggers errors
+ * in the expansion of the VMSTATE macros.
+ */
+
+static bool sve_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    CPUARMState *env = &cpu->env;
+
+    return arm_feature(env, ARM_FEATURE_SVE);
+}
+
+/* The first two words of each Zreg is stored in VFP state.  */
+static const VMStateDescription vmstate_zreg_hi_reg = {
+    .name = "cpu/sve/zreg_hi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_SUB_ARRAY(d, ARMVectorReg, 2, ARM_MAX_VQ - 2),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_preg_reg = {
+    .name = "cpu/sve/preg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(p, ARMPredicateReg, 2 * ARM_MAX_VQ / 8),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sve = {
+    .name = "cpu/sve",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sve_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(env.vfp.zregs, ARMCPU, 32, 0,
+                             vmstate_zreg_hi_reg, ARMVectorReg),
+        VMSTATE_STRUCT_ARRAY(env.vfp.pregs, ARMCPU, 17, 0,
+                             vmstate_preg_reg, ARMPredicateReg),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif /* AARCH64 */
+
 static bool m_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -586,6 +636,9 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_pmsav7,
         &vmstate_pmsav8,
         &vmstate_m_security,
+#ifdef TARGET_AARCH64
+        &vmstate_sve,
+#endif
         NULL
     }
 };
-- 
2.14.3
