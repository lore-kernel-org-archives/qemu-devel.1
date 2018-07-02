Received: from eggs.gnu.org ([2001:4830:134:3::10]:42428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aq-0004Qx-6H
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ao-0006bT-UX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ao-0006b9-PW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D0B440250FF
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:21:56 +0200
Message-Id: <20180702162218.13678-11-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 10/32] tests/test-qga: Demonstrate the
 guest-agent ignores "control"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qga.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 564a4594b5..2e9e0f73bb 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -243,6 +243,22 @@ static void test_qga_invalid_id(gconstpointer fix)
     qobject_unref(ret);
 }
 
+static void test_qga_invalid_oob(gconstpointer fix)
+{
+    /* FIXME "control" is ignored; it should be rejected */
+    const TestFixture *fixture = fix;
+    QDict *ret;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping',"
+                 " 'control': {'run-oob': true}}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    qdict_get_qdict(ret, "return");
+
+    qobject_unref(ret);
+}
+
 static void test_qga_invalid_args(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -951,6 +967,7 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/file-write-read", &fix, test_qga_file_write_read);
     g_test_add_data_func("/qga/get-time", &fix, test_qga_get_time);
     g_test_add_data_func("/qga/invalid-id", &fix, test_qga_invalid_id);
+    g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
     g_test_add_data_func("/qga/fsfreeze-status", &fix,
-- 
2.17.1
