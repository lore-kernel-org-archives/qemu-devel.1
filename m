Received: from eggs.gnu.org ([2001:4830:134:3::10]:45629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO90-00059D-L0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8w-0001cr-2f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:46 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8v-0001cc-V6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:42 -0500
Received: by mail-qk0-x242.google.com with SMTP id u25so16699117qki.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:41 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:31 +1100
Message-Id: <20170213212536.31871-20-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 19/24] target/openrisc: Implement muld, muldu,
 macu, msbu
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

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 82b8bec..ce9672e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -362,6 +362,56 @@ static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     gen_ove_cy(dc);
 }
 
+static void gen_muld(DisasContext *dc, TCGv srca, TCGv srcb)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_ext_tl_i64(t1, srca);
+    tcg_gen_ext_tl_i64(t2, srcb);
+    if (TARGET_LONG_BITS == 32) {
+        tcg_gen_mul_i64(cpu_mac, t1, t2);
+        tcg_gen_movi_tl(cpu_sr_ov, 0);
+    } else {
+        TCGv_i64 high = tcg_temp_new_i64();
+
+        tcg_gen_muls2_i64(cpu_mac, high, t1, t2);
+        tcg_gen_sari_i64(t1, cpu_mac, 63);
+        tcg_gen_setcond_i64(TCG_COND_NE, t1, t1, high);
+        tcg_temp_free_i64(high);
+        tcg_gen_trunc_i64_tl(cpu_sr_ov, t1);
+        tcg_gen_neg_tl(cpu_sr_ov, cpu_sr_ov);
+
+        gen_ove_ov(dc);
+    }
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
+static void gen_muldu(DisasContext *dc, TCGv srca, TCGv srcb)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_extu_tl_i64(t1, srca);
+    tcg_gen_extu_tl_i64(t2, srcb);
+    if (TARGET_LONG_BITS == 32) {
+        tcg_gen_mul_i64(cpu_mac, t1, t2);
+        tcg_gen_movi_tl(cpu_sr_cy, 0);
+    } else {
+        TCGv_i64 high = tcg_temp_new_i64();
+
+        tcg_gen_mulu2_i64(cpu_mac, high, t1, t2);
+        tcg_gen_setcondi_i64(TCG_COND_NE, high, high, 0);
+        tcg_gen_trunc_i64_tl(cpu_sr_cy, high);
+        tcg_temp_free_i64(high);
+
+        gen_ove_cy(dc);
+    }
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
 static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
@@ -388,6 +438,25 @@ static void gen_mac(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_ov(dc);
 }
 
+static void gen_macu(DisasContext *dc, TCGv srca, TCGv srcb)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_extu_tl_i64(t1, srca);
+    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_mul_i64(t1, t1, t2);
+    tcg_temp_free_i64(t2);
+
+    /* Note that overflow is only computed during addition stage.  */
+    tcg_gen_add_i64(cpu_mac, cpu_mac, t1);
+    tcg_gen_setcond_i64(TCG_COND_LTU, t1, cpu_mac, t1);
+    tcg_gen_trunc_i64_tl(cpu_sr_cy, t1);
+    tcg_temp_free_i64(t1);
+
+    gen_ove_cy(dc);
+}
+
 static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
@@ -414,6 +483,25 @@ static void gen_msb(DisasContext *dc, TCGv srca, TCGv srcb)
     gen_ove_ov(dc);
 }
 
+static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
+{
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    tcg_gen_extu_tl_i64(t1, srca);
+    tcg_gen_extu_tl_i64(t2, srcb);
+    tcg_gen_mul_i64(t1, t1, t2);
+
+    /* Note that overflow is only computed during subtraction stage.  */
+    tcg_gen_setcond_i64(TCG_COND_LTU, t2, cpu_mac, t1);
+    tcg_gen_sub_i64(cpu_mac, cpu_mac, t1);
+    tcg_gen_trunc_i64_tl(cpu_sr_cy, t2);
+    tcg_temp_free_i64(t2);
+    tcg_temp_free_i64(t1);
+
+    gen_ove_cy(dc);
+}
+
 static void gen_lwa(DisasContext *dc, TCGv rd, TCGv ra, int32_t ofs)
 {
     TCGv ea = tcg_temp_new();
@@ -590,6 +678,11 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
             gen_mul(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             return;
 
+        case 0x7: /* l.muld */
+            LOG_DIS("l.muld r%d, r%d\n", ra, rb);
+            gen_muld(dc, cpu_R[ra], cpu_R[rb]);
+            break;
+
         case 0x9: /* l.div */
             LOG_DIS("l.div r%d, r%d, r%d\n", rd, ra, rb);
             gen_div(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
@@ -604,6 +697,11 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
             LOG_DIS("l.mulu r%d, r%d, r%d\n", rd, ra, rb);
             gen_mulu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
             return;
+
+        case 0xc: /* l.muldu */
+            LOG_DIS("l.muldu r%d, r%d\n", ra, rb);
+            gen_muldu(dc, cpu_R[ra], cpu_R[rb]);
+            return;
         }
         break;
     }
@@ -916,6 +1014,16 @@ static void dec_mac(DisasContext *dc, uint32_t insn)
         gen_msb(dc, cpu_R[ra], cpu_R[rb]);
         break;
 
+    case 0x0003:    /* l.macu */
+        LOG_DIS("l.macu r%d, r%d\n", ra, rb);
+        gen_macu(dc, cpu_R[ra], cpu_R[rb]);
+        break;
+
+    case 0x0004:    /* l.msbu */
+        LOG_DIS("l.msbu r%d, r%d\n", ra, rb);
+        gen_msbu(dc, cpu_R[ra], cpu_R[rb]);
+        break;
+
     default:
         gen_illegal_exception(dc);
         break;
-- 
2.9.3
