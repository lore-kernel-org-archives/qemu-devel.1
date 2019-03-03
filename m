Received: from eggs.gnu.org ([209.51.188.92]:45464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqA-0004vl-Vu
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqA-0001qG-1C
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:54 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  3 Mar 2019 17:23:39 +0000
Message-Id: <20190303172343.13406-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/8] target/ppc: introduce avrh_offset() and
 avrl_offset() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

These will become more useful later, but initially use this as an aid to
simplify the offset calculation by replacing the HOST_TARGET_BIGENDIAN
sections with the VsrD macro.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/cpu.h       | 10 ++++++++++
 target/ppc/translate.c | 24 ++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d0580c6b6d..326593e0e7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2603,6 +2603,16 @@ static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
     return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
 }
 
+static inline int avrh_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[32 + i].VsrD(0));
+}
+
+static inline int avrl_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[32 + i].VsrD(1));
+}
+
 static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
 {
     return &env->vsr[32 + i];
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3b1992faf1..f646f359e7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6687,24 +6687,20 @@ static inline void set_fpr(int regno, TCGv_i64 src)
 
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 0 : 1)]));
-#else
-    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 1 : 0)]));
-#endif
+    if (high) {
+        tcg_gen_ld_i64(dst, cpu_env, avrh_offset(regno));
+    } else {
+        tcg_gen_ld_i64(dst, cpu_env, avrl_offset(regno));
+    }
 }
 
 static inline void set_avr64(int regno, TCGv_i64 src, bool high)
 {
-#ifdef HOST_WORDS_BIGENDIAN
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 0 : 1)]));
-#else
-    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
-                                          vsr[32 + regno].u64[(high ? 1 : 0)]));
-#endif
+    if (high) {
+        tcg_gen_st_i64(src, cpu_env, avrh_offset(regno));
+    } else {
+        tcg_gen_st_i64(src, cpu_env, avrl_offset(regno));
+    }
 }
 
 #include "translate/fp-impl.inc.c"
-- 
2.11.0
