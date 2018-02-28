Received: from eggs.gnu.org ([2001:4830:134:3::10]:54144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1X-0003DM-9N
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1erA1T-00036o-Vb
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:31 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1erA1T-00034s-GT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:16:27 -0500
Received: by mail-lf0-x242.google.com with SMTP id q69so5856931lfi.10
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:16:27 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 14:16:01 -0800
Message-Id: <20180228221609.11265-4-jcmvbkbc@gmail.com>
In-Reply-To: <20180228221609.11265-1-jcmvbkbc@gmail.com>
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 03/11] target/xtensa: use correct number of
 registers in gdbstub
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

System emulation should provide access to all registers, userspace
emulation should only provide access to unprivileged registers.
Record register flags from GDB register map definition, calculate both
num_regs and num_core_regs if either is zero. Use num_regs in system
emulation, num_core_regs in userspace emulation gdbstub.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          |  1 +
 target/xtensa/gdbstub.c      | 14 ++++++++++++--
 target/xtensa/helper.c       | 28 ++++++++++++++++++++--------
 target/xtensa/overlay_tool.h | 11 ++++++++---
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 49c2e3cf9a1b..255cc9e08ed9 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -310,6 +310,7 @@ typedef struct xtensa_tlb {
 
 typedef struct XtensaGdbReg {
     int targno;
+    unsigned flags;
     int type;
     int group;
     unsigned size;
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index d78a1b437dbf..a8ea98d03fb8 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -28,9 +28,14 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
+#ifdef CONFIG_USER_ONLY
+    int num_regs = env->config->gdb_regmap.num_core_regs;
+#else
+    int num_regs = env->config->gdb_regmap.num_regs;
+#endif
     unsigned i;
 
-    if (n < 0 || n >= env->config->gdb_regmap.num_regs) {
+    if (n < 0 || n >= num_regs) {
         return 0;
     }
 
@@ -81,8 +86,13 @@ int xtensa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUXtensaState *env = &cpu->env;
     uint32_t tmp;
     const XtensaGdbReg *reg = env->config->gdb_regmap.reg + n;
+#ifdef CONFIG_USER_ONLY
+    int num_regs = env->config->gdb_regmap.num_core_regs;
+#else
+    int num_regs = env->config->gdb_regmap.num_regs;
+#endif
 
-    if (n < 0 || n >= env->config->gdb_regmap.num_regs) {
+    if (n < 0 || n >= num_regs) {
         return 0;
     }
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5009fecedcb0..34885038d554 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -88,19 +88,31 @@ static void init_libisa(XtensaConfig *config)
 
 void xtensa_finalize_config(XtensaConfig *config)
 {
-    unsigned i, n = 0;
-
     if (config->isa_internal) {
         init_libisa(config);
     }
-    if (config->gdb_regmap.num_regs) {
-        return;
-    }
 
-    for (i = 0; config->gdb_regmap.reg[i].targno >= 0; ++i) {
-        n += (config->gdb_regmap.reg[i].type != 6);
+    if (config->gdb_regmap.num_regs == 0 ||
+        config->gdb_regmap.num_core_regs == 0) {
+        unsigned i;
+        unsigned n_regs = 0;
+        unsigned n_core_regs = 0;
+
+        for (i = 0; config->gdb_regmap.reg[i].targno >= 0; ++i) {
+            if (config->gdb_regmap.reg[i].type != 6) {
+                ++n_regs;
+                if ((config->gdb_regmap.reg[i].flags & 0x1) == 0) {
+                    ++n_core_regs;
+                }
+            }
+        }
+        if (config->gdb_regmap.num_regs == 0) {
+            config->gdb_regmap.num_regs = n_regs;
+        }
+        if (config->gdb_regmap.num_core_regs == 0) {
+            config->gdb_regmap.num_core_regs = n_core_regs;
+        }
     }
-    config->gdb_regmap.num_regs = n;
 }
 
 void xtensa_register_core(XtensaConfigList *node)
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 589dd6285089..b24ad11fec1c 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -25,9 +25,14 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#define XTREG(idx, ofs, bi, sz, al, no, flags, cp, typ, grp, name, \
-        a1, a2, a3, a4, a5, a6) \
-    { .targno = (no), .type = (typ), .group = (grp), .size = (sz) },
+#define XTREG(idx, ofs, bi, sz, al, no, fl, cp, typ, grp, name, \
+              a1, a2, a3, a4, a5, a6) { \
+    .targno = (no), \
+    .flags = (fl), \
+    .type = (typ), \
+    .group = (grp), \
+    .size = (sz), \
+},
 #define XTREG_END { .targno = -1 },
 
 #ifndef XCHAL_HAVE_DEPBITS
-- 
2.11.0
