Received: from eggs.gnu.org ([209.51.188.92]:58137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFt-0007AD-Bg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griFs-0001Nk-6Q
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:09 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griFr-0001Mm-VK
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:54:08 -0500
Received: by mail-wm1-x342.google.com with SMTP id g67so6357047wmd.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:54:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Feb 2019 11:53:43 +0000
Message-Id: <20190207115400.647-3-richard.henderson@linaro.org>
In-Reply-To: <20190207115400.647-1-richard.henderson@linaro.org>
References: <20190207115400.647-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/19] target/hppa: Begin using
 scripts/decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, svens@stackframe.org

Convert the BREAK instruction to start.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c   | 24 +++++++++++++++++++-----
 target/hppa/Makefile.objs |  8 ++++++++
 target/hppa/insns.decode  | 24 ++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 5 deletions(-)
 create mode 100644 target/hppa/insns.decode

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a4f253a022..f50ec7b9c2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -278,6 +278,9 @@ typedef struct DisasContext {
     bool psw_n_nonzero;
 } DisasContext;
 
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
+
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
 #define DISAS_IAQ_N_UPDATED  DISAS_TARGET_0
@@ -661,7 +664,8 @@ static void nullify_set(DisasContext *ctx, bool x)
 }
 
 /* Mark the end of an instruction that may have been nullified.
-   This is the pair to nullify_over.  */
+   This is the pair to nullify_over.  Always returns true so that
+   it may be tail-called from a translate function.  */
 static bool nullify_end(DisasContext *ctx)
 {
     TCGLabel *null_lab = ctx->null_lab;
@@ -745,12 +749,17 @@ static bool gen_illegal(DisasContext *ctx)
     return gen_excp_iir(ctx, EXCP_ILL);
 }
 
-#define CHECK_MOST_PRIVILEGED(EXCP)          \
+#ifdef CONFIG_USER_ONLY
+#define CHECK_MOST_PRIVILEGED(EXCP) \
+    return gen_excp_iir(ctx, EXCP)
+#else
+#define CHECK_MOST_PRIVILEGED(EXCP) \
     do {                                     \
         if (ctx->privilege != 0) {           \
             return gen_excp_iir(ctx, EXCP);  \
         }                                    \
     } while (0)
+#endif
 
 static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
 {
@@ -1982,7 +1991,7 @@ static bool trans_nop(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     return true;
 }
 
-static bool trans_break(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static bool trans_break(DisasContext *ctx, arg_break *a)
 {
     return gen_excp_iir(ctx, EXCP_BREAK);
 }
@@ -2308,7 +2317,6 @@ static bool gen_hlt(DisasContext *ctx, int reset)
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_system[] = {
-    { 0x00000000u, 0xfc001fe0u, trans_break },
     { 0x00001820u, 0xffe01fffu, trans_mtsp },
     { 0x00001840u, 0xfc00ffffu, trans_mtctl },
     { 0x016018c0u, 0xffe0ffffu, trans_mtsarcm },
@@ -4534,8 +4542,14 @@ static void translate_table_int(DisasContext *ctx, uint32_t insn,
 
 static void translate_one(DisasContext *ctx, uint32_t insn)
 {
-    uint32_t opc = extract32(insn, 26, 6);
+    uint32_t opc;
 
+    /* Transition to the auto-generated decoder.  */
+    if (decode(ctx, insn)) {
+        return;
+    }
+
+    opc = extract32(insn, 26, 6);
     switch (opc) {
     case 0x00: /* system op */
         translate_table(ctx, insn, table_system);
diff --git a/target/hppa/Makefile.objs b/target/hppa/Makefile.objs
index 3359da5341..174f50a96c 100644
--- a/target/hppa/Makefile.objs
+++ b/target/hppa/Makefile.objs
@@ -1,3 +1,11 @@
 obj-y += translate.o helper.o cpu.o op_helper.o gdbstub.o mem_helper.o
 obj-y += int_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/hppa/decode.inc.c: $(SRC_PATH)/target/hppa/insns.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
+
+target/hppa/translate.o: target/hppa/decode.inc.c
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
new file mode 100644
index 0000000000..2822fbc58b
--- /dev/null
+++ b/target/hppa/insns.decode
@@ -0,0 +1,24 @@
+#
+# HPPA instruction decode definitions.
+#
+# Copyright (c) 2018 Richard Henderson <rth@twiddle.net>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+#
+
+####
+# System
+####
+
+break           000000 ----- ----- --- 00000000 -----
-- 
2.17.2
