Received: from eggs.gnu.org ([2001:4830:134:3::10]:53251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Ji-82
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007IC-T1
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007Dq-JY
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:48 -0500
Received: by mail-wm1-x344.google.com with SMTP id u13-v6so6507408wmc.4
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:19 +0100
Message-Id: <20181111233622.8976-9-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 08/11] target/mips: Add a decodetree stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/Makefile.objs   |  8 ++++++++
 target/mips/insns.decode    |  2 ++
 target/mips/translate.c     |  7 +++++++
 target/mips/translate.inc.c | 13 +++++++++++++
 4 files changed, 30 insertions(+)
 create mode 100644 target/mips/insns.decode
 create mode 100644 target/mips/translate.inc.c

diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index 651f36f517..3510835d57 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -2,3 +2,11 @@ obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
 obj-y += gdbstub.o msa_helper.o mips-semi.o
 obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
 obj-$(CONFIG_KVM) += kvm.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/mips/decode.inc.c: $(SRC_PATH)/target/mips/insns.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
+
+target/mips/translate.o: target/mips/decode.inc.c
diff --git a/target/mips/insns.decode b/target/mips/insns.decode
new file mode 100644
index 0000000000..7fbf21cbb9
--- /dev/null
+++ b/target/mips/insns.decode
@@ -0,0 +1,2 @@
+# MIPS32/MIPS64 Instruction Set
+#
diff --git a/target/mips/translate.c b/target/mips/translate.c
index e726f3ec00..560325c563 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27848,6 +27848,8 @@ static void gen_msa(CPUMIPSState *env, DisasContext *ctx)
 
 }
 
+#include "translate.inc.c"
+
 static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 {
     int32_t offset;
@@ -27872,6 +27874,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         gen_set_label(l1);
     }
 
+    /* Transition to the auto-generated decoder.  */
+    if (decode(ctx, ctx->opcode)) {
+        return;
+    }
+
     op = MASK_OP_MAJOR(ctx->opcode);
     rs = (ctx->opcode >> 21) & 0x1f;
     rt = (ctx->opcode >> 16) & 0x1f;
diff --git a/target/mips/translate.inc.c b/target/mips/translate.inc.c
new file mode 100644
index 0000000000..69fe78ac89
--- /dev/null
+++ b/target/mips/translate.inc.c
@@ -0,0 +1,13 @@
+/*
+ *  MIPS emulation for QEMU - MIPS32 translation routines
+ *
+ *  Copyright (c) 2004-2005 Jocelyn Mayer
+ *  Copyright (c) 2006 Marius Groeger (FPU operations)
+ *  Copyright (c) 2006 Thiemo Seufer (MIPS32R2 support)
+ *  Copyright (c) 2018 Philippe Mathieu-Daudé
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
-- 
2.17.2
