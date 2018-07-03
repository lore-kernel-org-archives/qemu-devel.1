Received: from eggs.gnu.org ([2001:4830:134:3::10]:34398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMz-0002N0-Bf
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMx-0005JW-9W
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMx-0005Hq-2t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CAD9818B126
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A8121C65F
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:09 +0200
Message-Id: <20180703153728.2175-14-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/32] qmp: Revert change to handle_qmp_command
 tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 71da4667db6 "monitor: separate QMP parser and dispatcher" moved
the handle_qmp_command tracepoint from handle_qmp_command() to
monitor_qmp_dispatch_one().  This delays tracing from enqueue time to
dequeue time.  Revert that.  Dequeue remains adequately visible via
tracepoint monitor_qmp_cmd_in_band.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-14-armbru@redhat.com>
---
 monitor.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index 3bf3e68bdc..3cc4b07788 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4184,12 +4184,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 
     g_free(req_obj);
 
-    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
-        QString *req_json = qobject_to_json(req);
-        trace_handle_qmp_command(mon, qstring_get_str(req_json));
-        qobject_unref(req_json);
-    }
-
     old_mon = cur_mon;
     cur_mon = mon;
 
@@ -4283,6 +4277,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
 
+    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
+        QString *req_json = qobject_to_json(req);
+        trace_handle_qmp_command(mon, qstring_get_str(req_json));
+        qobject_unref(req_json);
+    }
+
     /* Check against the request in general layout */
     qdict = qmp_dispatch_check_obj(req, qmp_oob_enabled(mon), &err);
     if (!qdict) {
-- 
2.17.1
