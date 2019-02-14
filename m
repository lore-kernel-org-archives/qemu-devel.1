Received: from eggs.gnu.org ([209.51.188.92]:49516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8m-00035F-66
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ0L-0005Iq-6V
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:21 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ0I-0005FW-WC
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:15 -0500
Received: by mail-lf1-x142.google.com with SMTP id v7so5817433lfd.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:01:11 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 15:00:00 -0800
Message-Id: <20190214230000.24894-14-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 13/13] target/xtensa: prioritize load/store in
 FLIX bundles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Load/store opcodes may raise MMU exceptions. Normally exceptions should
be checked in priority order before any actual operations, but since MMU
exceptions are tightly coupled with actual memory access, there's
currently no way to do it.

Approximate this behavior by executing all load, then all store, and
then all other opcodes in the FLIX bundles. Use opcode dependency
mechanism to express ordering. Mark load/store opcodes with
XTENSA_OP_{LOAD,STORE} flags. Newer libisa has classifier functions that
can tell whether opcode is a load or store, but this information is not
available in the existing overlays.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  4 ++++
 target/xtensa/translate.c | 37 ++++++++++++++++++++++++++++++++-----
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index bf021f7695e6..a01a94e2a683 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -390,6 +390,10 @@ enum {
     XTENSA_OP_NAME_ARRAY = 0x8000,
 
     XTENSA_OP_CONTROL_FLOW = 0x10000,
+    XTENSA_OP_STORE = 0x20000,
+    XTENSA_OP_LOAD = 0x40000,
+    XTENSA_OP_LOAD_STORE =
+        XTENSA_OP_LOAD | XTENSA_OP_STORE,
 };
 
 typedef struct XtensaOpcodeOps {
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 8bc272d05b4b..2fd64f8d995d 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -985,6 +985,10 @@ static bool op_depends_on(const struct slot_prop *a,
     if (a->op_flags & XTENSA_OP_CONTROL_FLOW) {
         return true;
     }
+    if ((a->op_flags & XTENSA_OP_LOAD_STORE) <
+        (b->op_flags & XTENSA_OP_LOAD_STORE)) {
+        return true;
+    }
     while (i < a->n_out && j < b->n_in) {
         if (a->out[i].resource < b->in[j].resource) {
             ++i;
@@ -1016,6 +1020,10 @@ static bool break_dependency(struct slot_prop *a,
     if (a->op_flags & XTENSA_OP_CONTROL_FLOW) {
         return false;
     }
+    if ((a->op_flags & XTENSA_OP_LOAD_STORE) <
+        (b->op_flags & XTENSA_OP_LOAD_STORE)) {
+        return false;
+    }
     while (i < a->n_out && j < b->n_in) {
         if (a->out[i].resource < b->in[j].resource) {
             ++i;
@@ -1292,7 +1300,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         if (slots > 1) {
             slot_prop[slot].n_in = 0;
             slot_prop[slot].n_out = 0;
-            slot_prop[slot].op_flags = 0;
+            slot_prop[slot].op_flags = ops->op_flags & XTENSA_OP_LOAD_STORE;
 
             opnds = xtensa_opcode_num_operands(isa, opc);
 
@@ -3222,40 +3230,47 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "l16si",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TESW, false, false},
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "l16ui",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUW, false, false},
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "l32ai",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, true, false},
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "l32e",
         .translate = translate_l32e,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_LOAD,
     }, {
         .name = (const char * const[]) {
             "l32i", "l32i.n", NULL,
         },
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, false},
-        .op_flags = XTENSA_OP_NAME_ARRAY,
+        .op_flags = XTENSA_OP_NAME_ARRAY | XTENSA_OP_LOAD,
     }, {
         .name = "l32r",
         .translate = translate_l32r,
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "l8ui",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, false},
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "lddec",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, -4},
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "ldinc",
         .translate = translate_mac16,
         .par = (const uint32_t[]){MAC16_NONE, 0, 4},
+        .op_flags = XTENSA_OP_LOAD,
     }, {
         .name = "ldpte",
         .op_flags = XTENSA_OP_ILL,
@@ -4213,28 +4228,32 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "s16i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUW, false, true},
+        .op_flags = XTENSA_OP_STORE,
     }, {
         .name = "s32c1i",
         .translate = translate_s32c1i,
+        .op_flags = XTENSA_OP_LOAD | XTENSA_OP_STORE,
     }, {
         .name = "s32e",
         .translate = translate_s32e,
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_STORE,
     }, {
         .name = (const char * const[]) {
             "s32i", "s32i.n", "s32nb", NULL,
         },
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
-        .op_flags = XTENSA_OP_NAME_ARRAY,
+        .op_flags = XTENSA_OP_NAME_ARRAY | XTENSA_OP_STORE,
     }, {
         .name = "s32ri",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, true, true},
+        .op_flags = XTENSA_OP_STORE,
     }, {
         .name = "s8i",
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_UB, false, true},
+        .op_flags = XTENSA_OP_STORE,
     }, {
         .name = "salt",
         .translate = translate_salt,
@@ -5524,21 +5543,25 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "lsi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, false},
+        .op_flags = XTENSA_OP_LOAD,
         .coprocessor = 0x1,
     }, {
         .name = "lsiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){false, true},
+        .op_flags = XTENSA_OP_LOAD,
         .coprocessor = 0x1,
     }, {
         .name = "lsx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, false},
+        .op_flags = XTENSA_OP_LOAD,
         .coprocessor = 0x1,
     }, {
         .name = "lsxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){false, true},
+        .op_flags = XTENSA_OP_LOAD,
         .coprocessor = 0x1,
     }, {
         .name = "madd.s",
@@ -5618,21 +5641,25 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .name = "ssi",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, false},
+        .op_flags = XTENSA_OP_STORE,
         .coprocessor = 0x1,
     }, {
         .name = "ssiu",
         .translate = translate_ldsti,
         .par = (const uint32_t[]){true, true},
+        .op_flags = XTENSA_OP_STORE,
         .coprocessor = 0x1,
     }, {
         .name = "ssx",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, false},
+        .op_flags = XTENSA_OP_STORE,
         .coprocessor = 0x1,
     }, {
         .name = "ssxu",
         .translate = translate_ldstx,
         .par = (const uint32_t[]){true, true},
+        .op_flags = XTENSA_OP_STORE,
         .coprocessor = 0x1,
     }, {
         .name = "sub.s",
-- 
2.11.0
