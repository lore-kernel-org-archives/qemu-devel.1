Received: from eggs.gnu.org ([2001:4830:134:3::10]:54818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1f9aOn-000632-Np
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1f9aOk-0007ls-Ko
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:04:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1f9aOk-0007js-E3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:04:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id v24-v6so25103761wra.8
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 11:04:37 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Fri, 20 Apr 2018 20:04:34 +0200
Message-Id: <d8f2677fdb9c4d261b6c0f80ca0fd4ce5ef6efba.1524247455.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] test-qga: add trivial tests for some commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

These commands did not get their tests in the original commits:
- guest-get-host-name
- guest-get-timezone
- guest-get-users

Trivial tests that mostly only call the commands were added.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 tests/test-qga.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index e6ab788f31..503f48bacf 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -856,6 +856,54 @@ static void test_qga_guest_exec_invalid(gconstpointer fix)
     QDECREF(ret);
 }
 
+static void test_qga_guest_get_host_name(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    QDict *ret, *val;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-host-name'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    val = qdict_get_qdict(ret, "return");
+    g_assert(qdict_haskey(val, "host-name"));
+
+    QDECREF(ret);
+}
+
+static void test_qga_guest_get_timezone(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    QDict *ret, *val;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-timezone'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    /* Make sure there's at least offset */
+    val = qdict_get_qdict(ret, "return");
+    g_assert(qdict_haskey(val, "offset"));
+
+    QDECREF(ret);
+}
+
+static void test_qga_guest_get_users(gconstpointer fix)
+{
+    const TestFixture *fixture = fix;
+    QDict *ret;
+    QList *val;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-get-users'}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    /* There is not much to test here */
+    val = qdict_get_qlist(ret, "return");
+    g_assert_nonnull(val);
+
+    QDECREF(ret);
+}
+
 static void test_qga_guest_get_osinfo(gconstpointer data)
 {
     TestFixture fixture;
@@ -948,6 +996,12 @@ int main(int argc, char **argv)
                          test_qga_guest_exec_invalid);
     g_test_add_data_func("/qga/guest-get-osinfo", &fix,
                          test_qga_guest_get_osinfo);
+    g_test_add_data_func("/qga/guest-get-host-name", &fix,
+                         test_qga_guest_get_host_name);
+    g_test_add_data_func("/qga/guest-get-timezone", &fix,
+                         test_qga_guest_get_timezone);
+    g_test_add_data_func("/qga/guest-get-users", &fix,
+                         test_qga_guest_get_users);
 
     ret = g_test_run();
 
-- 
2.17.0
