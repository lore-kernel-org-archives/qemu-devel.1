Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYtsB-00060n-Dm
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005cu-9S
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:51 -0500
Received: from bran.ispras.ru ([83.149.199.196]:46085 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts8-0005cD-2V
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:48 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Wed,  1 Feb 2017 15:18:11 +0300
Message-Id: <1485951502-28774-10-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
References: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2 09/20] target/arm: support access to vector
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

To support vector guest registers as globals we need to do two things:

1) create corresponding globals,
2) mark which globals can overlap,

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 target/arm/translate.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 493c627..d7578e2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -65,6 +65,8 @@ static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
+static TCGv_v128 cpu_Q[16];
+static TCGv_v64 cpu_D[32];
 
 /* FIXME:  These should be removed.  */
 static TCGv_i32 cpu_F0s, cpu_F1s;
@@ -72,10 +74,20 @@ static TCGv_i64 cpu_F0d, cpu_F1d;
 
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
@@ -87,8 +99,22 @@ void arm_translate_init(void)
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
     }
+    for (i = 0; i < 32; i++) {
+        cpu_D[i] = tcg_global_mem_new_v64(cpu_env,
+                                          offsetof(CPUARMState, vfp.regs[i]),
+                                          regnames_d[i]);
+    }
+
+    tcg_detect_overlapping_temps(&tcg_ctx);
+
     cpu_CF = tcg_global_mem_new_i32(cpu_env, offsetof(CPUARMState, CF), "CF");
     cpu_NF = tcg_global_mem_new_i32(cpu_env, offsetof(CPUARMState, NF), "NF");
     cpu_VF = tcg_global_mem_new_i32(cpu_env, offsetof(CPUARMState, VF), "VF");
-- 
2.1.4
