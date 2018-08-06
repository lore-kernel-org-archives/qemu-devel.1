Received: from eggs.gnu.org ([2001:4830:134:3::10]:33391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOq-0001Xb-TI
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fmZOm-00088L-Nz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fmZOm-00087U-Es
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 02:53:48 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Aug 2018 08:53:33 +0200
Message-Id: <20180806065344.7103-13-armbru@redhat.com>
In-Reply-To: <20180806065344.7103-1-armbru@redhat.com>
References: <20180806065344.7103-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/23] tests: Clean up string interpolation
 into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

When you build QMP input manually like this

    cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
                          "'arguments': { 'uri': '%s' } }",
                          uri);
    rsp =3D qmp(cmd);
    g_free(cmd);

you're responsible for escaping the interpolated values for JSON.  Not
done here, and therefore works only for sufficiently nice @uri.  For
instance, if @uri contained a single "'", qobject_from_vjsonf_nofail()
would abort.  A sufficiently nasty @uri could even inject unwanted
members into the arguments object.

Leaving interpolation into JSON to qmp() is more robust:

    rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", u=
ri);

It's also more concise.

Clean up the simple cases where we interpolate exactly a JSON value.

Bonus: gets rid of non-literal format strings.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/pci-pc.c   |   9 +--
 tests/libqtest.c        |   7 +-
 tests/migration-test.c  |   8 +--
 tests/test-qga.c        | 150 ++++++++++++++++++----------------------
 tests/tpm-util.c        |   9 +--
 tests/vhost-user-test.c |   6 +-
 6 files changed, 77 insertions(+), 112 deletions(-)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index a7803308b7..585f5289ec 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -160,14 +160,9 @@ void qpci_free_pc(QPCIBus *bus)
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 {
     QDict *response;
-    char *cmd;
=20
-    cmd =3D g_strdup_printf("{'execute': 'device_del',"
-                          " 'arguments': {"
-                          "   'id': '%s'"
-                          "}}", id);
-    response =3D qmp(cmd);
-    g_free(cmd);
+    response =3D qmp("{'execute': 'device_del', 'arguments': {'id': %s}}=
",
+                   id);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     qobject_unref(response);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 9e3870bb7d..81b17f6fc9 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1054,12 +1054,9 @@ void qtest_qmp_device_add(const char *driver, cons=
t char *id, const char *fmt,
 void qtest_qmp_device_del(const char *id)
 {
     QDict *response1, *response2, *event =3D NULL;
-    char *cmd;
=20
-    cmd =3D g_strdup_printf("{'execute': 'device_del',"
-                          " 'arguments': { 'id': '%s' }}", id);
-    response1 =3D qmp(cmd);
-    g_free(cmd);
+    response1 =3D qmp("{'execute': 'device_del', 'arguments': {'id': %s}=
}",
+                    id);
     g_assert(response1);
     g_assert(!qdict_haskey(response1, "error"));
=20
diff --git a/tests/migration-test.c b/tests/migration-test.c
index bbe9c9e95d..486059580c 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -532,14 +532,12 @@ static void test_migrate_end(QTestState *from, QTes=
tState *to, bool test_dest)
 static void deprecated_set_downtime(QTestState *who, const double value)
 {
     QDict *rsp;
-    gchar *cmd;
     char *expected;
     int64_t result_int;
=20
-    cmd =3D g_strdup_printf("{ 'execute': 'migrate_set_downtime',"
-                          "'arguments': { 'value': %g } }", value);
-    rsp =3D qtest_qmp(who, cmd);
-    g_free(cmd);
+    rsp =3D qtest_qmp(who,
+                    "{ 'execute': 'migrate_set_downtime',"
+                    " 'arguments': { 'value': %f } }", value);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
     result_int =3D value * 1000L;
diff --git a/tests/test-qga.c b/tests/test-qga.c
index d638b1571a..c552cc0125 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -146,12 +146,11 @@ static void test_qga_sync_delimited(gconstpointer f=
ix)
     guint32 v, r =3D g_random_int();
     unsigned char c;
     QDict *ret;
-    gchar *cmd;
=20
-    cmd =3D g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"
-                          " 'arguments': {'id': %u } }", r);
-    qmp_fd_send(fixture->fd, cmd);
-    g_free(cmd);
+    qmp_fd_send(fixture->fd,
+                "\xff{'execute': 'guest-sync-delimited',"
+                " 'arguments': {'id': %u } }",
+                r);
=20
     /*
      * Read and ignore garbage until resynchronized.
@@ -188,7 +187,6 @@ static void test_qga_sync(gconstpointer fix)
     const TestFixture *fixture =3D fix;
     guint32 v, r =3D g_random_int();
     QDict *ret;
-    gchar *cmd;
=20
     /*
      * TODO guest-sync is inherently limited: we cannot distinguish
@@ -201,10 +199,9 @@ static void test_qga_sync(gconstpointer fix)
      * invalid JSON. Testing of '\xff' handling is done in
      * guest-sync-delimited instead.
      */
-    cmd =3D g_strdup_printf("{'execute': 'guest-sync',"
-                          " 'arguments': {'id': %u } }", r);
-    ret =3D qmp_fd(fixture->fd, cmd);
-    g_free(cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-sync', 'arguments': {'id': %u } }",
+                 r);
=20
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
@@ -428,7 +425,7 @@ static void test_qga_file_ops(gconstpointer fix)
     const TestFixture *fixture =3D fix;
     const unsigned char helloworld[] =3D "Hello World!\n";
     const char *b64;
-    gchar *cmd, *path, *enc;
+    gchar *path, *enc;
     unsigned char *dec;
     QDict *ret, *val;
     int64_t id, eof;
@@ -446,10 +443,10 @@ static void test_qga_file_ops(gconstpointer fix)
=20
     enc =3D g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-write',"
-                          " 'arguments': { 'handle': %" PRId64 ","
-                          " 'buf-b64': '%s' } }", id, enc);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-write',"
+                 " 'arguments': { 'handle': %" PRId64 ", 'buf-b64': %s }=
 }",
+                 id, enc);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
=20
@@ -459,23 +456,20 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, =3D=3D, sizeof(helloworld));
     g_assert_cmpint(eof, =3D=3D, 0);
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* flush */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-flush',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-flush',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* close */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-close',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* check content */
     path =3D g_build_filename(fixture->test_dir, "foo", NULL);
@@ -497,10 +491,10 @@ static void test_qga_file_ops(gconstpointer fix)
     qobject_unref(ret);
=20
     /* read */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "count");
     eof =3D qdict_get_bool(val, "eof");
@@ -510,14 +504,13 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpstr(b64, =3D=3D, enc);
=20
     qobject_unref(ret);
-    g_free(cmd);
     g_free(enc);
=20
     /* read eof */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "count");
     eof =3D qdict_get_bool(val, "eof");
@@ -526,14 +519,13 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, "");
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* seek */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-seek',"
-                          " 'arguments': { 'handle': %" PRId64 ", "
-                          " 'offset': %d, 'whence': '%s' } }",
-                          id, 6, "set");
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-seek',"
+                 " 'arguments': { 'handle': %" PRId64 ", "
+                 " 'offset': %d, 'whence': %s } }",
+                 id, 6, "set");
     qmp_assert_no_error(ret);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "position");
@@ -541,13 +533,12 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, =3D=3D, 6);
     g_assert(!eof);
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* partial read */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "count");
     eof =3D qdict_get_bool(val, "eof");
@@ -560,15 +551,13 @@ static void test_qga_file_ops(gconstpointer fix)
     g_free(dec);
=20
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* close */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-close',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     qobject_unref(ret);
-    g_free(cmd);
 }
=20
 static void test_qga_file_write_read(gconstpointer fix)
@@ -576,7 +565,7 @@ static void test_qga_file_write_read(gconstpointer fi=
x)
     const TestFixture *fixture =3D fix;
     const unsigned char helloworld[] =3D "Hello World!\n";
     const char *b64;
-    gchar *cmd, *enc;
+    gchar *enc;
     QDict *ret, *val;
     int64_t id, eof;
     gsize count;
@@ -591,10 +580,10 @@ static void test_qga_file_write_read(gconstpointer =
fix)
=20
     enc =3D g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-write',"
-                          " 'arguments': { 'handle': %" PRId64 ","
-                          " 'buf-b64': '%s' } }", id, enc);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-write',"
+                 " 'arguments': { 'handle': %" PRId64 ","
+                 " 'buf-b64': %s } }", id, enc);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
=20
@@ -604,13 +593,12 @@ static void test_qga_file_write_read(gconstpointer =
fix)
     g_assert_cmpint(count, =3D=3D, sizeof(helloworld));
     g_assert_cmpint(eof, =3D=3D, 0);
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* read (check implicit flush) */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "count");
     eof =3D qdict_get_bool(val, "eof");
@@ -619,14 +607,13 @@ static void test_qga_file_write_read(gconstpointer =
fix)
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, "");
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* seek to 0 */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-seek',"
-                          " 'arguments': { 'handle': %" PRId64 ", "
-                          " 'offset': %d, 'whence': '%s' } }",
-                          id, 0, "set");
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-seek',"
+                 " 'arguments': { 'handle': %" PRId64 ", "
+                 " 'offset': %d, 'whence': %s } }",
+                 id, 0, "set");
     qmp_assert_no_error(ret);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "position");
@@ -634,13 +621,12 @@ static void test_qga_file_write_read(gconstpointer =
fix)
     g_assert_cmpint(count, =3D=3D, 0);
     g_assert(!eof);
     qobject_unref(ret);
-    g_free(cmd);
=20
     /* read */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val =3D qdict_get_qdict(ret, "return");
     count =3D qdict_get_int(val, "count");
     eof =3D qdict_get_bool(val, "eof");
@@ -649,16 +635,14 @@ static void test_qga_file_write_read(gconstpointer =
fix)
     g_assert(eof);
     g_assert_cmpstr(b64, =3D=3D, enc);
     qobject_unref(ret);
-    g_free(cmd);
     g_free(enc);
=20
     /* close */
-    cmd =3D g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret =3D qmp_fd(fixture->fd, cmd);
+    ret =3D qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-close',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     qobject_unref(ret);
-    g_free(cmd);
 }
=20
 static void test_qga_get_time(gconstpointer fix)
@@ -814,7 +798,6 @@ static void test_qga_guest_exec(gconstpointer fix)
     int64_t pid, now, exitcode;
     gsize len;
     bool exited;
-    char *cmd;
=20
     /* exec 'echo foo bar' */
     ret =3D qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': =
{"
@@ -829,10 +812,10 @@ static void test_qga_guest_exec(gconstpointer fix)
=20
     /* wait for completion */
     now =3D g_get_monotonic_time();
-    cmd =3D g_strdup_printf("{'execute': 'guest-exec-status',"
-                          " 'arguments': { 'pid': %" PRId64 " } }", pid)=
;
     do {
-        ret =3D qmp_fd(fixture->fd, cmd);
+        ret =3D qmp_fd(fixture->fd,
+                     "{'execute': 'guest-exec-status',"
+                     " 'arguments': { 'pid': %" PRId64 " } }", pid);
         g_assert_nonnull(ret);
         val =3D qdict_get_qdict(ret, "return");
         exited =3D qdict_get_bool(val, "exited");
@@ -842,7 +825,6 @@ static void test_qga_guest_exec(gconstpointer fix)
     } while (!exited &&
              g_get_monotonic_time() < now + 5 * G_TIME_SPAN_SECOND);
     g_assert(exited);
-    g_free(cmd);
=20
     /* check stdout */
     exitcode =3D qdict_get_int(val, "exitcode");
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index 672cedf905..3bd2887f1e 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -239,13 +239,10 @@ void tpm_util_swtpm_kill(GPid pid)
 void tpm_util_migrate(QTestState *who, const char *uri)
 {
     QDict *rsp;
-    gchar *cmd;
=20
-    cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp =3D qtest_qmp(who, cmd);
-    g_free(cmd);
+    rsp =3D qtest_qmp(who,
+                    "{ 'execute': 'migrate', 'arguments': { 'uri': %s } =
}",
+                    uri);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index fecc832d99..ca6251f5f8 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -709,11 +709,7 @@ static void test_migrate(void)
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
=20
-    cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp =3D qmp(cmd);
-    g_free(cmd);
+    rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", =
uri);
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
=20
--=20
2.17.1
