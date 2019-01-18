Received: from eggs.gnu.org ([209.51.188.92]:42899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbR-0002jQ-Ux
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbP-0007Jz-TF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbN-00078I-Vh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id c14so15472063wrr.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:24 +0000
Message-Id: <20190118145805.6852-9-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/49] target/arm: Introduce raise_exception_ra
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

This path uses cpu_loop_exit_restore to unwind current processor state.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  7 +++++++
 target/arm/op_helper.c | 19 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 78e026d6e90..c01a3f8c968 100644
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
index ef72361a36d..8b31c6a13b8 100644
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
2.20.1
