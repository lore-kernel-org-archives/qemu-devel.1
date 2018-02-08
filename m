Received: from eggs.gnu.org ([2001:4830:134:3::10]:32916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejb2y-0003CR-RO
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejb2x-0001sZ-Lm
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:30:44 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ejb2x-0001rI-FN
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:30:43 -0500
Received: by mail-pl0-x243.google.com with SMTP id t4-v6so1229129plo.0
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 17:30:43 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Thu,  8 Feb 2018 14:28:33 +1300
Message-Id: <1518053328-34687-9-git-send-email-mjc@sifive.com>
In-Reply-To: <1518053328-34687-1-git-send-email-mjc@sifive.com>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v5 08/23] RISC-V GDB Stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

GDB Register read and write routines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/gdbstub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 target/riscv/gdbstub.c

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
new file mode 100644
index 0000000..500bd5f
--- /dev/null
+++ b/target/riscv/gdbstub.c
@@ -0,0 +1,60 @@
+/*
+ * RISC-V GDB Server Stub
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
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
+#include "qemu-common.h"
+#include "exec/gdbstub.h"
+#include "cpu.h"
+
+int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (n < 32) {
+        return gdb_get_regl(mem_buf, env->gpr[n]);
+    } else if (n == 32) {
+        return gdb_get_regl(mem_buf, env->pc);
+    } else if (n < 65) {
+        return gdb_get_reg64(mem_buf, env->fpr[n - 33]);
+    }
+    return 0;
+}
+
+int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (n == 0) {
+        /* discard writes to x0 */
+        return sizeof(target_ulong);
+    } else if (n < 32) {
+        env->gpr[n] = ldtul_p(mem_buf);
+        return sizeof(target_ulong);
+    } else if (n == 32) {
+        env->pc = ldtul_p(mem_buf);
+        return sizeof(target_ulong);
+    } else if (n < 65) {
+        env->fpr[n - 33] = ldq_p(mem_buf); /* always 64-bit */
+        return sizeof(uint64_t);
+    }
+    return 0;
+}
-- 
2.7.0
