Received: from eggs.gnu.org ([2001:4830:134:3::10]:48171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7c-0002yQ-F7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7X-0004E4-Gl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7K-0002bn-JH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY6C-0006mY-2k
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:21 +0100
Message-Id: <20181019165735.22511-32-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/45] target/arm: Use gvec for NEON_2RM_VMN,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011205206.3552-11-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fc0173076a4..d29328774b6 100644
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
2.19.1
