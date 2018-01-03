Received: from eggs.gnu.org ([2001:4830:134:3::10]:58731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXCd-0005dq-UM
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWXCb-00082q-CW
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:44 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWXCb-000827-6j
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:46:41 -0500
Received: by mail-pl0-x241.google.com with SMTP id z5so130622plo.10
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 16:46:41 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  3 Jan 2018 13:44:11 +1300
Message-Id: <1514940265-18093-8-git-send-email-mjc@sifive.com>
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 07/21] RISC-V GDB Stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

GDB Register read and write routines.

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/gdbstub.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 target/riscv/gdbstub.c

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
new file mode 100644
index 0000000..12d1d9f
--- /dev/null
+++ b/target/riscv/gdbstub.c
@@ -0,0 +1,59 @@
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
+    /* TODO proper x0 handling */
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
+    /* TODO proper x0 handling */
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (n < 32) {
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
