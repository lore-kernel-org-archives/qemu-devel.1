Received: from eggs.gnu.org ([209.51.188.92]:45142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRV-0006eL-7B
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRT-0004JC-07
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:45 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:54418)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRQ-00043E-Sa
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:42 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 21 Jan 2019 22:15:55 +0900
Message-Id: <20190121131602.55003-5-ysato@users.sourceforge.jp>
In-Reply-To: <20190121131602.55003-1-ysato@users.sourceforge.jp>
References: <20190121131602.55003-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC 04/11] Target miscellaneous functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/gdbstub.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/monitor.c |  38 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/monitor.c

diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
new file mode 100644
index 0000000000..cd29302f59
--- /dev/null
+++ b/target/rx/gdbstub.c
@@ -0,0 +1,114 @@
+/*
+ * RX gdb server stub
+ *
+ * Copyright (c) 2019 Yoshinori Sato
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/gdbstub.h"
+
+int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+
+    switch (n) {
+    case 0 ... 15:
+        return gdb_get_regl(mem_buf, env->regs[n]);
+    case 16:
+        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
+    case 17:
+        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
+    case 18:
+        rx_cpu_pack_psw(env);
+        return gdb_get_regl(mem_buf, env->psw);
+    case 19:
+        return gdb_get_regl(mem_buf, env->pc);
+    case 20:
+        return gdb_get_regl(mem_buf, env->intb);
+    case 21:
+        return gdb_get_regl(mem_buf, env->bpsw);
+    case 22:
+        return gdb_get_regl(mem_buf, env->bpc);
+    case 23:
+        return gdb_get_regl(mem_buf, env->fintv);
+    case 24:
+        return gdb_get_regl(mem_buf, env->fpsw);
+    case 25:
+        return 0;
+    }
+    return 0;
+}
+
+int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+
+    switch (n) {
+    case 0 ... 15:
+        env->regs[n] = ldl_p(mem_buf);
+        if (n == 0) {
+            if (env->psw_u) {
+                env->usp = env->regs[0];
+            } else {
+                env->isp = env->regs[0];
+            }
+        }
+        break;
+    case 16:
+        env->usp = ldl_p(mem_buf);
+        if (env->psw_u) {
+            env->regs[0] = ldl_p(mem_buf);
+        }
+        break;
+    case 17:
+        env->isp = ldl_p(mem_buf);
+        if (!env->psw_u) {
+            env->regs[0] = ldl_p(mem_buf);
+        }
+        break;
+    case 18:
+        env->psw = ldl_p(mem_buf);
+        rx_cpu_unpack_psw(env, 1);
+        break;
+    case 19:
+        env->pc = ldl_p(mem_buf);
+        break;
+    case 20:
+        env->intb = ldl_p(mem_buf);
+        break;
+    case 21:
+        env->bpsw = ldl_p(mem_buf);
+        break;
+    case 22:
+        env->bpc = ldl_p(mem_buf);
+        break;
+    case 23:
+        env->fintv = ldl_p(mem_buf);
+        break;
+    case 24:
+        env->fpsw = ldl_p(mem_buf);
+        break;
+    case 25:
+        return 8;
+    default:
+        return 0;
+    }
+
+    return 4;
+}
diff --git a/target/rx/monitor.c b/target/rx/monitor.c
new file mode 100644
index 0000000000..5d7a1e58b5
--- /dev/null
+++ b/target/rx/monitor.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "hmp.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env = mon_get_cpu_env();
+
+    if (!env) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+}
-- 
2.11.0
