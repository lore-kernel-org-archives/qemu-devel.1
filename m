Received: from eggs.gnu.org ([2001:4830:134:3::10]:53066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92y-0001iW-Ap
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92s-0002t9-Gh
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:04 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:42085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92r-0001tb-Pe
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:57 -0500
Received: by mail-pg1-x52b.google.com with SMTP id d72so7337892pga.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:39 -0800
Message-Id: <20181218063911.2112-3-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/34] target/arm: Rely on optimization within
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Since we're now handling a == b generically, we no longer need
to do it by hand within target/arm/.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c |  6 +-----
 target/arm/translate-sve.c |  6 +-----
 target/arm/translate.c     | 12 +++---------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e1da1e4d6f..2d6f8c1b4f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10152,11 +10152,7 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
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
index 7c4675ffd8..33b1860148 100644
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
