Received: from eggs.gnu.org ([2001:4830:134:3::10]:39515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en794-000067-HQ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en793-0001Sd-1R
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:34 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en792-0001S7-Ql
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:32 -0500
Received: by mail-pl0-x243.google.com with SMTP id bd10so3449386plb.1
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:23:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:19 -0800
Message-Id: <20180217182323.25885-4-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/67] target/arm: Add SVE decode skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Including only 4, as-yet unimplemented, instruction patterns
so that the whole thing compiles.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 11 +++++++-
 target/arm/translate-sve.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 .gitignore                 |  1 +
 target/arm/Makefile.objs   | 10 ++++++++
 target/arm/sve.decode      | 45 +++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/translate-sve.c
 create mode 100644 target/arm/sve.decode

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e0e7ebf68c..a50fef98af 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -12772,9 +12772,18 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     s->fp_access_checked = false;
 
     switch (extract32(insn, 25, 4)) {
-    case 0x0: case 0x1: case 0x2: case 0x3: /* UNALLOCATED */
+    case 0x0: case 0x1: case 0x3: /* UNALLOCATED */
         unallocated_encoding(s);
         break;
+    case 0x2:
+        if (!arm_dc_feature(s, ARM_FEATURE_SVE)) {
+            unallocated_encoding(s);
+        } else if (!sve_access_check(s) || !fp_access_check(s)) {
+            /* exception raised */
+        } else if (!disas_sve(s, insn)) {
+            unallocated_encoding(s);
+        }
+        break;
     case 0x8: case 0x9: /* Data processing - immediate */
         disas_data_proc_imm(s, insn);
         break;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
new file mode 100644
index 0000000000..2c9e4733cb
--- /dev/null
+++ b/target/arm/translate-sve.c
@@ -0,0 +1,63 @@
+/*
+ * AArch64 SVE translation
+ *
+ * Copyright (c) 2018 Linaro, Ltd
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "tcg-op.h"
+#include "tcg-op-gvec.h"
+#include "qemu/log.h"
+#include "arm_ldst.h"
+#include "translate.h"
+#include "internals.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+#include "trace-tcg.h"
+#include "translate-a64.h"
+
+/*
+ * Include the generated decoder.
+ */
+
+#include "decode-sve.inc.c"
+
+/*
+ * Implement all of the translator functions referenced by the decoder.
+ */
+
+static void trans_AND_zzz(DisasContext *s, arg_AND_zzz *a, uint32_t insn)
+{
+    unsupported_encoding(s, insn);
+}
+
+static void trans_ORR_zzz(DisasContext *s, arg_ORR_zzz *a, uint32_t insn)
+{
+    unsupported_encoding(s, insn);
+}
+
+static void trans_EOR_zzz(DisasContext *s, arg_EOR_zzz *a, uint32_t insn)
+{
+    unsupported_encoding(s, insn);
+}
+
+static void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
+{
+    unsupported_encoding(s, insn);
+}
diff --git a/.gitignore b/.gitignore
index 704b22285d..abe2b81a26 100644
--- a/.gitignore
+++ b/.gitignore
@@ -140,3 +140,4 @@ trace-dtrace-root.h
 trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
+/target/arm/decode-sve.inc.c
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 847fb52ee0..9934cf1d4d 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -10,3 +10,13 @@ obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
 obj-y += crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/translate-sve.o: target/arm/decode-sve.inc.c
+obj-$(TARGET_AARCH64) += translate-sve.o
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
new file mode 100644
index 0000000000..2c13a6024a
--- /dev/null
+++ b/target/arm/sve.decode
@@ -0,0 +1,45 @@
+# AArch64 SVE instruction descriptions
+#
+#  Copyright (c) 2017 Linaro, Ltd
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
+
+#
+# This file is processed by scripts/decodetree.py
+#
+
+###########################################################################
+# Named attribute sets.  These are used to make nice(er) names
+# when creating helpers common to those for the individual
+# instruction patterns.
+
+&rrr_esz	rd rn rm esz
+
+###########################################################################
+# Named instruction formats.  These are generally used to
+# reduce the amount of duplication between instruction patterns.
+
+# Three operand with unused vector element size
+@rd_rn_rm_e0	........ ... rm:5  ... ...  rn:5 rd:5		&rrr_esz esz=0
+
+###########################################################################
+# Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
+
+### SVE Logical - Unpredicated Group
+
+# SVE bitwise logical operations (unpredicated)
+AND_zzz		00000100 00 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
+ORR_zzz		00000100 01 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
+EOR_zzz		00000100 10 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
+BIC_zzz		00000100 11 1 ..... 001 100 ..... .....		@rd_rn_rm_e0
-- 
2.14.3
