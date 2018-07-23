Received: from eggs.gnu.org ([2001:4830:134:3::10]:42675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKB-0003Q0-QU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhK8-00052K-JM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:55 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:13 -0500
Message-Id: <20180723201748.25573-65-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 64/99] tcg/i386: Fix dup_vec in non-AVX2
 codepath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

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
(cherry picked from commit 7eb30ef0ba2eb59e7430d4848ae8d4bf4e50f768)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1
