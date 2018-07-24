Received: from eggs.gnu.org ([2001:4830:134:3::10]:60109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr8-0002Ri-GA
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkr7-0005Bs-Ey
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:10 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 19:01:26 -0500
Message-Id: <20180724000126.21787-3-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
References: <20180724000126.21787-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.0 2/2] qga: process_event() simplification
 and leak fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

json_parser_parse_err() may return something else than a QDict, in
which case we loose the object. Let's keep track of the original
object to avoid leaks.

When an error occurs, "qdict" contains the response, but we still
check the "execute" key there. Untangle a bit this code, by having a
clear error path.

CC: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/main.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 537cc0e162..87372d40ef 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -600,42 +600,42 @@ static void process_command(GAState *s, QDict *req)
 static void process_event(JSONMessageParser *parser, GQueue *tokens)
 {
     GAState *s = container_of(parser, GAState, parser);
-    QDict *qdict;
+    QObject *obj;
+    QDict *req, *rsp;
     Error *err = NULL;
     int ret;
 
     g_assert(s && parser);
 
     g_debug("process_event: called");
-    qdict = qobject_to(QDict, json_parser_parse_err(tokens, NULL, &err));
-    if (err || !qdict) {
-        qobject_unref(qdict);
-        if (!err) {
-            g_warning("failed to parse event: unknown error");
-            error_setg(&err, QERR_JSON_PARSING);
-        } else {
-            g_warning("failed to parse event: %s", error_get_pretty(err));
-        }
-        qdict = qmp_error_response(err);
+    obj = json_parser_parse_err(tokens, NULL, &err);
+    if (err) {
+        goto err;
     }
-
-    /* handle host->guest commands */
-    if (qdict_haskey(qdict, "execute")) {
-        process_command(s, qdict);
-    } else {
-        if (!qdict_haskey(qdict, "error")) {
-            qobject_unref(qdict);
-            g_warning("unrecognized payload format");
-            error_setg(&err, QERR_UNSUPPORTED);
-            qdict = qmp_error_response(err);
-        }
-        ret = send_response(s, qdict);
-        if (ret < 0) {
-            g_warning("error sending error response: %s", strerror(-ret));
-        }
+    req = qobject_to(QDict, obj);
+    if (!req) {
+        error_setg(&err, QERR_JSON_PARSING);
+        goto err;
+    }
+    if (!qdict_haskey(req, "execute")) {
+        g_warning("unrecognized payload format");
+        error_setg(&err, QERR_UNSUPPORTED);
+        goto err;
     }
 
-    qobject_unref(qdict);
+    process_command(s, req);
+    qobject_unref(obj);
+    return;
+
+err:
+    g_warning("failed to parse event: %s", error_get_pretty(err));
+    rsp = qmp_error_response(err);
+    ret = send_response(s, rsp);
+    if (ret < 0) {
+        g_warning("error sending error response: %s", strerror(-ret));
+    }
+    qobject_unref(rsp);
+    qobject_unref(obj);
 }
 
 /* false return signals GAChannel to close the current client connection */
-- 
2.17.1
