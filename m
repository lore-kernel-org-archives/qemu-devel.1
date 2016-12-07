Received: from eggs.gnu.org ([2001:4830:134:3::10]:60706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEdXV-0007Cf-1V
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEdXQ-0001WE-5v
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:49:45 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:37466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEdXQ-0001W4-0U
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:49:40 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cEdXO-0002Zo-UJ from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:49:39 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Wed, 7 Dec 2016 06:49:23 -0800
Message-ID: <b26ad55255a5ce744d2efda4773a2dc1a298a3a2.1481121503.git.julian@codesourcery.com>
In-Reply-To: <cover.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/6] ARM big-endian system-mode gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When debugging a big-endian (either BE8 or BE32) executable, GDB uses
a big-endian byte ordering for its remote protocol.  The gdb stub
code in QEMU needs to interpret data in host (little-endian) order in
arm_cpu_gdb_read_register and arm_cpu_gdb_write_register, so this patch
arranges to byte-swap the data to/from GDB in those cases.

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 target-arm/gdbstub.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target-arm/gdbstub.c b/target-arm/gdbstub.c
index 04c1208..1e9fe68 100644
--- a/target-arm/gdbstub.c
+++ b/target-arm/gdbstub.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
+#include "exec/softmmu-arm-semi.h"
 
 /* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
    whatever the target description contains.  Due to a historical mishap
@@ -32,10 +33,22 @@ int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+#ifndef CONFIG_USER_ONLY
+    bool targ_bigendian = arm_bswap_needed(env);
+#endif
 
     if (n < 16) {
         /* Core integer register.  */
+#ifdef CONFIG_USER_ONLY
         return gdb_get_reg32(mem_buf, env->regs[n]);
+#else
+        if (targ_bigendian) {
+            stl_be_p(mem_buf, env->regs[n]);
+        } else {
+            stl_le_p(mem_buf, env->regs[n]);
+        }
+        return 4;
+#endif
     }
     if (n < 24) {
         /* FPA registers.  */
@@ -51,10 +64,28 @@ int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
         if (gdb_has_xml) {
             return 0;
         }
+#ifdef CONFIG_USER_ONLY
         return gdb_get_reg32(mem_buf, 0);
+#else
+        if (targ_bigendian) {
+            stl_be_p(mem_buf, 0);
+        } else {
+            stl_le_p(mem_buf, 0);
+        }
+        return 4;
+#endif
     case 25:
         /* CPSR */
+#ifdef CONFIG_USER_ONLY
         return gdb_get_reg32(mem_buf, cpsr_read(env));
+#else
+        if (targ_bigendian) {
+            stl_be_p(mem_buf, cpsr_read(env));
+        } else {
+            stl_le_p(mem_buf, cpsr_read(env));
+        }
+        return 4;
+#endif
     }
     /* Unknown register.  */
     return 0;
@@ -65,8 +96,19 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     uint32_t tmp;
+#ifndef CONFIG_USER_ONLY
+    bool targ_bigendian = arm_bswap_needed(env);
+#endif
 
+#ifdef CONFIG_USER_ONLY
     tmp = ldl_p(mem_buf);
+#else
+    if (targ_bigendian) {
+        tmp = ldl_be_p(mem_buf);
+    } else {
+        tmp = ldl_le_p(mem_buf);
+    }
+#endif
 
     /* Mask out low bit of PC to workaround gdb bugs.  This will probably
        cause problems if we ever implement the Jazelle DBX extensions.  */
-- 
2.8.1
