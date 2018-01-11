Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd49-0007aX-Bf
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd48-0000Gl-IZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd48-0000Dl-Bl
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd47-0005lg-3w
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:43 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:20 +0000
Message-Id: <1515677902-23436-25-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/26] target/arm: Make disas_thumb2_insn()
 generate its own UNDEF exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Refactor disas_thumb2_insn() so that it generates the code for raising
an UNDEF exception for invalid insns, rather than returning a flag
which the caller must check to see if it needs to generate the UNDEF
code. This brings the function in to line with the behaviour of
disas_thumb_insn() and disas_arm_insn().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1513080506-17703-1-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c690658..781be1e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9775,9 +9775,8 @@ gen_thumb2_data_op(DisasContext *s, int op, int conds, uint32_t shifter_out,
     return 0;
 }
 
-/* Translate a 32-bit thumb instruction.  Returns nonzero if the instruction
-   is not legal.  */
-static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
+/* Translate a 32-bit thumb instruction. */
+static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t imm, shift, offset;
     uint32_t rd, rn, rm, rs;
@@ -11016,16 +11015,16 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     /* UNPREDICTABLE, unallocated hint or
                      * PLD/PLDW/PLI (literal)
                      */
-                    return 0;
+                    return;
                 }
                 if (op1 & 1) {
-                    return 0; /* PLD/PLDW/PLI or unallocated hint */
+                    return; /* PLD/PLDW/PLI or unallocated hint */
                 }
                 if ((op2 == 0) || ((op2 & 0x3c) == 0x30)) {
-                    return 0; /* PLD/PLDW/PLI or unallocated hint */
+                    return; /* PLD/PLDW/PLI or unallocated hint */
                 }
                 /* UNDEF space, or an UNPREDICTABLE */
-                return 1;
+                goto illegal_op;
             }
         }
         memidx = get_mem_index(s);
@@ -11151,9 +11150,10 @@ static int disas_thumb2_insn(DisasContext *s, uint32_t insn)
     default:
         goto illegal_op;
     }
-    return 0;
+    return;
 illegal_op:
-    return 1;
+    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+                       default_exception_el(s));
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
@@ -12275,10 +12275,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     if (is_16bit) {
         disas_thumb_insn(dc, insn);
     } else {
-        if (disas_thumb2_insn(dc, insn)) {
-            gen_exception_insn(dc, 4, EXCP_UDEF, syn_uncategorized(),
-                               default_exception_el(dc));
-        }
+        disas_thumb2_insn(dc, insn);
     }
 
     /* Advance the Thumb condexec condition.  */
-- 
2.7.4
