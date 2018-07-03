Received: from eggs.gnu.org ([2001:4830:134:3::10]:52993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0001Rd-9e
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4U-0007CQ-7N
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4U-0007Bp-0C
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:31 +0200
Message-Id: <20180703085358.13941-6-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/32] qmp: Get rid of x-oob-test command
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

tests/qmp-test tests an out-of-band command overtaking a slow in-band
command.  To do that, it needs:

1. An in-band command that *reliably* takes long enough to be
   overtaken.

2. An out-of-band command to do the overtaking.

3. To avoid delays, a way to make the in-band command complete quickly
   after it was overtaken.

To satisfy these needs, commit 469638f9cb3 provides the rather
peculiar oob-capable QMP command x-oob-test:

* With "lock": true, it waits for a global semaphore.

* With "lock": false, it signals the global semaphore.

To satisfy 1., the test runs x-oob-test in-band with "lock": true.
To satisfy 2. and 3., it runs x-oob-test out-of-band with "lock": false.

Note that waiting for a semaphore violates the rules for oob-capable
commands.  Running x-oob-test with "lock": true hangs the monitor
until you run x-oob-test with "lock": false on another monitor (which
you might not have set up).

Having an externally visible QMP command that may hang the monitor is
not nice.  Let's apply a little more ingenuity to the problem.  Idea:
have an existing command block on reading a FIFO special file, unblock
it by opening the FIFO for writing.

For 1., use

    {"execute": "blockdev-add",  "id": ID1,
     "arguments": {
        "driver": "blkdebug", "node-name": ID1, "config": FIFO,
        "image": { "driver": "null-co"}}}

where ID1 is an arbitrary string, and FIFO is the name of the FIFO.

For 2., use

    {"execute": "migrate-pause", "id": ID2, "control": {"run-oob": true}}

where ID2 is a different arbitrary string.  Since there's no migration
to pause, the command will fail, but that's fine; instant failure is
still a test of out-of-band responses overtaking in-band commands.

For 3., open FIFO for writing.

Drop QMP command x-oob-test.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/misc.json   | 18 ---------
 qmp.c            | 16 --------
 tests/qmp-test.c | 96 +++++++++++++++++++++++++++++++++---------------
 3 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 74cd97f237..f1860418e8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3472,24 +3472,6 @@
 { 'event': 'COMMAND_DROPPED' ,
   'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
 
-##
-# @x-oob-test:
-#
-# Test OOB functionality.  When sending this command with lock=true,
-# it'll try to hang the dispatcher.  When sending it with lock=false,
-# it'll try to notify the locked thread to continue.  Note: it should
-# only be used by QMP test program rather than anything else.
-#
-# Since: 2.12
-#
-# Example:
-#
-# { "execute": "x-oob-test",
-#   "arguments": { "lock": true } }
-##
-{ 'command': 'x-oob-test', 'data' : { 'lock': 'bool' },
-  'allow-oob': true }
-
 ##
 # @set-numa-node:
 #
diff --git a/qmp.c b/qmp.c
index 73e46d795f..62325ac6aa 100644
--- a/qmp.c
+++ b/qmp.c
@@ -775,19 +775,3 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
     return mem_info;
 }
-
-static QemuSemaphore x_oob_test_sem;
-
-static void __attribute__((constructor)) x_oob_test_init(void)
-{
-    qemu_sem_init(&x_oob_test_sem, 0);
-}
-
-void qmp_x_oob_test(bool lock, Error **errp)
-{
-    if (lock) {
-        qemu_sem_wait(&x_oob_test_sem);
-    } else {
-        qemu_sem_post(&x_oob_test_sem);
-    }
-}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5206b14ca6..6dd331fcdd 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -135,16 +135,67 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }
 
-/* Tests for out-of-band support. */
+/* Out-of-band tests */
+
+char tmpdir[] = "/tmp/qmp-test-XXXXXX";
+char *fifo_name;
+
+static void setup_blocking_cmd(void)
+{
+    int rc;
+
+    if (!mkdtemp(tmpdir)) {
+        g_error("mkdtemp: %s", strerror(errno));
+    }
+    fifo_name = g_strdup_printf("%s/fifo", tmpdir);
+    rc = mkfifo(fifo_name, 0666);
+    g_assert(!rc);
+}
+
+static void cleanup_blocking_cmd(void)
+{
+    unlink(fifo_name);
+    rmdir(tmpdir);
+}
+
+static void send_cmd_that_blocks(QTestState *s, const char *id)
+{
+    qtest_async_qmp(s, "{ 'execute': 'blockdev-add',  'id': %s,"
+                    " 'arguments': {"
+                    " 'driver': 'blkdebug', 'node-name': %s,"
+                    " 'config': %s,"
+                    " 'image': { 'driver': 'null-co' } } }",
+                    id, id, fifo_name);
+}
+
+static void unblock_blocked_cmd(void)
+{
+    int fd = open(fifo_name, O_WRONLY);
+    g_assert(fd >= 0);
+    close(fd);
+}
+
+static void send_oob_cmd_that_fails(QTestState *s, const char *id)
+{
+    qtest_async_qmp(s, "{ 'execute': 'migrate-pause', 'id': %s,"
+                    "  'control': { 'run-oob': true } }", id);
+}
+
+static void recv_cmd_id(QTestState *s, const char *id)
+{
+    QDict *resp = qtest_qmp_receive(s);
+
+    g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, id);
+    qobject_unref(resp);
+}
+
 static void test_qmp_oob(void)
 {
     QTestState *qts;
     QDict *resp, *q;
-    int acks = 0;
     const QListEntry *entry;
     QList *capabilities;
     QString *qstr;
-    const char *cmd_id;
 
     qts = qtest_init_without_qmp_handshake(true, common_args);
 
@@ -185,37 +236,20 @@ static void test_qmp_oob(void)
     g_assert(qdict_haskey(resp, "error"));
     qobject_unref(resp);
 
-    /*
-     * First send the "x-oob-test" command with lock=true and
-     * oob=false, it should hang the dispatcher and main thread;
-     * later, we send another lock=false with oob=true to continue
-     * that thread processing.  Finally we should receive replies from
-     * both commands.
-     */
-    qtest_async_qmp(qts,
-                    "{ 'execute': 'x-oob-test',"
-                    "  'arguments': { 'lock': true }, "
-                    "  'id': 'lock-cmd'}");
-    qtest_async_qmp(qts,
-                    "{ 'execute': 'x-oob-test', "
-                    "  'arguments': { 'lock': false }, "
-                    "  'control': { 'run-oob': true }, "
-                    "  'id': 'unlock-cmd' }");
-
-    /* Ignore all events.  Wait for 2 acks */
-    while (acks < 2) {
-        resp = qtest_qmp_receive(qts);
-        cmd_id = qdict_get_str(resp, "id");
-        if (!g_strcmp0(cmd_id, "lock-cmd") ||
-            !g_strcmp0(cmd_id, "unlock-cmd")) {
-            acks++;
-        }
-        qobject_unref(resp);
-    }
+    /* OOB command overtakes slow in-band command */
+    setup_blocking_cmd();
+    send_cmd_that_blocks(qts, "ib-blocks-1");
+    send_oob_cmd_that_fails(qts, "oob-1");
+    recv_cmd_id(qts, "oob-1");
+    unblock_blocked_cmd();
+    recv_cmd_id(qts, "ib-blocks-1");
+    cleanup_blocking_cmd();
 
     qtest_quit(qts);
 }
 
+/* Query smoke tests */
+
 static int query_error_class(const char *cmd)
 {
     static struct {
@@ -392,6 +426,8 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
+/* Preconfig tests */
+
 static void test_qmp_preconfig(void)
 {
     QDict *rsp, *ret;
-- 
2.17.1
