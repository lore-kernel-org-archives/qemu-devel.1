Received: from eggs.gnu.org ([209.51.188.92]:33313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil2l-0003aD-MQ
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gil2j-00045i-RB
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:03:35 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:55302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gil2j-00044Q-K9
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 14:03:33 -0500
Date: Sun, 13 Jan 2019 20:03:20 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <dccb35585b1e6f333e6809234cb9eacf63d5a686.1547403692.git.noring@nocrew.org>
References: <cover.1547403692.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1547403692.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH 2/9] target/mips: Introduce 32 R5900 128-bit
 multimedia registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

The 32 R5900 128-bit MMRs are split into two 64-bit halves: the lower
halves are the GPRs and the upper halves are accessible by the R5900-
specific multimedia instructions.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/cpu.h       |  2 ++
 target/mips/translate.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 03c03fd8c6..9ff4a68d90 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -180,6 +180,8 @@ struct TCState {
 #define MXU_CR_RD_EN    1
 #define MXU_CR_MXU_EN   0
 
+    /* Upper 64-bit MMRs (multimedia registers); the lower 64-bit are GPRs */
+    uint64_t mmr[32];
 };
 
 typedef struct CPUMIPSState CPUMIPSState;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index a538351032..9d5150ec8b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2455,7 +2455,10 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
 
-#if !defined(TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
+/* Upper 64-bit MMRs (multimedia registers); the lower 64-bit are GPRs */
+static TCGv_i64 cpu_mmr[32];
+#else
 /* MXU registers */
 static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
 static TCGv mxu_CR;
@@ -29785,7 +29788,14 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
-#if !defined(TARGET_MIPS64)
+#if defined(TARGET_MIPS64)
+    cpu_mmr[0] = NULL;
+    for (i = 1; i < 32; i++)
+        cpu_mmr[i] = tcg_global_mem_new_i64(cpu_env,
+                                            offsetof(CPUMIPSState,
+                                                     active_tc.mmr[i]),
+                                            regnames[i]);
+#else
     for (i = 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
         mxu_gpr[i] = tcg_global_mem_new(cpu_env,
                                         offsetof(CPUMIPSState,
-- 
2.19.2
