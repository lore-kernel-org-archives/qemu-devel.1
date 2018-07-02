Received: from eggs.gnu.org ([2001:4830:134:3::10]:42433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aq-0004Qy-7r
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1ao-0006bG-Px
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ao-0006b3-Lx
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E83D805A530
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:21:54 +0200
Message-Id: <20180702162218.13678-9-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 08/32] tests/test-qga: Demonstrate the
 guest-agent ignores "id"
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
index 30c9643257..4edd35535d 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -227,6 +227,22 @@ static void test_qga_ping(gconstpointer fix)
     qobject_unref(ret);
 }
 
+static void test_qga_invalid_id(gconstpointer fix)
+{
+    /* FIXME "id" is ignored; it should be rejected */
+    const TestFixture *fixture = fix;
+    QDict *ret, *val;
+
+    ret = qmp_fd(fixture->fd, "{'execute': 'guest-ping', 'id': 1}");
+    g_assert_nonnull(ret);
+    qmp_assert_no_error(ret);
+
+    val = qdict_get_qdict(ret, "return");
+    g_assert(!qdict_haskey(val, "id"));
+
+    qobject_unref(ret);
+}
+
 static void test_qga_invalid_args(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
@@ -934,6 +950,7 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/file-ops", &fix, test_qga_file_ops);
     g_test_add_data_func("/qga/file-write-read", &fix, test_qga_file_write_read);
     g_test_add_data_func("/qga/get-time", &fix, test_qga_get_time);
+    g_test_add_data_func("/qga/invalid-id", &fix, test_qga_invalid_id);
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
     g_test_add_data_func("/qga/fsfreeze-status", &fix,
-- 
2.17.1
