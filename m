Received: from eggs.gnu.org ([2001:4830:134:3::10]:54814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkg-00057A-LS
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tke-0002ij-Hq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tke-0002fO-CR
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:39 +0200
Message-Id: <20180326150916.9602-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/38] HACK: add back OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This adds back temporarily OOB for the sake of automated testing and
for the rest of the patches that are based upon OOB, as well as a few
pending fixes squashed together.

Revert "qapi: Force UTF8 encoding when parsing qapi files"

This reverts commit 39615354fc07af34e04ab5efb5b6d478b0d24e32.

Revert "Revert "monitor: enable IO thread for (qmp & !mux) typed""

This reverts commit a4f90923b520f1dc0a768634877eb412e5052c26.

Revert "Revert "tests: qmp-test: verify command batching""

This reverts commit cc797607c03722871a030f8a64d800a8df93b5b2.

Revert "Revert "tests: qmp-test: add oob test""

This reverts commit 4fd78ad7934bbd002da8ea420ce16f73ad23f417.

monitor: fix expected qmp_capabilities error description regression

Fix regression introduced in commit cf869d53172920536a14180a83292b240e9d0=
545:

Before:
{"execute":"foo"}
{"error": {"class": "CommandNotFound", "desc": "Expecting capabilities ne=
gotiation with 'qmp_capabilities'"}}

After:
{"execute":"foo"}
{"error": {"class": "CommandNotFound", "desc": "The command foo has not b=
een found"}}

Because qmp_cmd_oob_check() happens before
monitor_qmp_dispatch_one(). Move the error manipulation code to
monitor_qmp_respond() instead.

migration: fix pfd leak

Fix leak spotted by ASAN:

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7fe1abb80a38 in __interceptor_calloc (/lib64/libasan.so.4+0xdea3=
8)
    #1 0x7fe1aaf1bf75 in g_malloc0 ../glib/gmem.c:124
    #2 0x7fe1aaf1c249 in g_malloc0_n ../glib/gmem.c:355
    #3 0x55f4841cfaa9 in postcopy_ram_fault_thread /home/elmarco/src/qemu=
/migration/postcopy-ram.c:596
    #4 0x55f48479447b in qemu_thread_start /home/elmarco/src/qemu/util/qe=
mu-thread-posix.c:504
    #5 0x7fe1a043550a in start_thread (/lib64/libpthread.so.0+0x750a)

Regression introduced with commit 00fa4fc85b00f1a8a810068d158a7a66e88658e=
b.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/postcopy-ram.c |  1 +
 monitor.c                | 30 +++++++------
 tests/qmp-test.c         | 97 +++++++++++++++++++++++++++++++++++++++-
 tests/Makefile.include   |  6 +--
 4 files changed, 116 insertions(+), 18 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index efd77939af..4a0b33b373 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -754,6 +754,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
         }
     }
     trace_postcopy_ram_fault_thread_exit();
+    g_free(pfd);
     return NULL;
 }
=20
diff --git a/monitor.c b/monitor.c
index 77f4c41cfa..d57bbbb134 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
+#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -3996,6 +3997,18 @@ static void monitor_qmp_respond(Monitor *mon, QObj=
ect *rsp,
             qdict_put_obj(qobject_to(QDict, rsp), "id", id);
         }
=20
+        if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
+            qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
+            if (qdict
+                && !g_strcmp0(qdict_get_try_str(qdict, "class"),
+                          QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOU=
ND))) {
+                /* Provide a more useful error message */
+                qdict_del(qdict, "desc");
+                qdict_put_str(qdict, "desc", "Expecting capabilities"
+                              " negotiation with 'qmp_capabilities'");
+            }
+        }
+
         monitor_json_emitter(mon, rsp);
     }
=20
@@ -4027,7 +4040,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
 {
     Monitor *mon, *old_mon;
     QObject *req, *rsp =3D NULL, *id;
-    QDict *qdict =3D NULL;
     bool need_resume;
=20
     req =3D req_obj->req;
@@ -4050,18 +4062,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
eq_obj)
=20
     cur_mon =3D old_mon;
=20
-    if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
-        qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error");
-        if (qdict
-            && !g_strcmp0(qdict_get_try_str(qdict, "class"),
-                    QapiErrorClass_str(ERROR_CLASS_COMMAND_NOT_FOUND))) =
{
-            /* Provide a more useful error message */
-            qdict_del(qdict, "desc");
-            qdict_put_str(qdict, "desc", "Expecting capabilities negotia=
tion"
-                          " with 'qmp_capabilities'");
-        }
-    }
-
     /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, NULL, id);
=20
@@ -4536,8 +4536,10 @@ static void monitor_qmp_setup_handlers_bh(void *op=
aque)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon =3D g_malloc(sizeof(*mon));
+    /* Enable IOThread for QMPs that are not using MUX chardev backends.=
 */
+    bool use_io_thr =3D (!CHARDEV_IS_MUX(chr)) && (flags & MONITOR_USE_C=
ONTROL);
=20
-    monitor_data_init(mon, false, false);
+    monitor_data_init(mon, false, use_io_thr);
=20
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags =3D flags;
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 558e83540c..07c0b87e27 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -80,6 +80,9 @@ static void test_qmp_protocol(void)
     QDict *resp, *q, *ret;
     QList *capabilities;
     QTestState *qts;
+    const QListEntry *entry;
+    QString *qstr;
+    int i;
=20
     qts =3D qtest_init_without_qmp_handshake(common_args);
=20
@@ -89,7 +92,13 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities =3D qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities && qlist_empty(capabilities));
+    g_assert(capabilities);
+    entry =3D qlist_first(capabilities);
+    g_assert(entry);
+    qstr =3D qobject_to(QString, entry->value);
+    g_assert(qstr);
+    g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "oob");
+    QDECREF(resp);
=20
     /* Test valid command before handshake */
     resp =3D qtest_qmp(qts, "{ 'execute': 'query-version' }");
@@ -131,9 +140,94 @@ static void test_qmp_protocol(void)
     g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
     QDECREF(resp);
=20
+    /*
+     * Test command batching.  In current test OOB is not enabled, we
+     * should be able to run as many commands in batch as we like.
+     * Using 16 (>8, which is OOB queue length) to make sure OOB won't
+     * break existing clients.  Note: this test does not control the
+     * scheduling of QEMU's QMP command processing threads so it may
+     * not really trigger batching inside QEMU.  This is just a
+     * best-effort test.
+     */
+    for (i =3D 0; i < 16; i++) {
+        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");
+    }
+    /* Verify the replies to make sure no command is dropped. */
+    for (i =3D 0; i < 16; i++) {
+        resp =3D qtest_qmp_receive(qts);
+        /* It should never be dropped.  Each of them should be a reply. =
*/
+        g_assert(qdict_haskey(resp, "return"));
+        g_assert(!qdict_haskey(resp, "event"));
+        QDECREF(resp);
+    }
+
     qtest_quit(qts);
 }
=20
+/* Tests for Out-Of-Band support. */
+static void test_qmp_oob(void)
+{
+    QDict *resp;
+    int acks =3D 0;
+    const char *cmd_id;
+
+    global_qtest =3D qtest_init_without_qmp_handshake(common_args);
+
+    /* Ignore the greeting message. */
+    resp =3D qmp_receive();
+    g_assert(qdict_get_qdict(resp, "QMP"));
+    QDECREF(resp);
+
+    /* Try a fake capability, it should fail. */
+    resp =3D qmp("{ 'execute': 'qmp_capabilities', "
+               "  'arguments': { 'enable': [ 'cap-does-not-exist' ] } }"=
);
+    g_assert(qdict_haskey(resp, "error"));
+    QDECREF(resp);
+
+    /* Now, enable OOB in current QMP session, it should succeed. */
+    resp =3D qmp("{ 'execute': 'qmp_capabilities', "
+               "  'arguments': { 'enable': [ 'oob' ] } }");
+    g_assert(qdict_haskey(resp, "return"));
+    QDECREF(resp);
+
+    /*
+     * Try any command that does not support OOB but with OOB flag. We
+     * should get failure.
+     */
+    resp =3D qmp("{ 'execute': 'query-cpus',"
+               "  'control': { 'run-oob': true } }");
+    g_assert(qdict_haskey(resp, "error"));
+    QDECREF(resp);
+
+    /*
+     * First send the "x-oob-test" command with lock=3Dtrue and
+     * oob=3Dfalse, it should hang the dispatcher and main thread;
+     * later, we send another lock=3Dfalse with oob=3Dtrue to continue
+     * that thread processing.  Finally we should receive replies from
+     * both commands.
+     */
+    qmp_async("{ 'execute': 'x-oob-test',"
+              "  'arguments': { 'lock': true }, "
+              "  'id': 'lock-cmd'}");
+    qmp_async("{ 'execute': 'x-oob-test', "
+              "  'arguments': { 'lock': false }, "
+              "  'control': { 'run-oob': true }, "
+              "  'id': 'unlock-cmd' }");
+
+    /* Ignore all events.  Wait for 2 acks */
+    while (acks < 2) {
+        resp =3D qmp_receive();
+        cmd_id =3D qdict_get_str(resp, "id");
+        if (!g_strcmp0(cmd_id, "lock-cmd") ||
+            !g_strcmp0(cmd_id, "unlock-cmd")) {
+            acks++;
+        }
+        QDECREF(resp);
+    }
+
+    qtest_end();
+}
+
 static int query_error_class(const char *cmd)
 {
     static struct {
@@ -318,6 +412,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);
=20
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/oob", test_qmp_oob);
     qmp_schema_init(&schema);
     add_query_tests(&schema);
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index eb218a9539..0b277036df 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -669,13 +669,13 @@ tests/test-qapi-events.c tests/test-qapi-events.h \
 tests/test-qapi-introspect.c tests/test-qapi-introspect.h: \
 tests/test-qapi-gen-timestamp ;
 tests/test-qapi-gen-timestamp: $(SRC_PATH)/tests/qapi-schema/qapi-schema=
-test.json $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests -p "test-" $<, \
 		"GEN","$(@:%-timestamp=3D%)")
 	@>$@
=20
 tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-=
good.json $(qapi-py)
-	$(call quiet-command,$(PYTHON_UTF8) $(SRC_PATH)/scripts/qapi-gen.py \
+	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
 		-o tests/qapi-schema -p "doc-good-" $<, \
 		"GEN","$@")
 	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
@@ -927,7 +927,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests=
-quick.sh qemu-img$(EXESUF)
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
 $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
 	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
-		$(PYTHON_UTF8) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
+		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
 		$^ >$*.test.out 2>$*.test.err; \
 		echo $$? >$*.test.exit, \
 		"TEST","$*.out")
--=20
2.17.0.rc1.1.g4c4f2b46a3
