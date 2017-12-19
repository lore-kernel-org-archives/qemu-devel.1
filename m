Received: from eggs.gnu.org ([2001:4830:134:3::10]:49701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdQ-0001KW-Cm
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdO-00029N-VK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:12 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAdO-00027o-Lr
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:40:10 -0500
Received: by mail-wr0-x242.google.com with SMTP id v21so6297515wrc.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:40:10 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:52 -0800
Message-Id: <1513661932-6849-17-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 16/16] target/xtensa: implement disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

Add disas/xtensa.c and use libisa for instruction decoding/opcode name
lookup.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS         |   1 +
 disas/Makefile.objs |   1 +
 disas/xtensa.c      | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/disas/bfd.h |   1 +
 target/xtensa/cpu.c |   9 ++++
 5 files changed, 145 insertions(+)
 create mode 100644 disas/xtensa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0255113470c2..4e2795bc029f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -259,6 +259,7 @@ S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
 F: tests/tcg/xtensa/
+F: disas/xtensa.c
 
 TriCore
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
diff --git a/disas/Makefile.objs b/disas/Makefile.objs
index 194648fb1ac9..53556f8f5a9f 100644
--- a/disas/Makefile.objs
+++ b/disas/Makefile.objs
@@ -21,6 +21,7 @@ common-obj-$(CONFIG_S390_DIS) += s390.o
 common-obj-$(CONFIG_SH4_DIS) += sh4.o
 common-obj-$(CONFIG_SPARC_DIS) += sparc.o
 common-obj-$(CONFIG_LM32_DIS) += lm32.o
+common-obj-$(CONFIG_XTENSA_DIS) += xtensa.o
 
 # TODO: As long as the TCG interpreter and its generated code depend
 # on the QEMU target, we cannot compile the disassembler here.
diff --git a/disas/xtensa.c b/disas/xtensa.c
new file mode 100644
index 000000000000..114326a4fc2e
--- /dev/null
+++ b/disas/xtensa.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2017, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "disas/bfd.h"
+#include "hw/xtensa/xtensa-isa.h"
+
+int print_insn_xtensa(bfd_vma memaddr, struct disassemble_info *info)
+{
+    xtensa_isa isa = info->private_data;
+    xtensa_insnbuf insnbuf = xtensa_insnbuf_alloc(isa);
+    xtensa_insnbuf slotbuf = xtensa_insnbuf_alloc(isa);
+    bfd_byte *buffer = g_malloc(1);
+    int status = info->read_memory_func(memaddr, buffer, 1, info);
+    xtensa_format fmt;
+    unsigned slot, slots;
+    unsigned len;
+
+    if (status) {
+        info->memory_error_func(status, memaddr, info);
+        len = -1;
+        goto out;
+    }
+    len = xtensa_isa_length_from_chars(isa, buffer);
+    if (len == XTENSA_UNDEFINED) {
+        info->fprintf_func(info->stream, ".byte 0x%02x", buffer[0]);
+        len = 1;
+        goto out;
+    }
+    buffer = g_realloc(buffer, len);
+    status = info->read_memory_func(memaddr + 1, buffer + 1, len - 1, info);
+    if (status) {
+        info->fprintf_func(info->stream, ".byte 0x%02x", buffer[0]);
+        info->memory_error_func(status, memaddr + 1, info);
+        len = 1;
+        goto out;
+    }
+
+    xtensa_insnbuf_from_chars(isa, insnbuf, buffer, len);
+    fmt = xtensa_format_decode(isa, insnbuf);
+    if (fmt == XTENSA_UNDEFINED) {
+        unsigned i;
+
+        for (i = 0; i < len; ++i) {
+            info->fprintf_func(info->stream, "%s 0x%02x",
+                               i ? ", " : ".byte ", buffer[i]);
+        }
+        goto out;
+    }
+    slots = xtensa_format_num_slots(isa, fmt);
+
+    if (slots > 1) {
+        info->fprintf_func(info->stream, "{ ");
+    }
+
+    for (slot = 0; slot < slots; ++slot) {
+        xtensa_opcode opc;
+        unsigned opnd, vopnd, opnds;
+
+        if (slot) {
+            info->fprintf_func(info->stream, "; ");
+        }
+        xtensa_format_get_slot(isa, fmt, slot, insnbuf, slotbuf);
+        opc = xtensa_opcode_decode(isa, fmt, slot, slotbuf);
+        if (opc == XTENSA_UNDEFINED) {
+            info->fprintf_func(info->stream, "???");
+            continue;
+        }
+        opnds = xtensa_opcode_num_operands(isa, opc);
+
+        info->fprintf_func(info->stream, "%s", xtensa_opcode_name(isa, opc));
+
+        for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
+            if (xtensa_operand_is_visible(isa, opc, opnd)) {
+                uint32_t v = 0xbadc0de;
+                int rc;
+
+                info->fprintf_func(info->stream, vopnd ? ", " : "\t");
+                xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
+                                         slotbuf, &v);
+                rc = xtensa_operand_decode(isa, opc, opnd, &v);
+                if (rc == XTENSA_UNDEFINED) {
+                    info->fprintf_func(info->stream, "???");
+                } else if (xtensa_operand_is_register(isa, opc, opnd)) {
+                    xtensa_regfile rf = xtensa_operand_regfile(isa, opc, opnd);
+
+                    info->fprintf_func(info->stream, "%s%d",
+                                       xtensa_regfile_shortname(isa, rf), v);
+                } else if (xtensa_operand_is_PCrelative(isa, opc, opnd)) {
+                    xtensa_operand_undo_reloc(isa, opc, opnd, &v, memaddr);
+                    info->fprintf_func(info->stream, "0x%x", v);
+                } else {
+                    info->fprintf_func(info->stream, "%d", v);
+                }
+                ++vopnd;
+            }
+        }
+    }
+    if (slots > 1) {
+        info->fprintf_func(info->stream, " }");
+    }
+
+out:
+    g_free(buffer);
+    xtensa_insnbuf_free(isa, insnbuf);
+    xtensa_insnbuf_free(isa, slotbuf);
+
+    return len;
+}
diff --git a/include/disas/bfd.h b/include/disas/bfd.h
index 46c7ec3376fe..932453750cc0 100644
--- a/include/disas/bfd.h
+++ b/include/disas/bfd.h
@@ -428,6 +428,7 @@ int print_insn_ia64             (bfd_vma, disassemble_info*);
 int print_insn_lm32             (bfd_vma, disassemble_info*);
 int print_insn_big_nios2        (bfd_vma, disassemble_info*);
 int print_insn_little_nios2     (bfd_vma, disassemble_info*);
+int print_insn_xtensa           (bfd_vma, disassemble_info*);
 
 #if 0
 /* Fetch the disassembler for a given BFD, if that support is available.  */
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 91961789a5b7..1c982a0b2e31 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -93,6 +93,14 @@ static ObjectClass *xtensa_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
+{
+    XtensaCPU *cpu = XTENSA_CPU(cs);
+
+    info->private_data = cpu->env.config->isa;
+    info->print_insn = print_insn_xtensa;
+}
+
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -164,6 +172,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_unassigned_access = xtensa_cpu_do_unassigned_access;
 #endif
     cc->debug_excp_handler = xtensa_breakpoint_handler;
+    cc->disas_set_info = xtensa_cpu_disas_set_info;
     cc->tcg_initialize = xtensa_translate_init;
     dc->vmsd = &vmstate_xtensa_cpu;
 }
-- 
2.1.4
