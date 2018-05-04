Received: from eggs.gnu.org ([2001:4830:134:3::10]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSQ-0008Ov-Gs
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSP-0004fP-87
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:38 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSO-0004dj-Vq
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:37 -0400
Received: by mail-pf0-x242.google.com with SMTP id a22so2474940pfn.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:19 -0700
Message-Id: <20180504054030.24527-3-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/13] target/openrisc: Start conversion to
 decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Begin with the 0x08 major opcode, the system instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c   | 79 +++++++++++++++++++++----------------------
 target/openrisc/Makefile.objs |  9 +++++
 target/openrisc/insns.decode  | 28 +++++++++++++++
 3 files changed, 76 insertions(+), 40 deletions(-)
 create mode 100644 target/openrisc/insns.decode

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6876317971..40b21a5db1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -31,6 +31,7 @@
 
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
+#include "exec/gen-icount.h"
 
 #include "trace-tcg.h"
 #include "exec/log.h"
@@ -53,6 +54,9 @@ typedef struct DisasContext {
     bool singlestep_enabled;
 } DisasContext;
 
+/* Include the auto-generated decoder.  */
+#include "decode.inc.c"
+
 static TCGv cpu_sr;
 static TCGv cpu_R[32];
 static TCGv cpu_R0;
@@ -67,7 +71,6 @@ static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
 static TCGv_i64 cpu_mac;        /* MACHI:MACLO */
 static TCGv_i32 cpu_dflag;
-#include "exec/gen-icount.h"
 
 void openrisc_translate_init(void)
 {
@@ -1243,45 +1246,40 @@ static void dec_compi(DisasContext *dc, uint32_t insn)
     }
 }
 
-static void dec_sys(DisasContext *dc, uint32_t insn)
+static bool trans_l_sys(DisasContext *dc, arg_l_sys *a, uint32_t insn)
 {
-    uint32_t op0;
-    uint32_t K16;
+    LOG_DIS("l.sys %d\n", a->k);
+    tcg_gen_movi_tl(cpu_pc, dc->pc);
+    gen_exception(dc, EXCP_SYSCALL);
+    dc->is_jmp = DISAS_UPDATE;
+    return true;
+}
 
-    op0 = extract32(insn, 16, 10);
-    K16 = extract32(insn, 0, 16);
+static bool trans_l_trap(DisasContext *dc, arg_l_trap *a, uint32_t insn)
+{
+    LOG_DIS("l.trap %d\n", a->k);
+    tcg_gen_movi_tl(cpu_pc, dc->pc);
+    gen_exception(dc, EXCP_TRAP);
+    return true;
+}
 
-    switch (op0) {
-    case 0x000:    /* l.sys */
-        LOG_DIS("l.sys %d\n", K16);
-        tcg_gen_movi_tl(cpu_pc, dc->pc);
-        gen_exception(dc, EXCP_SYSCALL);
-        dc->is_jmp = DISAS_UPDATE;
-        break;
+static bool trans_l_msync(DisasContext *dc, arg_l_msync *a, uint32_t insn)
+{
+    LOG_DIS("l.msync\n");
+    tcg_gen_mb(TCG_MO_ALL);
+    return true;
+}
 
-    case 0x100:    /* l.trap */
-        LOG_DIS("l.trap %d\n", K16);
-        tcg_gen_movi_tl(cpu_pc, dc->pc);
-        gen_exception(dc, EXCP_TRAP);
-        break;
+static bool trans_l_psync(DisasContext *dc, arg_l_psync *a, uint32_t insn)
+{
+    LOG_DIS("l.psync\n");
+    return true;
+}
 
-    case 0x300:    /* l.csync */
-        LOG_DIS("l.csync\n");
-        break;
-
-    case 0x200:    /* l.msync */
-        LOG_DIS("l.msync\n");
-        tcg_gen_mb(TCG_MO_ALL);
-        break;
-
-    case 0x270:    /* l.psync */
-        LOG_DIS("l.psync\n");
-        break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
-    }
+static bool trans_l_csync(DisasContext *dc, arg_l_csync *a, uint32_t insn)
+{
+    LOG_DIS("l.csync\n");
+    return true;
 }
 
 static void dec_float(DisasContext *dc, uint32_t insn)
@@ -1509,17 +1507,18 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
     uint32_t op0;
     uint32_t insn;
     insn = cpu_ldl_code(&cpu->env, dc->pc);
-    op0 = extract32(insn, 26, 6);
 
+    /* Transition to the auto-generated decoder.  */
+    if (decode(dc, insn)) {
+        return;
+    }
+
+    op0 = extract32(insn, 26, 6);
     switch (op0) {
     case 0x06:
         dec_M(dc, insn);
         break;
 
-    case 0x08:
-        dec_sys(dc, insn);
-        break;
-
     case 0x2e:
         dec_logic(dc, insn);
         break;
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index 918b1c6e9c..1b98a911ea 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -3,3 +3,12 @@ obj-y += cpu.o exception.o interrupt.o mmu.o translate.o
 obj-y += exception_helper.o fpu_helper.o \
          interrupt_helper.o mmu_helper.o sys_helper.o
 obj-y += gdbstub.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/openrisc/decode.inc.c: \
+  $(SRC_PATH)/target/openrisc/insns.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) -o $@ $<, "GEN", $(TARGET_DIR)$@)
+
+target/openrisc/translate.o: target/openrisc/decode.inc.c
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
new file mode 100644
index 0000000000..47d31afc5b
--- /dev/null
+++ b/target/openrisc/insns.decode
@@ -0,0 +1,28 @@
+#
+# OpenRISC instruction decode definitions.
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
+# System Instructions
+####
+
+l_sys           001000 0000000000 k:16
+l_trap          001000 0100000000 k:16
+l_msync         001000 1000000000 00000000 00000000
+l_psync         001000 1010000000 00000000 00000000
+l_csync         001000 1100000000 00000000 00000000
-- 
2.14.3
