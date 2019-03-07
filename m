Received: from eggs.gnu.org ([209.51.188.92]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOh-0007CP-ID
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOf-0006F8-8l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:35 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:15 +0000
Message-Id: <20190307180520.13868-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 2/7] target/ppc: introduce single
 vsrl_offset() function
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
single vsrl_offset() function.

This commit also renames the existing get_vsr()/set_vsr() functions to
get_vsrl()/set_vsrl() which better describes their purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h                    |  7 ++++++-
 target/ppc/translate/vsx-impl.inc.c | 12 ++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4bb4e42670..4a7df13c2d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2573,9 +2573,14 @@ static inline uint64_t *cpu_fpr_ptr(CPUPPCState *env, int i)
     return (uint64_t *)((uintptr_t)env + fpr_offset(i));
 }
 
+static inline int vsrl_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[i].u64[1]);
+}
+
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
 {
-    return &env->vsr[i].u64[1];
+    return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
 }
 
 static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index e73197e717..381ae0f2e9 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1,13 +1,13 @@
 /***                           VSX extension                               ***/
 
-static inline void get_vsr(TCGv_i64 dst, int n)
+static inline void get_vsrl(TCGv_i64 dst, int n)
 {
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
+    tcg_gen_ld_i64(dst, cpu_env, vsrl_offset(n));
 }
 
-static inline void set_vsr(int n, TCGv_i64 src)
+static inline void set_vsrl(int n, TCGv_i64 src)
 {
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
+    tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
 }
 
 static inline int vsr_full_offset(int n)
@@ -27,7 +27,7 @@ static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 static inline void get_cpu_vsrl(TCGv_i64 dst, int n)
 {
     if (n < 32) {
-        get_vsr(dst, n);
+        get_vsrl(dst, n);
     } else {
         get_avr64(dst, n - 32, false);
     }
@@ -45,7 +45,7 @@ static inline void set_cpu_vsrh(int n, TCGv_i64 src)
 static inline void set_cpu_vsrl(int n, TCGv_i64 src)
 {
     if (n < 32) {
-        set_vsr(n, src);
+        set_vsrl(n, src);
     } else {
         set_avr64(n - 32, src, false);
     }
-- 
2.11.0
