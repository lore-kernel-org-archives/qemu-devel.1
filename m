Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiD-00080O-5L
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSqiC-00073H-7z
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:37 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSqiC-0006zg-07
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 16:52:36 -0500
Received: by mail-pg1-x542.google.com with SMTP id t13so3036117pgr.11
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 13:52:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 13:52:14 -0800
Message-Id: <20181130215221.20554-10-richard.henderson@linaro.org>
In-Reply-To: <20181130215221.20554-1-richard.henderson@linaro.org>
References: <20181130215221.20554-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/16] tcg/sparc: Remove retranslation code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

There is no longer a need for preserving branch offset operands,
as we no longer re-translate.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc/tcg-target.inc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 04bdc3df5e..671a04c54b 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -639,13 +639,11 @@ static void tcg_out_bpcc0(TCGContext *s, int scond, int flags, int off19)
 
 static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
 {
-    int off19;
+    int off19 = 0;
 
     if (l->has_value) {
         off19 = INSN_OFF19(tcg_pcrel_diff(s, l->u.value_ptr));
     } else {
-        /* Make sure to preserve destinations during retranslation.  */
-        off19 = *s->code_ptr & INSN_OFF19(-1);
         tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP19, l, 0);
     }
     tcg_out_bpcc0(s, scond, flags, off19);
@@ -685,13 +683,11 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
 {
     /* For 64-bit signed comparisons vs zero, we can avoid the compare.  */
     if (arg2 == 0 && !is_unsigned_cond(cond)) {
-        int off16;
+        int off16 = 0;
 
         if (l->has_value) {
             off16 = INSN_OFF16(tcg_pcrel_diff(s, l->u.value_ptr));
         } else {
-            /* Make sure to preserve destinations during retranslation.  */
-            off16 = *s->code_ptr & INSN_OFF16(-1);
             tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP16, l, 0);
         }
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
-- 
2.17.2
