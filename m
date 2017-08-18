Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dioca-00071F-1A
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocX-0000rl-9T
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diocW-0000pA-ST
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBDD6C04B952
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 21:15:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:39 -0500
Message-Id: <20170818211542.5380-11-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/13] libqtest: Drop qtest_init() and
 qtest_qmp_discard_response()
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

Most of our tests were using qtest_start() to initialize the
connection and then set global_qtest; the few tests that were
using qtest_init() instead are still setting global_qtest shortly
afterwards.  So it makes more sense to just always set
global_qtest, and have all callers go through a single entry
point.

Furthermore, we already have another qtest_init() in
include/sysemu/qtest.h, with a different signature - which makes
it hard to trace which version is being called based on what was
being included.

So, morph qtest_init() into qtest_start(), and hoist the setting
of global_qtest earlier during initialization; which in turn lets
the initialization sequence also benefit from the global variable.
For now, having a separate qtest_end() and qtest_quit() still
makes some tests easier, but hoisting the declaration so the two
are side-by-side makes the overall lifecycle management of
global_qtest easier to see.

While reworking things, prefer 0-initialization, and simplify the
initial handshake work; rendering qtest_qmp_discard_response()
unused.  As a bonus: it removes one spot passing an empty string
through varargs, so we are one step closer to using compile-time
format checking on qmp() without tripping over -Wformat-zero-length.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h        | 61 ++++++++++++-------------------------------------
 tests/libqtest.c        | 45 +++++++++++++-----------------------
 tests/postcopy-test.c   |  2 +-
 tests/qmp-test.c        |  2 +-
 tests/vhost-user-test.c |  3 ++-
 5 files changed, 35 insertions(+), 78 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 28945b3f7f..dca62fd8da 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -24,20 +24,23 @@ typedef struct QTestState QTestState;
 extern QTestState *global_qtest;

 /**
- * qtest_init:
+ * qtest_start:
  * @extra_args: other arguments to pass to QEMU.
  *
+ * Start QEMU, and complete the QMP handshake. Sets #global_qtest, which
+ * is returned for convenience.
+ *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init(const char *extra_args);
+QTestState *qtest_start(const char *extra_args);

 /**
- * qtest_init_without_qmp_handshake:
+ * qtest_start_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.
  *
- * Returns: #QTestState instance.
+ * Starts the connection, but does no handshakes; sets #global_qtest.
  */
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
+void qtest_start_without_qmp_handshake(const char *extra_args);

 /**
  * qtest_quit:
@@ -48,13 +51,15 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 void qtest_quit(QTestState *s);

 /**
- * qtest_qmp_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu
+ * qtest_end:
  *
- * Sends a QMP message to QEMU and consumes the response.
+ * Shut down the current #global_qtest QEMU process.
  */
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...);
+static inline void qtest_end(void)
+{
+    qtest_quit(global_qtest);
+    global_qtest = NULL;
+}

 /**
  * qtest_qmp:
@@ -75,16 +80,6 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
 void qtest_async_qmp(QTestState *s, const char *fmt, ...);

 /**
- * qtest_qmpv_discard_response:
- * @s: #QTestState instance to operate on.
- * @fmt: QMP message to send to QEMU
- * @ap: QMP message arguments
- *
- * Sends a QMP message to QEMU and consumes the response.
- */
-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap);
-
-/**
  * qtest_qmpv:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU
@@ -506,32 +501,6 @@ void qtest_add_data_func_full(const char *str, void *data,
 void qtest_add_abrt_handler(GHookFunc fn, const void *data);

 /**
- * qtest_start:
- * @args: other arguments to pass to QEMU
- *
- * Start QEMU and assign the resulting #QTestState to a global variable.
- * The global variable is used by "shortcut" functions documented below.
- *
- * Returns: #QTestState instance.
- */
-static inline QTestState *qtest_start(const char *args)
-{
-    global_qtest = qtest_init(args);
-    return global_qtest;
-}
-
-/**
- * qtest_end:
- *
- * Shut down the QEMU process started by qtest_start().
- */
-static inline void qtest_end(void)
-{
-    qtest_quit(global_qtest);
-    global_qtest = NULL;
-}
-
-/**
  * qmp:
  * @fmt...: QMP message to send to qemu
  *
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 261d86df5a..c4e41261ab 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -266,7 +266,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data)
     g_hook_prepend(&abrt_hooks, hook);
 }

-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+void qtest_start_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -282,7 +282,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
         exit(1);
     }

-    s = g_malloc(sizeof(*s));
+    global_qtest = s = g_malloc0(sizeof(*s));

     socket_path = g_strdup_printf("/tmp/qtest-%d.sock", getpid());
     qmp_socket_path = g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
@@ -338,24 +338,26 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     }

     /* ask endianness of the target */
-    qtest_sendf(s, "endianness\n");
-    args = qtest_rsp(s, 1);
+    qtest_sendf(global_qtest, "endianness\n");
+    args = qtest_rsp(global_qtest, 1);
     g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
     s->big_endian = strcmp(args[1], "big") == 0;
     g_strfreev(args);
-
-    return s;
 }

-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_start(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    QDict *rsp;
+
+    qtest_start_without_qmp_handshake(extra_args);

     /* Read the QMP greeting and then do the handshake */
-    qtest_qmp_discard_response(s, "");
-    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
+    rsp = qmp_fd_receive(global_qtest->qmp_fd);
+    QDECREF(rsp);
+    rsp = qmp("{ 'execute': 'qmp_capabilities' }");
+    QDECREF(rsp);

-    return s;
+    return global_qtest;
 }

 void qtest_quit(QTestState *s)
@@ -539,23 +541,6 @@ void qtest_async_qmp(QTestState *s, const char *fmt, ...)
     va_end(ap);
 }

-void qtest_qmpv_discard_response(QTestState *s, const char *fmt, va_list ap)
-{
-    QDict *response = qtest_qmpv(s, fmt, ap);
-    QDECREF(response);
-}
-
-void qtest_qmp_discard_response(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-    QDict *response;
-
-    va_start(ap, fmt);
-    response = qtest_qmpv(s, fmt, ap);
-    va_end(ap);
-    QDECREF(response);
-}
-
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event)
 {
     QDict *response;
@@ -930,10 +915,12 @@ void qmp_async(const char *fmt, ...)
 void qmp_discard_response(const char *fmt, ...)
 {
     va_list ap;
+    QDict *response;

     va_start(ap, fmt);
-    qtest_qmpv_discard_response(global_qtest, fmt, ap);
+    response = qtest_qmpv(global_qtest, fmt, ap);
     va_end(ap);
+    QDECREF(response);
 }
 char *hmp(const char *fmt, ...)
 {
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 9c4e37473d..91419ee3cb 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -404,7 +404,7 @@ static void test_migrate(void)
     from = qtest_start(cmd_src);
     g_free(cmd_src);

-    to = qtest_init(cmd_dst);
+    to = qtest_start(cmd_dst);
     g_free(cmd_dst);

     global_qtest = from;
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5d0260b2be..3f1176f7f8 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -75,7 +75,7 @@ static void test_qmp_protocol(void)
     QDict *resp, *q, *ret;
     QList *capabilities;

-    global_qtest = qtest_init_without_qmp_handshake(common_args);
+    qtest_start_without_qmp_handshake(common_args);

     /* Test greeting */
     resp = qmp_receive();
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index d4da09f147..0518474b3a 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -646,7 +646,8 @@ static void test_migrate(void)
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));

     cmd = GET_QEMU_CMDE(dest, 2, "", " -incoming %s", uri);
-    to = qtest_init(cmd);
+    to = qtest_start(cmd);
+    global_qtest = from;
     g_free(cmd);

     source = g_source_new(&test_migrate_source_funcs,
-- 
2.13.5
