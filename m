Received: from eggs.gnu.org ([2001:4830:134:3::10]:45843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX4-0007YI-Rg
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5JX3-0004G6-AS
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:02 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5JX3-0004Bf-3c
	for qemu-devel@nongnu.org; Mon, 01 May 2017 18:11:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  2 May 2017 00:10:42 +0200
Message-Id: <20170501221046.9369-11-aurelien@aurel32.net>
In-Reply-To: <20170501221046.9369-1-aurelien@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 10/14] target/sh4: optimize gen_write_sr using
 extract op
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

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 23636eeb4c..7de459c9a5 100644
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
