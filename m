Received: from eggs.gnu.org ([2001:4830:134:3::10]:36103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyV-0007DN-Er
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyS-0006e2-6e
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:35 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:50390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbyR-0006ZJ-TL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:32 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:07 +0100
Message-ID: <20180620120620.12806-23-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 22/35] target/mips: Fix data type for offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

Offset can be larger than 16 bit from nanoMIPS,
and immediate field can be larger than 16 bits as well.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9e29dd7..8c20ba3 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2114,7 +2114,7 @@ OP_ST_ATOMIC(scd,st64,ld64,0x7);
 #undef OP_ST_ATOMIC
 
 static void gen_base_offset_addr (DisasContext *ctx, TCGv addr,
-                                  int base, int16_t offset)
+                                  int base, int offset)
 {
     if (base == 0) {
         tcg_gen_movi_tl(addr, offset);
@@ -2142,7 +2142,7 @@ static target_ulong pc_relative_pc (DisasContext *ctx)
 
 /* Load */
 static void gen_ld(DisasContext *ctx, uint32_t opc,
-                   int rt, int base, int16_t offset)
+                   int rt, int base, int offset)
 {
     TCGv t0, t1, t2;
     int mem_idx = ctx->mem_idx;
@@ -2377,7 +2377,7 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
 
 /* Store */
 static void gen_st (DisasContext *ctx, uint32_t opc, int rt,
-                    int base, int16_t offset)
+                    int base, int offset)
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
@@ -2602,7 +2602,7 @@ static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
 
 /* Arithmetic with immediate operand */
 static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
-                          int rt, int rs, int16_t imm)
+                          int rt, int rs, int imm)
 {
     target_ulong uimm = (target_long)imm; /* Sign extend to 32/64 bits */
 
-- 
1.9.1
