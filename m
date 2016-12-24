Received: from eggs.gnu.org ([2001:4830:134:3::10]:55858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWV-00076y-Gy
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWU-000638-J4
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:31 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:33 -0800
Message-Id: <20161224040042.12654-57-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 56/65] target-ppc: Use ctpop helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/ppc/helper.h     |  3 +--
 target/ppc/int_helper.c | 18 +++---------------
 target/ppc/translate.c  |  6 +++++-
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 1ed1d2c..0a8fbba 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -39,12 +39,11 @@ DEF_HELPER_4(divweu, tl, env, tl, tl, i32)
 DEF_HELPER_4(divwe, tl, env, tl, tl, i32)
 
 DEF_HELPER_FLAGS_1(popcntb, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(cmpb, TCG_CALL_NO_RWG_SE, tl, tl, tl)
 DEF_HELPER_3(sraw, tl, env, tl, tl)
 #if defined(TARGET_PPC64)
 DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
-DEF_HELPER_FLAGS_1(popcntd, TCG_CALL_NO_RWG_SE, tl, tl)
+DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
 DEF_HELPER_0(darn32, tl)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index e1bb695..1871792 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -272,6 +272,7 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
 #if defined(TARGET_PPC64)
 target_ulong helper_popcntb(target_ulong val)
 {
+    /* Note that we don't fold past bytes */
     val = (val & 0x5555555555555555ULL) + ((val >>  1) &
                                            0x5555555555555555ULL);
     val = (val & 0x3333333333333333ULL) + ((val >>  2) &
@@ -283,6 +284,7 @@ target_ulong helper_popcntb(target_ulong val)
 
 target_ulong helper_popcntw(target_ulong val)
 {
+    /* Note that we don't fold past words.  */
     val = (val & 0x5555555555555555ULL) + ((val >>  1) &
                                            0x5555555555555555ULL);
     val = (val & 0x3333333333333333ULL) + ((val >>  2) &
@@ -295,29 +297,15 @@ target_ulong helper_popcntw(target_ulong val)
                                            0x0000ffff0000ffffULL);
     return val;
 }
-
-target_ulong helper_popcntd(target_ulong val)
-{
-    return ctpop64(val);
-}
 #else
 target_ulong helper_popcntb(target_ulong val)
 {
+    /* Note that we don't fold past bytes */
     val = (val & 0x55555555) + ((val >>  1) & 0x55555555);
     val = (val & 0x33333333) + ((val >>  2) & 0x33333333);
     val = (val & 0x0f0f0f0f) + ((val >>  4) & 0x0f0f0f0f);
     return val;
 }
-
-target_ulong helper_popcntw(target_ulong val)
-{
-    val = (val & 0x55555555) + ((val >>  1) & 0x55555555);
-    val = (val & 0x33333333) + ((val >>  2) & 0x33333333);
-    val = (val & 0x0f0f0f0f) + ((val >>  4) & 0x0f0f0f0f);
-    val = (val & 0x00ff00ff) + ((val >>  8) & 0x00ff00ff);
-    val = (val & 0x0000ffff) + ((val >> 16) & 0x0000ffff);
-    return val;
-}
 #endif
 
 /*****************************************************************************/
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1224f56..1212180 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1844,14 +1844,18 @@ static void gen_popcntb(DisasContext *ctx)
 
 static void gen_popcntw(DisasContext *ctx)
 {
+#if defined(TARGET_PPC64)
     gen_helper_popcntw(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+#else
+    tcg_gen_ctpop_i32(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+#endif
 }
 
 #if defined(TARGET_PPC64)
 /* popcntd: PowerPC 2.06 specification */
 static void gen_popcntd(DisasContext *ctx)
 {
-    gen_helper_popcntd(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
+    tcg_gen_ctpop_i64(cpu_gpr[rA(ctx->opcode)], cpu_gpr[rS(ctx->opcode)]);
 }
 #endif
 
-- 
2.9.3
