Received: from eggs.gnu.org ([2001:4830:134:3::10]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJSx-0006FG-CY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJSw-0003Se-Jt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:43 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJSw-0003SV-Di
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:45:42 -0500
Received: by mail-pl0-x242.google.com with SMTP id d9-v6so5072318plo.8
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:45:42 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:43:44 +1300
Message-Id: <1520369037-37977-10-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369037-37977-1-git-send-email-mjc@sifive.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 09/22] RISC-V: Include hexidecimal
 instruction in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches disassembly <patches@groups.riscv.org>

This was added to help debug issues using -d in_asm. It is
useful to see the instruction bytes, as one can detect if
one is trying to execute ASCII or device-tree magic.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 disas/riscv.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 3c17501..4580308 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2769,25 +2769,6 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
     char tmp[64];
     const char *fmt;
 
-    if (dec->op == rv_op_illegal) {
-        size_t len = inst_length(dec->inst);
-        switch (len) {
-        case 2:
-            snprintf(buf, buflen, "(0x%04" PRIx64 ")", dec->inst);
-            break;
-        case 4:
-            snprintf(buf, buflen, "(0x%08" PRIx64 ")", dec->inst);
-            break;
-        case 6:
-            snprintf(buf, buflen, "(0x%012" PRIx64 ")", dec->inst);
-            break;
-        default:
-            snprintf(buf, buflen, "(0x%016" PRIx64 ")", dec->inst);
-            break;
-        }
-        return;
-    }
-
     fmt = opcode_data[dec->op].format;
     while (*fmt) {
         switch (*fmt) {
@@ -3004,6 +2985,11 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst)
     format_inst(buf, buflen, 16, &dec);
 }
 
+#define INST_FMT_2 "%04" PRIx64 "              "
+#define INST_FMT_4 "%08" PRIx64 "          "
+#define INST_FMT_6 "%012" PRIx64 "      "
+#define INST_FMT_8 "%016" PRIx64 "  "
+
 static int
 print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
 {
@@ -3031,6 +3017,21 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
     }
 
+    switch (len) {
+    case 2:
+        (*info->fprintf_func)(info->stream, INST_FMT_2, inst);
+        break;
+    case 4:
+        (*info->fprintf_func)(info->stream, INST_FMT_4, inst);
+        break;
+    case 6:
+        (*info->fprintf_func)(info->stream, INST_FMT_6, inst);
+        break;
+    default:
+        (*info->fprintf_func)(info->stream, INST_FMT_8, inst);
+        break;
+    }
+
     disasm_inst(buf, sizeof(buf), isa, memaddr, inst);
     (*info->fprintf_func)(info->stream, "%s", buf);
 
-- 
2.7.0
