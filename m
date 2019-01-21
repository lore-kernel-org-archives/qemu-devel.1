Received: from eggs.gnu.org ([209.51.188.92]:45055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRS-0006dl-Te
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRQ-0004Gs-O3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:42 -0500
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:42034)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1glZRK-00043D-NG
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:16:36 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 21 Jan 2019 22:15:54 +0900
Message-Id: <20190121131602.55003-4-ysato@users.sourceforge.jp>
In-Reply-To: <20190121131602.55003-1-ysato@users.sourceforge.jp>
References: <20190121131602.55003-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC 03/11] TCG helper functions
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
 target/rx/helper.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 target/rx/helper.c

diff --git a/target/rx/helper.c b/target/rx/helper.c
new file mode 100644
index 0000000000..1d00732c0c
--- /dev/null
+++ b/target/rx/helper.c
@@ -0,0 +1,143 @@
+/*
+ *  RX emulation
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
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
+
+#include "cpu.h"
+#include "exec/log.h"
+#include "exec/cpu_ldst.h"
+#include "sysemu/sysemu.h"
+
+void rx_cpu_do_interrupt(CPUState *cs)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int do_irq = cs->interrupt_request &
+        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SOFT | CPU_INTERRUPT_FIR);
+    int irq_vector = -1;
+
+    env->in_sleep = 0;
+
+    if (do_irq & CPU_INTERRUPT_HARD) {
+        irq_vector = env->irq;
+        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+    }
+    if (irq_vector == -1 && do_irq & CPU_INTERRUPT_SOFT) {
+        irq_vector = env->sirq;
+        cs->interrupt_request &= ~CPU_INTERRUPT_SOFT;
+    }
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        if (cs->exception_index < 0x100) {
+            const char *expname;
+            switch (cs->exception_index) {
+            case 20:
+                expname = "previlage_violation";
+                break;
+            case 21:
+                expname = "access_exception";
+                break;
+            case 23:
+                expname = "illegal_instruction";
+                break;
+            case 25:
+                expname = "fpu_exception";
+                break;
+            case 30:
+                expname = "NMI_interrupt";
+                break;
+            }
+            qemu_log("exception 0x%02x [%s] raised\n",
+                     cs->exception_index, expname);
+        } else {
+            if (do_irq & CPU_INTERRUPT_FIR)
+                qemu_log("fast interrupt raised\n");
+            else
+                qemu_log("interrupt 0x%02x raised\n",
+                         irq_vector);
+        }
+        log_cpu_state(cs, 0);
+    }
+    if (env->psw_u) {
+        env->usp = env->regs[0];
+    } else {
+        env->isp = env->regs[0];
+    }
+    rx_cpu_pack_psw(env);
+    if ((do_irq & CPU_INTERRUPT_FIR) == 0) {
+        env->isp -= 4;
+        cpu_stl_all(env, env->isp, env->psw);
+        env->isp -= 4;
+        cpu_stl_all(env, env->isp, env->pc);
+    } else {
+        env->bpc = env->pc;
+        env->bpsw = env->psw;
+    }
+    env->psw_pm = env->psw_i = env->psw_u = 0;
+    env->regs[0] = env->isp;
+    if (do_irq) {
+        if (do_irq & CPU_INTERRUPT_FIR) {
+            env->pc = env->fintv;
+            env->psw_ipl = 15;
+            cs->interrupt_request &= ~CPU_INTERRUPT_FIR;
+            qemu_set_irq(env->ack, 0);
+            return;
+        } else if (do_irq & CPU_INTERRUPT_HARD) {
+            env->psw_ipl = env->intlevel;
+            qemu_set_irq(env->ack, 0);
+        }
+        env->pc = cpu_ldl_all(env, env->intb + irq_vector * 4);
+        return;
+    } else {
+        uint32_t vec = cs->exception_index;
+        env->pc = cpu_ldl_all(env, 0xffffffc0 + vec * 4);
+        return;
+    }
+}
+
+bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int accept = 0;
+    /* software interrupt */
+    if (interrupt_request & CPU_INTERRUPT_SOFT) {
+        accept = 1;
+    }
+    /* hardware interrupt (Normal) */
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
+        env->psw_i && (env->psw_ipl < env->intlevel)) {
+        accept = 1;
+    }
+    /* hardware interrupt (FIR) */
+    if ((interrupt_request & CPU_INTERRUPT_FIR) &&
+        env->psw_i && (env->psw_ipl < 15)) {
+        accept = 1;
+    }
+    if (accept) {
+        rx_cpu_do_interrupt(cs);
+        return true;
+    }
+    return false;
+}
+
+hwaddr rx_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    return addr;
+}
-- 
2.11.0
