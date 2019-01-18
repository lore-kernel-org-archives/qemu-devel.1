Received: from eggs.gnu.org ([209.51.188.92]:45540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXV9-0003be-Sj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkXV7-00079v-I2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:15 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52993 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkXV7-00077W-9o
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:00:13 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 18 Jan 2019 17:59:45 +0100
Message-Id: <1547830785-7079-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 12/12] target/mips: Introduce 32 R5900
 multimedia registers
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

From: Fredrik Noring <noring@nocrew.org>

The 32 R5900 128-bit registers are split into two 64-bit halves:
the lower halves are the GPRs and the upper halves are accessible
by the R5900-specific multimedia instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/cpu.h       |  3 +++
 target/mips/translate.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 21daf50..c4da7df 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -429,6 +429,9 @@ struct TCState {
 
     float_status msa_fp_status;
 
+    /* Upper 64-bit MMRs (multimedia registers); the lower 64-bit are GPRs */
+    uint64_t mmr[32];
+
 #define NUMBER_OF_MXU_REGISTERS 16
     target_ulong mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
     target_ulong mxu_cr;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3ac0b1f..ab307c4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2455,6 +2455,11 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
 
+#if defined(TARGET_MIPS64)
+/* Upper halves of R5900's 128-bit registers: MMRs (multimedia registers) */
+static TCGv_i64 cpu_mmr[32];
+#endif
+
 #if !defined(TARGET_MIPS64)
 /* MXU registers */
 static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
@@ -29845,6 +29850,17 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
+
+#if defined(TARGET_MIPS64)
+    cpu_mmr[0] = NULL;
+    for (i = 1; i < 32; i++) {
+        cpu_mmr[i] = tcg_global_mem_new_i64(cpu_env,
+                                            offsetof(CPUMIPSState,
+                                                     active_tc.mmr[i]),
+                                            regnames[i]);
+    }
+#endif
+
 #if !defined(TARGET_MIPS64)
     for (i = 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
         mxu_gpr[i] = tcg_global_mem_new(cpu_env,
-- 
2.7.4
