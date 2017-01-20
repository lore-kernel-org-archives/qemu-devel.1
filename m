Received: from eggs.gnu.org ([2001:4830:134:3::10]:42763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc73-0002BS-C4
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc72-0004yP-4c
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:29 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc71-0004xy-Uh
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:28 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc70-0005ZJ-SP from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:27 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:32:07 -0800
Message-ID: <3787ef677853c10ae60beb867c4b3d170391ad2d.1484929304.git.julian@codesourcery.com>
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/7] ARM big-endian system-mode gdbstub
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
 target/arm/gdbstub.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 04c1208..1e9fe68 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
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
