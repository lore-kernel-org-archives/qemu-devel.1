Received: from eggs.gnu.org ([2001:4830:134:3::10]:42182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1frZWH-0000PC-VS
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1frZWF-0003J2-Vq
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:02:13 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1frZWD-0003GI-HL
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:02:10 -0400
Received: by mail-lj1-x234.google.com with SMTP id w16-v6so10329521ljh.12
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 19:02:07 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 19 Aug 2018 19:01:34 -0700
Message-Id: <20180820020134.4032-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] target/xtensa: clean up gdbstub register
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

- move register counting to xtensa/gdbstub.c
- add symbolic names for register types and flags from GDB and use them
  in register counting and access functions.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- add missing dereference to the n_regs/n_core_regs in xtensa_count_regs

 target/xtensa/cpu.h     |  2 ++
 target/xtensa/gdbstub.c | 60 +++++++++++++++++++++++++++++++++++++++----------
 target/xtensa/helper.c  | 12 +---------
 3 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 51b455146494..7472cf3ca32a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -503,6 +503,8 @@ void xtensa_cpu_do_unassigned_access(CPUState *cpu, hwaddr addr,
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f,
                            fprintf_function cpu_fprintf, int flags);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+void xtensa_count_regs(const XtensaConfig *config,
+                       unsigned *n_regs, unsigned *n_core_regs);
 int xtensa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index a8ea98d03fb8..c9450914c72d 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -23,6 +23,42 @@
 #include "exec/gdbstub.h"
 #include "qemu/log.h"
 
+enum {
+  xtRegisterTypeArRegfile = 1,  /* Register File ar0..arXX.  */
+  xtRegisterTypeSpecialReg,     /* CPU states, such as PS, Booleans, (rsr).  */
+  xtRegisterTypeUserReg,        /* User defined registers (rur).  */
+  xtRegisterTypeTieRegfile,     /* User define register files.  */
+  xtRegisterTypeTieState,       /* TIE States (mapped on user regs).  */
+  xtRegisterTypeMapped,         /* Mapped on Special Registers.  */
+  xtRegisterTypeUnmapped,       /* Special case of masked registers.  */
+  xtRegisterTypeWindow,         /* Live window registers (a0..a15).  */
+  xtRegisterTypeVirtual,        /* PC, FP.  */
+  xtRegisterTypeUnknown
+};
+
+#define XTENSA_REGISTER_FLAGS_PRIVILEGED        0x0001
+#define XTENSA_REGISTER_FLAGS_READABLE          0x0002
+#define XTENSA_REGISTER_FLAGS_WRITABLE          0x0004
+#define XTENSA_REGISTER_FLAGS_VOLATILE          0x0008
+
+void xtensa_count_regs(const XtensaConfig *config,
+                       unsigned *n_regs, unsigned *n_core_regs)
+{
+    unsigned i;
+
+    for (i = 0; config->gdb_regmap.reg[i].targno >= 0; ++i) {
+        if (config->gdb_regmap.reg[i].type != xtRegisterTypeTieState &&
+            config->gdb_regmap.reg[i].type != xtRegisterTypeMapped &&
+            config->gdb_regmap.reg[i].type != xtRegisterTypeUnmapped) {
+            ++*n_regs;
+            if ((config->gdb_regmap.reg[i].flags &
+                 XTENSA_REGISTER_FLAGS_PRIVILEGED) == 0) {
+                ++*n_core_regs;
+            }
+        }
+    }
+}
+
 int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
@@ -40,21 +76,21 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
 
     switch (reg->type) {
-    case 9: /*pc*/
+    case xtRegisterTypeVirtual: /*pc*/
         return gdb_get_reg32(mem_buf, env->pc);
 
-    case 1: /*ar*/
+    case xtRegisterTypeArRegfile: /*ar*/
         xtensa_sync_phys_from_window(env);
         return gdb_get_reg32(mem_buf, env->phys_regs[(reg->targno & 0xff)
                                                      % env->config->nareg]);
 
-    case 2: /*SR*/
+    case xtRegisterTypeSpecialReg: /*SR*/
         return gdb_get_reg32(mem_buf, env->sregs[reg->targno & 0xff]);
 
-    case 3: /*UR*/
+    case xtRegisterTypeUserReg: /*UR*/
         return gdb_get_reg32(mem_buf, env->uregs[reg->targno & 0xff]);
 
-    case 4: /*f*/
+    case xtRegisterTypeTieRegfile: /*f*/
         i = reg->targno & 0x0f;
         switch (reg->size) {
         case 4:
@@ -69,7 +105,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
             return reg->size;
         }
 
-    case 8: /*a*/
+    case xtRegisterTypeWindow: /*a*/
         return gdb_get_reg32(mem_buf, env->regs[reg->targno & 0x0f]);
 
     default:
@@ -99,24 +135,24 @@ int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     tmp = ldl_p(mem_buf);
 
     switch (reg->type) {
-    case 9: /*pc*/
+    case xtRegisterTypeVirtual: /*pc*/
         env->pc = tmp;
         break;
 
-    case 1: /*ar*/
+    case xtRegisterTypeArRegfile: /*ar*/
         env->phys_regs[(reg->targno & 0xff) % env->config->nareg] = tmp;
         xtensa_sync_window_from_phys(env);
         break;
 
-    case 2: /*SR*/
+    case xtRegisterTypeSpecialReg: /*SR*/
         env->sregs[reg->targno & 0xff] = tmp;
         break;
 
-    case 3: /*UR*/
+    case xtRegisterTypeUserReg: /*UR*/
         env->uregs[reg->targno & 0xff] = tmp;
         break;
 
-    case 4: /*f*/
+    case xtRegisterTypeTieRegfile: /*f*/
         switch (reg->size) {
         case 4:
             env->fregs[reg->targno & 0x0f].f32[FP_F32_LOW] = make_float32(tmp);
@@ -130,7 +166,7 @@ int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return reg->size;
         }
 
-    case 8: /*a*/
+    case xtRegisterTypeWindow: /*a*/
         env->regs[reg->targno & 0x0f] = tmp;
         break;
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index efb3cef12813..f74636f67854 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -95,20 +95,10 @@ void xtensa_finalize_config(XtensaConfig *config)
 
     if (config->gdb_regmap.num_regs == 0 ||
         config->gdb_regmap.num_core_regs == 0) {
-        unsigned i;
         unsigned n_regs = 0;
         unsigned n_core_regs = 0;
 
-        for (i = 0; config->gdb_regmap.reg[i].targno >= 0; ++i) {
-            if (config->gdb_regmap.reg[i].type != 5 &&
-                config->gdb_regmap.reg[i].type != 6 &&
-                config->gdb_regmap.reg[i].type != 7) {
-                ++n_regs;
-                if ((config->gdb_regmap.reg[i].flags & 0x1) == 0) {
-                    ++n_core_regs;
-                }
-            }
-        }
+        xtensa_count_regs(config, &n_regs, &n_core_regs);
         if (config->gdb_regmap.num_regs == 0) {
             config->gdb_regmap.num_regs = n_regs;
         }
-- 
2.11.0
