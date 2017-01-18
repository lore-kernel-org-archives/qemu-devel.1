Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjF-0003a7-Jd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjC-0007rJ-N2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsjC-0007r7-HT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0AEA2F9FDB
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:25 +0400
Message-Id: <20170118160332.13390-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/25] qtest: add qtest_init_qmp_caps()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a function to specify the qmp capabilities content.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/libqtest.h |  9 +++++++++
 tests/libqtest.c | 13 +++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 90f182e1d8..e7ab509d1a 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -32,6 +32,15 @@ extern QTestState *global_qtest;
 QTestState *qtest_init(const char *extra_args);
=20
 /**
+ * qtest_init_qmp_caps:
+ * @extra_args: other arguments to pass to QEMU.
+ * @qmp_caps: qmp capabilities (ex: "'cap1', 'cap2'")
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_qmp_caps(const char *extra_args, const char *qmp_=
caps);
+
+/**
  * qtest_quit:
  * @s: #QTestState instance to operate on.
  *
diff --git a/tests/libqtest.c b/tests/libqtest.c
index d8fba6647a..eb4a0c12c0 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -149,7 +149,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void =
*data)
     g_hook_prepend(&abrt_hooks, hook);
 }
=20
-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_init_qmp_caps(const char *extra_args, const char *qmp_=
caps)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -206,7 +206,11 @@ QTestState *qtest_init(const char *extra_args)
=20
     /* Read the QMP greeting and then do the handshake */
     qtest_qmp_discard_response(s, "");
-    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
+    command =3D g_strdup_printf(
+        "{ 'execute': 'qmp_capabilities',"
+        " 'arguments': {'capabilities': [%s]}}", qmp_caps);
+    qtest_qmp_discard_response(s, command);
+    g_free(command);
=20
     if (getenv("QTEST_STOP")) {
         kill(s->qemu_pid, SIGSTOP);
@@ -219,6 +223,11 @@ QTestState *qtest_init(const char *extra_args)
     return s;
 }
=20
+QTestState *qtest_init(const char *extra_args)
+{
+    return qtest_init_qmp_caps(extra_args, "");
+}
+
 void qtest_quit(QTestState *s)
 {
     qtest_instances =3D g_list_remove(qtest_instances, s);
--=20
2.11.0.295.gd7dffce1c
