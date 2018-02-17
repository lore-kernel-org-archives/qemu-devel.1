Received: from eggs.gnu.org ([2001:4830:134:3::10]:41870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en994-0008Oy-Qd
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en993-0000jZ-Hb
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:42 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en993-0000jB-Aq
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:41 -0500
Received: by mail-pg0-x241.google.com with SMTP id t4so4412657pgp.8
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:41 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:15 -0800
Message-Id: <20180217203132.31780-3-richard.henderson@linaro.org>
In-Reply-To: <20180217203132.31780-1-richard.henderson@linaro.org>
References: <20180217203132.31780-1-richard.henderson@linaro.org>
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

Convert the BREAK instruction to start.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c   | 14 +++++++++++---
 target/hppa/Makefile.objs |  8 ++++++++
 target/hppa/insns.decode  | 24 ++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)
 create mode 100644 target/hppa/insns.decode

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f72bc84873..a503ae38d4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -290,6 +290,9 @@ typedef struct DisasContext {
     bool psw_n_nonzero;
 } DisasContext;
 
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
+
 /* We are not using a goto_tb (for whatever reason), but have updated
    the iaq (for whatever reason), so don't do it again on exit.  */
 #define DISAS_IAQ_N_UPDATED  DISAS_TARGET_0
@@ -1997,7 +2000,7 @@ static void trans_nop(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
     cond_free(&ctx->null_cond);
 }
 
-static void trans_break(DisasContext *ctx, uint32_t insn, const DisasInsn *di)
+static void trans_break(DisasContext *ctx, arg_break *a, uint32_t insn)
 {
     nullify_over(ctx);
     gen_excp_iir(ctx, EXCP_BREAK);
@@ -2320,7 +2323,6 @@ static void gen_hlt(DisasContext *ctx, int reset)
 #endif /* !CONFIG_USER_ONLY */
 
 static const DisasInsn table_system[] = {
-    { 0x00000000u, 0xfc001fe0u, trans_break },
     { 0x00001820u, 0xffe01fffu, trans_mtsp },
     { 0x00001840u, 0xfc00ffffu, trans_mtctl },
     { 0x016018c0u, 0xffe0ffffu, trans_mtsarcm },
@@ -4508,8 +4510,14 @@ static void translate_table_int(DisasContext *ctx, uint32_t insn,
 
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
index 0000000000..6c2d3a3a52
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
+break		000000 ----- ----- --- 00000000 -----
-- 
2.14.3
