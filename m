Received: from eggs.gnu.org ([209.51.188.92]:45471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqB-0004vn-Ag
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqA-0001qe-7k
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:55 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  3 Mar 2019 17:23:42 +0000
Message-Id: <20190303172343.13406-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 7/8] target/ppc: introduce vsrh_offset()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Now that both VSX and VMX registers are in host-endian order we can introduce
a vsrh_offset() function as a replacement for fpr_offset().

In addition the avrh_offset() and avrl_offset() functions can be simplified in
terms of vsrh_offset() and vsrl_offset().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h       | 16 ++++++++--------
 target/ppc/translate.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index faae25a566..9f8eb0bdc0 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2583,16 +2583,11 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
 #define VsrSD(i) s64[1 - (i)]
 #endif
 
-static inline int fpr_offset(int i)
+static inline int vsrh_offset(int i)
 {
     return offsetof(CPUPPCState, vsr[i].VsrD(0));
 }
 
-static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
-{
-    return (uint64_t *)((uintptr_t)env + fpr_offset(i));
-}
-
 static inline int vsrl_offset(int i)
 {
     return offsetof(CPUPPCState, vsr[i].VsrD(1));
@@ -2603,6 +2598,11 @@ static inline int vsr_full_offset(int i)
     return offsetof(CPUPPCState, vsr[i].u64[0]);
 }
 
+static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
+{
+    return (uint64_t *)((uintptr_t)env + vsrh_offset(i));
+}
+
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
 {
     return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
@@ -2610,12 +2610,12 @@ static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
 
 static inline int avrh_offset(int i)
 {
-    return offsetof(CPUPPCState, vsr[32 + i].VsrD(0));
+    return vsrh_offset(i + 32);
 }
 
 static inline int avrl_offset(int i)
 {
-    return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
+    return vsrl_offset(i + 32);
 }
 
 static inline int avr_offset(int i)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index f646f359e7..1c7377d588 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6677,12 +6677,12 @@ GEN_TM_PRIV_NOOP(trechkpt);
 
 static inline void get_fpr(TCGv_i64 dst, int regno)
 {
-    tcg_gen_ld_i64(dst, cpu_env, fpr_offset(regno));
+    tcg_gen_ld_i64(dst, cpu_env, vsrh_offset(regno));
 }
 
 static inline void set_fpr(int regno, TCGv_i64 src)
 {
-    tcg_gen_st_i64(src, cpu_env, fpr_offset(regno));
+    tcg_gen_st_i64(src, cpu_env, vsrh_offset(regno));
 }
 
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
-- 
2.11.0
