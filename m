Received: from eggs.gnu.org ([2001:4830:134:3::10]:40455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006j0-Bp
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0000Pr-Pn
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKh-000089-Hj
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:49 -0400
Message-Id: <20181025172057.20414-41-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 40/48] plugin: let plugins control the virtual
 clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/plugin-api.h |  9 +++++
 include/qemu/plugin.h     |  5 +++
 plugin.c                  | 79 +++++++++++++++++++++++++++++++++++++++
 stubs/plugin.c            |  9 +++++
 util/qemu-timer.c         |  3 ++
 qemu-plugins.symbols      |  1 +
 stubs/Makefile.objs       |  1 +
 7 files changed, 107 insertions(+)
 create mode 100644 stubs/plugin.c

diff --git a/include/qemu/plugin-api.h b/include/qemu/plugin-api.h
index 5c6bb45279..076353a2d2 100644
--- a/include/qemu/plugin-api.h
+++ b/include/qemu/plugin-api.h
@@ -218,6 +218,15 @@ void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
+typedef int64_t (*qemu_plugin_clock_func_t)(void);
+
+/*
+ * Can only be called from plugin_init.
+ * Returns true on success
+ */
+bool qemu_plugin_register_virtual_clock(qemu_plugin_id_t id,
+                                        qemu_plugin_clock_func_t clock);
+
 /* returns -1 in user-mode */
 int qemu_plugin_n_vcpus(void);
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 0da0f1b892..617161329f 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -127,6 +127,8 @@ struct qemu_plugin_tb {
     struct qemu_plugin_dyn_cb_arr cbs;
 };
 
+extern bool use_plugin_clock;
+
 static inline void qemu_plugin_insn_append(struct qemu_plugin_insn *insn,
                                            const void *from, size_t size)
 {
@@ -191,6 +193,7 @@ void qemu_plugin_flush_cb(void);
 void qemu_plugin_atexit_cb(void);
 
 void qemu_plugin_add_dyn_cb_arr(struct qemu_plugin_dyn_cb_arr *arr);
+int64_t plugin_get_clock(void);
 
 #else /* !CONFIG_PLUGINS */
 
@@ -234,6 +237,8 @@ static inline
 void qemu_plugin_add_dyn_cb_arr(struct qemu_plugin_dyn_cb_arr *arr)
 { }
 
+int64_t plugin_get_clock(void);
+
 #endif /* !CONFIG_PLUGINS */
 
 #endif /* QEMU_PLUGIN_H */
diff --git a/plugin.c b/plugin.c
index 76609f1da4..291767f2bb 100644
--- a/plugin.c
+++ b/plugin.c
@@ -71,6 +71,13 @@ struct qemu_plugin_state {
      * the code cache is flushed.
      */
     struct qht dyn_cb_arr_ht;
+    /*
+     * We support a single clock reference from plugins. We keep a pointer
+     * to the context of the plugin that provides the reference,
+     * so that we can remove the reference when the plugin is uninstalled.
+     */
+    qemu_plugin_clock_func_t clock_ref;
+    struct qemu_plugin_ctx *clock_ctx;
 };
 
 /*
@@ -104,6 +111,8 @@ QemuOptsList qemu_plugin_opts = {
 typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, int, char **);
 
 static struct qemu_plugin_state plugin;
+bool use_plugin_clock;
+static bool plugin_installing;
 
 static bool plugin_dyn_cb_arr_cmp(const void *ap, const void *bp)
 {
@@ -251,7 +260,9 @@ static int plugin_load(struct qemu_plugin_desc *desc)
     QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
     qemu_rec_mutex_unlock(&plugin.lock);
 
+    plugin_installing = true;
     rc = install(ctx->id, desc->argc, desc->argv);
+    plugin_installing = false;
     if (rc) {
         error_report("%s: qemu_plugin_install returned error code %d",
                      __func__, rc);
@@ -418,6 +429,10 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_uninstall_cb_t cb)
     for (ev = 0; ev < QEMU_PLUGIN_EV_MAX; ev++) {
         plugin_unregister_cb__locked(ctx, ev);
     }
+    if (ctx == plugin.clock_ctx) {
+        atomic_set(&plugin.clock_ref, NULL);
+        plugin.clock_ctx = NULL;
+    }
     qemu_rec_mutex_unlock(&plugin.lock);
 
     /* XXX how to flush when we're not in a vCPU thread? */
@@ -964,6 +979,70 @@ uint64_t qemu_plugin_ram_addr_from_host(void *haddr)
 #endif
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool
+qemu_plugin_register_virtual_clock__locked(qemu_plugin_id_t id,
+                                           qemu_plugin_clock_func_t clock)
+{
+    struct qemu_plugin_ctx *ctx = id_to_ctx__locked(id);
+
+    if (!plugin_installing) {
+        error_report("plugin: can only call %s during plugin installation",
+                     __func__);
+        return false;
+    }
+    if (use_plugin_clock) {
+        error_report("plugin: clock reference already registered");
+        return false;
+    }
+    if (clock == NULL) {
+        error_report("%s: cannot pass NULL clock", __func__);
+        return false;
+    }
+    plugin.clock_ctx = ctx;
+    use_plugin_clock = true;
+    atomic_set(&plugin.clock_ref, clock);
+    return true;
+}
+#endif /* !CONFIG_USER_ONLY */
+
+bool qemu_plugin_register_virtual_clock(qemu_plugin_id_t id,
+                                        qemu_plugin_clock_func_t clock)
+{
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
+    bool ret;
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    ret = qemu_plugin_register_virtual_clock__locked(id, clock);
+    qemu_rec_mutex_unlock(&plugin.lock);
+    return ret;
+#endif
+}
+
+#ifdef CONFIG_USER_ONLY
+int64_t plugin_get_clock(void)
+{
+    abort();
+    return 0;
+}
+#else
+/*
+ * Note: use_plugin_clock might be set, but the plugin providing the clock
+ * might have been uninstalled.
+ */
+int64_t plugin_get_clock(void)
+{
+    qemu_plugin_clock_func_t clock_ref = atomic_read(&plugin.clock_ref);
+
+    if (clock_ref) {
+        return clock_ref();
+    }
+    return cpu_get_clock();
+}
+#endif
+
 static void __attribute__((__constructor__)) plugin_init(void)
 {
     int i;
diff --git a/stubs/plugin.c b/stubs/plugin.c
new file mode 100644
index 0000000000..ab70365652
--- /dev/null
+++ b/stubs/plugin.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+
+bool use_plugin_clock;
+
+int64_t plugin_get_clock(void)
+{
+    abort();
+}
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index eb60d8f73a..d20ab0331c 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/plugin.h"
 #include "qemu/timer.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
@@ -601,6 +602,8 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     case QEMU_CLOCK_VIRTUAL_EXT:
         if (use_icount) {
             return cpu_get_icount();
+        } else if (use_plugin_clock) {
+            return plugin_get_clock();
         } else {
             return cpu_get_clock();
         }
diff --git a/qemu-plugins.symbols b/qemu-plugins.symbols
index 76a57e62bb..93587b07e1 100644
--- a/qemu-plugins.symbols
+++ b/qemu-plugins.symbols
@@ -16,6 +16,7 @@
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_atexit_cb;
+  qemu_plugin_register_virtual_clock;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_vaddr;
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index fbcdc0256d..f32bea429f 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -23,6 +23,7 @@ stub-obj-y += migr-blocker.o
 stub-obj-y += change-state-handler.o
 stub-obj-y += monitor.o
 stub-obj-y += notify-event.o
+stub-obj-y += plugin.o
 stub-obj-y += qtest.o
 stub-obj-y += replay.o
 stub-obj-y += runstate-check.o
-- 
2.17.1
