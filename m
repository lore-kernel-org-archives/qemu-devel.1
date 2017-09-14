Received: from eggs.gnu.org ([2001:4830:134:3::10]:52160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOw5-0006n8-Mw
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOw2-0007Fe-Ih
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOw2-0007F0-AG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:42 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:29 +0800
Message-Id: <1505375436-28439-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 08/15] monitor: create IO thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Create one IO thread for the monitors, prepared to handle all the
input/output IOs.  Only adding the thread, loop and context, but doing
nothing else yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/monitor.c b/monitor.c
index 7bd2e90..9e9a32e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -208,6 +208,14 @@ struct Monitor {
     QLIST_ENTRY(Monitor) entry;
 };
 
+struct MonitorGlobal {
+    QemuThread mon_io_thread;
+    GMainContext *mon_context;
+    GMainLoop *mon_loop;
+};
+
+static struct MonitorGlobal mon_global;
+
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
 
@@ -4043,12 +4051,32 @@ static void sortcmdlist(void)
     qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
 }
 
+static void *monitor_io_thread(void *data)
+{
+    rcu_register_thread();
+
+    g_main_loop_run(mon_global.mon_loop);
+
+    rcu_unregister_thread();
+
+    return NULL;
+}
+
+static void monitor_io_thread_init(void)
+{
+    mon_global.mon_context = g_main_context_new();
+    mon_global.mon_loop = g_main_loop_new(mon_global.mon_context, TRUE);
+    qemu_thread_create(&mon_global.mon_io_thread, "mon-io-thr",
+                       monitor_io_thread, NULL, QEMU_THREAD_JOINABLE);
+}
+
 void monitor_init_globals(void)
 {
     monitor_init_qmp_commands();
     monitor_qapi_event_init();
     sortcmdlist();
     qemu_mutex_init(&monitor_lock);
+    monitor_io_thread_init();
 }
 
 /* These functions just adapt the readline interface in a typesafe way.  We
@@ -4122,6 +4150,25 @@ void monitor_init(Chardev *chr, int flags)
     qemu_mutex_unlock(&monitor_lock);
 }
 
+static void monitor_io_thread_destroy(void)
+{
+    /* Notify the monitor IO thread to quit. */
+    g_main_loop_quit(mon_global.mon_loop);
+    /*
+     * Make sure the context will get the quit message since it's in
+     * another thread.  Without this, it may not be able to respond to
+     * the quit message immediately.
+     */
+    g_main_context_wakeup(mon_global.mon_context);
+    qemu_thread_join(&mon_global.mon_io_thread);
+
+    g_main_loop_unref(mon_global.mon_loop);
+    mon_global.mon_loop = NULL;
+
+    g_main_context_unref(mon_global.mon_context);
+    mon_global.mon_context = NULL;
+}
+
 void monitor_cleanup(void)
 {
     Monitor *mon, *next;
@@ -4133,6 +4180,8 @@ void monitor_cleanup(void)
         g_free(mon);
     }
     qemu_mutex_unlock(&monitor_lock);
+
+    monitor_io_thread_destroy();
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.7.4
