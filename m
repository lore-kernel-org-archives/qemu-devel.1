Received: from eggs.gnu.org ([2001:4830:134:3::10]:37141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQC-0005B0-E7
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001Lp-Pq
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001HI-HR
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:42 +0200
Message-Id: <20170513093248.18230-10-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/15] target/sh4: optimize gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Using extr and avoiding intermediate temps.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a4c7a0895b..fe8bff54a6 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -305,13 +305,7 @@ static inline void gen_load_fpr64(TCGv_i64 t, int reg)
 
 static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_extrl_i64_i32(tmp, t);
-    tcg_gen_mov_i32(cpu_fregs[reg + 1], tmp);
-    tcg_gen_shri_i64(t, t, 32);
-    tcg_gen_extrl_i64_i32(tmp, t);
-    tcg_gen_mov_i32(cpu_fregs[reg], tmp);
-    tcg_temp_free_i32(tmp);
+    tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);
 }
 
 #define B3_0 (ctx->opcode & 0xf)
-- 
2.11.0
