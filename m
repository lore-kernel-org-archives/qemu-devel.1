Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPj-0000Aw-HL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSPg-0001qp-QL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:22:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:22 -0500
Message-Id: <20170911172022.4738-39-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 38/38] libqtest: Merge qtest_hmp() with hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:IDE" <qemu-block@nongnu.org>

Maintaining two layers of libqtest APIs, one that takes an explicit
QTestState object, and the other that uses the implicit global_qtest,
is annoying.  In the interest of getting rid of global implicit
state and having less code to maintain, merge:
 qtest_hmp()
with its short counterpart, and delete qtest_hmpv() as unused (not
to mention that a 'v' suffix is unusual, when compared to the
printf family or even our new qtest_vstartf() where the va_list
counterpart uses 'v' as a prefix).  All callers that previously
used the short form now make it explicit that they are relying on
global_qtest, and later patches can then clean things up to remove
the global variable.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.h               | 27 ++-------------------------
 tests/libqtest.c               | 26 ++++----------------------
 tests/device-introspect-test.c |  6 +++---
 tests/drive_del-test.c         |  4 ++--
 tests/ide-test.c               |  4 ++--
 tests/numa-test.c              |  6 +++---
 tests/test-hmp.c               |  6 +++---
 7 files changed, 19 insertions(+), 60 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index b811394d4d..34986955d3 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -140,7 +140,7 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);

 /**
- * qtest_hmp:
+ * hmp:
  * @s: #QTestState instance to operate on.
  * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
  *
@@ -149,20 +149,7 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
-
-/**
- * qtest_hmpv:
- * @s: #QTestState instance to operate on.
- * @fmt: HMP command to send to QEMU
- * @ap: HMP command arguments
- *
- * Send HMP command to QEMU via QMP's human-monitor-command.
- * QMP events are discarded.
- *
- * Returns: the command's output.  The caller should g_free() it.
- */
-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap);
+char *hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);

 /**
  * get_irq:
@@ -570,16 +557,6 @@ static inline QDict *qmp_eventwait_ref(const char *event)
     return qtest_qmp_eventwait_ref(global_qtest, event);
 }

-/**
- * hmp:
- * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
- *
- * Send HMP command to QEMU via QMP's human-monitor-command.
- *
- * Returns: the command's output.  The caller should g_free() it.
- */
-char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-
 QDict *qmp_fd_receive(int fd);
 void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
 void qmp_fd_send(int fd, const char *fmt, ...);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 747411b5b5..1641c3ae4c 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -596,13 +596,16 @@ void qtest_qmp_eventwait(QTestState *s, const char *event)
     QDECREF(response);
 }

-char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
+char *hmp(QTestState *s, const char *fmt, ...)
 {
+    va_list ap;
     char *cmd;
     QDict *resp;
     char *ret;

+    va_start(ap, fmt);
     cmd = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
     resp = qtest_qmp(s, "{'execute': 'human-monitor-command',"
                      " 'arguments': {'command-line': %s}}",
                      cmd);
@@ -619,17 +622,6 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
     return ret;
 }

-char *qtest_hmp(QTestState *s, const char *fmt, ...)
-{
-    va_list ap;
-    char *ret;
-
-    va_start(ap, fmt);
-    ret = qtest_hmpv(s, fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
 const char *qtest_get_arch(void)
 {
     const char *qemu = getenv("QTEST_QEMU_BINARY");
@@ -952,16 +944,6 @@ void qmp_discard_response(void)

     QDECREF(response);
 }
-char *hmp(const char *fmt, ...)
-{
-    va_list ap;
-    char *ret;
-
-    va_start(ap, fmt);
-    ret = qtest_hmpv(global_qtest, fmt, ap);
-    va_end(ap);
-    return ret;
-}

 bool qtest_big_endian(QTestState *s)
 {
diff --git a/tests/device-introspect-test.c b/tests/device-introspect-test.c
index ed4f5f2eed..7dbd27330a 100644
--- a/tests/device-introspect-test.c
+++ b/tests/device-introspect-test.c
@@ -110,14 +110,14 @@ static void test_one_device(const char *type)
                type);
     QDECREF(resp);

-    help = hmp("device_add \"%s,help\"", type);
+    help = hmp(global_qtest, "device_add \"%s,help\"", type);
     g_free(help);

     /*
      * Some devices leave dangling pointers in QOM behind.
      * "info qom-tree" has a good chance at crashing then
      */
-    qom_tree = hmp("info qom-tree");
+    qom_tree = hmp(global_qtest, "info qom-tree");
     g_free(qom_tree);
 }

@@ -131,7 +131,7 @@ static void test_device_intro_list(void)
     types = device_type_list(true);
     QDECREF(types);

-    help = hmp("device_add help");
+    help = hmp(global_qtest, "device_add help");
     g_free(help);

     qtest_quit(global_qtest);
diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 0fde0c2040..6b53ac5a1a 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -15,7 +15,7 @@

 static void drive_add(void)
 {
-    char *resp = hmp("drive_add 0 if=none,id=drive0");
+    char *resp = hmp(global_qtest, "drive_add 0 if=none,id=drive0");

     g_assert_cmpstr(resp, ==, "OK\r\n");
     g_free(resp);
@@ -23,7 +23,7 @@ static void drive_add(void)

 static void drive_del(void)
 {
-    char *resp = hmp("drive_del drive0");
+    char *resp = hmp(global_qtest, "drive_del drive0");

     g_assert_cmpstr(resp, ==, "");
     g_free(resp);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index 6ba3a8589d..5e7fa6e461 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -587,7 +587,7 @@ static void test_flush(void)
     make_dirty(0);

     /* Delay the completion of the flush request until we explicitly do it */
-    g_free(hmp("qemu-io ide0-hd0 \"break flush_to_os A\""));
+    g_free(hmp(global_qtest, "qemu-io ide0-hd0 \"break flush_to_os A\""));

     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -599,7 +599,7 @@ static void test_flush(void)
     assert_bit_clear(data, DF | ERR | DRQ);

     /* Complete the command */
-    g_free(hmp("qemu-io ide0-hd0 \"resume A\""));
+    g_free(hmp(global_qtest, "qemu-io ide0-hd0 \"resume A\""));

     /* Check registers */
     data = qpci_io_readb(dev, ide_bar, reg_device);
diff --git a/tests/numa-test.c b/tests/numa-test.c
index e2f6c68be8..a7e2b183f7 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -21,7 +21,7 @@ static void test_mon_explicit(const void *data)
                                 "-numa node,nodeid=0,cpus=0-3 "
                                 "-numa node,nodeid=1,cpus=4-7 ", args);

-    s = hmp("info numa");
+    s = hmp(global_qtest, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3"));
     g_assert(strstr(s, "node 1 cpus: 4 5 6 7"));
     g_free(s);
@@ -36,7 +36,7 @@ static void test_mon_default(const void *data)

     global_qtest = qtest_startf("%s -smp 8 -numa node -numa node", args);

-    s = hmp("info numa");
+    s = hmp(global_qtest, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 2 4 6"));
     g_assert(strstr(s, "node 1 cpus: 1 3 5 7"));
     g_free(s);
@@ -53,7 +53,7 @@ static void test_mon_partial(const void *data)
                                 "-numa node,nodeid=0,cpus=0-1 "
                                 "-numa node,nodeid=1,cpus=4-5 ", args);

-    s = hmp("info numa");
+    s = hmp(global_qtest, "info numa");
     g_assert(strstr(s, "node 0 cpus: 0 1 2 3 6 7"));
     g_assert(strstr(s, "node 1 cpus: 4 5"));
     g_free(s);
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index b3102daea1..e670a5ee6c 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -80,7 +80,7 @@ static void test_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", hmp_cmds[i]);
         }
-        response = hmp("%s", hmp_cmds[i]);
+        response = hmp(global_qtest, "%s", hmp_cmds[i]);
         g_free(response);
     }

@@ -91,7 +91,7 @@ static void test_info_commands(void)
 {
     char *resp, *info, *info_buf, *endp;

-    info_buf = info = hmp("help info");
+    info_buf = info = hmp(global_qtest, "help info");

     while (*info) {
         /* Extract the info command, ignore parameters and description */
@@ -103,7 +103,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp = hmp("%s", info);
+        resp = hmp(global_qtest, "%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info = strchr(endp + 1, '\n');
-- 
2.13.5
