Received: from eggs.gnu.org ([2001:4830:134:3::10]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYO-0004lz-Fq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYN-0004Lj-NK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:12 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYN-0004L8-Iq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:11 -0400
Received: by mail-qt0-x241.google.com with SMTP id p25so116829qtp.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:56:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:36 -0300
Message-Id: <20170718045540.16322-7-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 06/10] target/sparc: optimize various
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

Done with the Coccinelle semantic patch from commit 58daf05d07dd
(see scripts/coccinelle/tcg_gen_extract.cocci)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
Richard: maybe you need to update 58daf05d07dd to your commit...

 target/sparc/translate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index aa6734d54e..962ce08f80 100644
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
-- 
2.13.2
