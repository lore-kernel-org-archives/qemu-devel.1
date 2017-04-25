Received: from eggs.gnu.org ([2001:4830:134:3::10]:59956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r0i-0004ks-9V
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r0g-0003xz-3f
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:19:28 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r0f-0003xf-T1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:19:26 -0400
Received: by mail-it0-x242.google.com with SMTP id c26so12192972itd.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:19:25 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BD9E8ECB-EB56-45A9-89A4-C1506319A7BD@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:19:21 -0400
Subject: [Qemu-devel] [PATCH 3/9] Add risu_reginfo_ppc.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Add the risu_reginfo_ppc.c file. It handles operations involving the  
reginfo
structure.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risu_reginfo_ppc.c | 273 +++++++++++++++++++++++++++++++++++++++++++ 
++++++++++
  1 file changed, 273 insertions(+)
  create mode 100644 risu_reginfo_ppc.c

diff --git a/risu_reginfo_ppc.c b/risu_reginfo_ppc.c
new file mode 100644
index 0000000..123e5fa
--- /dev/null
+++ b/risu_reginfo_ppc.c
@@ -0,0 +1,273 @@
+/***********************************************************
+ * File: risu_reginfo_ppc.c
+ * Description: PowerPC register validation code.
+ * Note: This file was made to work on Mac OS X.
+ * Date: 3-26-2017
+ ***********************************************************/
+
+#include <stdio.h>
+#include <math.h>
+#include <memory.h>
+
+#include "risu.h"
+#include "risu_reginfo_ppc.h"
+
+#define NUMBER_OF_GPR 32    /* Number of general purpose registers */
+#define NUMBER_OF_FPR 32    /* Number of floating point registers */
+#define DEBUG 0             /* Set to 1 for debug printing */
+#define debug_print(...) \
+            do { if (DEBUG) fprintf(stderr, __VA_ARGS__); } while (0)
+
+extern int verbose_mode;
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+{
+    debug_print("reginfo_init() called\n");
+
+    int i;
+
+    /* init the program counter (PC) */
+    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext->ss.srr0);
+
+    /* Tells use the instruction that ran before any problem was  
detected */
+    ri->previous_instruction = *((uint32_t *)(uc->uc_mcontext- 
 >ss.srr0 - 4));
+
+    /*
+     * Tells the second from faulting instruction that caused a  
problem. Needed
+     * because the cleanup instruction for the register that held a  
memory
+     * address is in the way.
+     */
+     ri->second_previous_instruction = *((uint32_t *)(uc- 
 >uc_mcontext->ss.srr0 - 8));
+
+    /* Displays each instruction and the previous instruction being  
tested */
+    if(verbose_mode) {
+        printf("testing instruction: 0x%08x 0x%08x\n", ri- 
 >previous_instruction
+              , ri->second_previous_instruction);
+    }
+
+    /* init the general purpose registers */
+    ri->gpr[0] = uc->uc_mcontext->ss.r0;
+    ri->gpr[1] = 0xdeadbeef;                /* stack pointer */
+    ri->gpr[2] = uc->uc_mcontext->ss.r2;
+    ri->gpr[3] = uc->uc_mcontext->ss.r3;
+    ri->gpr[4] = uc->uc_mcontext->ss.r4;
+    ri->gpr[5] = uc->uc_mcontext->ss.r5;
+    ri->gpr[6] = uc->uc_mcontext->ss.r6;
+    ri->gpr[7] = uc->uc_mcontext->ss.r7;
+    ri->gpr[8] = uc->uc_mcontext->ss.r8;
+    ri->gpr[9] = uc->uc_mcontext->ss.r9;
+    ri->gpr[10] = uc->uc_mcontext->ss.r10;
+    ri->gpr[11] = uc->uc_mcontext->ss.r11;
+    ri->gpr[12] = uc->uc_mcontext->ss.r12;
+    ri->gpr[13] = uc->uc_mcontext->ss.r13;
+    ri->gpr[14] = uc->uc_mcontext->ss.r14;
+    ri->gpr[15] = uc->uc_mcontext->ss.r15;
+    ri->gpr[16] = uc->uc_mcontext->ss.r16;
+    ri->gpr[17] = uc->uc_mcontext->ss.r17;
+    ri->gpr[18] = uc->uc_mcontext->ss.r18;
+    ri->gpr[19] = uc->uc_mcontext->ss.r19;
+    ri->gpr[20] = uc->uc_mcontext->ss.r20;
+    ri->gpr[21] = uc->uc_mcontext->ss.r21;
+    ri->gpr[22] = uc->uc_mcontext->ss.r22;
+    ri->gpr[23] = uc->uc_mcontext->ss.r23;
+    ri->gpr[24] = uc->uc_mcontext->ss.r24;
+    ri->gpr[25] = uc->uc_mcontext->ss.r25;
+    ri->gpr[26] = uc->uc_mcontext->ss.r26;
+    ri->gpr[27] = uc->uc_mcontext->ss.r27;
+    ri->gpr[28] = uc->uc_mcontext->ss.r28;
+    ri->gpr[29] = uc->uc_mcontext->ss.r29;
+    ri->gpr[30] = uc->uc_mcontext->ss.r30;
+    ri->gpr[31] = uc->uc_mcontext->ss.r31;
+
+    /* init the floating-point registers */
+    for (i = 0; i < NUMBER_OF_FPR; i++) {
+        ri->fpr[i] = uc->uc_mcontext->fs.fpregs[i];
+    }
+
+    /* init the condition register */
+    ri->cr = uc->uc_mcontext->ss.cr;
+
+    /* init the floating point status and control register */
+    ri->fpscr = uc->uc_mcontext->fs.fpscr;
+
+    /* init the fixed-point exception register */
+    ri->xer = uc->uc_mcontext->ss.xer;
+
+    /* init the link register */
+    ri->lr = uc->uc_mcontext->ss.lr;
+
+    /* init the count register */
+    ri->ctr = uc->uc_mcontext->ss.ctr;
+}
+
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if  
equal */
+int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
+{
+    debug_print("reginfo_is_eq() called\n");
+
+    int i;
+
+    /* check each general purpose register */
+    for (i = 0; i < NUMBER_OF_GPR; i++) {
+        if (r1->gpr[i] != r2->gpr[i]) {
+            debug_print("general purpose register %d mismatch  
detected\n", i);
+            return 0;
+        }
+    }
+
+    /* check each floating point register */
+    for (i = 0; i < NUMBER_OF_FPR; i++) {
+        if (r1->fpr[i] != r2->fpr[i]) {
+            if (!(isnan(r1->fpr[i]) && isnan(r2->fpr[i]))) {
+                if ( fabs(r1->fpr[i] - r2->fpr[i]) < 0.000001) {
+                    debug_print("float point register %d mismatch  
detected\n", i);
+                    return 0;
+                }
+            }
+        }
+    }
+
+    /* check condition register */
+    if (r1->cr != r2->cr) {
+        debug_print("condition register mismatch detected\n");
+        return 0;
+    }
+
+    /* check floating point status and control register */
+    if (r1->fpscr != r2->fpscr) {
+        debug_print("fpscr mismatch detected\n");
+        return 0;
+    }
+
+    /* check fixed point exception register */
+    if (r1->xer != r2->xer) {
+        debug_print("xer mismatch detected\n");
+        return 0;
+    }
+
+    /* check link register */
+    if (r1->lr != r2->lr) {
+        debug_print("lr mismatch detected\n");
+        return 0;
+    }
+
+    /* check count register */
+    if (r1->ctr != r2->ctr) {
+        debug_print("ctr mismatch detected\n");
+        return 0;
+    }
+
+    return 1;   /* Everything is the same */
+}
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE *f)
+{
+    debug_print("reginfo_dump() called\n");
+
+    int i;
+    fprintf(f, "faulting insn %08x\n", ri->faulting_insn);
+    fprintf(f, "previous insn %08x\n", ri->previous_instruction);
+    fprintf(f, "second previous insn %08x\n", ri- 
 >second_previous_instruction);
+
+    /* print general purpose registers */
+    for (i = 0; i < NUMBER_OF_GPR; i++) {
+        fprintf(f, "gpr %2d = 0x%08x\n", i, ri->gpr[i]);
+    }
+
+    /* print floating point registers */
+    for (i = 0; i < NUMBER_OF_FPR; i++) {
+        fprintf(f, "fpr %2d = 0x%016" PRIx64 "\n", i, ri->fpr[i]);
+    }
+
+    /* print condition register */
+    fprintf(f, "cr = 0x%x\n", ri->cr);
+
+    /* print floating point status and control register */
+    fprintf(f, "fpscr = 0x%x\n", ri->fpscr);
+
+    /* print fixed point exception register */
+    fprintf(f, "xer = 0x%x\n", ri->xer);
+
+    /* print link register */
+    fprintf(f, "lr = 0x%x\n", ri->lr);
+
+    /* print count register */
+    fprintf(f, "ctr = 0x%x\n", ri->ctr);
+
+    return !ferror(f);
+}
+
+/*
+ * Shows the classification of a floating point value.
+ * Input: floating point value
+ * Output: string description
+ */
+const char *show_classification(double x) {
+    switch(fpclassify(x)) {
+        case FP_INFINITE:  return "Inf";
+        case FP_NAN:       return "NaN";
+        case FP_NORMAL:    return "normal";
+        case FP_SUBNORMAL: return "subnormal";
+        case FP_ZERO:      return "zero";
+        default:           return "unknown";
+    }
+}
+
+/* reginfo_dump_mismatch: print mismatch details to a stream, ret  
nonzero=ok */
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE  
*f)
+{
+    debug_print("reginfo_dump_mismatch() called\n");
+
+    int i;
+    fprintf(f, "mismatch detail (master : apprentice):\n");
+
+    /* if there are general purpose register mismatches */
+    for (i = 0; i < NUMBER_OF_GPR; i++) {
+        if (m->gpr[i] != a->gpr[i]) {
+            fprintf(f, "gpr %2d  0x%08x :  0x%08x\n", i, m->gpr[i],  
a->gpr[i]);
+        }
+    }
+
+    /* if there are floating point register mismatches */
+    for (i = 0; i < NUMBER_OF_FPR; i++) {
+        if (m->fpr[i] != a->fpr[i]) {
+            if (!(isnan(m->fpr[i]) && isnan(a->fpr[i]))) {
+                if ( fabs(m->fpr[i] - a->fpr[i]) < 0.000001) {
+                    printf("classification: %s : %s\n",  
show_classification(m->fpr[i]), show_classification(a->fpr[i]));
+                    //fprintf(f, "fpr %2d  %12f :  %12f\n", i, m->fpr 
[i], a->fpr[i]);  // uncomment to see the interpreted value
+                    fprintf(f, "fpr %2d  0x%016" PRIx64 " :  0x%016"  
PRIx64 "\n", i, m->fpr[i], a->fpr[i]);
+
+                }
+            }
+        }
+    }
+
+    /* if there is a condition register mismatch */
+    if (m->cr != a->cr) {
+        fprintf(f, "cr  0x%08x :  0x%08x\n", m->cr, a->cr);
+    }
+
+    /* if there is a fpscr mismatch */
+    if (m->fpscr != a->fpscr) {
+        fprintf(f, "fpscr  0x%08x  :  0x%08x\n", m->fpscr, a->fpscr);
+    }
+
+    /* if there is a fixed point exception register mismatch */
+    if (m->xer != a->xer) {
+        fprintf(f, "xer  0x%08x  :  0x%08x\n", m->xer, a->xer);
+    }
+
+    /* if there is a link register mismatch */
+    if (m->lr != a->lr) {
+        fprintf(f, "lr  0x%08x  :  0x%08x\n", m->lr, a->lr);
+    }
+
+    /* if there is a count register mismatch */
+    if (m->ctr != a->ctr) {
+        fprintf(f, "ctr  0x%08x  :  0x%08x\n", m->ctr, a->ctr);
+    }
+
+    return !ferror(f);
+}
\ No newline at end of file
-- 
2.10.2
