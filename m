Received: from eggs.gnu.org ([2001:4830:134:3::10]:48493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe1e-0004uD-Ah
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe1d-0004Qg-Fr
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:49:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe1d-0004QC-9H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:49:01 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:25 +0800
Message-Id: <20171106094643.14881-10-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 09/27] monitor: let mon_list be tail queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

It was QLIST.  I want to use this list to do monitor priority job later,
which need tail insertion ability.  So switching to a tail queue.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index ac5313023b..a70ab5606b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -205,7 +205,7 @@ struct Monitor {
     void *password_opaque;
     mon_cmd_t *cmd_table;
     QLIST_HEAD(,mon_fd_t) fds;
-    QLIST_ENTRY(Monitor) entry;
+    QTAILQ_ENTRY(Monitor) entry;
 };
 
 /* QMP checker flags */
@@ -214,7 +214,7 @@ struct Monitor {
 /* Protects mon_list, monitor_event_state.  */
 static QemuMutex monitor_lock;
 
-static QLIST_HEAD(mon_list, Monitor) mon_list;
+static QTAILQ_HEAD(mon_list, Monitor) mon_list;
 static QLIST_HEAD(mon_fdsets, MonFdset) mon_fdsets;
 static int mon_refcount;
 
@@ -415,7 +415,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
     Monitor *mon;
 
     trace_monitor_protocol_event_emit(event, qdict);
-    QLIST_FOREACH(mon, &mon_list, entry) {
+    QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (monitor_is_qmp(mon)
             && mon->qmp.commands != &qmp_cap_negotiation_commands) {
             monitor_json_emitter(mon, QOBJECT(qdict));
@@ -4118,8 +4118,8 @@ void monitor_cleanup(void)
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
2.13.5
