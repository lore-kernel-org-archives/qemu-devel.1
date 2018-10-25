Received: from eggs.gnu.org ([2001:4830:134:3::10]:40358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKh-0006hu-Eg
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKg-0000OT-4k
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37891)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKc-0000Dc-JC
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:54 -0400
Message-Id: <20181025172057.20414-46-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 45/48] plugin: lockstep execution support
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
 include/qemu/plugin-api.h |  7 +++++++
 include/qemu/plugin.h     |  5 +++++
 cpus.c                    |  1 +
 plugin.c                  | 35 +++++++++++++++++++++++++++++++++++
 qemu-plugins.symbols      |  3 +++
 5 files changed, 51 insertions(+)

diff --git a/include/qemu/plugin-api.h b/include/qemu/plugin-api.h
index 076353a2d2..5062e20e08 100644
--- a/include/qemu/plugin-api.h
+++ b/include/qemu/plugin-api.h
@@ -227,6 +227,13 @@ typedef int64_t (*qemu_plugin_clock_func_t)(void);
 bool qemu_plugin_register_virtual_clock(qemu_plugin_id_t id,
                                         qemu_plugin_clock_func_t clock);
 
+void qemu_plugin_enable_lockstep_execution(void);
+
+void qemu_plugin_register_lockstep_cb(qemu_plugin_id_t id,
+                                      qemu_plugin_simple_cb_t cb);
+
+void qemu_plugin_end_time_slice(void);
+
 /* returns -1 in user-mode */
 int qemu_plugin_n_vcpus(void);
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 617161329f..c19071bdbe 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -58,6 +58,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_RESUME,
     QEMU_PLUGIN_EV_VCPU_SYSCALL,
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
+    QEMU_PLUGIN_EV_LOCKSTEP,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
     QEMU_PLUGIN_EV_MAX,
@@ -194,6 +195,7 @@ void qemu_plugin_atexit_cb(void);
 
 void qemu_plugin_add_dyn_cb_arr(struct qemu_plugin_dyn_cb_arr *arr);
 int64_t plugin_get_clock(void);
+void plugin_lockstep_cb(void);
 
 #else /* !CONFIG_PLUGINS */
 
@@ -237,6 +239,9 @@ static inline
 void qemu_plugin_add_dyn_cb_arr(struct qemu_plugin_dyn_cb_arr *arr)
 { }
 
+static inline void plugin_lockstep_cb(void)
+{ }
+
 int64_t plugin_get_clock(void);
 
 #endif /* !CONFIG_PLUGINS */
diff --git a/cpus.c b/cpus.c
index a446632a5c..8f490d1b11 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1359,6 +1359,7 @@ static void lockstep_check_stop(CPUState *cpu)
             /* wake up all waiting cpus */
             lockstep_ongoing_wakeup = true;
             n_lockstep_running_cpus = n_lockstep_cpus;
+            plugin_lockstep_cb();
             qemu_mutex_unlock(&lockstep_lock);
             cpu_mutex_unlock(cpu);
             for (i = 0; i < n_lockstep_cpus; i++) {
diff --git a/plugin.c b/plugin.c
index 291767f2bb..117f303249 100644
--- a/plugin.c
+++ b/plugin.c
@@ -472,6 +472,7 @@ static void plugin_cb__simple(enum qemu_plugin_event ev)
 
     switch (ev) {
     case QEMU_PLUGIN_EV_FLUSH:
+    case QEMU_PLUGIN_EV_LOCKSTEP:
         QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
             qemu_plugin_simple_cb_t func = cb->f.simple;
 
@@ -1043,6 +1044,40 @@ int64_t plugin_get_clock(void)
 }
 #endif
 
+/*
+ * We manage the CPU state changes; the plugin will control the length of the
+ * execution windows.
+ */
+void qemu_plugin_enable_lockstep_execution(void)
+{
+#ifdef CONFIG_USER_ONLY
+    abort();
+#else
+    cpu_lockstep_enable();
+#endif
+}
+
+void qemu_plugin_end_time_slice(void)
+{
+#ifdef CONFIG_USER_ONLY
+    abort();
+#else
+    g_assert(current_cpu);
+    cpu_lockstep_request_stop(current_cpu);
+#endif
+}
+
+void qemu_plugin_register_lockstep_cb(qemu_plugin_id_t id,
+                                      qemu_plugin_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_LOCKSTEP, cb);
+}
+
+void plugin_lockstep_cb(void)
+{
+    plugin_cb__simple(QEMU_PLUGIN_EV_LOCKSTEP);
+}
+
 static void __attribute__((__constructor__)) plugin_init(void)
 {
     int i;
diff --git a/qemu-plugins.symbols b/qemu-plugins.symbols
index 93587b07e1..a3268a40c7 100644
--- a/qemu-plugins.symbols
+++ b/qemu-plugins.symbols
@@ -1,5 +1,8 @@
 {
   qemu_plugin_uninstall;
+  qemu_plugin_enable_lockstep_execution;
+  qemu_plugin_end_time_slice;
+  qemu_plugin_register_lockstep_cb;
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_exit_cb;
   qemu_plugin_register_vcpu_idle_cb;
-- 
2.17.1
