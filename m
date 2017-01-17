Received: from eggs.gnu.org ([2001:4830:134:3::10]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkh-00039i-5M
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkg-0003tu-5E
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:27 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50116 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkf-0003sL-NF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:26 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:48 +0300
Message-Id: <1484644078-21312-9-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 08/18] target/arm: support access to vector
 guest registers as globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

To support vector guest registers as globals we need to do two things:

1) create corresponding globals,
2) mark which globals can overlap,

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---

I've declared regnames for new globals the same way they used to be declared for
scalar regs. checkpatch complains about it. Should I move '{' to the same line
for all 3 arrays?

---
 target/arm/translate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ad9070..2b81b5d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -65,6 +65,12 @@ static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
+static TCGv_v128 cpu_Q[16];
+static TCGv_v64 cpu_D[32];
+#ifdef CONFIG_USER_ONLY
+TCGv_i64 cpu_exclusive_test;
+TCGv_i32 cpu_exclusive_info;
+#endif
 
 /* FIXME:  These should be removed.  */
 static TCGv_i32 cpu_F0s, cpu_F1s;
@@ -72,14 +78,26 @@ static TCGv_i64 cpu_F0d, cpu_F1d;
 
 #include "exec/gen-icount.h"
 
-static const char *regnames[] =
+static const char *regnames_r[] =
     { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
       "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
 
+static const char *regnames_q[] =
+    { "q0", "q1", "q2", "q3", "q4", "q5", "q6", "q7",
+      "q8", "q9", "q10", "q11", "q12", "q13", "q14", "q15" };
+
+static const char *regnames_d[] =
+    { "d0", "d1", "d2", "d3", "d4", "d5", "d6", "d7",
+      "d8", "d9", "d10", "d11", "d12", "d13", "d14", "d15",
+      "d16", "d17", "d18", "d19", "d20", "d21", "d22", "d23",
+      "d24", "d25", "d26", "d27", "d28", "d29", "d30", "d31" };
+
 /* initialize TCG globals.  */
 void arm_translate_init(void)
 {
     int i;
+    static TCGArg overlap_temps[16][2];
+    static TCGArg sub_temps[16][3];
 
     cpu_env = tcg_global_reg_new_ptr(TCG_AREG0, "env");
     tcg_ctx.tcg_env = cpu_env;
@@ -87,7 +105,30 @@ void arm_translate_init(void)
     for (i = 0; i < 16; i++) {
         cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
                                           offsetof(CPUARMState, regs[i]),
-                                          regnames[i]);
+                                          regnames_r[i]);
+    }
+    for (i = 0; i < 16; i++) {
+        cpu_Q[i] = tcg_global_mem_new_v128(cpu_env,
+                                           offsetof(CPUARMState,
+                                                    vfp.regs[2 * i]),
+                                           regnames_q[i]);
+    }
+    for (i = 0; i < 32; i++) {
+        cpu_D[i] = tcg_global_mem_new_v64(cpu_env,
+                                          offsetof(CPUARMState, vfp.regs[i]),
+                                          regnames_d[i]);
+    }
+    for (i = 0; i < 16; i++) {
+        overlap_temps[i][0] = GET_TCGV_V128(cpu_Q[i]);
+        overlap_temps[i][1] = (TCGArg)-1;
+        sub_temps[i][0] = GET_TCGV_V64(cpu_D[i * 2]);
+        sub_temps[i][1] = GET_TCGV_V64(cpu_D[i * 2 + 1]);
+        sub_temps[i][2] = (TCGArg)-1;
+        tcg_temp_set_overlap_temps(GET_TCGV_V64(cpu_D[i * 2]),
+                                   overlap_temps[i]);
+        tcg_temp_set_overlap_temps(GET_TCGV_V64(cpu_D[i * 2 + 1]),
+                                   overlap_temps[i]);
+        tcg_temp_set_sub_temps(GET_TCGV_V128(cpu_Q[i]), sub_temps[i]);
     }
     cpu_CF = tcg_global_mem_new_i32(cpu_env, offsetof(CPUARMState, CF), "CF");
     cpu_NF = tcg_global_mem_new_i32(cpu_env, offsetof(CPUARMState, NF), "NF");
-- 
2.1.4
