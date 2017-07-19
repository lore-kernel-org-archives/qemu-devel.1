Received: from eggs.gnu.org ([2001:4830:134:3::10]:41645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3l-0003du-6J
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3k-0002Dt-B1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:05 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3k-0002Dh-6M
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:04 -0400
Received: by mail-pg0-x241.google.com with SMTP id v190so5448062pgv.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:58:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:18 -1000
Message-Id: <20170719045722.25492-11-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/14] target/sparc: optimize various functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Done with the Coccinelle semantic patch
scripts/coccinelle/tcg_gen_extract.cocci.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/translate.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d..67a83b7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -380,29 +380,25 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num,
 static inline void gen_mov_reg_N(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_shri_tl(reg, reg, PSR_NEG_SHIFT);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, reg, PSR_NEG_SHIFT, 1);
 }
 
 static inline void gen_mov_reg_Z(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_shri_tl(reg, reg, PSR_ZERO_SHIFT);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, reg, PSR_ZERO_SHIFT, 1);
 }
 
 static inline void gen_mov_reg_V(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_shri_tl(reg, reg, PSR_OVF_SHIFT);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, reg, PSR_OVF_SHIFT, 1);
 }
 
 static inline void gen_mov_reg_C(TCGv reg, TCGv_i32 src)
 {
     tcg_gen_extu_i32_tl(reg, src);
-    tcg_gen_shri_tl(reg, reg, PSR_CARRY_SHIFT);
-    tcg_gen_andi_tl(reg, reg, 0x1);
+    tcg_gen_extract_tl(reg, reg, PSR_CARRY_SHIFT, 1);
 }
 
 static inline void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
@@ -638,8 +634,7 @@ static inline void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
     // env->y = (b2 << 31) | (env->y >> 1);
     tcg_gen_andi_tl(r_temp, cpu_cc_src, 0x1);
     tcg_gen_shli_tl(r_temp, r_temp, 31);
-    tcg_gen_shri_tl(t0, cpu_y, 1);
-    tcg_gen_andi_tl(t0, t0, 0x7fffffff);
+    tcg_gen_extract_tl(t0, cpu_y, 1, 31);
     tcg_gen_or_tl(t0, t0, r_temp);
     tcg_gen_andi_tl(cpu_y, t0, 0xffffffff);
 
-- 
2.9.4
