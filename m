Received: from eggs.gnu.org ([2001:4830:134:3::10]:41375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGRKq-0000uD-MK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGRKo-0006wB-Er
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:56 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:44949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGRKo-0006um-9Z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:48:54 -0400
Received: by mail-pg0-x244.google.com with SMTP id x145-v6so2592092pgx.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 08:48:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 May 2018 08:48:48 -0700
Message-Id: <20180509154849.27979-2-richard.henderson@linaro.org>
In-Reply-To: <20180509154849.27979-1-richard.henderson@linaro.org>
References: <20180509154849.27979-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/2] tcg/i386: Fix dup_vec in non-AVX2 codepath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, qemu-stable@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The VPUNPCKLD* instructions are all "non-destructive source",
indicated by "NDS" in the encoding string in the x86 ISA manual.
This means that they take two source operands, one of which is
encoded in the VEX.vvvv field. We were incorrectly treating them
as if they were destructive-source and passing 0 as the 'v'
argument of tcg_out_vex_modrm(). This meant we were always
using %xmm0 as one of the source operands, causing incorrect
results if the register allocator happened to want to use
something else. For instance the input AArch64 insn:
 DUP v26.16b, w21
which becomes TCG IR ops:
 dup_vec v128,e8,tmp2,x21
 st_vec v128,e8,tmp2,env,$0xa40
was assembled to:
0x607c568c:  c4 c1 7a 7e 86 e8 00 00  vmovq    0xe8(%r14), %xmm0
0x607c5694:  00
0x607c5695:  c5 f9 60 c8              vpunpcklbw %xmm0, %xmm0, %xmm1
0x607c5699:  c5 f9 61 c9              vpunpcklwd %xmm1, %xmm0, %xmm1
0x607c569d:  c5 f9 70 c9 00           vpshufd  $0, %xmm1, %xmm1
0x607c56a2:  c4 c1 7a 7f 8e 40 0a 00  vmovdqu  %xmm1, 0xa40(%r14)
0x607c56aa:  00

when the vpunpcklwd insn should be "%xmm1, %xmm1, %xmm1".
This resulted in our incorrectly setting the output vector to
q26=0000320000003200:0000320000003200
when given an input of x21 == 0000000002803200
rather than the expected all-zeroes.

Pass the correct source register number to tcg_out_vex_modrm()
for these insns.

Fixes: 770c2fc7bb70804a
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180504153431.5169-1-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index d7e59e79c5..5357909fff 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -854,11 +854,11 @@ static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
         switch (vece) {
         case MO_8:
             /* ??? With zero in a register, use PSHUFB.  */
-            tcg_out_vex_modrm(s, OPC_PUNPCKLBW, r, 0, a);
+            tcg_out_vex_modrm(s, OPC_PUNPCKLBW, r, a, a);
             a = r;
             /* FALLTHRU */
         case MO_16:
-            tcg_out_vex_modrm(s, OPC_PUNPCKLWD, r, 0, a);
+            tcg_out_vex_modrm(s, OPC_PUNPCKLWD, r, a, a);
             a = r;
             /* FALLTHRU */
         case MO_32:
@@ -867,7 +867,7 @@ static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
             tcg_out8(s, 0);
             break;
         case MO_64:
-            tcg_out_vex_modrm(s, OPC_PUNPCKLQDQ, r, 0, a);
+            tcg_out_vex_modrm(s, OPC_PUNPCKLQDQ, r, a, a);
             break;
         default:
             g_assert_not_reached();
-- 
2.17.0
