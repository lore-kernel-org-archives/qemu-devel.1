Received: from eggs.gnu.org ([209.51.188.92]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8p-0003LF-13
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00055g-T4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:03 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-0004x7-Hd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:01 -0500
Received: by mail-lf1-x142.google.com with SMTP id n15so5801457lfe.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:50 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:51 -0800
Message-Id: <20190214230000.24894-5-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 04/13] target/xtensa: implement wide branches
 and loops
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

FLIX adds branch and loop instruction variants with 15- and 18-bit wide
target offset. Implement them as additional names for the ordinary
branch/loop opcodes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 129 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 27 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 1b730781ec05..e8dddd32b3af 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2463,40 +2463,64 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_all,
         .par = (const uint32_t[]){false, 8},
     }, {
-        .name = "ball",
+        .name = (const char * const[]) {
+            "ball", "ball.w15", "ball.w18", NULL,
+        },
         .translate = translate_ball,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bany",
+        .name = (const char * const[]) {
+            "bany", "bany.w15", "bany.w18", NULL,
+        },
         .translate = translate_bany,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bbc",
+        .name = (const char * const[]) {
+            "bbc", "bbc.w15", "bbc.w18", NULL,
+        },
         .translate = translate_bb,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bbci",
+        .name = (const char * const[]) {
+            "bbci", "bbci.w15", "bbci.w18", NULL,
+        },
         .translate = translate_bbi,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bbs",
+        .name = (const char * const[]) {
+            "bbs", "bbs.w15", "bbs.w18", NULL,
+        },
         .translate = translate_bb,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bbsi",
+        .name = (const char * const[]) {
+            "bbsi", "bbsi.w15", "bbsi.w18", NULL,
+        },
         .translate = translate_bbi,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "beq",
+        .name = (const char * const[]) {
+            "beq", "beq.w15", "beq.w18", NULL,
+        },
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "beqi",
+        .name = (const char * const[]) {
+            "beqi", "beqi.w15", "beqi.w18", NULL,
+        },
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = (const char * const[]) {
-            "beqz", "beqz.n", NULL,
+            "beqz", "beqz.n", "beqz.w15", "beqz.w18", NULL,
         },
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_EQ},
@@ -2506,68 +2530,110 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_bp,
         .par = (const uint32_t[]){TCG_COND_EQ},
     }, {
-        .name = "bge",
+        .name = (const char * const[]) {
+            "bge", "bge.w15", "bge.w18", NULL,
+        },
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bgei",
+        .name = (const char * const[]) {
+            "bgei", "bgei.w15", "bgei.w18", NULL,
+        },
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bgeu",
+        .name = (const char * const[]) {
+            "bgeu", "bgeu.w15", "bgeu.w18", NULL,
+        },
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_GEU},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bgeui",
+        .name = (const char * const[]) {
+            "bgeui", "bgeui.w15", "bgeui.w18", NULL,
+        },
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_GEU},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bgez",
+        .name = (const char * const[]) {
+            "bgez", "bgez.w15", "bgez.w18", NULL,
+        },
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_GE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "blt",
+        .name = (const char * const[]) {
+            "blt", "blt.w15", "blt.w18", NULL,
+        },
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "blti",
+        .name = (const char * const[]) {
+            "blti", "blti.w15", "blti.w18", NULL,
+        },
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bltu",
+        .name = (const char * const[]) {
+            "bltu", "bltu.w15", "bltu.w18", NULL,
+        },
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_LTU},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bltui",
+        .name = (const char * const[]) {
+            "bltui", "bltui.w15", "bltui.w18", NULL,
+        },
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_LTU},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bltz",
+        .name = (const char * const[]) {
+            "bltz", "bltz.w15", "bltz.w18", NULL,
+        },
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_LT},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bnall",
+        .name = (const char * const[]) {
+            "bnall", "bnall.w15", "bnall.w18", NULL,
+        },
         .translate = translate_ball,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bne",
+        .name = (const char * const[]) {
+            "bne", "bne.w15", "bne.w18", NULL,
+        },
         .translate = translate_b,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bnei",
+        .name = (const char * const[]) {
+            "bnei", "bnei.w15", "bnei.w18", NULL,
+        },
         .translate = translate_bi,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = (const char * const[]) {
-            "bnez", "bnez.n", NULL,
+            "bnez", "bnez.n", "bnez.w15", "bnez.w18", NULL,
         },
         .translate = translate_bz,
         .par = (const uint32_t[]){TCG_COND_NE},
         .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "bnone",
+        .name = (const char * const[]) {
+            "bnone", "bnone.w15", "bnone.w18", NULL,
+        },
         .translate = translate_bany,
         .par = (const uint32_t[]){TCG_COND_EQ},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "break",
         .translate = translate_nop,
@@ -2785,17 +2851,26 @@ static const XtensaOpcodeOps core_ops[] = {
         .name = "ldpte",
         .op_flags = XTENSA_OP_ILL,
     }, {
-        .name = "loop",
+        .name = (const char * const[]) {
+            "loop", "loop.w15", NULL,
+        },
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NEVER},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "loopgtz",
+        .name = (const char * const[]) {
+            "loopgtz", "loopgtz.w15", NULL,
+        },
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_GT},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
-        .name = "loopnez",
+        .name = (const char * const[]) {
+            "loopnez", "loopnez.w15", NULL,
+        },
         .translate = translate_loop,
         .par = (const uint32_t[]){TCG_COND_NE},
+        .op_flags = XTENSA_OP_NAME_ARRAY,
     }, {
         .name = "max",
         .translate = translate_smax,
-- 
2.11.0
