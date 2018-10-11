Received: from eggs.gnu.org ([2001:4830:134:3::10]:45007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwj-0006lw-EN
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwh-0005Xf-5j
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:37 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwf-0004EA-5W
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:33 -0400
Received: by mail-pg1-x532.google.com with SMTP id 80-v6so4721210pgh.10
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:55 -0700
Message-Id: <20181011205206.3552-10-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/20] target/arm: Use gvec for
 NEON_3R_VADD_VSUB insns
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ab9f69b01..4dcd7123e9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5949,6 +5949,16 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 break;
             }
             return 0;
+
+        case NEON_3R_VADD_VSUB:
+            if (u) {
+                tcg_gen_gvec_sub(size, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+            } else {
+                tcg_gen_gvec_add(size, rd_ofs, rn_ofs, rm_ofs,
+                                 vec_size, vec_size);
+            }
+            return 0;
         }
         if (size == 3) {
             /* 64-bit element instructions. */
@@ -6006,13 +6016,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                                   cpu_V1, cpu_V0);
                     }
                     break;
-                case NEON_3R_VADD_VSUB:
-                    if (u) {
-                        tcg_gen_sub_i64(CPU_V001);
-                    } else {
-                        tcg_gen_add_i64(CPU_V001);
-                    }
-                    break;
                 default:
                     abort();
                 }
@@ -6147,18 +6150,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rd, pass);
             gen_neon_add(size, tmp, tmp2);
             break;
-        case NEON_3R_VADD_VSUB:
-            if (!u) { /* VADD */
-                gen_neon_add(size, tmp, tmp2);
-            } else { /* VSUB */
-                switch (size) {
-                case 0: gen_helper_neon_sub_u8(tmp, tmp, tmp2); break;
-                case 1: gen_helper_neon_sub_u16(tmp, tmp, tmp2); break;
-                case 2: tcg_gen_sub_i32(tmp, tmp, tmp2); break;
-                default: abort();
-                }
-            }
-            break;
         case NEON_3R_VTST_VCEQ:
             if (!u) { /* VTST */
                 switch (size) {
-- 
2.17.1
