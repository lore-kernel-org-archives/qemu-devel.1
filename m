Received: from eggs.gnu.org ([2001:4830:134:3::10]:57300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45a-0007HN-D7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-00046m-9N
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:50 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eR45Z-0003uN-3e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:49 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:25 +0100
Message-Id: <20171218224030.26726-2-aurelien@aurel32.net>
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/6] target/sh4: add missing tcg_temp_free() in
 _decode_opc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

missed in c55497ecb8c and 852d481faf7.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20171205170013.22337-3-f4bug@amsat.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 8569179883..f56808b45d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -601,6 +601,7 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx, MO_TEUL);
 	    tcg_gen_mov_i32(REG(B11_8), addr);
+        tcg_temp_free(addr);
 	}
 	return;
     case 0x6004:		/* mov.b @Rm+,Rn */
@@ -1524,6 +1525,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_qemu_ld_i32(val, REG(B11_8), ctx->memidx, MO_TEUL);
             gen_helper_movcal(cpu_env, REG(B11_8), val);
             tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+            tcg_temp_free(val);
         }
         ctx->has_movcal = 1;
 	return;
-- 
2.15.1
