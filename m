Received: from eggs.gnu.org ([209.51.188.92]:43144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toX-0001P9-Lh
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toW-0001dj-AL
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:09 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:40 +1100
Message-Id: <20190310082703.1245-38-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/60] target/ppc: introduce avr_full_offset()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

All TCG vector operations require pointers to the base address of the vec=
tor
rather than separate access to the top and bottom 64-bits. Convert the VM=
X TCG
instructions to use a new avr_full_offset() function instead of avr64_off=
set()
which can then itself be written as a simple wrapper onto vsr_full_offset=
().

This same function can also reused in cpu_avr_ptr() to avoid having more =
than
one copy of the offset calculation logic.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190307180520.13868-5-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h                    | 12 +++++++++++-
 target/ppc/translate/vmx-impl.inc.c | 22 +++++++++++-----------
 target/ppc/translate/vsx-impl.inc.c |  5 -----
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1c4af4a1dc..caddbd012c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2598,14 +2598,24 @@ static inline int vsrl_offset(int i)
     return offsetof(CPUPPCState, vsr[i].u64[1]);
 }
=20
+static inline int vsr_full_offset(int i)
+{
+    return offsetof(CPUPPCState, vsr[i].u64[0]);
+}
+
 static inline uint64_t *cpu_vsrl_ptr(CPUPPCState *env, int i)
 {
     return (uint64_t *)((uintptr_t)env + vsrl_offset(i));
 }
=20
+static inline int avr_full_offset(int i)
+{
+    return vsr_full_offset(i + 32);
+}
+
 static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
 {
-    return &env->vsr[32 + i];
+    return (ppc_avr_t *)((uintptr_t)env + avr_full_offset(i));
 }
=20
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index f1b15ae2cb..4e5d0bc0e0 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -10,7 +10,7 @@
 static inline TCGv_ptr gen_avr_ptr(int reg)
 {
     TCGv_ptr r =3D tcg_temp_new_ptr();
-    tcg_gen_addi_ptr(r, cpu_env, offsetof(CPUPPCState, vsr[32 + reg].u64=
[0]));
+    tcg_gen_addi_ptr(r, cpu_env, avr_full_offset(reg));
     return r;
 }
=20
@@ -205,7 +205,7 @@ static void gen_mtvscr(DisasContext *ctx)
     }
=20
     val =3D tcg_temp_new_i32();
-    bofs =3D avr64_offset(rB(ctx->opcode), true);
+    bofs =3D avr_full_offset(rB(ctx->opcode));
 #ifdef HOST_WORDS_BIGENDIAN
     bofs +=3D 3 * 4;
 #endif
@@ -284,9 +284,9 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
     }                                                                   =
\
                                                                         =
\
     tcg_op(vece,                                                        =
\
-           avr64_offset(rD(ctx->opcode), true),                         =
\
-           avr64_offset(rA(ctx->opcode), true),                         =
\
-           avr64_offset(rB(ctx->opcode), true),                         =
\
+           avr_full_offset(rD(ctx->opcode)),                            =
\
+           avr_full_offset(rA(ctx->opcode)),                            =
\
+           avr_full_offset(rB(ctx->opcode)),                            =
\
            16, 16);                                                     =
\
 }
=20
@@ -578,10 +578,10 @@ static void glue(gen_, NAME)(DisasContext *ctx)    =
                     \
         gen_exception(ctx, POWERPC_EXCP_VPU);                           =
\
         return;                                                         =
\
     }                                                                   =
\
-    tcg_gen_gvec_4(avr64_offset(rD(ctx->opcode), true),                 =
\
+    tcg_gen_gvec_4(avr_full_offset(rD(ctx->opcode)),                    =
\
                    offsetof(CPUPPCState, vscr_sat),                     =
\
-                   avr64_offset(rA(ctx->opcode), true),                 =
\
-                   avr64_offset(rB(ctx->opcode), true),                 =
\
+                   avr_full_offset(rA(ctx->opcode)),                    =
\
+                   avr_full_offset(rB(ctx->opcode)),                    =
\
                    16, 16, &g);                                         =
\
 }
=20
@@ -755,7 +755,7 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
             return;                                                     =
\
         }                                                               =
\
         simm =3D SIMM5(ctx->opcode);                                    =
  \
-        tcg_op(avr64_offset(rD(ctx->opcode), true), 16, 16, simm);      =
\
+        tcg_op(avr_full_offset(rD(ctx->opcode)), 16, 16, simm);         =
\
     }
=20
 GEN_VXFORM_DUPI(vspltisb, tcg_gen_gvec_dup8i, 6, 12);
@@ -850,8 +850,8 @@ static void gen_vsplt(DisasContext *ctx, int vece)
     }
=20
     uimm =3D UIMM5(ctx->opcode);
-    bofs =3D avr64_offset(rB(ctx->opcode), true);
-    dofs =3D avr64_offset(rD(ctx->opcode), true);
+    bofs =3D avr_full_offset(rB(ctx->opcode));
+    dofs =3D avr_full_offset(rD(ctx->opcode));
=20
     /* Experimental testing shows that hardware masks the immediate.  */
     bofs +=3D (uimm << vece) & 15;
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 381ae0f2e9..7d02a235e7 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -10,11 +10,6 @@ static inline void set_vsrl(int n, TCGv_i64 src)
     tcg_gen_st_i64(src, cpu_env, vsrl_offset(n));
 }
=20
-static inline int vsr_full_offset(int n)
-{
-    return offsetof(CPUPPCState, vsr[n].u64[0]);
-}
-
 static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
 {
     if (n < 32) {
--=20
2.20.1
