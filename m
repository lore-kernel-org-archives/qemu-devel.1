Received: from eggs.gnu.org ([2001:4830:134:3::10]:40591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbW-0000iu-SC
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbW-0008NA-0t
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:02 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbV-0008N1-SX
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:01 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so2853915qte.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:17:01 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	u19sm1262380qtc.64.2017.05.26.14.17.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 May 2017 14:17:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:26 -0700
Message-Id: <20170526211638.32301-15-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v7 14/26] tcg/sparc: Implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/sparc/tcg-target.h     |  2 +-
 tcg/sparc/tcg-target.inc.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 9348ddd..854a0af 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -123,7 +123,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_goto_ptr         0
+#define TCG_TARGET_HAS_goto_ptr         1
 
 #define TCG_TARGET_HAS_extrl_i64_i32    1
 #define TCG_TARGET_HAS_extrh_i64_i32    1
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 3785d77..18afce2 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1003,7 +1003,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     /* delay slot */
     tcg_out_nop(s);
 
-    /* No epilogue required.  We issue ret + restore directly in the TB.  */
+    /* Epilogue for goto_ptr.  */
+    s->code_gen_epilogue = s->code_ptr;
+    tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
+    /* delay slot */
+    tcg_out_movi_imm13(s, TCG_REG_O0, 0);
 
 #ifdef CONFIG_SOFTMMU
     build_trampolines(s);
@@ -1288,6 +1292,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_nop(s);
         s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
         break;
+    case INDEX_op_goto_ptr:
+        tcg_out_arithi(s, TCG_REG_G0, a0, 0, JMPL);
+        tcg_out_nop(s);
+        break;
     case INDEX_op_br:
         tcg_out_bpcc(s, COND_A, BPCC_PT, arg_label(a0));
         tcg_out_nop(s);
@@ -1513,6 +1521,7 @@ static const TCGTargetOpDef sparc_op_defs[] = {
     { INDEX_op_exit_tb, { } },
     { INDEX_op_goto_tb, { } },
     { INDEX_op_br, { } },
+    { INDEX_op_goto_ptr, { "r" } },
 
     { INDEX_op_ld8u_i32, { "r", "r" } },
     { INDEX_op_ld8s_i32, { "r", "r" } },
-- 
2.9.4
