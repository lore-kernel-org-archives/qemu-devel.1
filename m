Received: from eggs.gnu.org ([2001:4830:134:3::10]:58571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKt-0000uP-PG
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKs-0002OO-Gh
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvPKs-0002OB-9Y
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 17:58:07 +0200
Message-Id: <20180830155810.17629-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180830155810.17629-1-marcandre.lureau@redhat.com>
References: <20180830155810.17629-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/4] tests: add qmp_assert_error_class()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This helper will simplify a bunch of code checking for QMP errors and
can be shared by various tests.  Note that test-qga does check for
error description as well, so don't replace the code there for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqtest.h       |  9 ++++++
 tests/drive_del-test.c |  5 +--
 tests/libqtest.c       | 11 +++++++
 tests/qmp-test.c       | 73 +++++++++++++-----------------------------
 tests/test-qga.c       |  9 ++----
 5 files changed, 46 insertions(+), 61 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 36d5caecd4..ed88ff99d5 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -1004,4 +1004,13 @@ void qtest_qmp_device_del(const char *id);
  */
 bool qmp_rsp_is_err(QDict *rsp);
=20
+/**
+ * qmp_assert_error_class:
+ * @rsp: QMP response to check for error
+ * @class: an error class
+ *
+ * Assert the response has the given error class and discard @rsp.
+ */
+void qmp_assert_error_class(QDict *rsp, const char *class);
+
 #endif
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 673c10140f..4a1a0889c8 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -67,7 +67,6 @@ static void test_after_failed_device_add(void)
 {
     char driver[32];
     QDict *response;
-    QDict *error;
=20
     snprintf(driver, sizeof(driver), "virtio-blk-%s",
              qvirtio_get_dev_type());
@@ -83,9 +82,7 @@ static void test_after_failed_device_add(void)
                    "   'drive': 'drive0'"
                    "}}", driver);
     g_assert(response);
-    error =3D qdict_get_qdict(response, "error");
-    g_assert_cmpstr(qdict_get_try_str(error, "class"), =3D=3D, "GenericE=
rror");
-    qobject_unref(response);
+    qmp_assert_error_class(response, "GenericError");
=20
     /* Delete the drive */
     drive_del();
diff --git a/tests/libqtest.c b/tests/libqtest.c
index d635c5bea0..2cd5736642 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1194,3 +1194,14 @@ bool qmp_rsp_is_err(QDict *rsp)
     qobject_unref(rsp);
     return !!error;
 }
+
+void qmp_assert_error_class(QDict *rsp, const char *class)
+{
+    QDict *error =3D qdict_get_qdict(rsp, "error");
+
+    g_assert_cmpstr(qdict_get_try_str(error, "class"), =3D=3D, class);
+    g_assert_nonnull(qdict_get_try_str(error, "desc"));
+    g_assert(!qdict_haskey(rsp, "return"));
+
+    qobject_unref(rsp);
+}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 4ae2245484..b3472281ae 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -21,15 +21,6 @@
=20
 const char common_args[] =3D "-nodefaults -machine none";
=20
-static const char *get_error_class(QDict *resp)
-{
-    QDict *error =3D qdict_get_qdict(resp, "error");
-    const char *desc =3D qdict_get_try_str(error, "desc");
-
-    g_assert(desc);
-    return error ? qdict_get_try_str(error, "class") : NULL;
-}
-
 static void test_version(QObject *version)
 {
     Visitor *v;
@@ -42,15 +33,12 @@ static void test_version(QObject *version)
     visit_free(v);
 }
=20
-static bool recovered(QTestState *qts)
+static void assert_recovered(QTestState *qts)
 {
     QDict *resp;
-    bool ret;
=20
     resp =3D qtest_qmp(qts, "{ 'execute': 'no-such-cmd' }");
-    ret =3D !strcmp(get_error_class(resp), "CommandNotFound");
-    qobject_unref(resp);
-    return ret;
+    qmp_assert_error_class(resp, "CommandNotFound");
 }
=20
 static void test_malformed(QTestState *qts)
@@ -60,73 +48,61 @@ static void test_malformed(QTestState *qts)
     /* syntax error */
     qtest_qmp_send_raw(qts, "{]\n");
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
-    g_assert(recovered(qts));
+    qmp_assert_error_class(resp, "GenericError");
+    assert_recovered(qts);
=20
     /* lexical error: impossible byte outside string */
     qtest_qmp_send_raw(qts, "{\xFF");
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
-    g_assert(recovered(qts));
+    qmp_assert_error_class(resp, "GenericError");
+    assert_recovered(qts);
=20
     /* lexical error: funny control character outside string */
     qtest_qmp_send_raw(qts, "{\x01");
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
-    g_assert(recovered(qts));
+    qmp_assert_error_class(resp, "GenericError");
+    assert_recovered(qts);
=20
     /* lexical error: impossible byte in string */
     qtest_qmp_send_raw(qts, "{'bad \xFF");
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
-    g_assert(recovered(qts));
+    qmp_assert_error_class(resp, "GenericError");
+    assert_recovered(qts);
=20
     /* lexical error: control character in string */
     qtest_qmp_send_raw(qts, "{'execute': 'nonexistent', 'id':'\n");
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
-    g_assert(recovered(qts));
+    qmp_assert_error_class(resp, "GenericError");
+    assert_recovered(qts);
=20
     /* lexical error: interpolation */
     qtest_qmp_send_raw(qts, "%%p\n");
     /* two errors, one for "%", one for "p" */
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
     resp =3D qtest_qmp_receive(qts);
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
-    g_assert(recovered(qts));
+    qmp_assert_error_class(resp, "GenericError");
+    assert_recovered(qts);
=20
     /* Not even a dictionary */
     resp =3D qtest_qmp(qts, "null");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
=20
     /* No "execute" key */
     resp =3D qtest_qmp(qts, "{}");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
=20
     /* "execute" isn't a string */
     resp =3D qtest_qmp(qts, "{ 'execute': true }");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
=20
     /* "arguments" isn't a dictionary */
     resp =3D qtest_qmp(qts, "{ 'execute': 'no-such-cmd', 'arguments': []=
 }");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
=20
     /* extra key */
     resp =3D qtest_qmp(qts, "{ 'execute': 'no-such-cmd', 'extra': true }=
");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
 }
=20
 static void test_qmp_protocol(void)
@@ -148,8 +124,7 @@ static void test_qmp_protocol(void)
=20
     /* Test valid command before handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "CommandNotFound");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "CommandNotFound");
=20
     /* Test malformed commands before handshake */
     test_malformed(qts);
@@ -162,8 +137,7 @@ static void test_qmp_protocol(void)
=20
     /* Test repeated handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'qmp_capabilities' }");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "CommandNotFound");
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "CommandNotFound");
=20
     /* Test valid command */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
@@ -182,9 +156,8 @@ static void test_qmp_protocol(void)
=20
     /* Test command failure with 'id' */
     resp =3D qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id':=
 2 }");
-    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
     g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
-    qobject_unref(resp);
+    qmp_assert_error_class(resp, "GenericError");
=20
     qtest_quit(qts);
 }
diff --git a/tests/test-qga.c b/tests/test-qga.c
index f69cdf6c03..3d6377436a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -244,17 +244,12 @@ static void test_qga_invalid_id(gconstpointer fix)
 static void test_qga_invalid_oob(gconstpointer fix)
 {
     const TestFixture *fixture =3D fix;
-    QDict *ret, *error;
-    const char *class;
+    QDict *ret;
=20
     ret =3D qmp_fd(fixture->fd, "{'exec-oob': 'guest-ping'}");
     g_assert_nonnull(ret);
=20
-    error =3D qdict_get_qdict(ret, "error");
-    class =3D qdict_get_try_str(error, "class");
-    g_assert_cmpstr(class, =3D=3D, "GenericError");
-
-    qobject_unref(ret);
+    qmp_assert_error_class(ret, "GenericError");
 }
=20
 static void test_qga_invalid_args(gconstpointer fix)
--=20
2.19.0.rc0.48.gb9dfa238d5
