Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsL-0008Ic-FD
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsI-0006W2-8M
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsI-0006Vr-4H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:18 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so271160qtb.2
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:06:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 17:05:33 -0300
Message-Id: <20170510200535.13268-7-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-1-f4bug@amsat.org>
References: <20170510200535.13268-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/8] target/mips: optimize bshfl() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Applied using Coccinelle script.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3022f349cb..96177da9ae 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4573,8 +4573,7 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
         {
             TCGv t1 = tcg_temp_new();
 
-            tcg_gen_shri_tl(t1, t0, 8);
-            tcg_gen_andi_tl(t1, t1, 0x00FF00FF);
+            tcg_gen_extract_tl(t1, t0, 8, 0x00FF00FF);
             tcg_gen_shli_tl(t0, t0, 8);
             tcg_gen_andi_tl(t0, t0, ~0x00FF00FF);
             tcg_gen_or_tl(t0, t0, t1);
@@ -4593,8 +4592,7 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
         {
             TCGv t1 = tcg_temp_new();
 
-            tcg_gen_shri_tl(t1, t0, 8);
-            tcg_gen_andi_tl(t1, t1, 0x00FF00FF00FF00FFULL);
+            tcg_gen_extract_tl(t1, t0, 8, 0x00FF00FF00FF00FFULL);
             tcg_gen_shli_tl(t0, t0, 8);
             tcg_gen_andi_tl(t0, t0, ~0x00FF00FF00FF00FFULL);
             tcg_gen_or_tl(cpu_gpr[rd], t0, t1);
@@ -4605,8 +4603,7 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
         {
             TCGv t1 = tcg_temp_new();
 
-            tcg_gen_shri_tl(t1, t0, 16);
-            tcg_gen_andi_tl(t1, t1, 0x0000FFFF0000FFFFULL);
+            tcg_gen_extract_tl(t1, t0, 16, 0x0000FFFF0000FFFFULL);
             tcg_gen_shli_tl(t0, t0, 16);
             tcg_gen_andi_tl(t0, t0, ~0x0000FFFF0000FFFFULL);
             tcg_gen_or_tl(t0, t0, t1);
-- 
2.11.0
