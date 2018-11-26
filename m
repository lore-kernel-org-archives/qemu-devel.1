Received: from eggs.gnu.org ([2001:4830:134:3::10]:43089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPwH-0002oC-G5
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPw7-0000I4-IT
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:05:07 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRPw3-0000H2-Pc
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:59 -0500
Received: by mail-pg1-x543.google.com with SMTP id w6so6877520pgl.6
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 15:04:58 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-170-180.tukw.qwest.net.
	[97.113.170.180]) by smtp.gmail.com with ESMTPSA id
	o13sm1798703pfk.57.2018.11.26.15.04.56 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 26 Nov 2018 15:04:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 26 Nov 2018 15:04:49 -0800
Message-Id: <20181126230450.672-4-richard.henderson@linaro.org>
In-Reply-To: <20181126230450.672-1-richard.henderson@linaro.org>
References: <20181126230450.672-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] tcg: Reference count labels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Increment when adding branches, and decrement when removing them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h |  1 +
 tcg/tcg.h    |  3 ++-
 tcg/tcg-op.c |  2 ++
 tcg/tcg.c    | 20 ++++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index db4e9188f4..7007ec0d4d 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -260,6 +260,7 @@ static inline void gen_set_label(TCGLabel *l)
 
 static inline void tcg_gen_br(TCGLabel *l)
 {
+    l->refs++;
     tcg_gen_op1(INDEX_op_br, label_arg(l));
 }
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 6b6bc75c82..c6caeeb42b 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -246,7 +246,8 @@ typedef struct TCGRelocation {
 
 typedef struct TCGLabel {
     unsigned has_value : 1;
-    unsigned id : 31;
+    unsigned id : 15;
+    unsigned refs : 16;
     union {
         uintptr_t value;
         tcg_insn_unit *value_ptr;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1ad095cc35..bab889662d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -240,6 +240,7 @@ void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
+        l->refs++;
         tcg_gen_op4ii_i32(INDEX_op_brcond_i32, arg1, arg2, cond, label_arg(l));
     }
 }
@@ -1405,6 +1406,7 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
+        l->refs++;
         if (TCG_TARGET_REG_BITS == 32) {
             tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
                               TCGV_HIGH(arg1), TCGV_LOW(arg2),
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 17c193791f..31b9b58240 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2191,6 +2191,26 @@ static void process_op_defs(TCGContext *s)
 
 void tcg_op_remove(TCGContext *s, TCGOp *op)
 {
+    TCGLabel *label;
+
+    switch (op->opc) {
+    case INDEX_op_br:
+        label = arg_label(op->args[0]);
+        label->refs--;
+        break;
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        label = arg_label(op->args[3]);
+        label->refs--;
+        break;
+    case INDEX_op_brcond2_i32:
+        label = arg_label(op->args[5]);
+        label->refs--;
+        break;
+    default:
+        break;
+    }
+
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
-- 
2.17.2
