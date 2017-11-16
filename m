Received: from eggs.gnu.org ([2001:4830:134:3::10]:38388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJt5-0008HM-O5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsz-000768-Mb
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJsz-00075g-Gb
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:07:17 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:52 +0800
Message-Id: <20171116130610.23582-10-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 09/27] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Create one IOThread for the monitors, prepared to handle all the
input/output IOs using existing iothread framework.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/monitor.c b/monitor.c
index a70ab5606b..4ce9828fab 100644
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
     QTAILQ_ENTRY(Monitor) entry;
 };
 
+struct MonitorGlobal {
+    IOThread *mon_iothread;
+};
+
+static struct MonitorGlobal mon_global;
+
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
 
@@ -4034,12 +4041,24 @@ static void sortcmdlist(void)
     qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
 }
 
+static GMainContext *monitor_io_context_get(void)
+{
+    return iothread_get_g_main_context(mon_global.mon_iothread);
+}
+
+static void monitor_iothread_init(void)
+{
+    mon_global.mon_iothread = iothread_create("monitor_iothread",
+                                              &error_abort);
+}
+
 void monitor_init_globals(void)
 {
     monitor_init_qmp_commands();
     monitor_qapi_event_init();
     sortcmdlist();
     qemu_mutex_init(&monitor_lock);
+    monitor_iothread_init();
 }
 
 /* These functions just adapt the readline interface in a typesafe way.  We
@@ -4117,6 +4136,13 @@ void monitor_cleanup(void)
 {
     Monitor *mon, *next;
 
+    /*
+     * We need to explicitly stop the iothread (but not destroy it),
+     * cleanup the monitor resources, then destroy the iothread.  See
+     * again on the glib bug mentioned in 2b316774f6 for a reason.
+     */
+    iothread_stop(mon_global.mon_iothread);
+
     qemu_mutex_lock(&monitor_lock);
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
@@ -4124,6 +4150,9 @@ void monitor_cleanup(void)
         g_free(mon);
     }
     qemu_mutex_unlock(&monitor_lock);
+
+    iothread_destroy(mon_global.mon_iothread);
+    mon_global.mon_iothread = NULL;
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.13.6
