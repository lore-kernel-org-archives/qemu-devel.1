Received: from eggs.gnu.org ([2001:4830:134:3::10]:59918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNU-0008Ne-Nq
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNS-0003wA-Ab
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNS-0003vD-1n
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DCCB4DD49
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:40 -0500
Message-Id: <20170804012551.2714-12-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/22] test-qga: Simplify command
 construction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

When you build qga input manually like this:

    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
                          " 'arguments': {'handle': %" PRId64 ","
                          " 'buf-b64': '%s' } }", id, enc);
    ret = qmp_fd(fixture->fd, cmd);
    g_free(cmd);

you're responsible for escaping the interpolated values for JSON.
Not done here, and therefore works only because the base64 encoding
does not include % or '.

Leaving interpolation into JSON via qobject_from_jsonf() is more
robust; we can also reduce the boilerplate by factoring out the
common 'execute':%s and 'arguments':%p code into new qga() and
qga_args() helpers:

    ret = qga_args(fixture, "guest-file-write",
                   "{'handle': %" PRId64 ", 'buf-b64': %s}", id, enc);

Note that this reverts part of commit 1792d7d0; but that is because
we just recently guaranteed support of PRId64 in qobject_from_jsonf().

Also note that the simple form qga() sends "arguments":{} over the
wire rather than the previous approach of omitting it entirely;
test_qga_ping() is updated to use a long-hand form to ensure that
"arguments" is truly optional.

As a bonus, this eliminates the last external caller using varargs
for qmp_fd_send(); the next patch will simplify that interface to
take just the string being sent over the wire rather than performing
a string->QObject->string round trip (there's already a hint
of that in the simplification of passing '\xff' separately from
the command, where this patch had to tweak things to avoid an
assertion).  Also, this is a step towards getting rid of non-literal
format strings; our new helpers can already use GCC_ATTR_FMT() just
like qobject_from_jsonf().

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c |   3 +-
 tests/test-qga.c | 222 +++++++++++++++++++++++++++----------------------------
 2 files changed, 111 insertions(+), 114 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0cb439eefa..ba09c949dc 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -458,7 +458,8 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
      * resyncs */
     if (*fmt == '\377') {
         socket_send(fd, fmt, 1);
-        fmt++;
+        assert(!fmt[1]);
+        return;
     }
     assert(*fmt);

diff --git a/tests/test-qga.c b/tests/test-qga.c
index fd6bc7690f..839481e49b 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -5,6 +5,7 @@
 #include <sys/un.h>

 #include "libqtest.h"
+#include "qapi/qmp/qjson.h"

 typedef struct {
     char *test_dir;
@@ -111,6 +112,55 @@ fixture_tear_down(TestFixture *fixture, gconstpointer data)
     g_free(fixture->test_dir);
 }

+static void GCC_FMT_ATTR(3, 0) qga_sendv(const TestFixture *fixture,
+                                         const char *cmd,
+                                         const char *fmt, va_list ap)
+{
+    QObject *args = qobject_from_jsonv(fmt, ap);
+    QObject *obj = qobject_from_jsonf("{'execute':%s, 'arguments':%p}",
+                                      cmd, args);
+    QString *qstr = qobject_to_json(obj);
+    const char *str;
+
+    qstring_append_chr(qstr, '\n');
+    str = qstring_get_str(qstr);
+    assert(!strchr(str, '%'));
+    qmp_fd_send(fixture->fd, str);
+    QDECREF(qstr);
+    qobject_decref(obj);
+}
+
+static void GCC_FMT_ATTR(3, 4) qga_send_args(const TestFixture *fixture,
+                                             const char *cmd,
+                                             const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    qga_sendv(fixture, cmd, fmt, ap);
+    va_end(ap);
+}
+
+
+static QDict * GCC_FMT_ATTR(3, 4) qga_args(const TestFixture *fixture,
+                                           const char *cmd,
+                                           const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    qga_sendv(fixture, cmd, fmt, ap);
+    va_end(ap);
+    return qmp_fd_receive(fixture->fd);
+}
+
+static QDict *qga(const TestFixture *fixture, const char *cmd)
+{
+    qga_send_args(fixture, cmd, "{}");
+    return qmp_fd_receive(fixture->fd);
+}
+
+
 static void qmp_assertion_message_error(const char     *domain,
                                         const char     *file,
                                         int             line,
@@ -144,12 +194,9 @@ static void test_qga_sync_delimited(gconstpointer fix)
     guint32 v, r = g_random_int();
     unsigned char c;
     QDict *ret;
-    gchar *cmd;

-    cmd = g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"
-                          " 'arguments': {'id': %u } }", r);
-    qmp_fd_send(fixture->fd, cmd);
-    g_free(cmd);
+    qmp_fd_send(fixture->fd, "\xff");
+    qga_send_args(fixture, "guest-sync-delimited", "{'id': %u}", r);

     /*
      * Read and ignore garbage until resynchronized.
@@ -186,7 +233,6 @@ static void test_qga_sync(gconstpointer fix)
     const TestFixture *fixture = fix;
     guint32 v, r = g_random_int();
     QDict *ret;
-    gchar *cmd;

     /*
      * TODO guest-sync is inherently limited: we cannot distinguish
@@ -199,10 +245,7 @@ static void test_qga_sync(gconstpointer fix)
      * invalid JSON. Testing of '\xff' handling is done in
      * guest-sync-delimited instead.
      */
-    cmd = g_strdup_printf("{'execute': 'guest-sync',"
-                          " 'arguments': {'id': %u } }", r);
-    ret = qmp_fd(fixture->fd, cmd);
-    g_free(cmd);
+    ret = qga_args(fixture, "guest-sync", "{'id': %u}", r);

     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
@@ -218,10 +261,17 @@ static void test_qga_ping(gconstpointer fix)
     const TestFixture *fixture = fix;
     QDict *ret;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping'}");
+    /* qga() adds an "arguments":{} over the wire... */
+    ret = qga(fixture, "guest-ping");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
+    QDECREF(ret);

+    /* ...so also test in long-hand that "arguments" can be omitted. */
+    qmp_fd_send(fixture->fd, "{'execute':'guest-ping'}");
+    ret = qmp_fd_receive(fixture->fd);
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
     QDECREF(ret);
 }

@@ -231,8 +281,7 @@ static void test_qga_invalid_args(gconstpointer fix)
     QDict *ret, *error;
     const gchar *class, *desc;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping', "
-                 "'arguments': {'foo': 42 }}");
+    ret = qga_args(fixture, "guest-ping", "{'foo': 42 }");
     g_assert_nonnull(ret);

     error = qdict_get_qdict(ret, "error");
@@ -251,7 +300,7 @@ static void test_qga_invalid_cmd(gconstpointer fix)
     QDict *ret, *error;
     const gchar *class, *desc;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-invalid-cmd'}");
+    ret = qga(fixture, "guest-invalid-cmd");
     g_assert_nonnull(ret);

     error = qdict_get_qdict(ret, "error");
@@ -270,7 +319,7 @@ static void test_qga_info(gconstpointer fix)
     QDict *ret, *val;
     const gchar *version;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-info'}");
+    ret = qga(fixture, "guest-info");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -288,7 +337,7 @@ static void test_qga_get_vcpus(gconstpointer fix)
     QList *list;
     const QListEntry *entry;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-vcpus'}");
+    ret = qga(fixture, "guest-get-vcpus");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -308,7 +357,7 @@ static void test_qga_get_fsinfo(gconstpointer fix)
     QList *list;
     const QListEntry *entry;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-fsinfo'}");
+    ret = qga(fixture, "guest-get-fsinfo");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -331,7 +380,7 @@ static void test_qga_get_memory_block_info(gconstpointer fix)
     QDict *ret, *val;
     int64_t size;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-memory-block-info'}");
+    ret = qga(fixture, "guest-get-memory-block-info");
     g_assert_nonnull(ret);

     /* some systems might not expose memory block info in sysfs */
@@ -352,7 +401,7 @@ static void test_qga_get_memory_blocks(gconstpointer fix)
     QList *list;
     const QListEntry *entry;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-memory-blocks'}");
+    ret = qga(fixture, "guest-get-memory-blocks");
     g_assert_nonnull(ret);

     /* some systems might not expose memory block info in sysfs */
@@ -376,7 +425,7 @@ static void test_qga_network_get_interfaces(gconstpointer fix)
     QList *list;
     const QListEntry *entry;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-network-get-interfaces'}");
+    ret = qga(fixture, "guest-network-get-interfaces");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -393,7 +442,7 @@ static void test_qga_file_ops(gconstpointer fix)
     const TestFixture *fixture = fix;
     const unsigned char helloworld[] = "Hello World!\n";
     const char *b64;
-    gchar *cmd, *path, *enc;
+    gchar *path, *enc;
     unsigned char *dec;
     QDict *ret, *val;
     int64_t id, eof;
@@ -402,8 +451,8 @@ static void test_qga_file_ops(gconstpointer fix)
     char tmp[100];

     /* open */
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-file-open',"
-                 " 'arguments': { 'path': 'foo', 'mode': 'w+' } }");
+    ret = qga_args(fixture, "guest-file-open",
+                   "{ 'path': 'foo', 'mode': 'w+' }");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     id = qdict_get_int(ret, "return");
@@ -411,10 +460,8 @@ static void test_qga_file_ops(gconstpointer fix)

     enc = g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
-    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
-                          " 'arguments': { 'handle': %" PRId64 ","
-                          " 'buf-b64': '%s' } }", id, enc);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-write",
+                   "{ 'handle': %" PRId64 ", 'buf-b64': %s }", id, enc);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -424,23 +471,14 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, ==, sizeof(helloworld));
     g_assert_cmpint(eof, ==, 0);
     QDECREF(ret);
-    g_free(cmd);

     /* flush */
-    cmd = g_strdup_printf("{'execute': 'guest-file-flush',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-flush", "{'handle': %" PRId64 "}", id);
     QDECREF(ret);
-    g_free(cmd);

     /* close */
-    cmd = g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-close", "{'handle': %" PRId64 "}", id);
     QDECREF(ret);
-    g_free(cmd);

     /* check content */
     path = g_build_filename(fixture->test_dir, "foo", NULL);
@@ -454,18 +492,15 @@ static void test_qga_file_ops(gconstpointer fix)
     fclose(f);

     /* open */
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-file-open',"
-                 " 'arguments': { 'path': 'foo', 'mode': 'r' } }");
+    ret = qga_args(fixture, "guest-file-open",
+                   "{ 'path': 'foo', 'mode': 'r' }");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     id = qdict_get_int(ret, "return");
     QDECREF(ret);

     /* read */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-read", "{'handle': %" PRId64 "}", id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -475,14 +510,10 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpstr(b64, ==, enc);

     QDECREF(ret);
-    g_free(cmd);
     g_free(enc);

     /* read eof */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-read", "{'handle': %" PRId64 "}", id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -491,14 +522,11 @@ static void test_qga_file_ops(gconstpointer fix)
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
+    ret = qga_args(fixture, "guest-file-seek",
+                   "{'handle': %" PRId64 ", 'offset': %d, 'whence': %s}",
+                   id, 6, "set");
     qmp_assert_no_error(ret);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "position");
@@ -506,13 +534,9 @@ static void test_qga_file_ops(gconstpointer fix)
     g_assert_cmpint(count, ==, 6);
     g_assert(!eof);
     QDECREF(ret);
-    g_free(cmd);

     /* partial read */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-read", "{'handle': %" PRId64 "}", id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -525,15 +549,10 @@ static void test_qga_file_ops(gconstpointer fix)
     g_free(dec);

     QDECREF(ret);
-    g_free(cmd);

     /* close */
-    cmd = g_strdup_printf("{'execute': 'guest-file-close',"
-                          " 'arguments': {'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-close", "{'handle': %" PRId64 "}", id);
     QDECREF(ret);
-    g_free(cmd);
 }

 static void test_qga_file_write_read(gconstpointer fix)
@@ -541,14 +560,14 @@ static void test_qga_file_write_read(gconstpointer fix)
     const TestFixture *fixture = fix;
     const unsigned char helloworld[] = "Hello World!\n";
     const char *b64;
-    gchar *cmd, *enc;
+    gchar *enc;
     QDict *ret, *val;
     int64_t id, eof;
     gsize count;

     /* open */
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-file-open',"
-                 " 'arguments': { 'path': 'foo', 'mode': 'w+' } }");
+    ret = qga_args(fixture, "guest-file-open",
+                   "{ 'path': 'foo', 'mode': 'w+' }");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     id = qdict_get_int(ret, "return");
@@ -556,10 +575,8 @@ static void test_qga_file_write_read(gconstpointer fix)

     enc = g_base64_encode(helloworld, sizeof(helloworld));
     /* write */
-    cmd = g_strdup_printf("{'execute': 'guest-file-write',"
-                          " 'arguments': { 'handle': %" PRId64 ","
-                          " 'buf-b64': '%s' } }", id, enc);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-write",
+                   "{'handle': %" PRId64 ", 'buf-b64': %s}", id, enc);
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -569,13 +586,9 @@ static void test_qga_file_write_read(gconstpointer fix)
     g_assert_cmpint(count, ==, sizeof(helloworld));
     g_assert_cmpint(eof, ==, 0);
     QDECREF(ret);
-    g_free(cmd);

     /* read (check implicit flush) */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-read", "{'handle': %" PRId64 "}", id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -584,14 +597,11 @@ static void test_qga_file_write_read(gconstpointer fix)
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
+    ret = qga_args(fixture, "guest-file-seek",
+                   "{'handle': %" PRId64 ", 'offset': %d, 'whence': %s}",
+                   id, 0, "set");
     qmp_assert_no_error(ret);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "position");
@@ -599,13 +609,9 @@ static void test_qga_file_write_read(gconstpointer fix)
     g_assert_cmpint(count, ==, 0);
     g_assert(!eof);
     QDECREF(ret);
-    g_free(cmd);

     /* read */
-    cmd = g_strdup_printf("{'execute': 'guest-file-read',"
-                          " 'arguments': { 'handle': %" PRId64 "} }",
-                          id);
-    ret = qmp_fd(fixture->fd, cmd);
+    ret = qga_args(fixture, "guest-file-read", "{'handle': %" PRId64 "}", id);
     val = qdict_get_qdict(ret, "return");
     count = qdict_get_int(val, "count");
     eof = qdict_get_bool(val, "eof");
@@ -614,16 +620,11 @@ static void test_qga_file_write_read(gconstpointer fix)
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
+    ret = qga_args(fixture, "guest-file-close", "{'handle': %" PRId64 "}", id);
     QDECREF(ret);
-    g_free(cmd);
 }

 static void test_qga_get_time(gconstpointer fix)
@@ -632,7 +633,7 @@ static void test_qga_get_time(gconstpointer fix)
     QDict *ret;
     int64_t time;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-time'}");
+    ret = qga(fixture, "guest-get-time");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -651,7 +652,7 @@ static void test_qga_blacklist(gconstpointer data)
     fixture_setup(&fix, "-b guest-ping,guest-get-time", NULL);

     /* check blacklist */
-    ret = qmp_fd(fix.fd, "{'execute': 'guest-ping'}");
+    ret = qga(&fix, "guest-ping");
     g_assert_nonnull(ret);
     error = qdict_get_qdict(ret, "error");
     class = qdict_get_try_str(error, "class");
@@ -660,7 +661,7 @@ static void test_qga_blacklist(gconstpointer data)
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
     QDECREF(ret);

-    ret = qmp_fd(fix.fd, "{'execute': 'guest-get-time'}");
+    ret = qga(&fix, "guest-get-time");
     g_assert_nonnull(ret);
     error = qdict_get_qdict(ret, "error");
     class = qdict_get_try_str(error, "class");
@@ -670,7 +671,7 @@ static void test_qga_blacklist(gconstpointer data)
     QDECREF(ret);

     /* check something work */
-    ret = qmp_fd(fix.fd, "{'execute': 'guest-get-fsinfo'}");
+    ret = qga(&fix, "guest-get-fsinfo");
     qmp_assert_no_error(ret);
     QDECREF(ret);

@@ -762,7 +763,7 @@ static void test_qga_fsfreeze_status(gconstpointer fix)
     QDict *ret;
     const gchar *status;

-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-fsfreeze-status'}");
+    ret = qga(fixture, "guest-fsfreeze-status");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

@@ -781,12 +782,11 @@ static void test_qga_guest_exec(gconstpointer fix)
     int64_t pid, now, exitcode;
     gsize len;
     bool exited;
-    char *cmd;

     /* exec 'echo foo bar' */
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/echo', 'arg': [ '-n', '\" test_str \"' ],"
-                 " 'capture-output': true } }");
+    ret = qga_args(fixture, "guest-exec",
+                 "{ 'path': '/bin/echo', 'arg': [ '-n', '\" test_str \"' ],"
+                 " 'capture-output': true }");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);
     val = qdict_get_qdict(ret, "return");
@@ -796,10 +796,9 @@ static void test_qga_guest_exec(gconstpointer fix)

     /* wait for completion */
     now = g_get_monotonic_time();
-    cmd = g_strdup_printf("{'execute': 'guest-exec-status',"
-                          " 'arguments': { 'pid': %" PRId64 " } }", pid);
     do {
-        ret = qmp_fd(fixture->fd, cmd);
+        ret = qga_args(fixture, "guest-exec-status", "{'pid': %" PRId64 "}",
+                       pid);
         g_assert_nonnull(ret);
         val = qdict_get_qdict(ret, "return");
         exited = qdict_get_bool(val, "exited");
@@ -809,7 +808,6 @@ static void test_qga_guest_exec(gconstpointer fix)
     } while (!exited &&
              g_get_monotonic_time() < now + 5 * G_TIME_SPAN_SECOND);
     g_assert(exited);
-    g_free(cmd);

     /* check stdout */
     exitcode = qdict_get_int(val, "exitcode");
@@ -829,8 +827,7 @@ static void test_qga_guest_exec_invalid(gconstpointer fix)
     const gchar *class, *desc;

     /* invalid command */
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
-                 " 'path': '/bin/invalid-cmd42' } }");
+    ret = qga_args(fixture, "guest-exec", "{ 'path': '/bin/invalid-cmd42' }");
     g_assert_nonnull(ret);
     error = qdict_get_qdict(ret, "error");
     g_assert_nonnull(error);
@@ -841,8 +838,7 @@ static void test_qga_guest_exec_invalid(gconstpointer fix)
     QDECREF(ret);

     /* invalid pid */
-    ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec-status',"
-                 " 'arguments': { 'pid': 0 } }");
+    ret = qga_args(fixture, "guest-exec-status", "{ 'pid': 0 }");
     g_assert_nonnull(ret);
     error = qdict_get_qdict(ret, "error");
     g_assert_nonnull(error);
@@ -868,7 +864,7 @@ static void test_qga_guest_get_osinfo(gconstpointer data)
     g_free(cwd);
     fixture_setup(&fixture, NULL, env);

-    ret = qmp_fd(fixture.fd, "{'execute': 'guest-get-osinfo'}");
+    ret = qga(&fixture, "guest-get-osinfo");
     g_assert_nonnull(ret);
     qmp_assert_no_error(ret);

-- 
2.13.3
