Received: from eggs.gnu.org ([209.51.188.92]:48439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOm-0007FI-D5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOl-0006Of-Dm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:40 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:14 +0000
Message-Id: <20190307180520.13868-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 1/7] target/ppc: introduce single
 fpr_offset() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Instead of having multiple copies of the offset calculation logic, move it to a
single fpr_offset() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h       | 7 ++++++-
 target/ppc/translate.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 26604ddf98..4bb4e42670 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2563,9 +2563,14 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 }
 
 /* Accessors for FP, VMX and VSX registers */
+static inline int fpr_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[i].u64[0]);
+}
+
 static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
 {
-    return &env->vsr[i].u64[0];
+    return (uint64_t *)((uintptr_t)env + fpr_offset(i));
 }
 
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 819221f246..3b1992faf1 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6677,12 +6677,12 @@ GEN_TM_PRIV_NOOP(trechkpt);
 
 static inline void get_fpr(TCGv_i64 dst, int regno)
 {
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]));
+    tcg_gen_ld_i64(dst, cpu_env, fpr_offset(regno));
 }
 
 static inline void set_fpr(int regno, TCGv_i64 src)
 {
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[regno].u64[0]));
+    tcg_gen_st_i64(src, cpu_env, fpr_offset(regno));
 }
 
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
-- 
2.11.0
