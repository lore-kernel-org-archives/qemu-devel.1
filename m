Received: from eggs.gnu.org ([2001:4830:134:3::10]:55428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVBwq-0002Uk-4M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVBwo-0000P0-3I
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:57:23 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Dec 2018 08:56:33 +0000
Message-Id: <20181207085635.4291-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH 4/6] target/ppc: switch FPR,
 VMX and VSX helpers to access data directly from cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

Instead of accessing the FPR, VMX and VSX registers through static arrays of
TCGv_i64 globals, remove them and change the helpers to load/store data directly
within cpu_env.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 59 ++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fa3e8dc114..5923c688cd 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -55,15 +55,9 @@
 /* global register indexes */
 static char cpu_reg_names[10*3 + 22*4 /* GPR */
     + 10*4 + 22*5 /* SPE GPRh */
-    + 10*4 + 22*5 /* FPR */
-    + 2*(10*6 + 22*7) /* AVRh, AVRl */
-    + 10*5 + 22*6 /* VSR */
     + 8*5 /* CRF */];
 static TCGv cpu_gpr[32];
 static TCGv cpu_gprh[32];
-static TCGv_i64 cpu_fpr[32];
-static TCGv_i64 cpu_avrh[32], cpu_avrl[32];
-static TCGv_i64 cpu_vsr[32];
 static TCGv_i32 cpu_crf[8];
 static TCGv cpu_nip;
 static TCGv cpu_msr;
@@ -108,39 +102,6 @@ void ppc_translate_init(void)
                                          offsetof(CPUPPCState, gprh[i]), p);
         p += (i < 10) ? 4 : 5;
         cpu_reg_names_size -= (i < 10) ? 4 : 5;
-
-        snprintf(p, cpu_reg_names_size, "fp%d", i);
-        cpu_fpr[i] = tcg_global_mem_new_i64(cpu_env,
-                                            offsetof(CPUPPCState, fpr[i]), p);
-        p += (i < 10) ? 4 : 5;
-        cpu_reg_names_size -= (i < 10) ? 4 : 5;
-
-        snprintf(p, cpu_reg_names_size, "avr%dH", i);
-#ifdef HOST_WORDS_BIGENDIAN
-        cpu_avrh[i] = tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i].u64[0]), p);
-#else
-        cpu_avrh[i] = tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i].u64[1]), p);
-#endif
-        p += (i < 10) ? 6 : 7;
-        cpu_reg_names_size -= (i < 10) ? 6 : 7;
-
-        snprintf(p, cpu_reg_names_size, "avr%dL", i);
-#ifdef HOST_WORDS_BIGENDIAN
-        cpu_avrl[i] = tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i].u64[1]), p);
-#else
-        cpu_avrl[i] = tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i].u64[0]), p);
-#endif
-        p += (i < 10) ? 6 : 7;
-        cpu_reg_names_size -= (i < 10) ? 6 : 7;
-        snprintf(p, cpu_reg_names_size, "vsr%d", i);
-        cpu_vsr[i] = tcg_global_mem_new_i64(cpu_env,
-                                            offsetof(CPUPPCState, vsr[i]), p);
-        p += (i < 10) ? 5 : 6;
-        cpu_reg_names_size -= (i < 10) ? 5 : 6;
     }
 
     cpu_nip = tcg_global_mem_new(cpu_env,
@@ -6696,22 +6657,34 @@ GEN_TM_PRIV_NOOP(trechkpt);
 
 static inline void get_fpr(TCGv_i64 dst, int regno)
 {
-    tcg_gen_mov_i64(dst, cpu_fpr[regno]);
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, fpr[regno]));
 }
 
 static inline void set_fpr(int regno, TCGv_i64 src)
 {
-    tcg_gen_mov_i64(cpu_fpr[regno], src);
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, fpr[regno]));
 }
 
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
 {
-    tcg_gen_mov_i64(dst, (high ? cpu_avrh : cpu_avrl)[regno]);
+#ifdef HOST_WORDS_BIGENDIAN
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 0 : 1)]));
+#else
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 1 : 0)]));
+#endif
 }
 
 static inline void set_avr64(int regno, TCGv_i64 src, bool high)
 {
-    tcg_gen_mov_i64((high ? cpu_avrh : cpu_avrl)[regno], src);
+#ifdef HOST_WORDS_BIGENDIAN
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 0 : 1)]));
+#else
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 1 : 0)]));
+#endif
 }
 
 #include "translate/fp-impl.inc.c"
-- 
2.11.0
