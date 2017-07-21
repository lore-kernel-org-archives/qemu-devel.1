Received: from eggs.gnu.org ([2001:4830:134:3::10]:34355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dYYyF-00066J-7z
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dYYyC-0001Z7-6H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:31:59 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45277 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dYYyB-0001Vx-RO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:31:56 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Jul 2017 17:31:49 +0300
Message-Id: <20170721143149.43721-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170721143149.43721-1-vsementsov@virtuozzo.com>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, dgilbert@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Calculate req_json only if trace_handle_qmp_command enabled.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6d040e620f..3606a7928b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3823,7 +3823,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
     QDict *qdict = NULL;
     Monitor *mon = cur_mon;
     Error *err = NULL;
-    QString *req_json;
+    QString *req_json = NULL;
 
     req = json_parser_parse_err(tokens, NULL, &err);
     if (!req && !err) {
@@ -3841,8 +3841,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
 
-    req_json = qobject_to_json(req);
-    trace_handle_qmp_command(mon, qstring_get_str(req_json));
+    trace_handle_qmp_command(mon,
+                             qstring_get_str(req_json = qobject_to_json(req)));
     QDECREF(req_json);
 
     rsp = qmp_dispatch(cur_mon->qmp.commands, req);
-- 
2.11.1
