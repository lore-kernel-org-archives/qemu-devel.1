Received: from eggs.gnu.org ([2001:4830:134:3::10]:52131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXQGZ-0005rh-D0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXQGT-00032z-87
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXQGS-00032Z-UU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IAwiEc022769
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:02:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bs9y7su9k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:02:03 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 07:02:01 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 06:01:44 -0500
In-Reply-To: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500375704-28002-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500375704-28002-9-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 8/8] test-qga: add test for guest-get-osinfo
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
* move declarations to beginning of functions
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c           | 13 +++++++---
 tests/data/test-qga-os-release |  7 ++++++
 tests/test-qga.c               | 56 ++++++++++++++++++++++++++++++++++++=
++++++
 3 files changed, 72 insertions(+), 4 deletions(-)
 create mode 100644 tests/data/test-qga-os-release

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7b3d89a..ab0c63d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2682,7 +2682,8 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
 {
     GuestOSInfo *info =3D NULL;
     struct utsname kinfo;
-    GKeyFile *osrelease;
+    GKeyFile *osrelease =3D NULL;
+    const char *qga_os_release =3D g_getenv("QGA_OS_RELEASE");
=20
     info =3D g_new0(GuestOSInfo, 1);
=20
@@ -2697,9 +2698,13 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
         info->machine =3D g_strdup(kinfo.machine);
     }
=20
-    osrelease =3D ga_parse_osrelease("/etc/os-release");
-    if (osrelease =3D=3D NULL) {
-        osrelease =3D ga_parse_osrelease("/usr/lib/os-release");
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
