Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDtY-0007rA-6N
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDtS-0007wx-Il
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:00:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDtS-0007wg-ER
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:00:50 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 16:59:49 +0800
Message-Id: <20180309090006.10018-7-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 06/23] monitor: move the cur_mon hack deeper
 for QMP
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

In monitor_qmp_read(), we have the hack to temporarily replace the
cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
routine since the Monitor pointer can be actually obtained using
container_of() upon the parser object, just like most of the other JSON
parser users do.

This does not make much sense as a single patch.  However, this will be
a big step for the next patch, when the QMP dispatcher routine will be
split from the QMP parser.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/monitor.c b/monitor.c
index 48645e0e91..2b70294772 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3762,7 +3762,9 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
     QObject *req, *rsp = NULL, *id = NULL;
     QDict *qdict = NULL;
-    Monitor *mon = cur_mon;
+    MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
+    Monitor *old_mon, *mon = container_of(mon_qmp, Monitor, qmp);
+
     Error *err = NULL;
 
     req = json_parser_parse_err(tokens, NULL, &err);
@@ -3787,8 +3789,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         QDECREF(req_json);
     }
 
+    old_mon = cur_mon;
+    cur_mon = mon;
+
     rsp = qmp_dispatch(cur_mon->qmp.commands, req);
 
+    cur_mon = old_mon;
+
     if (mon->qmp.commands == &qmp_cap_negotiation_commands) {
         qdict = qdict_get_qdict(qobject_to_qdict(rsp), "error");
         if (qdict
@@ -3825,13 +3832,9 @@ err_out:
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
-    Monitor *old_mon = cur_mon;
-
-    cur_mon = opaque;
-
-    json_message_parser_feed(&cur_mon->qmp.parser, (const char *) buf, size);
+    Monitor *mon = opaque;
 
-    cur_mon = old_mon;
+    json_message_parser_feed(&mon->qmp.parser, (const char *) buf, size);
 }
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
-- 
2.14.3
