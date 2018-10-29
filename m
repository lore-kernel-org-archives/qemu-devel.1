Received: from eggs.gnu.org ([2001:4830:134:3::10]:34161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LN-0008Fp-SD
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LI-0003Fl-VS
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38701 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9LH-0003Cy-GL
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:36 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:19:53 +0100
Message-Id: <1540826418-5501-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 02/27] target/mips: Introduce MXU registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Craig Janeczek <jancraig@amazon.com>

Define and initialize the 16 MXU registers - 15 general computational
register, and 1 control register). There is also a zero register, but
it does not have any corresponding variable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       | 10 ++++++++++
 target/mips/translate.c | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e48be4b..03c03fd 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -170,6 +170,16 @@ struct TCState {
         MSACSR_FS_MASK)
 
     float_status msa_fp_status;
+
+#define NUMBER_OF_MXU_REGISTERS 16
+    target_ulong mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
+    target_ulong mxu_cr;
+#define MXU_CR_LC       31
+#define MXU_CR_RC       30
+#define MXU_CR_BIAS     2
+#define MXU_CR_RD_EN    1
+#define MXU_CR_MXU_EN   0
+
 };
 
 typedef struct CPUMIPSState CPUMIPSState;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3bdefc0..d6e733f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2379,6 +2379,10 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
 
+/* MXU registers */
+static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
+static TCGv mxu_CR;
+
 #include "exec/gen-icount.h"
 
 #define gen_helper_0e0i(name, arg) do {                           \
@@ -2501,6 +2505,11 @@ static const char * const msaregnames[] = {
     "w30.d0", "w30.d1", "w31.d0", "w31.d1",
 };
 
+static const char * const mxuregnames[] = {
+    "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
+    "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "MXU_CR",
+};
+
 #define LOG_DISAS(...)                                                        \
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
@@ -27231,6 +27240,17 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
+
+    for (i = 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
+        mxu_gpr[i] = tcg_global_mem_new(cpu_env,
+                                        offsetof(CPUMIPSState,
+                                                 active_tc.mxu_gpr[i]),
+                                        mxuregnames[i]);
+    }
+
+    mxu_CR = tcg_global_mem_new(cpu_env,
+                                offsetof(CPUMIPSState, active_tc.mxu_cr),
+                                mxuregnames[NUMBER_OF_MXU_REGISTERS - 1]);
 }
 
 #include "translate_init.inc.c"
-- 
2.7.4
