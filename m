Received: from eggs.gnu.org ([2001:4830:134:3::10]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTn-0007y4-PI
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTm-0002dT-Tx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:11 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlTm-0002d1-OD
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:10 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 01:01:59 +0200
Message-Id: <20170516230159.4195-5-aurelien@aurel32.net>
In-Reply-To: <20170516230159.4195-1-aurelien@aurel32.net>
References: <20170516230159.4195-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 4/4] target/mips: optimize WSBH, DSBH and DSHD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

Use the same mask to avoid having to load two different constants, as
suggested by Richard Henderson.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/translate.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3022f349cb..c71eed498c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4572,12 +4572,14 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
     case OPC_WSBH:
         {
             TCGv t1 = tcg_temp_new();
+            TCGv t2 = tcg_const_tl(0x00FF00FF);
 
             tcg_gen_shri_tl(t1, t0, 8);
-            tcg_gen_andi_tl(t1, t1, 0x00FF00FF);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_gen_and_tl(t0, t0, t2);
             tcg_gen_shli_tl(t0, t0, 8);
-            tcg_gen_andi_tl(t0, t0, ~0x00FF00FF);
             tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t2);
             tcg_temp_free(t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
         }
@@ -4592,27 +4594,31 @@ static void gen_bshfl (DisasContext *ctx, uint32_t op2, int rt, int rd)
     case OPC_DSBH:
         {
             TCGv t1 = tcg_temp_new();
+            TCGv t2 = tcg_const_tl(0x00FF00FF00FF00FFULL);
 
             tcg_gen_shri_tl(t1, t0, 8);
-            tcg_gen_andi_tl(t1, t1, 0x00FF00FF00FF00FFULL);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_gen_and_tl(t0, t0, t2);
             tcg_gen_shli_tl(t0, t0, 8);
-            tcg_gen_andi_tl(t0, t0, ~0x00FF00FF00FF00FFULL);
             tcg_gen_or_tl(cpu_gpr[rd], t0, t1);
+            tcg_temp_free(t2);
             tcg_temp_free(t1);
         }
         break;
     case OPC_DSHD:
         {
             TCGv t1 = tcg_temp_new();
+            TCGv t2 = tcg_const_tl(0x0000FFFF0000FFFFULL);
 
             tcg_gen_shri_tl(t1, t0, 16);
-            tcg_gen_andi_tl(t1, t1, 0x0000FFFF0000FFFFULL);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_gen_and_tl(t0, t0, t2);
             tcg_gen_shli_tl(t0, t0, 16);
-            tcg_gen_andi_tl(t0, t0, ~0x0000FFFF0000FFFFULL);
             tcg_gen_or_tl(t0, t0, t1);
             tcg_gen_shri_tl(t1, t0, 32);
             tcg_gen_shli_tl(t0, t0, 32);
             tcg_gen_or_tl(cpu_gpr[rd], t0, t1);
+            tcg_temp_free(t2);
             tcg_temp_free(t1);
         }
         break;
-- 
2.11.0
