Received: from eggs.gnu.org ([2001:4830:134:3::10]:50704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmr-0001B3-0S
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmn-0005SE-Sr
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDma-0005AR-Jm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:32 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:52 +0200
Message-Id: <20180816083701.3932-17-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 16/25] tests: New helper
 qtest_qmp_receive_success()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Commit b21373d0713 copied wait_command() from tests/migration-test.c
to tests/tpm-util.c.  Replace both copies by new libqtest helper
qtest_qmp_receive_success().  Also use it to simplify
qtest_qmp_device_del().

Bonus: gets rid of a non-literal format string.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-17-armbru@redhat.com>
---
 tests/libqtest.c       | 69 ++++++++++++++++++++++++++++++------------
 tests/libqtest.h       | 17 +++++++++++
 tests/migration-test.c | 29 ++++++------------
 tests/tpm-util.c       | 32 +++-----------------
 4 files changed, 80 insertions(+), 67 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 17c91f5c47..2f81bc6382 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1004,6 +1004,35 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
     qobject_unref(response);
 }
 
+QDict *qtest_qmp_receive_success(QTestState *s,
+                                 void (*event_cb)(void *opaque,
+                                                  const char *event,
+                                                  QDict *data),
+                                 void *opaque)
+{
+    QDict *response, *ret, *data;
+    const char *event;
+
+    for (;;) {
+        response = qtest_qmp_receive(s);
+        g_assert(!qdict_haskey(response, "error"));
+        ret = qdict_get_qdict(response, "return");
+        if (ret) {
+            break;
+        }
+        event = qdict_get_str(response, "event");
+        data = qdict_get_qdict(response, "data");
+        if (event_cb) {
+            event_cb(opaque, event, data);
+        }
+        qobject_unref(response);
+    }
+
+    qobject_ref(ret);
+    qobject_unref(response);
+    return ret;
+}
+
 /*
  * Generic hot-plugging test via the device_add QMP command.
  */
@@ -1028,6 +1057,14 @@ void qtest_qmp_device_add(const char *driver, const char *id,
     qobject_unref(response);
 }
 
+static void device_deleted_cb(void *opaque, const char *name, QDict *data)
+{
+    bool *got_event = opaque;
+
+    g_assert_cmpstr(name, ==, "DEVICE_DELETED");
+    *got_event = true;
+}
+
 /*
  * Generic hot-unplugging test via the device_del QMP command.
  * Device deletion will get one response and one event. For example:
@@ -1048,27 +1085,21 @@ void qtest_qmp_device_add(const char *driver, const char *id,
  */
 void qtest_qmp_device_del(const char *id)
 {
-    QDict *response1, *response2, *event = NULL;
+    bool got_event = false;
+    QDict *rsp;
 
-    response1 = qmp("{'execute': 'device_del', 'arguments': {'id': %s}}",
-                    id);
-    g_assert(response1);
-    g_assert(!qdict_haskey(response1, "error"));
-
-    response2 = qmp_receive();
-    g_assert(response2);
-    g_assert(!qdict_haskey(response2, "error"));
-
-    if (qdict_haskey(response1, "event")) {
-        event = response1;
-    } else if (qdict_haskey(response2, "event")) {
-        event = response2;
+    qtest_qmp_send(global_qtest,
+                   "{'execute': 'device_del', 'arguments': {'id': %s}}",
+                   id);
+    rsp = qtest_qmp_receive_success(global_qtest, device_deleted_cb,
+                                    &got_event);
+    qobject_unref(rsp);
+    if (!got_event) {
+        rsp = qmp_receive();
+        g_assert_cmpstr(qdict_get_try_str(rsp, "event"),
+                        ==, "DEVICE_DELETED");
+        qobject_unref(rsp);
     }
-    g_assert(event);
-    g_assert_cmpstr(qdict_get_str(event, "event"), ==, "DEVICE_DELETED");
-
-    qobject_unref(response1);
-    qobject_unref(response2);
 }
 
 bool qmp_rsp_is_err(QDict *rsp)
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 70e9c5157c..d3da42623e 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -146,6 +146,23 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
  */
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 
+/**
+ * qtest_qmp_receive_success:
+ * @s: #QTestState instance to operate on
+ * @event_cb: Event callback
+ * @opaque: Argument for @event_cb
+ *
+ * Poll QMP messages until a command success response is received.
+ * If @event_cb, call it for each event received, passing @opaque,
+ * the event's name and data.
+ * Return the success response's "return" member.
+ */
+QDict *qtest_qmp_receive_success(QTestState *s,
+                                 void (*event_cb)(void *opaque,
+                                                  const char *name,
+                                                  QDict *data),
+                                 void *opaque);
+
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
diff --git a/tests/migration-test.c b/tests/migration-test.c
index db652e30a0..402c82bdc4 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -149,31 +149,20 @@ static void wait_for_serial(const char *side)
     } while (true);
 }
 
+static void stop_cb(void *opaque, const char *name, QDict *data)
+{
+    if (!strcmp(name, "STOP")) {
+        got_stop = true;
+    }
+}
+
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
 static QDict *wait_command(QTestState *who, const char *command)
 {
-    const char *event_string;
-    QDict *response, *ret;
-
-    response = qtest_qmp(who, command);
-
-    while (qdict_haskey(response, "event")) {
-        /* OK, it was an event */
-        event_string = qdict_get_str(response, "event");
-        if (!strcmp(event_string, "STOP")) {
-            got_stop = true;
-        }
-        qobject_unref(response);
-        response = qtest_qmp_receive(who);
-    }
-
-    ret = qdict_get_qdict(response, "return");
-    g_assert(ret);
-    qobject_ref(ret);
-    qobject_unref(response);
-    return ret;
+    qtest_qmp_send(who, command);
+    return qtest_qmp_receive_success(who, stop_cb, NULL);
 }
 
 /*
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index 3bd2887f1e..9f3f156e42 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -22,8 +22,6 @@
 #define TIS_REG(LOCTY, REG) \
     (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
 
-static bool got_stop;
-
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size)
@@ -247,41 +245,19 @@ void tpm_util_migrate(QTestState *who, const char *uri)
     qobject_unref(rsp);
 }
 
-/*
- * Events can get in the way of responses we are actually waiting for.
- */
-static QDict *tpm_util_wait_command(QTestState *who, const char *command)
-{
-    const char *event_string;
-    QDict *response;
-
-    response = qtest_qmp(who, command);
-
-    while (qdict_haskey(response, "event")) {
-        /* OK, it was an event */
-        event_string = qdict_get_str(response, "event");
-        if (!strcmp(event_string, "STOP")) {
-            got_stop = true;
-        }
-        qobject_unref(response);
-        response = qtest_qmp_receive(who);
-    }
-    return response;
-}
-
 void tpm_util_wait_for_migration_complete(QTestState *who)
 {
     while (true) {
-        QDict *rsp, *rsp_return;
+        QDict *rsp_return;
         bool completed;
         const char *status;
 
-        rsp = tpm_util_wait_command(who, "{ 'execute': 'query-migrate' }");
-        rsp_return = qdict_get_qdict(rsp, "return");
+        qtest_qmp_send(who, "{ 'execute': 'query-migrate' }");
+        rsp_return = qtest_qmp_receive_success(who, NULL, NULL);
         status = qdict_get_str(rsp_return, "status");
         completed = strcmp(status, "completed") == 0;
         g_assert_cmpstr(status, !=,  "failed");
-        qobject_unref(rsp);
+        qobject_unref(rsp_return);
         if (completed) {
             return;
         }
-- 
2.17.1
