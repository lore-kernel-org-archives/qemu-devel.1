Received: from eggs.gnu.org ([2001:4830:134:3::10]:48384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN4-0007jp-E2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dYYN2-00046u-2H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dYYN1-00045p-Ok
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5E3D883B4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 13:53:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 21 Jul 2017 15:53:21 +0200
Message-Id: <1500645206-13559-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-1-git-send-email-armbru@redhat.com>
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation into
 QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When you build QMP input manually like this

    cmd = g_strdup_printf("{ 'execute': 'migrate',"
                          "'arguments': { 'uri': '%s' } }",
                          uri);
    rsp = qmp(cmd);
    g_free(cmd);

you're responsible for escaping the interpolated values for JSON.  Not
done here, and therefore works only for sufficiently nice @uri.  For
instance, if @uri contained a single "'", qobject_from_jsonv() would
fail, qmp_fd_sendv() would misinterpret the failure as empty input and
do nothing, and the test would hang waiting for a response that never
comes.

Leaving interpolation into JSON to qmp() is more robust:

    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);

It's also more concise.

Clean up the simple cases where we interpolate exactly a JSON value.

Bonus: gets rid of non-literal format strings.  A step towards
compile-time format string checking without triggering
-Wformat-nonliteral.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/libqos/libqos.c   |  16 +----
 tests/libqos/pci-pc.c   |   9 +--
 tests/postcopy-test.c   |   8 +--
 tests/test-qga.c        | 160 +++++++++++++++++++++---------------------------
 tests/vhost-user-test.c |   6 +-
 5 files changed, 77 insertions(+), 122 deletions(-)

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index 6226546..42c5315 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -86,20 +86,12 @@ void set_context(QOSState *s)
 
 static QDict *qmp_execute(const char *command)
 {
-    char *fmt;
-    QDict *rsp;
-
-    fmt = g_strdup_printf("{ 'execute': '%s' }", command);
-    rsp = qmp(fmt);
-    g_free(fmt);
-
-    return rsp;
+    return qmp("{ 'execute': %s }", command);
 }
 
 void migrate(QOSState *from, QOSState *to, const char *uri)
 {
     const char *st;
-    char *s;
     QDict *rsp, *sub;
     bool running;
 
@@ -114,11 +106,7 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     QDECREF(rsp);
 
     /* Issue the migrate command. */
-    s = g_strdup_printf("{ 'execute': 'migrate',"
-                        "'arguments': { 'uri': '%s' } }",
-                        uri);
-    rsp = qmp(s);
-    g_free(s);
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index ded1c54..d40aa9d 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -159,14 +159,9 @@ void qpci_free_pc(QPCIBus *bus)
 void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
 {
     QDict *response;
-    char *cmd;
 
-    cmd = g_strdup_printf("{'execute': 'device_del',"
-                          " 'arguments': {"
-                          "   'id': '%s'"
-                          "}}", id);
-    response = qmp(cmd);
-    g_free(cmd);
+    response = qmp("{'execute': 'device_del', 'arguments': {'id': %s}}",
+                   id);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2a..e2ead87 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -358,7 +358,7 @@ static void test_migrate(void)
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *global = global_qtest, *from, *to;
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
-    gchar *cmd, *cmd_src, *cmd_dst;
+    gchar *cmd_src, *cmd_dst;
     QDict *rsp;
 
     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -445,11 +445,7 @@ static void test_migrate(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 06783e7..91a7b6e 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -144,12 +144,11 @@ static void test_qga_sync_delimited(gconstpointer fix)
     guint32 v, r = g_random_int();
     unsigned char c;
     QDict *ret;
-    gchar *cmd;
 
-    cmd = g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"
-                          " 'arguments': {'id': %u } }", r);
-    qmp_fd_send(fixture->fd, cmd);
-    g_free(cmd);
+    qmp_fd_send(fixture->fd,
+                "\xff{'execute': 'guest-sync-delimited',"
+                " 'arguments': {'id': %u } }",
+                r);
 
     /*
      * Read and ignore garbage until resynchronized.
@@ -186,7 +185,6 @@ static void test_qga_sync(gconstpointer fix)
     const TestFixture *fixture = fix;
     guint32 v, r = g_random_int();
     QDict *ret;
-    gchar *cmd;
 
     /*
      * TODO guest-sync is inherently limited: we cannot distinguish
@@ -199,10 +197,9 @@ static void test_qga_sync(gconstpointer fix)
      * invalid JSON. Testing of '\xff' handling is done in
      * guest-sync-delimited instead.
      */
-    cmd = g_strdup_printf("{'execute': 'guest-sync',"
-                          " 'arguments': {'id': %u } }", r);
-    ret = qmp_fd(fixture->fd, cmd);
-    g_free(cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-sync', 'arguments': {'id': %u } }",
+                 r);
 
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
@@ -393,7 +390,7 @@ static void test_qga_file_ops(gconstpointer fix)
     const TestFixture *fixture = fix;
     const unsigned char helloworld[] = "Hello World!\n";
     const char *b64;
-    gchar *cmd, *path, *enc;
+    gchar *path, *enc;
     unsigned char *dec;
     QDict *ret, *val;
     int64_t id, eof;
@@ -411,10 +408,10 @@ static void test_qga_file_ops(gconstpointer fix)
 
     enc = g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
-    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
-                          " 'arguments': { 'handle': %" PRId64 ","
-                          " 'buf-b64': '%s' } }", id, enc);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-write',"
+                 " 'arguments': { 'handle': %" PRId64 ", 'buf-b64': %s } }",
+                 id, enc);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
 
@@ -424,23 +421,20 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, ==, sizeof(helloworld));
     g_assert_cmpint(eof, ==, 0);
     QDECREF(ret);
-    g_free(cmd);
 
     /* flush */
-    cmd = g_strdup_printf("{'execute': 'guest-file-flush',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-flush',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     QDECREF(ret);
-    g_free(cmd);
 
     /* close */
-    cmd = g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-close',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     QDECREF(ret);
-    g_free(cmd);
 
     /* check content */
     path = g_build_filename(fixture->test_dir, "foo", NULL);
@@ -462,10 +456,10 @@ static void test_qga_file_ops(gconstpointer fix)
     QDECREF(ret);
 
     /* read */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -475,14 +469,13 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpstr(b64, ==, enc);
 
     QDECREF(ret);
-    g_free(cmd);
     g_free(enc);
 
     /* read eof */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -491,14 +484,13 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert(eof);
     g_assert_cmpstr(b64, ==, "");
     QDECREF(ret);
-    g_free(cmd);
 
     /* seek */
-    cmd = g_strdup_printf("{'execute': 'guest-file-seek',"
-                          " 'arguments': { 'handle': %" PRId64 ", "
-                          " 'offset': %d, 'whence': '%s' } }",
-                          id, 6, "set");
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-seek',"
+                 " 'arguments': { 'handle': %" PRId64 ", "
+                 " 'offset': %d, 'whence': %s } }",
+                 id, 6, "set");
     qmp_assert_no_error(ret);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "position");
@@ -506,13 +498,12 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, ==, 6);
     g_assert(!eof);
     QDECREF(ret);
-    g_free(cmd);
 
     /* partial read */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -525,15 +516,13 @@ static void test_qga_file_ops(gconstpointer fix)
     g_free(dec);
 
     QDECREF(ret);
-    g_free(cmd);
 
     /* close */
-    cmd = g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-close',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     QDECREF(ret);
-    g_free(cmd);
 }
 
 static void test_qga_file_write_read(gconstpointer fix)
@@ -541,7 +530,7 @@ static void test_qga_file_write_read(gconstpointer fix)
     const TestFixture *fixture = fix;
     const unsigned char helloworld[] = "Hello World!\n";
     const char *b64;
-    gchar *cmd, *enc;
+    gchar *enc;
     QDict *ret, *val;
     int64_t id, eof;
     gsize count;
@@ -556,10 +545,10 @@ static void test_qga_file_write_read(gconstpointer fix)
 
     enc = g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
-    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
-                          " 'arguments': { 'handle': %" PRId64 ","
-                          " 'buf-b64': '%s' } }", id, enc);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-write',"
+                 " 'arguments': { 'handle': %" PRId64 ","
+                 " 'buf-b64': %s } }", id, enc);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
 
@@ -569,13 +558,12 @@ static void test_qga_file_write_read(gconstpointer fix)
     g_assert_cmpint(count, ==, sizeof(helloworld));
     g_assert_cmpint(eof, ==, 0);
     QDECREF(ret);
-    g_free(cmd);
 
     /* read (check implicit flush) */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -584,14 +572,13 @@ static void test_qga_file_write_read(gconstpointer fix)
     g_assert(eof);
     g_assert_cmpstr(b64, ==, "");
     QDECREF(ret);
-    g_free(cmd);
 
     /* seek to 0 */
-    cmd = g_strdup_printf("{'execute': 'guest-file-seek',"
-                          " 'arguments': { 'handle': %" PRId64 ", "
-                          " 'offset': %d, 'whence': '%s' } }",
-                          id, 0, "set");
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-seek',"
+                 " 'arguments': { 'handle': %" PRId64 ", "
+                 " 'offset': %d, 'whence': %s } }",
+                 id, 0, "set");
     qmp_assert_no_error(ret);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "position");
@@ -599,13 +586,12 @@ static void test_qga_file_write_read(gconstpointer fix)
     g_assert_cmpint(count, ==, 0);
     g_assert(!eof);
     QDECREF(ret);
-    g_free(cmd);
 
     /* read */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-read',"
+                 " 'arguments': { 'handle': %" PRId64 "} }",
+                 id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -614,16 +600,14 @@ static void test_qga_file_write_read(gconstpointer fix)
     g_assert(eof);
     g_assert_cmpstr(b64, ==, enc);
     QDECREF(ret);
-    g_free(cmd);
     g_free(enc);
 
     /* close */
-    cmd = g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-file-close',"
+                 " 'arguments': {'handle': %" PRId64 "} }",
+                 id);
     QDECREF(ret);
-    g_free(cmd);
 }
 
 static void test_qga_get_time(gconstpointer fix)
@@ -647,7 +631,6 @@ static void test_qga_set_time(gconstpointer fix)
     const TestFixture *fixture = fix;
     QDict *ret;
     int64_t current, time;
-    gchar *cmd;
 
     /* get current time */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-time'}");
@@ -673,11 +656,10 @@ static void test_qga_set_time(gconstpointer fix)
     QDECREF(ret);
 
     /* set back current time */
-    cmd = g_strdup_printf("{'execute': 'guest-set-time',"
-                          " 'arguments': { 'time': %" PRId64 " } }",
-                          current + time * 1000);
-    ret = qmp_fd(fixture->fd, cmd);
-    g_free(cmd);
+    ret = qmp_fd(fixture->fd,
+                 "{'execute': 'guest-set-time',"
+                 " 'arguments': { 'time': %" PRId64 " } }",
+                 current + time * 1000);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     QDECREF(ret);
@@ -864,7 +846,6 @@ static void test_qga_guest_exec(gconstpointer fix)
     int64_t pid, now, exitcode;
     gsize len;
     bool exited;
-    char *cmd;
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
@@ -879,10 +860,10 @@ static void test_qga_guest_exec(gconstpointer fix)
 
     /* wait for completion */
     now = g_get_monotonic_time();
-    cmd = g_strdup_printf("{'execute': 'guest-exec-status',"
-                          " 'arguments': { 'pid': %" PRId64 " } }", pid);
     do {
-        ret = qmp_fd(fixture->fd, cmd);
+        ret = qmp_fd(fixture->fd,
+                     "{'execute': 'guest-exec-status',"
+                     " 'arguments': { 'pid': %" PRId64 " } }", pid);
         g_assert_nonnull(ret);
         val = qdict_get_qdict(ret, "return");
         exited = qdict_get_bool(val, "exited");
@@ -892,7 +873,6 @@ static void test_qga_guest_exec(gconstpointer fix)
     } while (!exited &&
              g_get_monotonic_time() < now + 5 * G_TIME_SPAN_SECOND);
     g_assert(exited);
-    g_free(cmd);
 
     /* check stdout */
     exitcode = qdict_get_int(val, "exitcode");
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index d4da09f..f2a2b6c 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -662,11 +662,7 @@ static void test_migrate(void)
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
+    rsp = qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
-- 
2.7.5
