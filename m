Received: from eggs.gnu.org ([209.51.188.92]:53944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLF-00080m-RZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLD-0004qA-Rs
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLC-0004lc-Gg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id j125so7207131wmj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:51 +0000
Message-Id: <20190214190603.25030-16-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/27] target/arm: Rely on optimization within
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

From: Richard Henderson <richard.henderson@linaro.org>

Since we're now handling a == b generically, we no longer need
to do it by hand within target/arm/.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c |  6 +-----
 target/arm/translate-sve.c |  6 +-----
 target/arm/translate.c     | 12 +++---------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2f849a6951d..08c13484cd7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10652,11 +10652,7 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
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
index b15b615ceb3..3a2eb515664 100644
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
index eb258958768..eaa6e297384 100644
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
2.20.1
