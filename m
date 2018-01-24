Received: from eggs.gnu.org ([2001:4830:134:3::10]:55812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDnx-0001Lp-Co
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeDnw-0007FL-Ez
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:41:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeDnw-0007EK-9E
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 00:41:00 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 24 Jan 2018 13:39:40 +0800
Message-Id: <20180124053957.29145-7-peterx@redhat.com>
In-Reply-To: <20180124053957.29145-1-peterx@redhat.com>
References: <20180124053957.29145-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 06/23] monitor: move the cur_mon hack deeper
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
index 3a28a6d935..253be6871a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3811,7 +3811,9 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
     QObject *req, *rsp = NULL, *id = NULL;
     QDict *qdict = NULL;
-    Monitor *mon = cur_mon;
+    MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
+    Monitor *old_mon, *mon = container_of(mon_qmp, Monitor, qmp);
+
     Error *err = NULL;
 
     req = json_parser_parse_err(tokens, NULL, &err);
@@ -3836,8 +3838,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
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
@@ -3874,13 +3881,9 @@ err_out:
 
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
