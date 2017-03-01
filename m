Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7f-0007ty-56
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7e-0008Rv-1S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:16 +1100
Message-Id: <20170301044405.1792-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/50] target/ppc: move cpu_[read,
 write]_xer to cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/Makefile.objs |  1 +
 target/ppc/cpu.c         | 36 ++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h         | 14 ++------------
 3 files changed, 39 insertions(+), 12 deletions(-)
 create mode 100644 target/ppc/cpu.c

diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
index a8c7a30..4f4168f 100644
--- a/target/ppc/Makefile.objs
+++ b/target/ppc/Makefile.objs
@@ -1,4 +1,5 @@
 obj-y += cpu-models.o
+obj-y += cpu.o
 obj-y += translate.o
 ifeq ($(CONFIG_SOFTMMU),y)
 obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
new file mode 100644
index 0000000..de3004b
--- /dev/null
+++ b/target/ppc/cpu.c
@@ -0,0 +1,36 @@
+/*
+ *  PowerPC CPU routines for qemu.
+ *
+ * Copyright (c) 2017 Nikunj A Dadhania, IBM Corporation.
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
+#include "cpu.h"
+#include "cpu-models.h"
+
+target_ulong cpu_read_xer(CPUPPCState *env)
+{
+    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) |
+        (env->ca << XER_CA);
+}
+
+void cpu_write_xer(CPUPPCState *env, target_ulong xer)
+{
+    env->so = (xer >> XER_SO) & 1;
+    env->ov = (xer >> XER_OV) & 1;
+    env->ca = (xer >> XER_CA) & 1;
+    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
+}
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 425e79d..b559b67 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2343,18 +2343,8 @@ enum {
 
 /*****************************************************************************/
 
-static inline target_ulong cpu_read_xer(CPUPPCState *env)
-{
-    return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) | (env->ca << XER_CA);
-}
-
-static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
-{
-    env->so = (xer >> XER_SO) & 1;
-    env->ov = (xer >> XER_OV) & 1;
-    env->ca = (xer >> XER_CA) & 1;
-    env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
-}
+target_ulong cpu_read_xer(CPUPPCState *env);
+void cpu_write_xer(CPUPPCState *env, target_ulong xer);
 
 static inline void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
-- 
2.9.3
