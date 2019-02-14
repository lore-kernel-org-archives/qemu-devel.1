Received: from eggs.gnu.org ([209.51.188.92]:49516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8t-00035F-Vs
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00055Q-Np
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:03 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-0004tI-CZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:01 -0500
Received: by mail-lf1-x144.google.com with SMTP id n23so5807821lfl.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:43 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:48 -0800
Message-Id: <20190214230000.24894-2-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 01/13] target/xtensa: move
 xtensa_finalize_config to xtensa_core_class_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Don't run xtensa_finalize_config at the time of core registration,
instead run it at the CPU class initialization.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h          |  1 -
 target/xtensa/helper.c       | 36 +++++++++++++++++++-----------------
 target/xtensa/overlay_tool.h |  1 -
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index f1861244720e..47d80a59e2f5 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -566,7 +566,6 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 void xtensa_translate_init(void);
 void xtensa_breakpoint_handler(CPUState *cs);
-void xtensa_finalize_config(XtensaConfig *config);
 void xtensa_register_core(XtensaConfigList *node);
 void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 6cf1dbb8a69b..321ca4295521 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -34,22 +34,6 @@
 
 static struct XtensaConfigList *xtensa_cores;
 
-static void xtensa_core_class_init(ObjectClass *oc, void *data)
-{
-    CPUClass *cc = CPU_CLASS(oc);
-    XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
-    const XtensaConfig *config = data;
-
-    xcc->config = config;
-
-    /* Use num_core_regs to see only non-privileged registers in an unmodified
-     * gdb. Use num_regs to see all registers. gdb modification is required
-     * for that: reset bit 0 in the 'flags' field of the registers definitions
-     * in the gdb/xtensa-config.c inside gdb source tree or inside gdb overlay.
-     */
-    cc->gdb_num_core_regs = config->gdb_regmap.num_regs;
-}
-
 static void init_libisa(XtensaConfig *config)
 {
     unsigned i, j;
@@ -91,7 +75,7 @@ static void init_libisa(XtensaConfig *config)
     config->a_regfile = xtensa_regfile_lookup(config->isa, "AR");
 }
 
-void xtensa_finalize_config(XtensaConfig *config)
+static void xtensa_finalize_config(XtensaConfig *config)
 {
     if (config->isa_internal) {
         init_libisa(config);
@@ -112,6 +96,24 @@ void xtensa_finalize_config(XtensaConfig *config)
     }
 }
 
+static void xtensa_core_class_init(ObjectClass *oc, void *data)
+{
+    CPUClass *cc = CPU_CLASS(oc);
+    XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
+    XtensaConfig *config = data;
+
+    xtensa_finalize_config(config);
+    xcc->config = config;
+
+    /*
+     * Use num_core_regs to see only non-privileged registers in an unmodified
+     * gdb. Use num_regs to see all registers. gdb modification is required
+     * for that: reset bit 0 in the 'flags' field of the registers definitions
+     * in the gdb/xtensa-config.c inside gdb source tree or inside gdb overlay.
+     */
+    cc->gdb_num_core_regs = config->gdb_regmap.num_regs;
+}
+
 void xtensa_register_core(XtensaConfigList *node)
 {
     TypeInfo type = {
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 12609a0d0c1e..ea07576bc921 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -377,7 +377,6 @@
         static XtensaConfigList node = { \
             .config = &core, \
         }; \
-        xtensa_finalize_config(&core); \
         xtensa_register_core(&node); \
     }
 #else
-- 
2.11.0
