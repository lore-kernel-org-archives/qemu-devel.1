Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92c-0001Tm-8I
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92X-0002ES-Tf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:40 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92V-0001y7-Ph
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:37 -0500
Received: by mail-pf1-x442.google.com with SMTP id 64so7641146pfr.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:38:46 -0800
Message-Id: <20181218063911.2112-10-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/34] target/arm: Use vector minmax expanders
 for aarch64
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d6f8c1b4f..bef21ada71 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10452,6 +10452,20 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x0c: /* SMAX, UMAX */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smax, size);
+        }
+        return;
+    case 0x0d: /* SMIN, UMIN */
+        if (u) {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umin, size);
+        } else {
+            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
+        }
+        return;
     case 0x10: /* ADD, SUB */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
@@ -10613,27 +10627,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0xc: /* SMAX, UMAX */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_max_s8, gen_helper_neon_max_u8 },
-                    { gen_helper_neon_max_s16, gen_helper_neon_max_u16 },
-                    { tcg_gen_smax_i32, tcg_gen_umax_i32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
-
-            case 0xd: /* SMIN, UMIN */
-            {
-                static NeonGenTwoOpFn * const fns[3][2] = {
-                    { gen_helper_neon_min_s8, gen_helper_neon_min_u8 },
-                    { gen_helper_neon_min_s16, gen_helper_neon_min_u16 },
-                    { tcg_gen_smin_i32, tcg_gen_umin_i32 },
-                };
-                genfn = fns[size][u];
-                break;
-            }
             case 0xe: /* SABD, UABD */
             case 0xf: /* SABA, UABA */
             {
-- 
2.17.2
