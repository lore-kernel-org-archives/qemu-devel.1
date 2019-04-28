Received: from eggs.gnu.org ([209.51.188.92]:34853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlM7-00010P-Dh
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKlM5-0008BJ-G2
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:04:39 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:42 +0100
Message-Id: <20190428143845.11810-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 11/14] target/ppc: decode target register in
 VSX_VECTOR_LOAD_STORE_LENGTH at translation time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/helper.h                 | 8 ++++----
 target/ppc/mem_helper.c             | 6 ++----
 target/ppc/translate/vsx-impl.inc.c | 7 ++++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 167d6e45fd..5f844cc968 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -291,10 +291,10 @@ DEF_HELPER_3(stvebx, void, env, avr, tl)
 DEF_HELPER_3(stvehx, void, env, avr, tl)
 DEF_HELPER_3(stvewx, void, env, avr, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_4(lxvl, void, env, tl, tl, tl)
-DEF_HELPER_4(lxvll, void, env, tl, tl, tl)
-DEF_HELPER_4(stxvl, void, env, tl, tl, tl)
-DEF_HELPER_4(stxvll, void, env, tl, tl, tl)
+DEF_HELPER_4(lxvl, void, env, tl, vsr, tl)
+DEF_HELPER_4(lxvll, void, env, tl, vsr, tl)
+DEF_HELPER_4(stxvl, void, env, tl, vsr, tl)
+DEF_HELPER_4(stxvll, void, env, tl, vsr, tl)
 #endif
 DEF_HELPER_4(vsumsws, void, env, avr, avr, avr)
 DEF_HELPER_4(vsum2sws, void, env, avr, avr, avr)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 4dfa7ee23f..f3426315d2 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -415,9 +415,8 @@ STVE(stvewx, cpu_stl_data_ra, bswap32, u32)
 
 #define VSX_LXVL(name, lj)                                              \
 void helper_##name(CPUPPCState *env, target_ulong addr,                 \
-                   target_ulong xt, target_ulong rb)                    \
+                   ppc_vsr_t *r, target_ulong rb)                       \
 {                                                                       \
-    ppc_vsr_t *r = &env->vsr[xt];                                       \
     int nb = GET_NB(env->gpr[rb]);                                      \
     int i;                                                              \
                                                                         \
@@ -444,9 +443,8 @@ VSX_LXVL(lxvll, 1)
 
 #define VSX_STXVL(name, lj)                                       \
 void helper_##name(CPUPPCState *env, target_ulong addr,           \
-                   target_ulong xt, target_ulong rb)              \
+                   ppc_vsr_t *r, target_ulong rb)                 \
 {                                                                 \
-    ppc_vsr_t *r = &env->vsr[xt];                                 \
     int nb = GET_NB(env->gpr[rb]);                                \
     int i;                                                        \
                                                                   \
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 51d4e0cdd6..7c79ec22dd 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -297,7 +297,8 @@ VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
 #define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
 static void gen_##name(DisasContext *ctx)                       \
 {                                                               \
-    TCGv EA, xt, rb;                                            \
+    TCGv EA, rb;                                                \
+    TCGv_ptr xt;                                                \
                                                                 \
     if (xT(ctx->opcode) < 32) {                                 \
         if (unlikely(!ctx->vsx_enabled)) {                      \
@@ -313,12 +314,12 @@ static void gen_##name(DisasContext *ctx)                       \
     EA = tcg_temp_new();                                        \
     gen_set_access_type(ctx, ACCESS_INT);                       \
     gen_addr_register(ctx, EA);                                 \
-    xt = tcg_const_tl(xT(ctx->opcode));                         \
+    xt = gen_vsr_ptr(xT(ctx->opcode));                          \
     rb = tcg_const_tl(rB(ctx->opcode));                         \
     gen_helper_##name(cpu_env, EA, xt, rb);                     \
     tcg_temp_free(EA);                                          \
-    tcg_temp_free(xt);                                          \
     tcg_temp_free(rb);                                          \
+    tcg_temp_free_ptr(xt);                                      \
 }
 
 VSX_VECTOR_LOAD_STORE_LENGTH(lxvl)
-- 
2.11.0
