Received: from eggs.gnu.org ([209.51.188.92]:52483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzuW-00081v-QK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzuV-0004GH-S3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:48 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzuV-0004Ft-MH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:47 -0500
Received: by mail-pl1-x642.google.com with SMTP id p8so2576110plo.2
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:31:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:02 +1000
Message-Id: <20190108223129.5570-5-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 04/31] target/arm: Introduce
 raise_exception_ra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This path uses cpu_loop_exit_restore to unwind current processor state.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  7 +++++++
 target/arm/op_helper.c | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 78e026d6e9..c01a3f8c96 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -103,6 +103,13 @@ FIELD(V7M_EXCRET, RES1, 7, 25) /* including the must-be-1 prefix */
 void QEMU_NORETURN raise_exception(CPUARMState *env, uint32_t excp,
                                    uint32_t syndrome, uint32_t target_el);
 
+/*
+ * Similarly, but also use unwinding to restore cpu state.
+ */
+void QEMU_NORETURN raise_exception_ra(CPUARMState *env, uint32_t excp,
+                                      uint32_t syndrome, uint32_t target_el,
+                                      uintptr_t ra);
+
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
  * Note that this mapping and the AArch32 mapping defined in bank_number()
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ef72361a36..8b31c6a13b 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -28,8 +28,8 @@
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
-void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint32_t syndrome, uint32_t target_el)
+static CPUState *do_raise_exception(CPUARMState *env, uint32_t excp,
+                                    uint32_t syndrome, uint32_t target_el)
 {
     CPUState *cs = CPU(arm_env_get_cpu(env));
 
@@ -50,9 +50,24 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     cs->exception_index = excp;
     env->exception.syndrome = syndrome;
     env->exception.target_el = target_el;
+
+    return cs;
+}
+
+void raise_exception(CPUARMState *env, uint32_t excp,
+                     uint32_t syndrome, uint32_t target_el)
+{
+    CPUState *cs = do_raise_exception(env, excp, syndrome, target_el);
     cpu_loop_exit(cs);
 }
 
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+                        uint32_t target_el, uintptr_t ra)
+{
+    CPUState *cs = do_raise_exception(env, excp, syndrome, target_el);
+    cpu_loop_exit_restore(cs, ra);
+}
+
 static int exception_target_el(CPUARMState *env)
 {
     int target_el = MAX(1, arm_current_el(env));
-- 
2.17.2
