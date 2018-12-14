Received: from eggs.gnu.org ([2001:4830:134:3::10]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0n-0005uu-QU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe0m-0006cq-QA
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:37 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe0m-0006ai-JE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:36 -0500
Received: by mail-ot1-x334.google.com with SMTP id u16so4105186otk.8
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:18:59 -0600
Message-Id: <20181214031923.29527-10-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/32] tcg/s390: Remove retranslation code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

There is no longer a need for preserving branch offset operands,
as we no longer re-translate.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390/tcg-target.inc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 17c435ade5..96c344142e 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1329,13 +1329,11 @@ static void tgen_branch(TCGContext *s, int cc, TCGLabel *l)
 static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
                                 TCGReg r1, TCGReg r2, TCGLabel *l)
 {
-    intptr_t off;
+    intptr_t off = 0;
 
     if (l->has_value) {
         off = l->u.value_ptr - s->code_ptr;
     } else {
-        /* We need to keep the offset unchanged for retranslation.  */
-        off = s->code_ptr[1];
         tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     }
 
@@ -1347,13 +1345,11 @@ static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
 static void tgen_compare_imm_branch(TCGContext *s, S390Opcode opc, int cc,
                                     TCGReg r1, int i2, TCGLabel *l)
 {
-    tcg_target_long off;
+    tcg_target_long off = 0;
 
     if (l->has_value) {
         off = l->u.value_ptr - s->code_ptr;
     } else {
-        /* We need to keep the offset unchanged for retranslation.  */
-        off = s->code_ptr[1];
         tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     }
 
@@ -1696,7 +1692,6 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
 
     base_reg = tcg_out_tlb_read(s, addr_reg, opc, mem_index, 1);
 
-    /* We need to keep the offset unchanged for retranslation.  */
     tcg_out16(s, RI_BRC | (S390_CC_NE << 4));
     label_ptr = s->code_ptr;
     s->code_ptr += 1;
@@ -1724,7 +1719,6 @@ static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_reg,
 
     base_reg = tcg_out_tlb_read(s, addr_reg, opc, mem_index, 0);
 
-    /* We need to keep the offset unchanged for retranslation.  */
     tcg_out16(s, RI_BRC | (S390_CC_NE << 4));
     label_ptr = s->code_ptr;
     s->code_ptr += 1;
-- 
2.17.2
