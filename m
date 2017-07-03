Received: from eggs.gnu.org ([2001:4830:134:3::10]:51131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dRziu-0004Xu-TW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dRzip-0004kM-W8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:41:00 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dRzip-0004jt-PF
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:40:55 -0400
Received: by mail-wm0-f45.google.com with SMTP id i127so105574751wma.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 04:40:55 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Mon,  3 Jul 2017 13:40:48 +0200
Message-Id: <d1ee0939a084ec0f120dbf7831cb7985123f7774.1499082038.git.tgolembi@redhat.com>
In-Reply-To: <cover.1499082038.git.tgolembi@redhat.com>
References: <cover.1499082038.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 3/3] test-qga: add test for guest-get-osinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Add test for guest-get-osinfo command.

Qemu-ga was modified to accept QGA_OS_RELEASE environment variable. If
the variable is defined it is interpreted as path to the os-release file
and it is parsed instead of the default paths.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c           | 13 +++++++---
 tests/data/test-qga-os-release |  7 ++++++
 tests/test-qga.c               | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100644 tests/data/test-qga-os-release

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7a933a5f12..16b18c96ef 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2683,9 +2683,16 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
     info->kernel_release = g_strdup(kinfo.release);
     info->machine_hardware = g_strdup(kinfo.machine);
 
-    GKeyFile *osrelease = ga_parse_osrelease("/etc/os-release");
-    if (osrelease == NULL) {
-        osrelease = ga_parse_osrelease("/usr/lib/os-release");
+    GKeyFile *osrelease = NULL;
+
+    const char *qga_os_release = g_getenv("QGA_OS_RELEASE");
+    if (qga_os_release != NULL) {
+        osrelease = ga_parse_osrelease(qga_os_release);
+    } else {
+        osrelease = ga_parse_osrelease("/etc/os-release");
+        if (osrelease == NULL) {
+            osrelease = ga_parse_osrelease("/usr/lib/os-release");
+        }
     }
 
     if (osrelease != NULL) {
diff --git a/tests/data/test-qga-os-release b/tests/data/test-qga-os-release
new file mode 100644
index 0000000000..70664eb6ec
--- /dev/null
+++ b/tests/data/test-qga-os-release
@@ -0,0 +1,7 @@
+ID=qemu-ga-test
+NAME=QEMU-GA
+PRETTY_NAME="QEMU Guest Agent test"
+VERSION="Test 1"
+VERSION_ID=1
+VARIANT="Unit test \"\'\$\`\\ and \\\\ etc."
+VARIANT_ID=unit-test
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 631b98639a..c151dfdc34 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -936,6 +936,59 @@ static void test_qga_guest_exec_invalid(gconstpointer fix)
     QDECREF(ret);
 }
 
+static void test_qga_guest_get_osinfo(gconstpointer data)
+{
+    TestFixture fixture;
+    const gchar *str;
+    gchar *cwd, *env[2];
+    QDict *ret, *val;
+
+    cwd = g_get_current_dir();
+    env[0] = g_strdup_printf(
+        "QGA_OS_RELEASE=%s%ctests%cdata%ctest-qga-os-release",
+        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
+    env[1] = NULL;
+    g_free(cwd);
+    fixture_setup(&fixture, NULL, env);
+
+    ret = qmp_fd(fixture.fd, "{'execute': 'guest-get-osinfo'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    val = qdict_get_qdict(ret, "return");
+
+    str = qdict_get_try_str(val, "id");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "qemu-ga-test");
+
+    str = qdict_get_try_str(val, "name");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "QEMU-GA");
+
+    str = qdict_get_try_str(val, "pretty-name");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "QEMU Guest Agent test");
+
+    str = qdict_get_try_str(val, "version");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "Test 1");
+
+    str = qdict_get_try_str(val, "version-id");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "1");
+
+    str = qdict_get_try_str(val, "variant");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "Unit test \"'$`\\ and \\\\ etc.");
+
+    str = qdict_get_try_str(val, "variant-id");
+    g_assert_nonnull(str);
+    g_assert_cmpstr(str, ==, "unit-test");
+
+    QDECREF(ret);
+    g_free(env[0]);
+}
+
 int main(int argc, char **argv)
 {
     TestFixture fix;
@@ -972,6 +1025,8 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/guest-exec", &fix, test_qga_guest_exec);
     g_test_add_data_func("/qga/guest-exec-invalid", &fix,
                          test_qga_guest_exec_invalid);
+    g_test_add_data_func("/qga/guest-get-osinfo", &fix,
+                         test_qga_guest_get_osinfo);
 
     if (g_getenv("QGA_TEST_SIDE_EFFECTING")) {
         g_test_add_data_func("/qga/fsfreeze-and-thaw", &fix,
-- 
2.13.1
