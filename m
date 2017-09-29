Received: from eggs.gnu.org ([2001:4830:134:3::10]:35913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9M-0005fb-CF
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm9H-0006U2-Cl
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm9H-0006Th-3W
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:35 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:29 +0800
Message-Id: <20170929033844.26935-8-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 07/22] monitor: move the cur_mon hack deeper
 for QMP
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

In monitor_qmp_read(), we have the hack to temporarily replace the
cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
routine since the Monitor pointer can be passed in to that using the new
JSON Parser opaque field now.

This does not make much sense as a single patch.  However, this will be
a big step for the next patch, when the QMP dispatcher routine will be
split from the QMP parser.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index ebeb54b0d3..f6cd9ba529 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3826,7 +3826,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
 {
     QObject *req, *rsp = NULL, *id = NULL;
     QDict *qdict = NULL;
-    Monitor *mon = cur_mon;
+    Monitor *mon = opaque, *old_mon;
     Error *err = NULL;
 
     req = json_parser_parse_err(tokens, NULL, &err);
@@ -3851,8 +3851,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
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
@@ -3889,13 +3894,9 @@ err_out:
 
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
@@ -3969,7 +3970,7 @@ static void monitor_qmp_event(void *opaque, int event)
         break;
     case CHR_EVENT_CLOSED:
         json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, NULL);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -4119,7 +4120,7 @@ void monitor_init(Chardev *chr, int flags)
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
                                  monitor_qmp_event, NULL, mon, NULL, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, NULL);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
                                  monitor_event, NULL, mon, NULL, true);
-- 
2.13.5
