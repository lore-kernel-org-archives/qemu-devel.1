Received: from eggs.gnu.org ([2001:4830:134:3::10]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaH-0007kY-O5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaG-0000d3-Ly
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaG-0000cg-Ft
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:44 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:23 +0200
Message-Id: <1505462549-27298-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] tests/libqtest: Use a proper error message
 if QTEST_QEMU_BINARY is missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

The user can currently still cause an abort() if running certain tests
(like the prom-env-test) without setting the QTEST_QEMU_BINARY first.
A similar problem has been fixed with commit 7c933ad61b8f3f51337
already, but forgot to also take care of the qtest_get_arch() function,
so let's introduce a proper wrapper around getenv("QTEST_QEMU_BINARY")
that can be used in both locations now.

Buglink: https://bugs.launchpad.net/qemu/+bug/1713434
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0c12b38..3daa0e3 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -150,6 +150,19 @@ void qtest_add_abrt_handler(GHookFunc fn, const void=
 *data)
     g_hook_prepend(&abrt_hooks, hook);
 }
=20
+static const char *qtest_qemu_binary(void)
+{
+    const char *qemu_bin;
+
+    qemu_bin =3D getenv("QTEST_QEMU_BINARY");
+    if (!qemu_bin) {
+        fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required=
\n");
+        exit(1);
+    }
+
+    return qemu_bin;
+}
+
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
@@ -157,13 +170,7 @@ QTestState *qtest_init_without_qmp_handshake(const c=
har *extra_args)
     gchar *socket_path;
     gchar *qmp_socket_path;
     gchar *command;
-    const char *qemu_binary;
-
-    qemu_binary =3D getenv("QTEST_QEMU_BINARY");
-    if (!qemu_binary) {
-        fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required=
\n");
-        exit(1);
-    }
+    const char *qemu_binary =3D qtest_qemu_binary();
=20
     s =3D g_malloc(sizeof(*s));
=20
@@ -624,8 +631,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
=20
 const char *qtest_get_arch(void)
 {
-    const char *qemu =3D getenv("QTEST_QEMU_BINARY");
-    g_assert(qemu !=3D NULL);
+    const char *qemu =3D qtest_qemu_binary();
     const char *end =3D strrchr(qemu, '/');
=20
     return end + strlen("/qemu-system-");
--=20
1.8.3.1
