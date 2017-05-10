Received: from eggs.gnu.org ([2001:4830:134:3::10]:33032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsC-0008Av-QR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8Xs9-0006Po-AR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 17:05:29 -0300
Message-Id: <20170510200535.13268-3-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-1-f4bug@amsat.org>
References: <20170510200535.13268-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/8] target/arm: optimize smul_dual() and
 neon_trn_u8() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Applied using Coccinelle script.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0b5a0bca06..3230efe1be 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -339,8 +339,7 @@ static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
 static void gen_rev16(TCGv_i32 var)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i32(tmp, var, 8);
-    tcg_gen_andi_i32(tmp, tmp, 0x00ff00ff);
+    tcg_gen_extract_i32(tmp, var, 8, 0x00ff00ff);
     tcg_gen_shli_i32(var, var, 8);
     tcg_gen_andi_i32(var, var, 0xff00ff00);
     tcg_gen_or_i32(var, var, tmp);
@@ -4700,8 +4699,7 @@ static void gen_neon_trn_u8(TCGv_i32 t0, TCGv_i32 t1)
     tcg_gen_andi_i32(tmp, t1, 0x00ff00ff);
     tcg_gen_or_i32(rd, rd, tmp);
 
-    tcg_gen_shri_i32(t1, t1, 8);
-    tcg_gen_andi_i32(t1, t1, 0x00ff00ff);
+    tcg_gen_extract_i32(t1, t1, 8, 0x00ff00ff);
     tcg_gen_andi_i32(tmp, t0, 0xff00ff00);
     tcg_gen_or_i32(t1, t1, tmp);
     tcg_gen_mov_i32(t0, rd);
-- 
2.11.0
