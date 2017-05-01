Received: from eggs.gnu.org ([2001:4830:134:3::10]:45797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX4-0007YD-1d
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX3-0004FW-3R
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX2-0004BM-Ua
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:41 +0200
Message-Id: <20170501221046.9369-10-aurelien@aurel32.net>
In-Reply-To: <20170501221046.9369-1-aurelien@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 09/14] target/sh4: optimize gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Isuing extrh and avoiding intermediate temps.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a8399239d1..23636eeb4c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -305,13 +305,8 @@ static inline void gen_load_fpr64(TCGv_i64 t, int reg)
 
 static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_extrl_i64_i32(tmp, t);
-    tcg_gen_mov_i32(cpu_fregs[reg + 1], tmp);
-    tcg_gen_shri_i64(t, t, 32);
-    tcg_gen_extrl_i64_i32(tmp, t);
-    tcg_gen_mov_i32(cpu_fregs[reg], tmp);
-    tcg_temp_free_i32(tmp);
+    tcg_gen_extrl_i64_i32(cpu_fregs[reg + 1], t);
+    tcg_gen_extrh_i64_i32(cpu_fregs[reg], t);
 }
 
 #define B3_0 (ctx->opcode & 0xf)
-- 
2.11.0
