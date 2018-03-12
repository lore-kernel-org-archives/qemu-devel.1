Received: from eggs.gnu.org ([2001:4830:134:3::10]:45342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJZ-0000o3-5u
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJW-0005zs-93
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38334 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJW-0005zX-44
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B27BD8D6D7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:10 -0500
Message-Id: <20180312183628.394722-20-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 19/36] monitor: let mon_list be tail queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Peter Xu <peterx@redhat.com>

It was QLIST.  I want to use this list to do monitor priority job later,
which need tail insertion ability.  So switching to a tail queue.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-9-peterx@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 71d53be1ddd..63b93f83217 100644
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
