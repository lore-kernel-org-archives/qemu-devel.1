Received: from eggs.gnu.org ([2001:4830:134:3::10]:52026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvu-0006YQ-42
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvq-00071H-Vf
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOvq-00070a-MK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:51:30 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:27 +0800
Message-Id: <1505375436-28439-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-1-git-send-email-peterx@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 06/15] monitor: move the cur_mon hack deeper for
 QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

In monitor_qmp_read(), we have the hack to temporarily replace the
cur_mon pointer.  Now we move this hack deeper inside the QMP dispatcher
routine since the Monitor pointer can be passed in to that using the new
JSON Parser opaque field now.

This does not make much sense as a single patch.  However, this will be
a big step for the next patch, when the QMP dispatcher routine will be
splitted from the QMP parser.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9096b64..d7eb3c2 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3822,7 +3822,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
 {
     QObject *req, *rsp = NULL, *id = NULL;
     QDict *qdict = NULL;
-    Monitor *mon = cur_mon;
+    Monitor *mon = opaque, *old_mon;
     Error *err = NULL;
 
     req = json_parser_parse_err(tokens, NULL, &err);
@@ -3847,8 +3847,13 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
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
@@ -3885,13 +3890,9 @@ err_out:
 
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
@@ -3965,7 +3966,7 @@ static void monitor_qmp_event(void *opaque, int event)
         break;
     case CHR_EVENT_CLOSED:
         json_message_parser_destroy(&mon->qmp.parser);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, NULL);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
@@ -4115,7 +4116,7 @@ void monitor_init(Chardev *chr, int flags)
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
                                  monitor_qmp_event, NULL, mon, NULL, true);
         qemu_chr_fe_set_echo(&mon->chr, true);
-        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, NULL);
+        json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
     } else {
         qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
                                  monitor_event, NULL, mon, NULL, true);
-- 
2.7.4
