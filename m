Received: from eggs.gnu.org ([2001:4830:134:3::10]:41693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDtd-0007w1-Gk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDtc-000810-ML
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDtc-00080q-I6
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:00 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 16:59:51 +0800
Message-Id: <20180309090006.10018-9-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 08/23] monitor: let mon_list be tail queue
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

It was QLIST.  I want to use this list to do monitor priority job later,
which need tail insertion ability.  So switching to a tail queue.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 16713b7c6d..5d10642b75 100644
--- a/monitor.c
+++ b/monitor.c
@@ -207,7 +207,7 @@ struct Monitor {
     void *password_opaque;
     mon_cmd_t *cmd_table;
     QLIST_HEAD(,mon_fd_t) fds;
-    QLIST_ENTRY(Monitor) entry;
+    QTAILQ_ENTRY(Monitor) entry;
 };
 
 /* QMP checker flags */
@@ -216,7 +216,7 @@ struct Monitor {
 /* Protects mon_list, monitor_event_state.  */
 static QemuMutex monitor_lock;
 
-static QLIST_HEAD(mon_list, Monitor) mon_list;
+static QTAILQ_HEAD(mon_list, Monitor) mon_list;
 static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
 static int mon_refcount;
 
@@ -417,7 +417,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
     Monitor *mon;
 
     trace_monitor_protocol_event_emit(event, qdict);
-    QLIST_FOREACH(mon, &mon_list, entry) {
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
             && mon->qmp.commands != &qmp_cap_negotiation_commands) {
             monitor_json_emitter(mon, QOBJECT(qdict));
@@ -4060,7 +4060,7 @@ void monitor_init(Chardev *chr, int flags)
     }
 
     qemu_mutex_lock(&monitor_lock);
-    QLIST_INSERT_HEAD(&mon_list, mon, entry);
+    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
     qemu_mutex_unlock(&monitor_lock);
 }
 
@@ -4069,8 +4069,8 @@ void monitor_cleanup(void)
     Monitor *mon, *next;
 
     qemu_mutex_lock(&monitor_lock);
-    QLIST_FOREACH_SAFE(mon, &mon_list, entry, next) {
-        QLIST_REMOVE(mon, entry);
+    QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
+        QTAILQ_REMOVE(&mon_list, mon, entry);
         monitor_data_destroy(mon);
         g_free(mon);
     }
-- 
2.14.3
