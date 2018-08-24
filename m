Received: from eggs.gnu.org ([2001:4830:134:3::10]:41362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0q-0006Rm-EI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0k-0003vq-TS
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:52 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:20478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7672175d0=jancraig@amazon.com>)
	id 1ftI0k-0003vR-NC
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:44:46 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Fri, 24 Aug 2018 15:44:02 -0400
Message-Id: <261dd8062c85c2a5eefb4d6effa2a44d5fc953f7.1535133089.git.jancraig@amazon.com>
In-Reply-To: <cover.1535133088.git.jancraig@amazon.com>
References: <cover.1535133088.git.jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH 1/7] target/mips: Add MXU register support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarkovic@wavecomp.com, aurelien@aurel32.net, Craig Janeczek <jancraig@amazon.com>

This commit makes the MXU registers and the helper functions for
reading/writing to them. This is required for full MXU instruction
support.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 target/mips/cpu.h       |  1 +
 target/mips/translate.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 009202cf64..4b2948a2c8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -170,6 +170,7 @@ struct TCState {
         MSACSR_FS_MASK)
 
     float_status msa_fp_status;
+    target_ulong mxu_gpr[16];
 };
 
 typedef struct CPUMIPSState CPUMIPSState;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index bdd880bb77..50f0cb558f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1398,6 +1398,9 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
 
+/* MXU registers */
+static TCGv mxu_gpr[16];
+
 #include "exec/gen-icount.h"
 
 #define gen_helper_0e0i(name, arg) do {                           \
@@ -1517,6 +1520,13 @@ static const char * const msaregnames[] = {
     "w30.d0", "w30.d1", "w31.d0", "w31.d1",
 };
 
+static const char * const mxuregnames[] = {
+    "XR1",  "XR2",  "XR3",  "XR4",  "XR5",
+    "XR6",  "XR7",  "XR8",  "XR9",  "XR10",
+    "XR11", "XR12", "XR13", "XR14", "XR15",
+    "XR16",
+};
+
 #define LOG_DISAS(...)                                                        \
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
@@ -1550,6 +1560,21 @@ static inline void gen_store_gpr (TCGv t, int reg)
         tcg_gen_mov_tl(cpu_gpr[reg], t);
 }
 
+/* MXU General purpose registers moves. */
+static inline void gen_load_mxu_gpr (TCGv t, int reg)
+{
+    if (reg == 0)
+        tcg_gen_movi_tl(t, 0);
+    else
+        tcg_gen_mov_tl(t, mxu_gpr[reg-1]);
+}
+
+static inline void gen_store_mxu_gpr (TCGv t, int reg)
+{
+    if (reg != 0)
+        tcg_gen_mov_tl(mxu_gpr[reg-1], t);
+}
+
 /* Moves to/from shadow registers. */
 static inline void gen_load_srsgpr (int from, int to)
 {
@@ -20742,6 +20767,11 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
+
+    for (i = 0; i < 16; i++)
+        mxu_gpr[i] = tcg_global_mem_new(cpu_env,
+                                        offsetof(CPUMIPSState, active_tc.mxu_gpr[i]),
+                                        mxuregnames[i]);
 }
 
 #include "translate_init.inc.c"
-- 
2.18.0
