Received: from eggs.gnu.org ([2001:4830:134:3::10]:45194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwq-0006s6-02
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwm-00063p-LX
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:36418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwm-0004La-Cy
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id l81-v6so5011778pfg.3
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:56 -0700
Message-Id: <20181011205206.3552-11-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/20] target/arm: Use gvec for NEON_2RM_VMN,
 NEON_2RM_VNEG
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
 target/arm/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4dcd7123e9..fae132791a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7501,6 +7501,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tcg_temp_free_ptr(ptr1);
                     tcg_temp_free_ptr(ptr2);
                     break;
+
+                case NEON_2RM_VMVN:
+                    tcg_gen_gvec_not(0, rd_ofs, rm_ofs, vec_size, vec_size);
+                    break;
+                case NEON_2RM_VNEG:
+                    tcg_gen_gvec_neg(size, rd_ofs, rm_ofs, vec_size, vec_size);
+                    break;
+
                 default:
                 elementwise:
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
@@ -7541,9 +7549,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case NEON_2RM_VCNT:
                             gen_helper_neon_cnt_u8(tmp, tmp);
                             break;
-                        case NEON_2RM_VMVN:
-                            tcg_gen_not_i32(tmp, tmp);
-                            break;
                         case NEON_2RM_VQABS:
                             switch (size) {
                             case 0:
@@ -7616,11 +7621,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             default: abort();
                             }
                             break;
-                        case NEON_2RM_VNEG:
-                            tmp2 = tcg_const_i32(0);
-                            gen_neon_rsb(size, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
-                            break;
                         case NEON_2RM_VCGT0_F:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-- 
2.17.1
