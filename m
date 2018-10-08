Received: from eggs.gnu.org ([2001:4830:134:3::10]:46107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5T-00019R-Ht
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5K-00076c-Im
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5K-0006yM-9b
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5I-0003jC-FP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 14:59:53 +0100
Message-Id: <20181008140004.12612-23-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/33] target/arm: Move v7m_using_psp() to
 internals.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We're going to want v7m_using_psp() in op_helper.c in the
next patch, so move it from helper.c to internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002163556.10279-4-peter.maydell@linaro.org
---
 target/arm/internals.h | 16 ++++++++++++++++
 target/arm/helper.c    | 12 ------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 24c0444c8d2..2495681435d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -801,4 +801,20 @@ static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
  */
 #define MEMOPIDX_SHIFT  8
 
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
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a9a2173cb2f..7ffd1840447 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6582,18 +6582,6 @@ pend_fault:
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
