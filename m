Received: from eggs.gnu.org ([2001:4830:134:3::10]:46189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKG-000343-6T
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqgKC-0001h2-Kp
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqgKC-0001gW-Bl
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:06:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Aug 2018 17:05:04 +0200
Message-Id: <20180817150559.16243-6-armbru@redhat.com>
In-Reply-To: <20180817150559.16243-1-armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/60] qmp-test: Cover syntax and lexical
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqtest.c | 17 +++++++++++++++++
 tests/libqtest.h | 11 +++++++++++
 tests/qmp-test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 852ccff1ce..dc42347da3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -604,6 +604,23 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }
 
+void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
+{
+    bool log = getenv("QTEST_LOG") != NULL;
+    va_list ap;
+    char *str;
+
+    va_start(ap, fmt);
+    str = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    if (log) {
+        fprintf(stderr, "%s", str);
+    }
+    socket_send(s->qmp_fd, str, strlen(str));
+    g_free(str);
+}
+
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
 {
     QDict *response;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index def1edaafa..1e831973ff 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -96,6 +96,17 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
 void qtest_qmp_send(QTestState *s, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
+/**
+ * qtest_qmp_send_raw:
+ * @s: #QTestState instance to operate on.
+ * @fmt...: text to send, formatted like sprintf()
+ *
+ * Sends text to the QMP monitor verbatim.  Need not be valid JSON;
+ * this is useful for negative tests.
+ */
+void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+
 /**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index dbc8f6c16e..17153192fe 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -1,7 +1,7 @@
 /*
  * QMP protocol test cases
  *
- * Copyright (c) 2017 Red Hat Inc.
+ * Copyright (c) 2017-2018 Red Hat Inc.
  *
  * Authors:
  *  Markus Armbruster <armbru@redhat.com>
@@ -42,10 +42,49 @@ static void test_version(QObject *version)
     visit_free(v);
 }
 
+static bool recovered(QTestState *qts)
+{
+    QDict *resp;
+    bool ret;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'no-such-cmd' }");
+    ret = !strcmp(get_error_class(resp), "CommandNotFound");
+    qobject_unref(resp);
+    return ret;
+}
+
 static void test_malformed(QTestState *qts)
 {
     QDict *resp;
 
+    /* syntax error */
+    qtest_qmp_send_raw(qts, "{]\n");
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    qobject_unref(resp);
+    g_assert(recovered(qts));
+
+    /* lexical error: impossible byte outside string */
+    qtest_qmp_send_raw(qts, "{\xFF");
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    qobject_unref(resp);
+    g_assert(recovered(qts));
+
+    /* lexical error: impossible byte in string */
+    qtest_qmp_send_raw(qts, "{'bad \xFF");
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    qobject_unref(resp);
+    g_assert(recovered(qts));
+
+    /* lexical error: interpolation */
+    qtest_qmp_send_raw(qts, "%%p\n");
+    resp = qtest_qmp_receive(qts);
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    qobject_unref(resp);
+    g_assert(recovered(qts));
+
     /* Not even a dictionary */
     resp = qtest_qmp(qts, "null");
     g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
-- 
2.17.1
