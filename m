Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrx-0005uI-PF
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrv-0006jv-T4
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:33 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e]:40294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMru-0006gE-Q1
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:31 -0400
Received: by mail-lf1-x12e.google.com with SMTP id x26-v6so4575915lfi.7
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:29 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:41 -0700
Message-Id: <20180905014352.970-5-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 04/15] target/xtensa: extract test for debug
 exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

- mark break and break.n instructions;
- collect debug cause bits from parameter 0 of instructions marked for
  debug exception;
- put debug exception check right after syscall check;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 450e30d316a8..5222c952a1b7 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -959,6 +959,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         uint32_t arg[MAX_OPCODE_ARGS];
         uint32_t raw_arg[MAX_OPCODE_ARGS];
     } slot_prop[MAX_INSN_SLOTS];
+    uint32_t debug_cause = 0;
 
     if (len == XTENSA_UNDEFINED) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -1040,6 +1041,9 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
             gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
             return;
         }
+        if (ops->op_flags & XTENSA_OP_DEBUG_BREAK) {
+            debug_cause |= ops->par[0];
+        }
     }
 
     if ((op_flags & XTENSA_OP_PRIVILEGED) &&
@@ -1052,6 +1056,11 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
+    if ((op_flags & XTENSA_OP_DEBUG_BREAK) && dc->debug) {
+        gen_debug_exception(dc, debug_cause);
+        return;
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -1515,14 +1524,6 @@ static void translate_bp(DisasContext *dc, const uint32_t arg[],
     tcg_temp_free(tmp);
 }
 
-static void translate_break(DisasContext *dc, const uint32_t arg[],
-                            const uint32_t par[])
-{
-    if (dc->debug) {
-        gen_debug_exception(dc, par[0]);
-    }
-}
-
 static void translate_call0(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
@@ -2827,12 +2828,14 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){TCG_COND_EQ},
     }, {
         .name = "break",
-        .translate = translate_break,
+        .translate = translate_nop,
         .par = (const uint32_t[]){DEBUGCAUSE_BI},
+        .op_flags = XTENSA_OP_DEBUG_BREAK,
     }, {
         .name = "break.n",
-        .translate = translate_break,
+        .translate = translate_nop,
         .par = (const uint32_t[]){DEBUGCAUSE_BN},
+        .op_flags = XTENSA_OP_DEBUG_BREAK,
     }, {
         .name = "bt",
         .translate = translate_bp,
-- 
2.11.0
