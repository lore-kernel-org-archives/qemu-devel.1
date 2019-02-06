Received: from eggs.gnu.org ([209.51.188.92]:50846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFbg-0007HS-61
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFQU-0003Jf-Ml
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFQU-0003JC-81
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:07:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id z5so1114575wmf.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:07:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:06:57 +0000
Message-Id: <20190206050701.11847-2-richard.henderson@linaro.org>
In-Reply-To: <20190206050701.11847-1-richard.henderson@linaro.org>
References: <20190206050701.11847-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/5] target/arm: Rely on optimization within
 tcg_gen_gvec_or
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Since we're now handling a == b generically, we no longer need
to do it by hand within target/arm/.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c |  6 +-----
 target/arm/translate-sve.c |  6 +-----
 target/arm/translate.c     | 12 +++---------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e002251ac6..a12bfac719 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10648,11 +10648,7 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
         gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_andc, 0);
         return;
     case 2: /* ORR */
-        if (rn == rm) { /* MOV */
-            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_mov, 0);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
-        }
+        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
         return;
     case 3: /* ORN */
         gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_orc, 0);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b15b615ceb..3a2eb51566 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -280,11 +280,7 @@ static bool trans_AND_zzz(DisasContext *s, arg_rrr_esz *a)
 
 static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    if (a->rn == a->rm) { /* MOV */
-        return do_mov_z(s, a->rd, a->rn);
-    } else {
-        return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
-    }
+    return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
 }
 
 static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 66cf28c8cb..9d2dba7ed2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6294,15 +6294,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_gvec_andc(0, rd_ofs, rn_ofs, rm_ofs,
                                   vec_size, vec_size);
                 break;
-            case 2:
-                if (rn == rm) {
-                    /* VMOV */
-                    tcg_gen_gvec_mov(0, rd_ofs, rn_ofs, vec_size, vec_size);
-                } else {
-                    /* VORR */
-                    tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
-                                    vec_size, vec_size);
-                }
+            case 2: /* VORR */
+                tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
+                                vec_size, vec_size);
                 break;
             case 3: /* VORN */
                 tcg_gen_gvec_orc(0, rd_ofs, rn_ofs, rm_ofs,
-- 
2.17.2
