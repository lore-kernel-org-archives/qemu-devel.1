Received: from eggs.gnu.org ([2001:4830:134:3::10]:34723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7NeZ-0006az-DO
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7NeY-00051r-C1
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:46 +0100
Message-Id: <20181002163556.10279-4-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/13] target/arm: Move v7m_using_psp() to
 internals.h
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

We're going to want v7m_using_psp() in op_helper.c in the
next patch, so move it from helper.c to internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 15 +++++++++++++++
 target/arm/helper.c    | 12 ------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc9357766c9..bc4c01ccd92 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -796,4 +796,19 @@ static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
     }
 }
 
+/**
+ * v7m_using_psp: Return true if using process stack pointer
+ * Return true if the CPU is currently using the process stack
+ * pointer, or false if it is using the main stack pointer.
+ */
+static inline bool v7m_using_psp(CPUARMState *env)
+{
+    /* Handler mode always uses the main stack; for thread mode
+     * the CONTROL.SPSEL bit determines the answer.
+     * Note that in v7M it is not possible to be in Handler mode with
+     * CONTROL.SPSEL non-zero, but in v8M it is, so we must check both.
+     */
+    return !arm_v7m_is_handler_mode(env) &&
+        env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK;
+}
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c303dc453f1..ef8c244fb84 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6554,18 +6554,6 @@ pend_fault:
     return false;
 }
 
-/* Return true if we're using the process stack pointer (not the MSP) */
-static bool v7m_using_psp(CPUARMState *env)
-{
-    /* Handler mode always uses the main stack; for thread mode
-     * the CONTROL.SPSEL bit determines the answer.
-     * Note that in v7M it is not possible to be in Handler mode with
-     * CONTROL.SPSEL non-zero, but in v8M it is, so we must check both.
-     */
-    return !arm_v7m_is_handler_mode(env) &&
-        env->v7m.control[env->v7m.secure] & R_V7M_CONTROL_SPSEL_MASK;
-}
-
 /* Write to v7M CONTROL.SPSEL bit for the specified security bank.
  * This may change the current stack pointer between Main and Process
  * stack pointers if it is done for the CONTROL register for the current
-- 
2.19.0
