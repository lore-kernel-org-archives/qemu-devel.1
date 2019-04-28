Received: from eggs.gnu.org ([209.51.188.92]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0q-000608-Mb
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0p-00055R-Jm
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:40 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:33 +0100
Message-Id: <20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
registers are in host endian order" functions getVSR() and putVSR() which used
to convert the VSR registers into host endian order are no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/mem_helper.c             | 24 +++++++++++-------------
 target/ppc/translate/vsx-impl.inc.c |  8 +++++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 5b0f9ee50d..4dfa7ee23f 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -415,28 +415,27 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 
 #define VSX_LXVL(name, lj)                                              \
 void helper_##name(CPUPPCState *env, target_ulong addr,                 \
-                   target_ulong xt_num, target_ulong rb)                \
+                   target_ulong xt, target_ulong rb)                    \
 {                                                                       \
+    ppc_vsr_t *r = &env->vsr[xt];                                       \
+    int nb = GET_NB(env->gpr[rb]);                                      \
     int i;                                                              \
-    ppc_vsr_t xt;                                                       \
-    uint64_t nb = GET_NB(rb);                                           \
                                                                         \
-    xt.s128 = int128_zero();                                            \
+    r->s128 = int128_zero();                                            \
     if (nb) {                                                           \
         nb = (nb >= 16) ? 16 : nb;                                      \
         if (msr_le && !lj) {                                            \
             for (i = 16; i > 16 - nb; i--) {                            \
-                xt.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
+                r->VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
                 addr = addr_add(env, addr, 1);                          \
             }                                                           \
         } else {                                                        \
             for (i = 0; i < nb; i++) {                                  \
-                xt.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
+                r->VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
                 addr = addr_add(env, addr, 1);                          \
             }                                                           \
         }                                                               \
     }                                                                   \
-    putVSR(xt_num, &xt, env);                                           \
 }
 
 VSX_LXVL(lxvl, 0)
@@ -445,25 +444,24 @@ VSX_LXVL(lxvll, 1)
 
 #define VSX_STXVL(name, lj)                                       \
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
-                   target_ulong xt_num, target_ulong rb)          \
+                   target_ulong xt, target_ulong rb)              \
 {                                                                 \
+    ppc_vsr_t *r = &env->vsr[xt];                                 \
+    int nb = GET_NB(env->gpr[rb]);                                \
     int i;                                                        \
-    ppc_vsr_t xt;                                                 \
-    target_ulong nb = GET_NB(rb);                                 \
                                                                   \
     if (!nb) {                                                    \
         return;                                                   \
     }                                                             \
-    getVSR(xt_num, &xt, env);                                     \
     nb = (nb >= 16) ? 16 : nb;                                    \
     if (msr_le && !lj) {                                          \
         for (i = 16; i > 16 - nb; i--) {                          \
-            cpu_stb_data_ra(env, addr, xt.VsrB(i - 1), GETPC());  \
+            cpu_stb_data_ra(env, addr, r->VsrB(i - 1), GETPC());  \
             addr = addr_add(env, addr, 1);                        \
         }                                                         \
     } else {                                                      \
         for (i = 0; i < nb; i++) {                                \
-            cpu_stb_data_ra(env, addr, xt.VsrB(i), GETPC());      \
+            cpu_stb_data_ra(env, addr, r->VsrB(i), GETPC());      \
             addr = addr_add(env, addr, 1);                        \
         }                                                         \
     }                                                             \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 11d9b75d01..c776d50ddc 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -290,7 +290,7 @@ VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
 #define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-    TCGv EA, xt;                                                \
+    TCGv EA, xt, rb;                                            \
                                                                 \
     if (xT(ctx->opcode) < 32) {                                 \
         if (unlikely(!ctx->vsx_enabled)) {                      \
@@ -304,12 +304,14 @@ static void gen_##name(DisasContext *ctx)                       \
         }                                                       \
     }                                                           \
     EA = tcg_temp_new();                                        \
-    xt = tcg_const_tl(xT(ctx->opcode));                         \
     gen_set_access_type(ctx, ACCESS_INT);                       \
     gen_addr_register(ctx, EA);                                 \
-    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
+    xt = tcg_const_tl(xT(ctx->opcode));                         \
+    rb = tcg_const_tl(rB(ctx->opcode));                         \
+    gen_helper_##name(cpu_env, EA, xt, rb);                     \
     tcg_temp_free(EA);                                          \
     tcg_temp_free(xt);                                          \
+    tcg_temp_free(rb);                                          \
 }
 
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
-- 
2.11.0
