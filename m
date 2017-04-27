Received: from eggs.gnu.org ([2001:4830:134:3::10]:52362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i6A-0004AY-AG
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i69-0001ZS-B2
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:38 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3i69-0001Z9-4O
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:37 -0400
Received: by mail-wr0-x244.google.com with SMTP id w50so3540847wrc.0
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:00:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 27 Apr 2017 14:00:06 +0200
Message-Id: <20170427120006.20564-20-rth@twiddle.net>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 19/19] tcg/s390: Implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.h     |  2 +-
 tcg/s390/tcg-target.inc.c | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 6b7bcfb..957f0c0 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -92,7 +92,7 @@ extern uint64_t s390_facilities;
 #define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
-#define TCG_TARGET_HAS_goto_ptr       0
+#define TCG_TARGET_HAS_goto_ptr       1
 
 #define TCG_TARGET_HAS_div2_i64       1
 #define TCG_TARGET_HAS_rot_i64        1
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index a679280..5d7083e 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1741,9 +1741,14 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        /* return value */
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, args[0]);
-        tgen_gotoi(s, S390_CC_ALWAYS, tb_ret_addr);
+        /* Reuse the zeroing that exists for goto_ptr.  */
+        a0 = args[0];
+        if (a0 == 0) {
+            tgen_gotoi(s, S390_CC_ALWAYS, s->code_gen_epilogue);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, a0);
+            tgen_gotoi(s, S390_CC_ALWAYS, tb_ret_addr);
+        }
         break;
 
     case INDEX_op_goto_tb:
@@ -1767,6 +1772,10 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         s->tb_jmp_reset_offset[args[0]] = tcg_current_code_size(s);
         break;
 
+    case INDEX_op_goto_ptr:
+        tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, args[0]);
+        break;
+
     OP_32_64(ld8u):
         /* ??? LLC (RXY format) is only present with the extended-immediate
            facility, whereas LLGC is always present.  */
@@ -2241,6 +2250,7 @@ static const TCGTargetOpDef s390_op_defs[] = {
     { INDEX_op_exit_tb, { } },
     { INDEX_op_goto_tb, { } },
     { INDEX_op_br, { } },
+    { INDEX_op_goto_ptr, { "r" } },
 
     { INDEX_op_ld8u_i32, { "r", "r" } },
     { INDEX_op_ld8s_i32, { "r", "r" } },
@@ -2439,6 +2449,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /* br %r3 (go to TB) */
     tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, tcg_target_call_iarg_regs[1]);
 
+    /*
+     * Return path for goto_ptr. Set return value to 0, a-la exit_tb,
+     * and fall through to the rest of the epilogue.
+     */
+    s->code_gen_epilogue = s->code_ptr;
+    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R2, 0);
+
+    /* TB epilogue */
     tb_ret_addr = s->code_ptr;
 
     /* lmg %r6,%r15,fs+48(%r15) (restore registers) */
-- 
2.9.3
