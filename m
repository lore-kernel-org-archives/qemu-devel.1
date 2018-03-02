Received: from eggs.gnu.org ([2001:4830:134:3::10]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWX-0002nf-ND
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWW-0004om-6F
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWV-0004lz-Tf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:48 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWU-0001KH-Qm
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:09 +0000
Message-Id: <20180302110640.28004-9-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/39] target/arm: Define an IDAU interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In v8M, the Implementation Defined Attribution Unit (IDAU) is
a small piece of hardware typically implemented in the SoC
which provides board or SoC specific security attribution
information for each address that the CPU performs MPU/SAU
checks on. For QEMU, we model this with a QOM interface which
is implemented by the board or SoC object and connected to
the CPU using a link property.

This commit defines the new interface class, adds the link
property to the CPU object, and makes the SAU checking
code call the IDAU interface if one is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-5-peter.maydell@linaro.org
---
 target/arm/cpu.h    |  3 +++
 target/arm/idau.h   | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c    | 15 +++++++++++++
 target/arm/helper.c | 28 +++++++++++++++++++++---
 4 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100644 target/arm/idau.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b9740878b..4710a43110 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -694,6 +694,9 @@ struct ARMCPU {
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
 
+    /* For v8M, pointer to the IDAU interface provided by board/SoC */
+    Object *idau;
+
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
 
diff --git a/target/arm/idau.h b/target/arm/idau.h
new file mode 100644
index 0000000000..cac27b95fa
--- /dev/null
+++ b/target/arm/idau.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU ARM CPU -- interface for the Arm v8M IDAU
+ *
+ * Copyright (c) 2018 Linaro Ltd
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see
+ * <http://www.gnu.org/licenses/gpl-2.0.html>
+ *
+ * In the v8M architecture, the IDAU is a small piece of hardware
+ * typically implemented in the SoC which provides board or SoC
+ * specific security attribution information for each address that
+ * the CPU performs MPU/SAU checks on. For QEMU, we model this with a
+ * QOM interface which is implemented by the board or SoC object and
+ * connected to the CPU using a link property.
+ */
+
+#ifndef TARGET_ARM_IDAU_H
+#define TARGET_ARM_IDAU_H
+
+#include "qom/object.h"
+
+#define TYPE_IDAU_INTERFACE "idau-interface"
+#define IDAU_INTERFACE(obj) \
+    INTERFACE_CHECK(IDAUInterface, (obj), TYPE_IDAU_INTERFACE)
+#define IDAU_INTERFACE_CLASS(class) \
+    OBJECT_CLASS_CHECK(IDAUInterfaceClass, (class), TYPE_IDAU_INTERFACE)
+#define IDAU_INTERFACE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(IDAUInterfaceClass, (obj), TYPE_IDAU_INTERFACE)
+
+typedef struct IDAUInterface {
+    Object parent;
+} IDAUInterface;
+
+#define IREGION_NOTVALID -1
+
+typedef struct IDAUInterfaceClass {
+    InterfaceClass parent;
+
+    /* Check the specified address and return the IDAU security information
+     * for it by filling in iregion, exempt, ns and nsc:
+     *  iregion: IDAU region number, or IREGION_NOTVALID if not valid
+     *  exempt: true if address is exempt from security attribution
+     *  ns: true if the address is NonSecure
+     *  nsc: true if the address is NonSecure-callable
+     */
+    void (*check)(IDAUInterface *ii, uint32_t address, int *iregion,
+                  bool *exempt, bool *ns, bool *nsc);
+} IDAUInterfaceClass;
+
+#endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1b3ae62db6..291ff0b1db 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "target/arm/idau.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
@@ -688,6 +689,13 @@ static void arm_cpu_post_init(Object *obj)
         }
     }
 
+    if (arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
+        object_property_add_link(obj, "idau", TYPE_IDAU_INTERFACE, &cpu->idau,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                                 &error_abort);
+    }
+
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
                              &error_abort);
 }
@@ -1821,11 +1829,18 @@ static const TypeInfo arm_cpu_type_info = {
     .class_init = arm_cpu_class_init,
 };
 
+static const TypeInfo idau_interface_type_info = {
+    .name = TYPE_IDAU_INTERFACE,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(IDAUInterfaceClass),
+};
+
 static void arm_cpu_register_types(void)
 {
     const ARMCPUInfo *info = arm_cpus;
 
     type_register_static(&arm_cpu_type_info);
+    type_register_static(&idau_interface_type_info);
 
     while (info->name) {
         cpu_register(info);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c82f63d440..09893e3f72 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "target/arm/idau.h"
 #include "trace.h"
 #include "cpu.h"
 #include "internals.h"
@@ -9741,19 +9742,32 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
      */
     ARMCPU *cpu = arm_env_get_cpu(env);
     int r;
+    bool idau_exempt = false, idau_ns = true, idau_nsc = true;
+    int idau_region = IREGION_NOTVALID;
 
-    /* TODO: implement IDAU */
+    if (cpu->idau) {
+        IDAUInterfaceClass *iic = IDAU_INTERFACE_GET_CLASS(cpu->idau);
+        IDAUInterface *ii = IDAU_INTERFACE(cpu->idau);
+
+        iic->check(ii, address, &idau_region, &idau_exempt, &idau_ns,
+                   &idau_nsc);
+    }
 
     if (access_type == MMU_INST_FETCH && extract32(address, 28, 4) == 0xf) {
         /* 0xf0000000..0xffffffff is always S for insn fetches */
         return;
     }
 
-    if (v8m_is_sau_exempt(env, address, access_type)) {
+    if (idau_exempt || v8m_is_sau_exempt(env, address, access_type)) {
         sattrs->ns = !regime_is_secure(env, mmu_idx);
         return;
     }
 
+    if (idau_region != IREGION_NOTVALID) {
+        sattrs->irvalid = true;
+        sattrs->iregion = idau_region;
+    }
+
     switch (env->sau.ctrl & 3) {
     case 0: /* SAU.ENABLE == 0, SAU.ALLNS == 0 */
         break;
@@ -9790,7 +9804,15 @@ static void v8m_security_lookup(CPUARMState *env, uint32_t address,
             }
         }
 
-        /* TODO when we support the IDAU then it may override the result here */
+        /* The IDAU will override the SAU lookup results if it specifies
+         * higher security than the SAU does.
+         */
+        if (!idau_ns) {
+            if (sattrs->ns || (!idau_nsc && sattrs->nsc)) {
+                sattrs->ns = false;
+                sattrs->nsc = idau_nsc;
+            }
+        }
         break;
     }
 }
-- 
2.16.2
