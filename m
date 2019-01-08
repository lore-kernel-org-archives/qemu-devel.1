Received: from eggs.gnu.org ([209.51.188.92]:57896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08r-0005xc-6S
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08o-0006fO-H1
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:41 +1100
Message-Id: <20190108224600.23125-11-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/29] target/ppc: switch FPR,
 VMX and VSX helpers to access data directly from cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Instead of accessing the FPR, VMX and VSX registers through static arrays=
 of
TCGv_i64 globals, remove them and change the helpers to load/store data d=
irectly
within cpu_env.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c              | 59 ++++++++---------------------
 target/ppc/translate/vsx-impl.inc.c |  4 +-
 2 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3bb24e7310..b18ded07b3 100644
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
                                          offsetof(CPUPPCState, gprh[i]),=
 p);
         p +=3D (i < 10) ? 4 : 5;
         cpu_reg_names_size -=3D (i < 10) ? 4 : 5;
-
-        snprintf(p, cpu_reg_names_size, "fp%d", i);
-        cpu_fpr[i] =3D tcg_global_mem_new_i64(cpu_env,
-                                            offsetof(CPUPPCState, fpr[i]=
), p);
-        p +=3D (i < 10) ? 4 : 5;
-        cpu_reg_names_size -=3D (i < 10) ? 4 : 5;
-
-        snprintf(p, cpu_reg_names_size, "avr%dH", i);
-#ifdef HOST_WORDS_BIGENDIAN
-        cpu_avrh[i] =3D tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i=
].u64[0]), p);
-#else
-        cpu_avrh[i] =3D tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i=
].u64[1]), p);
-#endif
-        p +=3D (i < 10) ? 6 : 7;
-        cpu_reg_names_size -=3D (i < 10) ? 6 : 7;
-
-        snprintf(p, cpu_reg_names_size, "avr%dL", i);
-#ifdef HOST_WORDS_BIGENDIAN
-        cpu_avrl[i] =3D tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i=
].u64[1]), p);
-#else
-        cpu_avrl[i] =3D tcg_global_mem_new_i64(cpu_env,
-                                             offsetof(CPUPPCState, avr[i=
].u64[0]), p);
-#endif
-        p +=3D (i < 10) ? 6 : 7;
-        cpu_reg_names_size -=3D (i < 10) ? 6 : 7;
-        snprintf(p, cpu_reg_names_size, "vsr%d", i);
-        cpu_vsr[i] =3D tcg_global_mem_new_i64(cpu_env,
-                                            offsetof(CPUPPCState, vsr[i]=
), p);
-        p +=3D (i < 10) ? 5 : 6;
-        cpu_reg_names_size -=3D (i < 10) ? 5 : 6;
     }
=20
     cpu_nip =3D tcg_global_mem_new(cpu_env,
@@ -6701,22 +6662,34 @@ GEN_TM_PRIV_NOOP(trechkpt);
=20
 static inline void get_fpr(TCGv_i64 dst, int regno)
 {
-    tcg_gen_mov_i64(dst, cpu_fpr[regno]);
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, fpr[regno]));
 }
=20
 static inline void set_fpr(int regno, TCGv_i64 src)
 {
-    tcg_gen_mov_i64(cpu_fpr[regno], src);
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, fpr[regno]));
 }
=20
 static inline void get_avr64(TCGv_i64 dst, int regno, bool high)
 {
-    tcg_gen_mov_i64(dst, (high ? cpu_avrh : cpu_avrl)[regno]);
+#ifdef HOST_WORDS_BIGENDIAN
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 0 : 1)]=
));
+#else
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 1 : 0)]=
));
+#endif
 }
=20
 static inline void set_avr64(int regno, TCGv_i64 src, bool high)
 {
-    tcg_gen_mov_i64((high ? cpu_avrh : cpu_avrl)[regno], src);
+#ifdef HOST_WORDS_BIGENDIAN
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 0 : 1)]=
));
+#else
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState,
+                                          avr[regno].u64[(high ? 1 : 0)]=
));
+#endif
 }
=20
 #include "translate/fp-impl.inc.c"
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index f0665df1a5..7eaa36b4d5 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -2,12 +2,12 @@
=20
 static inline void get_vsr(TCGv_i64 dst, int n)
 {
-    tcg_gen_mov_i64(dst, cpu_vsr[n]);
+    tcg_gen_ld_i64(dst, cpu_env, offsetof(CPUPPCState, vsr[n]));
 }
=20
 static inline void set_vsr(int n, TCGv_i64 src)
 {
-    tcg_gen_mov_i64(cpu_vsr[n], src);
+    tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n]));
 }
=20
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
--=20
2.20.1
