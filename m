Received: from eggs.gnu.org ([2001:4830:134:3::10]:35126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJz-0003Eu-Lh
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJy-0000Hc-Cf
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:47 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8WJy-0000GN-6g
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:46 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 May 2017 20:26:31 +0200
Message-Id: <20170510182636.17791-11-aurelien@aurel32.net>
In-Reply-To: <20170510182636.17791-1-aurelien@aurel32.net>
References: <20170510182636.17791-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/15] target/sh4: optimize gen_write_sr
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
Cc: Aurelien Jarno <aurelien@aurel32.net>

This doesn't change the generated code on x86, but optimizes it on most
RISC architectures and makes the code simpler to read.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index fe8bff54a6..7a504a7f5a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -204,12 +204,9 @@ static void gen_write_sr(TCGv src)
 {
     tcg_gen_andi_i32(cpu_sr, src,
                      ~((1u << SR_Q) | (1u << SR_M) | (1u << SR_T)));
-    tcg_gen_shri_i32(cpu_sr_q, src, SR_Q);
-    tcg_gen_andi_i32(cpu_sr_q, cpu_sr_q, 1);
-    tcg_gen_shri_i32(cpu_sr_m, src, SR_M);
-    tcg_gen_andi_i32(cpu_sr_m, cpu_sr_m, 1);
-    tcg_gen_shri_i32(cpu_sr_t, src, SR_T);
-    tcg_gen_andi_i32(cpu_sr_t, cpu_sr_t, 1);
+    tcg_gen_extract_i32(cpu_sr_q, src, SR_Q, 1);
+    tcg_gen_extract_i32(cpu_sr_m, src, SR_M, 1);
+    tcg_gen_extract_i32(cpu_sr_t, src, SR_T, 1);
 }
 
 static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
-- 
2.11.0
