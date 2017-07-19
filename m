Received: from eggs.gnu.org ([2001:4830:134:3::10]:33243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVb-0008BG-Kr
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVa-0006hx-MU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:59 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXyVa-0006h9-IF
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:35:58 -0400
Received: by mail-qt0-x243.google.com with SMTP id 50so1792805qtz.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:35:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Jul 2017 13:34:48 -1000
Message-Id: <20170719233455.8740-8-rth@twiddle.net>
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 07/14] target/arm: optimize aarch32 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

Use the same mask to avoid having to load two different constants, as
suggested by Richard Henderson.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170516230159.4195-2-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e27736ce5b..d3003ae0d8 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -343,11 +343,13 @@ static void gen_smul_dual(TCGv_i32 a, TCGv_i32 b)
 static void gen_rev16(TCGv_i32 var)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 mask = tcg_const_i32(0x00ff00ff);
     tcg_gen_shri_i32(tmp, var, 8);
-    tcg_gen_andi_i32(tmp, tmp, 0x00ff00ff);
+    tcg_gen_and_i32(tmp, tmp, mask);
+    tcg_gen_and_i32(var, var, mask);
     tcg_gen_shli_i32(var, var, 8);
-    tcg_gen_andi_i32(var, var, 0xff00ff00);
     tcg_gen_or_i32(var, var, tmp);
+    tcg_temp_free_i32(mask);
     tcg_temp_free_i32(tmp);
 }
 
-- 
2.13.3
