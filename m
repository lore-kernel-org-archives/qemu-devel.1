Received: from eggs.gnu.org ([2001:4830:134:3::10]:58800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzu-0002Jc-3F
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmgzt-0002fs-7g
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmgzs-0002fL-UY
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:23:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:47 +0400
Message-Id: <20170311132256.22951-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/21] test-qga: drop everything until
 guest-sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

In the following commits, qemu-ga will emit an event on connect that
a real client should treat or ignore and test-qga can skip.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-qga.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index c780f0079a..e1f59b7370 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -13,6 +13,8 @@ typedef struct {
     GPid pid;
 } TestFixture;
=20
+static void guest_sync_delimited(const TestFixture *fixture);
+
 static int connect_qga(char *path)
 {
     int s, ret, len, i =3D 0;
@@ -45,12 +47,13 @@ static void qga_watch(GPid pid, gint status, gpointer=
 user_data)
     g_main_loop_quit(fixture->loop);
 }
=20
+
 static void
 fixture_setup(TestFixture *fixture, gconstpointer data)
 {
     const gchar *extra_arg =3D data;
     GError *error =3D NULL;
-    gchar *cwd, *path, *cmd, **argv =3D NULL;
+    char *cwd, *path, *cmd, **argv =3D NULL;
=20
     fixture->loop =3D g_main_loop_new(NULL, FALSE);
=20
@@ -77,6 +80,8 @@ fixture_setup(TestFixture *fixture, gconstpointer data)
     fixture->fd =3D connect_qga(path);
     g_assert_cmpint(fixture->fd, !=3D, -1);
=20
+    guest_sync_delimited(fixture);
+
     g_strfreev(argv);
     g_free(cmd);
     g_free(cwd);
@@ -138,9 +143,8 @@ static void qmp_assertion_message_error(const char   =
  *domain,
     }                                                                   =
\
 } while (0)
=20
-static void test_qga_sync_delimited(gconstpointer fix)
+static void guest_sync_delimited(const TestFixture *fixture)
 {
-    const TestFixture *fixture =3D fix;
     guint32 v, r =3D g_random_int();
     unsigned char c;
     QDict *ret;
@@ -148,12 +152,13 @@ static void test_qga_sync_delimited(gconstpointer f=
ix)
=20
     cmd =3D g_strdup_printf("%c{'execute': 'guest-sync-delimited',"
                           " 'arguments': {'id': %u } }", 0xff, r);
+
     qmp_fd_send(fixture->fd, cmd);
-    g_free(cmd);
=20
-    v =3D read(fixture->fd, &c, 1);
-    g_assert_cmpint(v, =3D=3D, 1);
-    g_assert_cmpint(c, =3D=3D, 0xff);
+    do {
+        v =3D read(fixture->fd, &c, 1);
+        g_assert_cmpint(v, =3D=3D, 1);
+    } while (c !=3D 0xff);
=20
     ret =3D qmp_fd_receive(fixture->fd);
     g_assert_nonnull(ret);
@@ -163,6 +168,14 @@ static void test_qga_sync_delimited(gconstpointer fi=
x)
     g_assert_cmpint(r, =3D=3D, v);
=20
     QDECREF(ret);
+    g_free(cmd);
+}
+
+static void test_qga_sync_delimited(gconstpointer fix)
+{
+    const TestFixture *fixture =3D fix;
+
+    guest_sync_delimited(fixture);
 }
=20
 static void test_qga_sync(gconstpointer fix)
--=20
2.12.0.191.gc5d8de91d
