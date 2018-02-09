Received: from eggs.gnu.org ([2001:4830:134:3::10]:39879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6St-000147-Ja
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Ss-00021D-N5
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Ss-0001zI-Gr
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sr-0002du-Js
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:03:09 +0000
Message-Id: <20180209110314.11766-26-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/30] target/arm: Add SVE to migration state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Save the high parts of the Zregs and all of the Pregs.
The ZCR_ELx registers are migrated via the CP mechanism.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180123035349.24538-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.16.1
