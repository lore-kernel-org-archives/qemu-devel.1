Received: from eggs.gnu.org ([209.51.188.92]:47020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQK-0003OO-7M
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQJ-0001I6-6r
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQJ-0001H3-0O
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:39 -0500
Received: by mail-wr1-x443.google.com with SMTP id i8so1291180wrm.0
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:28 +0100
Message-Id: <20190310003428.11723-7-f4bug@amsat.org>
In-Reply-To: <20190310003428.11723-1-f4bug@amsat.org>
References: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/6] target/m68k: Reduce the scope of the
 'zero' tcg_temp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Reduce the scope of the 'zero' tcg_temp. Since this tcg_temp is
allocated with tcg_const_i32(), free it using tcg_temp_free_i32().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index b51b8a2a12..3f27079379 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3664,7 +3664,7 @@ static void rotate_x_flags(TCGv reg, TCGv X, int size)
 /* Result of rotate_x() is valid if 0 <= shift <= size */
 static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
 {
-    TCGv X, shl, shr, shx, sz, zero;
+    TCGv X, shl, shr, shx, sz;
 
     sz = tcg_const_i32(size);
 
@@ -3672,14 +3672,14 @@ static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
     shl = tcg_temp_new();
     shx = tcg_temp_new();
     if (left) {
+        TCGv zero = tcg_const_i32(0);
         tcg_gen_mov_i32(shl, shift);      /* shl = shift */
         tcg_gen_movi_i32(shr, size + 1);
         tcg_gen_sub_i32(shr, shr, shift); /* shr = size + 1 - shift */
         tcg_gen_subi_i32(shx, shift, 1);  /* shx = shift - 1 */
         /* shx = shx < 0 ? size : shx; */
-        zero = tcg_const_i32(0);
         tcg_gen_movcond_i32(TCG_COND_LT, shx, shx, zero, sz, shx);
-        tcg_temp_free(zero);
+        tcg_temp_free_i32(zero);
     } else {
         tcg_gen_mov_i32(shr, shift);      /* shr = shift */
         tcg_gen_movi_i32(shl, size + 1);
-- 
2.19.1
