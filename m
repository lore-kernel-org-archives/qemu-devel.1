Received: from eggs.gnu.org ([2001:4830:134:3::10]:38871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOx-0007sI-4C
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSOt-0001QK-3I
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSOs-0001Q5-QY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC9F0279AF5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:21:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:11 -0500
Message-Id: <20170911172022.4738-28-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 27/38] libqtest: Swap order of qtest_init()
 and qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com

We already have another qtest_init() in the tree (namely, as part
of the device initialization of the qtest device at the top level
qtest.c), with a different signature; having two different
qtest_init() is confusing, so an upcoming patch will consolidate
all testsuite callers onto a unified spelling.  But the
consolidation is easier if qtest_start() is further down the call
chain, rather than an intermediate wrapper, so swap the call chain
around.  This includes renaming qtest_init_without_qmp_handshake()
into qtest_start_without_qmp_handshake(), as it remains the lowest
point in the call stack.

Note that qtest_init() now asserts that global_qtest was not set
on entry, and clears it on exit, to preserve the behavior of
existing tests that assert the same (and also proving that we
fixed all tests that had parallel connections); but later patches
will eventually simplify things by getting rid of qtest_init()
and global_qtest altogether.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h | 52 ++++++++++++++++++++++++++++------------------------
 tests/libqtest.c |  9 +++++----
 tests/qmp-test.c |  2 +-
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index d976a542b8..9ef0fbefea 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -24,20 +24,39 @@ typedef struct QTestState QTestState;
 extern QTestState *global_qtest;

 /**
+ * qtest_start_without_qmp_handshake:
+ * @extra_args: other arguments to pass to QEMU.
+ *
+ * Returns: #QTestState instance.  Does not affect #global_qtest.
+ */
+QTestState *qtest_start_without_qmp_handshake(const char *extra_args);
+
+/**
+ * qtest_start:
+ * @args: other arguments to pass to QEMU
+ *
+ * Start QEMU and assign the resulting #QTestState to #global_qtest.
+ * The global variable is used by "shortcut" functions documented below.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_start(const char *args);
+
+/**
  * qtest_init:
  * @extra_args: other arguments to pass to QEMU.
  *
- * Returns: #QTestState instance.
+ * Returns: #QTestState instance.  Does not affect #global_qtest.
  */
-QTestState *qtest_init(const char *extra_args);
+static inline QTestState *qtest_init(const char *extra_args)
+{
+    QTestState *s;

-/**
- * qtest_init_without_qmp_handshake:
- * @extra_args: other arguments to pass to QEMU.
- *
- * Returns: #QTestState instance.
- */
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
+    assert(!global_qtest);
+    s = qtest_start(extra_args);
+    global_qtest = NULL;
+    return s;
+}

 /**
  * qtest_quit:
@@ -508,21 +527,6 @@ void qtest_add_data_func_full(const char *str, void *data,
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
  * qmp:
  * @fmt...: QMP message to send to qemu
  *
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 94c157ce02..e8c2e11817 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -152,7 +152,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data)
     g_hook_prepend(&abrt_hooks, hook);
 }

-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+QTestState *qtest_start_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -233,15 +233,16 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return s;
 }

-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_start(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    QTestState *s = qtest_start_without_qmp_handshake(extra_args);

     /* Read the QMP greeting and then do the handshake */
     qtest_qmp_discard_response(s, "");
     qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");

-    return s;
+    assert(!global_qtest);
+    return global_qtest = s;
 }

 void qtest_quit(QTestState *s)
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index a31c0f7de1..8985e7f9ec 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -77,7 +77,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     QTestState *qts;

-    qts = qtest_init_without_qmp_handshake(common_args);
+    qts = qtest_start_without_qmp_handshake(common_args);

     /* Test greeting */
     resp = qtest_qmp_receive(qts);
-- 
2.13.5
