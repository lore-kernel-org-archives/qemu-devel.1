Received: from eggs.gnu.org ([2001:4830:134:3::10]:48684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwP-0000YT-LB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwM-0005e2-E7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:21:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXKwM-0005dT-3l
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5Jkft090334
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:57 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bsbx40cy2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:56 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 01:20:55 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 00:20:16 -0500
In-Reply-To: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500355216-23603-9-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/8] test-qga: add test for guest-get-osinfo
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

Add test for guest-get-osinfo command.

Qemu-ga was modified to accept QGA_OS_RELEASE environment variable. If
the variable is defined it is interpreted as path to the os-release file
and it is parsed instead of the default paths.

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c           | 13 +++++++---
 tests/data/test-qga-os-release |  7 ++++++
 tests/test-qga.c               | 56 ++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100644 tests/data/test-qga-os-release

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 672bf29..86c20e9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2682,6 +2682,8 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 {
     GuestOSInfo *info =3D NULL;
     struct utsname kinfo =3D {0};
+    GKeyFile *osrelease =3D NULL;
+
=20
     info =3D g_new0(GuestOSInfo, 1);
=20
@@ -2696,9 +2698,14 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
         info->machine =3D g_strdup(kinfo.machine);
     }
=20
-    GKeyFile *osrelease =3D ga_parse_osrelease("/etc/os-release");
-    if (osrelease =3D=3D NULL) {
-        osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
+    const char *qga_os_release =3D g_getenv("QGA_OS_RELEASE");
+    if (qga_os_release !=3D NULL) {
+        osrelease =3D ga_parse_osrelease(qga_os_release);
+    } else {
+        osrelease =3D ga_parse_osrelease("/etc/os-release");
+        if (osrelease =3D=3D NULL) {
+            osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
+        }
     }
=20
     if (osrelease !=3D NULL) {
diff --git a/tests/data/test-qga-os-release b/tests/data/test-qga-os-rele=
ase
new file mode 100644
index 0000000..70664eb
--- /dev/null
+++ b/tests/data/test-qga-os-release
@@ -0,0 +1,7 @@
+ID=3Dqemu-ga-test
+NAME=3DQEMU-GA
+PRETTY_NAME=3D"QEMU Guest Agent test"
+VERSION=3D"Test 1"
+VERSION_ID=3D1
+VARIANT=3D"Unit test \"\'\$\`\\ and \\\\ etc."
+VARIANT_ID=3Dunit-test
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 631b986..06783e7 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -936,6 +936,60 @@ static void test_qga_guest_exec_invalid(gconstpointe=
r fix)
     QDECREF(ret);
 }
=20
+static void test_qga_guest_get_osinfo(gconstpointer data)
+{
+    TestFixture fixture;
+    const gchar *str;
+    gchar *cwd, *env[2];
+    QDict *ret, *val;
+
+    cwd =3D g_get_current_dir();
+    env[0] =3D g_strdup_printf(
+        "QGA_OS_RELEASE=3D%s%ctests%cdata%ctest-qga-os-release",
+        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
+    env[1] =3D NULL;
+    g_free(cwd);
+    fixture_setup(&fixture, NULL, env);
+
+    ret =3D qmp_fd(fixture.fd, "{'execute': 'guest-get-osinfo'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    val =3D qdict_get_qdict(ret, "return");
+
+    str =3D qdict_get_try_str(val, "id");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "qemu-ga-test");
+
+    str =3D qdict_get_try_str(val, "name");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "QEMU-GA");
+
+    str =3D qdict_get_try_str(val, "pretty-name");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "QEMU Guest Agent test");
+
+    str =3D qdict_get_try_str(val, "version");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "Test 1");
+
+    str =3D qdict_get_try_str(val, "version-id");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "1");
+
+    str =3D qdict_get_try_str(val, "variant");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "Unit test \"'$`\\ and \\\\ etc.");
+
+    str =3D qdict_get_try_str(val, "variant-id");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, =3D=3D, "unit-test");
+
+    QDECREF(ret);
+    g_free(env[0]);
+    fixture_tear_down(&fixture, NULL);
+}
+
 int main(int argc, char **argv)
 {
     TestFixture fix;
@@ -972,6 +1026,8 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/guest-exec", &fix, test_qga_guest_exec);
     g_test_add_data_func("/qga/guest-exec-invalid", &fix,
                          test_qga_guest_exec_invalid);
+    g_test_add_data_func("/qga/guest-get-osinfo", &fix,
+                         test_qga_guest_get_osinfo);
=20
     if (g_getenv("QGA_TEST_SIDE_EFFECTING")) {
         g_test_add_data_func("/qga/fsfreeze-and-thaw", &fix,
--=20
2.7.4
