Received: from eggs.gnu.org ([2001:4830:134:3::10]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ecEuv-0004nZ-Mx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ecEuu-0000mp-S1
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:28:01 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:44083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ecEuu-0000kz-Ke
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:28:00 -0500
Received: by mail-lf0-x242.google.com with SMTP id w23so27848708lfd.11
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:28:00 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 18 Jan 2018 10:27:46 -0800
Message-Id: <1516300066-18600-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: disas/xtensa: fix coverity
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Coverity warnings CID 1385146, 1385148 1385149 and 1385150 point that
xtensa_opcode_num_operands and xtensa_format_num_slots may return -1
even when xtensa_opcode_decode and xtensa_format_decode succeed. In that
case unsigned counters used to iterate through operands/slots will not
do the right thing.
Make counters and loop bounds signed to fix the warnings.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 disas/xtensa.c            | 4 ++--
 target/xtensa/translate.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/disas/xtensa.c b/disas/xtensa.c
index 114326a4fc2e..5e3870b9ad23 100644
--- a/disas/xtensa.c
+++ b/disas/xtensa.c
@@ -37,7 +37,7 @@ int print_insn_xtensa(bfd_vma memaddr, struct disassemble_info *info)
     bfd_byte *buffer = g_malloc(1);
     int status = info->read_memory_func(memaddr, buffer, 1, info);
     xtensa_format fmt;
-    unsigned slot, slots;
+    int slot, slots;
     unsigned len;
 
     if (status) {
@@ -79,7 +79,7 @@ int print_insn_xtensa(bfd_vma memaddr, struct disassemble_info *info)
 
     for (slot = 0; slot < slots; ++slot) {
         xtensa_opcode opc;
-        unsigned opnd, vopnd, opnds;
+        int opnd, vopnd, opnds;
 
         if (slot) {
             info->fprintf_func(info->stream, "; ");
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4bdfcd24d09b..3f439203acf3 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -942,7 +942,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     unsigned char b[MAX_INSN_LENGTH] = {cpu_ldub_code(env, dc->pc)};
     unsigned len = xtensa_op0_insn_len(dc, b[0]);
     xtensa_format fmt;
-    unsigned slot, slots;
+    int slot, slots;
     unsigned i;
 
     if (len == XTENSA_UNDEFINED) {
@@ -969,7 +969,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
     slots = xtensa_format_num_slots(isa, fmt);
     for (slot = 0; slot < slots; ++slot) {
         xtensa_opcode opc;
-        unsigned opnd, vopnd, opnds;
+        int opnd, vopnd, opnds;
         uint32_t raw_arg[MAX_OPCODE_ARGS];
         uint32_t arg[MAX_OPCODE_ARGS];
         XtensaOpcodeOps *ops;
-- 
2.1.4
