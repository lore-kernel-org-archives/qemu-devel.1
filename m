Received: from eggs.gnu.org ([2001:4830:134:3::10]:54066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxWoi-0001TT-2z
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxWoh-000843-2k
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:45:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 11:44:57 +0100
Message-Id: <1491821097-5647-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] arm: Move excnames[] array into
 arm_log_exceptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The excnames[] array is defined in internals.h because we used
to use it from two different source files for handling logging
of AArch32 and AArch64 exception entry. Refactoring means that
it's now used only in arm_log_exception() in helper.c, so move
the array into that function.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  2 +-
 target/arm/internals.h | 23 -----------------------
 target/arm/helper.c    | 19 +++++++++++++++++++
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e6f05e2..ab86943 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -58,7 +58,7 @@
 #define EXCP_SEMIHOST       16   /* semihosting call */
 #define EXCP_NOCP           17   /* v7M NOCP UsageFault */
 #define EXCP_INVSTATE       18   /* v7M INVSTATE UsageFault */
-/* NB: new EXCP_ defines should be added to the excnames[] array too */
+/* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 97ca034..1f6efef 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -51,29 +51,6 @@ static inline bool excp_is_internal(int excp)
         || excp == EXCP_SEMIHOST;
 }
 
-/* Exception names for debug logging; note that not all of these
- * precisely correspond to architectural exceptions.
- */
-static const char * const excnames[] = {
-    [EXCP_UDEF] = "Undefined Instruction",
-    [EXCP_SWI] = "SVC",
-    [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
-    [EXCP_DATA_ABORT] = "Data Abort",
-    [EXCP_IRQ] = "IRQ",
-    [EXCP_FIQ] = "FIQ",
-    [EXCP_BKPT] = "Breakpoint",
-    [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
-    [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
-    [EXCP_HVC] = "Hypervisor Call",
-    [EXCP_HYP_TRAP] = "Hypervisor Trap",
-    [EXCP_SMC] = "Secure Monitor Call",
-    [EXCP_VIRQ] = "Virtual IRQ",
-    [EXCP_VFIQ] = "Virtual FIQ",
-    [EXCP_SEMIHOST] = "Semihosting call",
-    [EXCP_NOCP] = "v7M NOCP UsageFault",
-    [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
-};
-
 /* Scale factor for generic timers, ie number of ns per tick.
  * This gives a 62.5MHz timer.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8cb7a94..8a3e448 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6271,6 +6271,25 @@ static void arm_log_exception(int idx)
 {
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *exc = NULL;
+        static const char * const excnames[] = {
+            [EXCP_UDEF] = "Undefined Instruction",
+            [EXCP_SWI] = "SVC",
+            [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
+            [EXCP_DATA_ABORT] = "Data Abort",
+            [EXCP_IRQ] = "IRQ",
+            [EXCP_FIQ] = "FIQ",
+            [EXCP_BKPT] = "Breakpoint",
+            [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
+            [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
+            [EXCP_HVC] = "Hypervisor Call",
+            [EXCP_HYP_TRAP] = "Hypervisor Trap",
+            [EXCP_SMC] = "Secure Monitor Call",
+            [EXCP_VIRQ] = "Virtual IRQ",
+            [EXCP_VFIQ] = "Virtual FIQ",
+            [EXCP_SEMIHOST] = "Semihosting call",
+            [EXCP_NOCP] = "v7M NOCP UsageFault",
+            [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
+        };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
             exc = excnames[idx];
-- 
2.7.4
