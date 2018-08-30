Received: from eggs.gnu.org ([208.118.235.92]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSsz-000139-AQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSfR-0007QF-2n
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:31:49 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7732fbd28=jancraig@amazon.com>)
	id 1fvSfQ-0007Q7-Tt
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:31:45 -0400
From: Craig Janeczek <jancraig@amazon.com>
Date: Thu, 30 Aug 2018 15:30:11 -0400
Message-Id: <20180830193019.20104-2-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-1-jancraig@amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>
Subject: [Qemu-devel] [PATCH v4 1/9] target/mips: Introduce MXU registers
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

Define and initialize the 16 MXU registers.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
---
 v1
    - NA
 v2
    - NA
 v3
    - Initial patch, split out from prior first patch
 v4
    - fixed reg name alignment
    - added braces around init for loop
    - Split mxu_CR out of the mxu_gpr array

 target/mips/cpu.h       |  2 ++
 target/mips/translate.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 009202cf64..ff356f529b 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -170,6 +170,8 @@ struct TCState {
         MSACSR_FS_MASK)
 
     float_status msa_fp_status;
+    target_ulong mxu_gpr[15];
+    target_ulong mxu_cr;
 };
 
 typedef struct CPUMIPSState CPUMIPSState;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index bdd880bb77..19b90c8735 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1398,6 +1398,10 @@ static TCGv_i32 fpu_fcr0, fpu_fcr31;
 static TCGv_i64 fpu_f64[32];
 static TCGv_i64 msa_wr_d[64];
 
+/* MXU registers */
+static TCGv mxu_gpr[15];
+static TCGv mxu_CR;
+
 #include "exec/gen-icount.h"
 
 #define gen_helper_0e0i(name, arg) do {                           \
@@ -1517,6 +1521,11 @@ static const char * const msaregnames[] = {
     "w30.d0", "w30.d1", "w31.d0", "w31.d1",
 };
 
+static const char * const mxuregnames[] = {
+    "XR1", "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
+    "XR9", "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XR16",
+};
+
 #define LOG_DISAS(...)                                                        \
     do {                                                                      \
         if (MIPS_DEBUG_DISAS) {                                               \
@@ -20742,6 +20751,17 @@ void mips_tcg_init(void)
     fpu_fcr31 = tcg_global_mem_new_i32(cpu_env,
                                        offsetof(CPUMIPSState, active_fpu.fcr31),
                                        "fcr31");
+
+    for (i = 0; i < 15; i++) {
+        mxu_gpr[i] = tcg_global_mem_new(cpu_env,
+                                        offsetof(CPUMIPSState,
+                                                 active_tc.mxu_gpr[i]),
+                                        mxuregnames[i]);
+    }
+
+    mxu_CR = tcg_global_mem_new(cpu_env,
+                                offsetof(CPUMIPSState, active_tc.mxu_cr),
+                                "MXU_CR");
 }
 
 #include "translate_init.inc.c"
-- 
2.18.0
