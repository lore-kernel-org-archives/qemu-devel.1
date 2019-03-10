Received: from eggs.gnu.org ([209.51.188.92]:46975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQF-0003LS-I5
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQE-0001Be-SH
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQE-0001AW-LI
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id i16so1245644wrs.13
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:24 +0100
Message-Id: <20190310003428.11723-3-f4bug@amsat.org>
In-Reply-To: <20190310003428.11723-1-f4bug@amsat.org>
References: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/6] target/m68k: Optimize the partset
 instruction using deposit_i32()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ab801b6ceb..55766fd7ef 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -720,17 +720,15 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
     TCGv tmp;
     switch (opsize) {
     case OS_BYTE:
-        tcg_gen_andi_i32(reg, reg, 0xffffff00);
         tmp = tcg_temp_new();
         tcg_gen_ext8u_i32(tmp, val);
-        tcg_gen_or_i32(reg, reg, tmp);
+        tcg_gen_deposit_i32(reg, tmp, reg, 8, 24);
         tcg_temp_free(tmp);
         break;
     case OS_WORD:
-        tcg_gen_andi_i32(reg, reg, 0xffff0000);
         tmp = tcg_temp_new();
         tcg_gen_ext16u_i32(tmp, val);
-        tcg_gen_or_i32(reg, reg, tmp);
+        tcg_gen_deposit_i32(reg, tmp, reg, 16, 16);
         tcg_temp_free(tmp);
         break;
     case OS_LONG:
-- 
2.19.1
