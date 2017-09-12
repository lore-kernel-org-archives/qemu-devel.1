Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgx-0003M4-2t
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drpgv-0006N4-QE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:13:49 +0100
Message-Id: <1505240046-11454-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 02/19] nvic: Add banked exception states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

For the v8M security extension, some exceptions must be banked
between security states. Add the new vecinfo array which holds
the state for the banked exceptions and migrate it if the
CPU the NVIC is attached to implements the security extension.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/armv7m_nvic.h | 14 +++++++++++++
 hw/intc/armv7m_nvic.c         | 49 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 1a4cce7..317601e 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -21,6 +21,8 @@
 
 /* Highest permitted number of exceptions (architectural limit) */
 #define NVIC_MAX_VECTORS 512
+/* Number of internal exceptions */
+#define NVIC_INTERNAL_VECTORS 16
 
 typedef struct VecInfo {
     /* Exception priorities can range from -3 to 255; only the unmodifiable
@@ -41,6 +43,18 @@ typedef struct NVICState {
     ARMCPU *cpu;
 
     VecInfo vectors[NVIC_MAX_VECTORS];
+    /* If the v8M security extension is implemented, some of the internal
+     * exceptions are banked between security states (ie there exists both
+     * a Secure and a NonSecure version of the exception and its state):
+     *  HardFault, MemManage, UsageFault, SVCall, PendSV, SysTick (R_PJHV)
+     * The rest (including all the external exceptions) are not banked, though
+     * they may be configurable to target either Secure or NonSecure state.
+     * We store the secure exception state in sec_vectors[] for the banked
+     * exceptions, and otherwise use only vectors[] (including for exceptions
+     * like SecureFault that unconditionally target Secure state).
+     * Entries in sec_vectors[] for non-banked exception numbers are unused.
+     */
+    VecInfo sec_vectors[NVIC_INTERNAL_VECTORS];
     uint32_t prigroup;
 
     /* vectpending and exception_prio are both cached state that can
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d3e2056..694b9e0 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -47,7 +47,7 @@
  * For historical reasons QEMU tends to use "interrupt" and
  * "exception" more or less interchangeably.
  */
-#define NVIC_FIRST_IRQ 16
+#define NVIC_FIRST_IRQ NVIC_INTERNAL_VECTORS
 #define NVIC_MAX_IRQ (NVIC_MAX_VECTORS - NVIC_FIRST_IRQ)
 
 /* Effective running priority of the CPU when no exception is active
@@ -1158,6 +1158,43 @@ static const VMStateDescription vmstate_VecInfo = {
     }
 };
 
+static bool nvic_security_needed(void *opaque)
+{
+    NVICState *s = opaque;
+
+    return arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY);
+}
+
+static int nvic_security_post_load(void *opaque, int version_id)
+{
+    NVICState *s = opaque;
+    int i;
+
+    /* Check for out of range priority settings */
+    if (s->sec_vectors[ARMV7M_EXCP_HARD].prio != -1) {
+        return 1;
+    }
+    for (i = ARMV7M_EXCP_MEM; i < ARRAY_SIZE(s->sec_vectors); i++) {
+        if (s->sec_vectors[i].prio & ~0xff) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_nvic_security = {
+    .name = "nvic/m-security",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = nvic_security_needed,
+    .post_load = &nvic_security_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(sec_vectors, NVICState, NVIC_INTERNAL_VECTORS, 1,
+                             vmstate_VecInfo, VecInfo),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_nvic = {
     .name = "armv7m_nvic",
     .version_id = 4,
@@ -1195,6 +1232,16 @@ static void armv7m_nvic_reset(DeviceState *dev)
     s->vectors[ARMV7M_EXCP_NMI].prio = -2;
     s->vectors[ARMV7M_EXCP_HARD].prio = -1;
 
+    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
+        s->sec_vectors[ARMV7M_EXCP_HARD].enabled = 1;
+        s->sec_vectors[ARMV7M_EXCP_SVC].enabled = 1;
+        s->sec_vectors[ARMV7M_EXCP_PENDSV].enabled = 1;
+        s->sec_vectors[ARMV7M_EXCP_SYSTICK].enabled = 1;
+
+        /* AIRCR.BFHFNMINS resets to 0 so Secure HF is priority -1 (R_CMTC) */
+        s->sec_vectors[ARMV7M_EXCP_HARD].prio = -1;
+    }
+
     /* Strictly speaking the reset handler should be enabled.
      * However, we don't simulate soft resets through the NVIC,
      * and the reset vector should never be pended.
-- 
2.7.4
