Received: from eggs.gnu.org ([209.51.188.92]:49516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8v-00035F-21
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00054v-Cc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:02 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ03-0004wH-V2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:01 -0500
Received: by mail-lf1-x141.google.com with SMTP id l10so5777065lfh.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:47 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:50 -0800
Message-Id: <20190214230000.24894-4-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 03/13] target/xtensa: allow multiple names for
 single opcode
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

There are opcodes that differ only in encoding or possible range of
immediate arguments. Allow multiple names for single opcode translation
table entry to reduce code duplication in that case.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |   4 +-
 target/xtensa/helper.c    |  16 ++++++--
 target/xtensa/translate.c | 100 ++++++++++++++++++++--------------------------
 3 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 2765665ceca6..db8ee70a0386 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -371,10 +371,12 @@ enum {
     XTENSA_OP_CHECK_INTERRUPTS = 0x200,
     XTENSA_OP_EXIT_TB_M1 = 0x400,
     XTENSA_OP_EXIT_TB_0 = 0x800,
+
+    XTENSA_OP_NAME_ARRAY = 0x8000,
 };
 
 typedef struct XtensaOpcodeOps {
-    const char *name;
+    const void *name;
     XtensaOpcodeOp translate;
     XtensaOpcodeBoolTest test_ill;
     XtensaOpcodeUintTest test_overflow;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 57709fc20caf..7008c6390d20 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -51,9 +51,19 @@ static GHashTable *hash_opcode_translators(const XtensaOpcodeTranslators *t)
     GHashTable *translator = g_hash_table_new(g_str_hash, g_str_equal);
 
     for (i = 0; i < t->num_opcodes; ++i) {
-        add_translator_to_hash(translator,
-                               (void *)t->opcode[i].name,
-                               (void *)(t->opcode + i));
+        if (t->opcode[i].op_flags & XTENSA_OP_NAME_ARRAY) {
+            const char * const *name = t->opcode[i].name;
+
+            for (j = 0; name[j]; ++j) {
+                add_translator_to_hash(translator,
+                                       (void *)name[j],
+                                       (void *)(t->opcode + i));
+            }
+        } else {
+            add_translator_to_hash(translator,
+                                   (void *)t->opcode[i].name,
+                                   (void *)(t->opcode + i));
+        }
     }
     return translator;
 }
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 26342aaa1f82..1b730781ec05 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2409,17 +2409,17 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "abs",
         .translate = translate_abs,
     }, {
-        .name = "add",
+        .name = (const char * const[]) {
+            "add", "add.n", NULL,
+        },
         .translate = translate_add,
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "add.n",
-        .translate = translate_add,
-    }, {
-        .name = "addi",
-        .translate = translate_addi,
-    }, {
-        .name = "addi.n",
+        .name = (const char * const[]) {
+            "addi", "addi.n", NULL,
+        },
         .translate = translate_addi,
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "addmi",
         .translate = translate_addi,
@@ -2495,13 +2495,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_EQ},
     }, {
-        .name = "beqz",
-        .translate = translate_bz,
-        .par = (const uint32_t[]){TCG_COND_EQ},
-    }, {
-        .name = "beqz.n",
+        .name = (const char * const[]) {
+            "beqz", "beqz.n", NULL,
+        },
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "bf",
         .translate = translate_bp,
@@ -2559,13 +2558,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_NE},
     }, {
-        .name = "bnez",
-        .translate = translate_bz,
-        .par = (const uint32_t[]){TCG_COND_NE},
-    }, {
-        .name = "bnez.n",
+        .name = (const char * const[]) {
+            "bnez", "bnez.n", NULL,
+        },
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "bnone",
         .translate = translate_bany,
@@ -2725,11 +2723,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_nop,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
-        .name = "ill",
-        .op_flags = XTENSA_OP_ILL,
-    }, {
-        .name = "ill.n",
-        .op_flags = XTENSA_OP_ILL,
+        .name = (const char * const[]) {
+            "ill", "ill.n", NULL,
+        },
+        .op_flags = XTENSA_OP_ILL | XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "ipf",
         .translate = translate_nop,
@@ -2763,13 +2760,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_l32e,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
-        .name = "l32i",
-        .translate = translate_ldst,
-        .par = (const uint32_t[]){MO_TEUL, false, false},
-    }, {
-        .name = "l32i.n",
+        .name = (const char * const[]) {
+            "l32i", "l32i.n", NULL,
+        },
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, false},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "l32r",
         .translate = translate_l32r,
@@ -2816,11 +2812,11 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "minu",
         .translate = translate_umin,
     }, {
-        .name = "mov",
-        .translate = translate_mov,
-    }, {
-        .name = "mov.n",
+        .name = (const char * const[]) {
+            "mov", "mov.n", NULL,
+        },
         .translate = translate_mov,
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "moveqz",
         .translate = translate_movcond,
@@ -3134,11 +3130,11 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "neg",
         .translate = translate_neg,
     }, {
-        .name = "nop",
-        .translate = translate_nop,
-    }, {
-        .name = "nop.n",
+        .name = (const char * const[]) {
+            "nop", "nop.n", NULL,
+        },
         .translate = translate_nop,
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "nsa",
         .translate = translate_nsa,
@@ -3202,21 +3198,18 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_rer,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
-        .name = "ret",
+        .name = (const char * const[]) {
+            "ret", "ret.n", NULL,
+        },
         .translate = translate_ret,
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "ret.n",
-        .translate = translate_ret,
-    }, {
-        .name = "retw",
+        .name = (const char * const[]) {
+            "retw", "retw.n", NULL,
+        },
         .translate = translate_retw,
         .test_ill = test_ill_retw,
-        .op_flags = XTENSA_OP_UNDERFLOW,
-    }, {
-        .name = "retw.n",
-        .translate = translate_retw,
-        .test_ill = test_ill_retw,
-        .op_flags = XTENSA_OP_UNDERFLOW,
+        .op_flags = XTENSA_OP_UNDERFLOW | XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "rfdd",
         .op_flags = XTENSA_OP_ILL,
@@ -3742,17 +3735,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_s32e,
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
-        .name = "s32i",
-        .translate = translate_ldst,
-        .par = (const uint32_t[]){MO_TEUL, false, true},
-    }, {
-        .name = "s32i.n",
-        .translate = translate_ldst,
-        .par = (const uint32_t[]){MO_TEUL, false, true},
-    }, {
-        .name = "s32nb",
+        .name = (const char * const[]) {
+            "s32i", "s32i.n", "s32nb", NULL,
+        },
         .translate = translate_ldst,
         .par = (const uint32_t[]){MO_TEUL, false, true},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "s32ri",
         .translate = translate_ldst,
-- 
2.11.0
