Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2C8-0001Lq-0g
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2C5-0002d6-N9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:51 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2C5-0002cf-HA
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:49 -0400
Received: by mail-pl0-x243.google.com with SMTP id 9-v6so11041186ple.11
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:19:49 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:18:32 -0700
Message-Id: <1521494329-19546-10-git-send-email-mjc@sifive.com>
In-Reply-To: <1521494329-19546-1-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 09/26] RISC-V: Include intruction hex in
 disassembly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

This was added to help debug issues using -d in_asm. It is
useful to see the instruction bytes, as one can detect if
one is trying to execute ASCII or device-tree magic.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
