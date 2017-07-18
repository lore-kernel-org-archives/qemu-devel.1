Received: from eggs.gnu.org ([2001:4830:134:3::10]:52197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXQGd-0005wK-HW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXQGa-000367-Ee
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXQGa-00035Y-5J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IAxCdo024084
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:02:10 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsbxaw8x8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:02:10 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 07:02:09 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 06:01:43 -0500
In-Reply-To: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500375704-28002-8-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 7/8] test-qga: pass environemnt to qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Modify fixture_setup() to pass environemnt variables to spawned qemu-ga
instance.

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/test-qga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index c77f241..631b986 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -46,7 +46,7 @@ static void qga_watch(GPid pid, gint status, gpointer u=
ser_data)
 }
=20
 static void
-fixture_setup(TestFixture *fixture, gconstpointer data)
+fixture_setup(TestFixture *fixture, gconstpointer data, gchar **envp)
 {
     const gchar *extra_arg =3D data;
     GError *error =3D NULL;
@@ -67,7 +67,7 @@ fixture_setup(TestFixture *fixture, gconstpointer data)
     g_shell_parse_argv(cmd, NULL, &argv, &error);
     g_assert_no_error(error);
=20
-    g_spawn_async(fixture->test_dir, argv, NULL,
+    g_spawn_async(fixture->test_dir, argv, envp,
                   G_SPAWN_SEARCH_PATH|G_SPAWN_DO_NOT_REAP_CHILD,
                   NULL, NULL, &fixture->pid, &error);
     g_assert_no_error(error);
@@ -707,7 +707,7 @@ static void test_qga_blacklist(gconstpointer data)
     QDict *ret, *error;
     const gchar *class, *desc;
=20
-    fixture_setup(&fix, "-b guest-ping,guest-get-time");
+    fixture_setup(&fix, "-b guest-ping,guest-get-time", NULL);
=20
     /* check blacklist */
     ret =3D qmp_fd(fix.fd, "{'execute': 'guest-ping'}");
@@ -943,7 +943,7 @@ int main(int argc, char **argv)
=20
     setlocale (LC_ALL, "");
     g_test_init(&argc, &argv, NULL);
-    fixture_setup(&fix, NULL);
+    fixture_setup(&fix, NULL, NULL);
=20
     g_test_add_data_func("/qga/sync-delimited", &fix, test_qga_sync_deli=
mited);
     g_test_add_data_func("/qga/sync", &fix, test_qga_sync);
--=20
2.7.4
