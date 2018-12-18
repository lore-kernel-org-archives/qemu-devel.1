Received: from eggs.gnu.org ([2001:4830:134:3::10]:53086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92y-0001j6-SK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92s-0002tR-Ix
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:04 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:35001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92s-00027p-0S
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:58 -0500
Received: by mail-pf1-x432.google.com with SMTP id z9so7657936pfi.2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:51 -0800
Message-Id: <20181218063911.2112-15-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 14/34] target/ppc: switch FPR,
 VMX and VSX helpers to access data directly from cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead of accessing the FPR, VMX and VSX registers through static arrays of
TCGv_i64 globals, remove them and change the helpers to load/store data directly
within cpu_env.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20181217122405.18732-6-mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c              | 59 ++++++++---------------------
 target/ppc/translate/vsx-impl.inc.c |  4 +-
 2 files changed, 18 insertions(+), 45 deletions(-)

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
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index e9a05d66f7..20e1fd9324 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -2,12 +2,12 @@
 
 static inline void get_vsr(TCGv_i64 dst, int n)
 {
-    tcg_gen_mov_i64(dst, cpu_vsr[n]);
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n]));
 }
 
 static inline void set_vsr(int n, TCGv_i64 src)
 {
-    tcg_gen_mov_i64(cpu_vsr[n], src);
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n]));
 }
 
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
-- 
2.17.2
