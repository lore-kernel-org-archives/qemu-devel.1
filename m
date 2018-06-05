Received: from eggs.gnu.org ([2001:4830:134:3::10]:45686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NO-0005jT-5z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NL-0006LZ-10
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:42 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55946)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NK-0006Kt-IG
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:38 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:37 +0300
Message-ID: <152819517756.30857.1862569750260837574.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 4/7] tcg: add instrumenting module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

This is a samples of the instrumenting interface and implementation
of some instruction tracing tasks.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/translator.c    |    5 +++++
 include/qemu/instrument.h |    7 +++++++
 plugins/helper.h          |    1 +
 plugins/plugins.c         |   41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 include/qemu/instrument.h
 create mode 100644 plugins/helper.h

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0f9dca9..48773ac 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "qemu/instrument.h"
 
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
@@ -89,6 +90,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             }
         }
 
+        if (plugins_need_before_insn(db->pc_next, cpu)) {
+            plugins_instrument_before_insn(db->pc_next, cpu);
+        }
+
         /* Disassemble one instruction.  The translate_insn hook should
            update db->pc_next and db->is_jmp to indicate what should be
            done next -- either exiting this loop or locate the start of
diff --git a/include/qemu/instrument.h b/include/qemu/instrument.h
new file mode 100644
index 0000000..e8f279f
--- /dev/null
+++ b/include/qemu/instrument.h
@@ -0,0 +1,7 @@
+#ifndef INSTRUMENT_H
+#define INSTRUMENT_H
+
+bool plugins_need_before_insn(target_ulong pc, CPUState *cpu);
+void plugins_instrument_before_insn(target_ulong pc, CPUState *cpu);
+
+#endif /* INSTRUMENT_H */
diff --git a/plugins/helper.h b/plugins/helper.h
new file mode 100644
index 0000000..007b395
--- /dev/null
+++ b/plugins/helper.h
@@ -0,0 +1 @@
+DEF_HELPER_2(before_insn, void, tl, ptr)
diff --git a/plugins/plugins.c b/plugins/plugins.c
index eabc931..5a08e71 100644
--- a/plugins/plugins.c
+++ b/plugins/plugins.c
@@ -1,8 +1,13 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "cpu.h"
 #include "qemu/error-report.h"
 #include "qemu/plugins.h"
+#include "qemu/instrument.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
 #include "qemu/queue.h"
+#include "qemu/option.h"
 #include <gmodule.h>
 
 typedef bool (*PluginInitFunc)(const char *);
@@ -80,6 +85,40 @@ void qemu_plugin_load(const char *filename, const char *args)
     return;
 }
 
+bool plugins_need_before_insn(target_ulong pc, CPUState *cpu)
+{
+    QemuPluginInfo *info;
+    QLIST_FOREACH(info, &qemu_plugins, next) {
+        if (info->needs_before_insn && info->needs_before_insn(pc, cpu)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+void plugins_instrument_before_insn(target_ulong pc, CPUState *cpu)
+{
+    TCGv t_pc = tcg_const_tl(pc);
+    TCGv_ptr t_cpu = tcg_const_ptr(cpu);
+    /* We will dispatch plugins' callbacks in our own helper below */
+    gen_helper_before_insn(t_pc, t_cpu);
+    tcg_temp_free(t_pc);
+    tcg_temp_free_ptr(t_cpu);
+}
+
+void helper_before_insn(target_ulong pc, void *cpu)
+{
+    QemuPluginInfo *info;
+    QLIST_FOREACH(info, &qemu_plugins, next) {
+        if (info->needs_before_insn && info->needs_before_insn(pc, cpu)) {
+            if (info->before_insn) {
+                info->before_insn(pc, cpu);
+            }
+        }
+    }
+}
+
 void qemu_plugins_init(void)
 {
     QemuPluginInfo *info;
@@ -88,4 +127,6 @@ void qemu_plugins_init(void)
             info->init(info->args);
         }
     }
+
+#include "exec/helper-register.h"
 }
