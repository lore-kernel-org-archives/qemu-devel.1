Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9k-00063v-0f
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9j-0006xd-5z
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm9j-0006xD-08
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:40:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:34 +0800
Message-Id: <20170929033844.26935-13-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 12/22] monitor: let mon_list be tail queue
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

It was QLIST.  I want to use this list to do monitor priority job later,
which need tail insertion ability.  So switching to a tail queue.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 0caf2019c1..7b76dff5ad 100644
--- a/monitor.c
+++ b/monitor.c
@@ -207,7 +207,7 @@ struct Monitor {
     void *password_opaque;
     mon_cmd_t *cmd_table;
     QLIST_HEAD(,mon_fd_t) fds;
-    QLIST_ENTRY(Monitor) entry;
+    QTAILQ_ENTRY(Monitor) entry;
 };
 
 struct MonitorGlobal {
@@ -222,7 +222,7 @@ static struct MonitorGlobal mon_global;
 /* Protects mon_list, monitor_event_state.  */
 static QemuMutex monitor_lock;
 
-static QLIST_HEAD(mon_list, Monitor) mon_list;
+static QTAILQ_HEAD(mon_list, Monitor) mon_list;
 static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
 static int mon_refcount;
 
@@ -423,7 +423,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
     Monitor *mon;
 
     trace_monitor_protocol_event_emit(event, qdict);
-    QLIST_FOREACH(mon, &mon_list, entry) {
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
             && mon->qmp.commands != &qmp_cap_negotiation_commands) {
             monitor_json_emitter(mon, QOBJECT(qdict));
@@ -4204,8 +4204,8 @@ void monitor_cleanup(void)
     iothread_stop(mon_global.mon_io_thread);
 
     qemu_mutex_lock(&monitor_lock);
-    QLIST_FOREACH_SAFE(mon, &mon_list, entry, next) {
-        QLIST_REMOVE(mon, entry);
+    QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
+        QTAILQ_REMOVE(&mon_list, mon, entry);
         monitor_data_destroy(mon);
         g_free(mon);
     }
-- 
2.13.5
