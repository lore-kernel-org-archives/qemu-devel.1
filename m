Received: from eggs.gnu.org ([2001:4830:134:3::10]:56891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMK-0000N7-21
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgVMF-0003ag-Qo
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51142
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgVMF-0003aS-KR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:45:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MBi364095008
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:18 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28s9xg88ff-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:45:18 -0500
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 17:15:15 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 17:14:34 +0530
In-Reply-To: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1487763883-4877-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 01/10] target/ppc: move cpu_[read,
 write]_xer to cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
2.7.4
