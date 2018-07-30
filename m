Received: from eggs.gnu.org ([2001:4830:134:3::10]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cJ-0003Oy-Ra
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cG-0004Vw-L1
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cG-0004VC-Em
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:32:56 +0200
Message-Id: <20180730083317.11765-3-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/23] libqtest: Rename functions to send
 QMP messages
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

The functions to receive messages are called qtest_qmp_receive() and
qmp_receive(), qmp_fd_receive().  The ones to send messages are called
qtest_async_qmp(), qtest_async_qmpv(), qmp_async(), qmp_fd_send(),
qmp_fd_sendv().  Inconsistent.  Rename the *_async* ones to
qmp_send(), qtest_qmp_send(), qtest_qmp_vsend().  Rename
qmp_fd_sendv() to qmp_fd_vsend().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/ahci-test.c   | 10 +++++-----
 tests/libqos/ahci.c |  4 ++--
 tests/libqtest.c    | 20 ++++++++++----------
 tests/libqtest.h    | 14 +++++++-------
 tests/qmp-test.c    | 18 +++++++++---------
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 1a7b761304..7e3491b5bd 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -1389,7 +1389,7 @@ static void test_flush_migrate(void)
=20
     /* Complete the command */
     s =3D "{'execute':'cont' }";
-    qmp_async(s);
+    qmp_send(s);
     qmp_eventwait("RESUME");
     ahci_command_wait(dst, cmd);
     ahci_command_verify(dst, cmd);
@@ -1592,8 +1592,8 @@ static void test_atapi_tray(void)
     atapi_wait_tray(false);
=20
     /* Remove media */
-    qmp_async("{'execute': 'blockdev-open-tray', "
-               "'arguments': {'id': 'cd0'}}");
+    qmp_send("{'execute': 'blockdev-open-tray',"
+             " 'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(true);
     rsp =3D qmp_receive();
     qobject_unref(rsp);
@@ -1619,8 +1619,8 @@ static void test_atapi_tray(void)
                                          "'node-name': 'node0' }}");
=20
     /* Again, the event shows up first */
-    qmp_async("{'execute': 'blockdev-close-tray', "
-               "'arguments': {'id': 'cd0'}}");
+    qmp_send("{'execute': 'blockdev-close-tray',"
+             " 'arguments': {'id': 'cd0'}}");
     atapi_wait_tray(false);
     rsp =3D qmp_receive();
     qobject_unref(rsp);
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index 42d3f76933..63fbc9e3c9 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -674,7 +674,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
         g_assert_cmpint(rc, =3D=3D, 0);
     }
     if (opts->error) {
-        qtest_async_qmp(ahci->parent->qts, "{'execute':'cont' }");
+        qtest_qmp_send(ahci->parent->qts, "{'execute':'cont' }");
         qtest_qmp_eventwait(ahci->parent->qts, "RESUME");
     }
=20
@@ -712,7 +712,7 @@ AHCICommand *ahci_guest_io_halt(AHCIQState *ahci, uin=
t8_t port,
 void ahci_guest_io_resume(AHCIQState *ahci, AHCICommand *cmd)
 {
     /* Complete the command */
-    qtest_async_qmp(ahci->parent->qts, "{'execute':'cont' }");
+    qtest_qmp_send(ahci->parent->qts, "{'execute':'cont' }");
     qtest_qmp_eventwait(ahci->parent->qts, "RESUME");
     ahci_command_wait(ahci, cmd);
     ahci_command_verify(ahci, cmd);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 098af6aec4..9cb4096639 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -484,7 +484,7 @@ QDict *qtest_qmp_receive(QTestState *s)
  * in the case that they choose to discard all replies up until
  * a particular EVENT is received.
  */
-void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
+void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
 {
     va_list ap_copy;
     QObject *qobj;
@@ -529,21 +529,21 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list =
ap)
     }
 }
=20
-void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap)
+void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
 {
-    qmp_fd_sendv(s->qmp_fd, fmt, ap);
+    qmp_fd_vsend(s->qmp_fd, fmt, ap);
 }
=20
 QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
 {
-    qmp_fd_sendv(fd, fmt, ap);
+    qmp_fd_vsend(fd, fmt, ap);
=20
     return qmp_fd_receive(fd);
 }
=20
 QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap)
 {
-    qtest_async_qmpv(s, fmt, ap);
+    qtest_qmp_vsend(s, fmt, ap);
=20
     /* Receive reply */
     return qtest_qmp_receive(s);
@@ -565,7 +565,7 @@ void qmp_fd_send(int fd, const char *fmt, ...)
     va_list ap;
=20
     va_start(ap, fmt);
-    qmp_fd_sendv(fd, fmt, ap);
+    qmp_fd_vsend(fd, fmt, ap);
     va_end(ap);
 }
=20
@@ -580,12 +580,12 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ..=
.)
     return response;
 }
=20
-void qtest_async_qmp(QTestState *s, const char *fmt, ...)
+void qtest_qmp_send(QTestState *s, const char *fmt, ...)
 {
     va_list ap;
=20
     va_start(ap, fmt);
-    qtest_async_qmpv(s, fmt, ap);
+    qtest_qmp_vsend(s, fmt, ap);
     va_end(ap);
 }
=20
@@ -968,12 +968,12 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }
=20
-void qmp_async(const char *fmt, ...)
+void qmp_send(const char *fmt, ...)
 {
     va_list ap;
=20
     va_start(ap, fmt);
-    qtest_async_qmpv(global_qtest, fmt, ap);
+    qtest_qmp_vsend(global_qtest, fmt, ap);
     va_end(ap);
 }
=20
diff --git a/tests/libqtest.h b/tests/libqtest.h
index aa2b2cd7c1..ced95f490a 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -96,7 +96,7 @@ void qtest_qmp_discard_response(QTestState *s, const ch=
ar *fmt, ...);
 QDict *qtest_qmp(QTestState *s, const char *fmt, ...);
=20
 /**
- * qtest_async_qmp:
+ * qtest_qmp_send:
  * @s: #QTestState instance to operate on.
  * @fmt...: QMP message to send to qemu, formatted like
  * qobject_from_jsonf().
@@ -104,7 +104,7 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)=
;
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_async_qmp(QTestState *s, const char *fmt, ...);
+void qtest_qmp_send(QTestState *s, const char *fmt, ...);
=20
 /**
  * qtest_qmpv_discard_response:
@@ -131,7 +131,7 @@ void qtest_qmpv_discard_response(QTestState *s, const=
 char *fmt, va_list ap);
 QDict *qtest_qmpv(QTestState *s, const char *fmt, va_list ap);
=20
 /**
- * qtest_async_qmpv:
+ * qtest_qmp_vsend:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU, formatted like
  * qobject_from_jsonf().
@@ -140,7 +140,7 @@ QDict *qtest_qmpv(QTestState *s, const char *fmt, va_=
list ap);
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qtest_async_qmpv(QTestState *s, const char *fmt, va_list ap);
+void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap);
=20
 /**
  * qtest_receive:
@@ -583,14 +583,14 @@ static inline void qtest_end(void)
 QDict *qmp(const char *fmt, ...);
=20
 /**
- * qmp_async:
+ * qmp_send:
  * @fmt...: QMP message to send to qemu, formatted like
  * qobject_from_jsonf().
  * Only understands '%((l|ll|I64)?d|[ipsf])', see parse_escape().
  *
  * Sends a QMP message to QEMU and leaves the response in the stream.
  */
-void qmp_async(const char *fmt, ...);
+void qmp_send(const char *fmt, ...);
=20
 /**
  * qmp_discard_response:
@@ -959,7 +959,7 @@ static inline int64_t clock_set(int64_t val)
 }
=20
 QDict *qmp_fd_receive(int fd);
-void qmp_fd_sendv(int fd, const char *fmt, va_list ap);
+void qmp_fd_vsend(int fd, const char *fmt, va_list ap);
 void qmp_fd_send(int fd, const char *fmt, ...);
 QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
 QDict *qmp_fd(int fd, const char *fmt, ...);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index b9774084f8..5eb15daebc 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -159,12 +159,12 @@ static void cleanup_blocking_cmd(void)
=20
 static void send_cmd_that_blocks(QTestState *s, const char *id)
 {
-    qtest_async_qmp(s, "{ 'execute': 'blockdev-add',  'id': %s,"
-                    " 'arguments': {"
-                    " 'driver': 'blkdebug', 'node-name': %s,"
-                    " 'config': %s,"
-                    " 'image': { 'driver': 'null-co' } } }",
-                    id, id, fifo_name);
+    qtest_qmp_send(s, "{ 'execute': 'blockdev-add',  'id': %s,"
+                   " 'arguments': {"
+                   " 'driver': 'blkdebug', 'node-name': %s,"
+                   " 'config': %s,"
+                   " 'image': { 'driver': 'null-co' } } }",
+                   id, id, fifo_name);
 }
=20
 static void unblock_blocked_cmd(void)
@@ -176,7 +176,7 @@ static void unblock_blocked_cmd(void)
=20
 static void send_oob_cmd_that_fails(QTestState *s, const char *id)
 {
-    qtest_async_qmp(s, "{ 'exec-oob': 'migrate-pause', 'id': %s }", id);
+    qtest_qmp_send(s, "{ 'exec-oob': 'migrate-pause', 'id': %s }", id);
 }
=20
 static void recv_cmd_id(QTestState *s, const char *id)
@@ -235,7 +235,7 @@ static void test_qmp_oob(void)
     /* OOB command overtakes slow in-band command */
     setup_blocking_cmd();
     send_cmd_that_blocks(qts, "ib-blocks-1");
-    qtest_async_qmp(qts, "{ 'execute': 'query-name', 'id': 'ib-quick-1' =
}");
+    qtest_qmp_send(qts, "{ 'execute': 'query-name', 'id': 'ib-quick-1' }=
");
     send_oob_cmd_that_fails(qts, "oob-1");
     recv_cmd_id(qts, "oob-1");
     unblock_blocked_cmd();
@@ -244,7 +244,7 @@ static void test_qmp_oob(void)
=20
     /* Even malformed in-band command fails in-band */
     send_cmd_that_blocks(qts, "blocks-2");
-    qtest_async_qmp(qts, "{ 'id': 'err-2' }");
+    qtest_qmp_send(qts, "{ 'id': 'err-2' }");
     unblock_blocked_cmd();
     recv_cmd_id(qts, "blocks-2");
     recv_cmd_id(qts, "err-2");
--=20
2.17.1
