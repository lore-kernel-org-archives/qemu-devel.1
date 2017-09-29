Received: from eggs.gnu.org ([2001:4830:134:3::10]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9Q-0005kI-U5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9Q-0006f0-2Y
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm9P-0006dn-QW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:44 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:31 +0800
Message-Id: <20170929033844.26935-10-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 09/22] monitor: create monitor dedicate
 iothread
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Create one IO thread for the monitors, prepared to handle all the
input/output IOs using existing iothread framework.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/monitor.c b/monitor.c
index 9a8482a962..b44e1f6c86 100644
--- a/monitor.c
+++ b/monitor.c
@@ -76,6 +76,7 @@
 #include "qmp-introspect.h"
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
+#include "sysemu/iothread.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/dispatch.h"
 
@@ -208,6 +209,12 @@ struct Monitor {
     QLIST_ENTRY(Monitor) entry;
 };
 
+struct MonitorGlobal {
+    IOThread *mon_io_thread;
+};
+
+static struct MonitorGlobal mon_global;
+
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
 
@@ -4047,12 +4054,29 @@ static void sortcmdlist(void)
     qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
 }
 
+static GMainContext *monitor_io_context_get(void)
+{
+    return iothread_get_g_main_context(mon_global.mon_io_thread);
+}
+
+static void monitor_io_thread_init(void)
+{
+    mon_global.mon_io_thread = iothread_create("monitor_io_thr",
+                                               &error_abort);
+    /*
+     * Gcontext in iothread is using lazy init - the first time we
+     * fetch the context we'll have that initialized.
+     */
+    monitor_io_context_get();
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
@@ -4126,10 +4150,23 @@ void monitor_init(Chardev *chr, int flags)
     qemu_mutex_unlock(&monitor_lock);
 }
 
+static void monitor_io_thread_destroy(void)
+{
+    iothread_destroy(mon_global.mon_io_thread);
+    mon_global.mon_io_thread = NULL;
+}
+
 void monitor_cleanup(void)
 {
     Monitor *mon, *next;
 
+    /*
+     * We need to explicitly stop the iothread (but not destroy it),
+     * cleanup the monitor resources, then destroy the iothread.  See
+     * again on the glib bug mentioned in 2b316774f6 for a reason.
+     */
+    iothread_stop(mon_global.mon_io_thread);
+
     qemu_mutex_lock(&monitor_lock);
     QLIST_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QLIST_REMOVE(mon, entry);
@@ -4137,6 +4174,8 @@ void monitor_cleanup(void)
         g_free(mon);
     }
     qemu_mutex_unlock(&monitor_lock);
+
+    monitor_io_thread_destroy();
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.13.5
