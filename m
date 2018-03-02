Received: from eggs.gnu.org ([2001:4830:134:3::10]:58428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erl7t-00076j-Sj
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1erl7s-000267-Ut
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:53:33 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1erl7s-00025q-OW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:53:32 -0500
Received: by mail-pl0-x244.google.com with SMTP id v9-v6so5722404plp.12
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:53:32 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Sat,  3 Mar 2018 02:51:35 +1300
Message-Id: <1519998711-73430-8-git-send-email-mjc@sifive.com>
In-Reply-To: <1519998711-73430-1-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 07/23] RISC-V GDB Stub
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
Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/gdbstub.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 target/riscv/gdbstub.c

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
new file mode 100644
index 0000000..4f919b6
--- /dev/null
+++ b/target/riscv/gdbstub.c
@@ -0,0 +1,62 @@
+/*
+ * RISC-V GDB Server Stub
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
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
+    } else if (n < 4096 + 65) {
+        return gdb_get_regl(mem_buf, csr_read_helper(env, n - 65));
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
+    } else if (n < 4096 + 65) {
+        csr_write_helper(env, ldtul_p(mem_buf), n - 65);
+    }
+    return 0;
+}
-- 
2.7.0
