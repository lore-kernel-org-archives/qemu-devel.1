Received: from eggs.gnu.org ([2001:4830:134:3::10]:53084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4Z-0001S7-Ii
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0007GY-79
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4X-0007Fs-0s
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:35 +0200
Message-Id: <20180703085358.13941-10-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/32] qmp qemu-ga: Revert change that
 accidentally made qemu-ga accept "id"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Commit cf869d53172 "qmp: support out-of-band (oob) execution" changed
how we check "id":

    Note that in the patch I exported qmp_dispatch_check_obj() to be
    used to check the request earlier, and at the same time allowed
    "id" field to be there since actually we always allow that.

The part after "and" is ill-advised: it makes qemu-ga accept and
ignore "id".  Revert.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor.c           | 14 ++++++++------
 qapi/qmp-dispatch.c |  2 --
 tests/test-qga.c    | 13 +++++--------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/monitor.c b/monitor.c
index b7d74b01b4..4659399b55 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4263,7 +4263,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
 {
     QObject *req, *id = NULL;
-    QDict *qdict = NULL;
+    QDict *qdict;
     MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
     Monitor *mon = container_of(mon_qmp, Monitor, qmp);
     Error *err = NULL;
@@ -4278,6 +4278,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         goto err;
     }
 
+    qdict = qobject_to(QDict, req);
+    if (qdict) {
+        id = qobject_ref(qdict_get(qdict, "id"));
+        qdict_del(qdict, "id");
+    } /* else will fail qmp_dispatch() */
+
     /* Check against the request in general layout */
     qdict = qmp_dispatch_check_obj(req, &err);
     if (!qdict) {
@@ -4289,16 +4295,12 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
         goto err;
     }
 
-    id = qdict_get(qdict, "id");
-
     req_obj = g_new0(QMPRequest, 1);
     req_obj->mon = mon;
-    req_obj->id = qobject_ref(id);
+    req_obj->id = id;
     req_obj->req = req;
     req_obj->need_resume = false;
 
-    qdict_del(qdict, "id");
-
     if (qmp_is_oob(qdict)) {
         /* Out-of-band (OOB) requests are executed directly in parser. */
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->id)
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 935f9e159c..3d5d5e110f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -52,8 +52,6 @@ QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
                            "QMP input member 'arguments' must be an object");
                 return NULL;
             }
-        } else if (!strcmp(arg_name, "id")) {
-            continue;
         } else if (!strcmp(arg_name, "control")) {
             if (qobject_type(arg_obj) != QTYPE_QDICT) {
                 error_setg(errp,
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 6b632e3da4..564a4594b5 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -229,19 +229,16 @@ static void test_qga_ping(gconstpointer fix)
 
 static void test_qga_invalid_id(gconstpointer fix)
 {
-    /*
-     * FIXME "id" is ignored; it should either be repeated in the
-     * reply, or rejected on input
-     */
     const TestFixture *fixture = fix;
-    QDict *ret, *val;
+    QDict *ret, *error;
+    const char *class;
 
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
     g_assert_nonnull(ret);
-    qmp_assert_no_error(ret);
 
-    val = qdict_get_qdict(ret, "return");
-    g_assert(!qdict_haskey(val, "id"));
+    error = qdict_get_qdict(ret, "error");
+    class = qdict_get_try_str(error, "class");
+    g_assert_cmpstr(class, ==, "GenericError");
 
     qobject_unref(ret);
 }
-- 
2.17.1
