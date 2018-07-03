Received: from eggs.gnu.org ([2001:4830:134:3::10]:50292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxu-00083Y-2o
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxr-00069G-I0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48958 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxr-00068S-A4
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDEE8DFDB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAC762026D76
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:32 +0200
Message-Id: <20180703213556.20619-9-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/32] tests/test-qga: Demonstrate the
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-9-armbru@redhat.com>
---
 tests/test-qga.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 30c9643257..6b632e3da4 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -227,6 +227,25 @@ static void test_qga_ping(gconstpointer fix)
     qobject_unref(ret);
 }
 
+static void test_qga_invalid_id(gconstpointer fix)
+{
+    /*
+     * FIXME "id" is ignored; it should either be repeated in the
+     * reply, or rejected on input
+     */
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
@@ -934,6 +953,7 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/file-ops", &fix, test_qga_file_ops);
     g_test_add_data_func("/qga/file-write-read", &fix, test_qga_file_write_read);
     g_test_add_data_func("/qga/get-time", &fix, test_qga_get_time);
+    g_test_add_data_func("/qga/invalid-id", &fix, test_qga_invalid_id);
     g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
     g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
     g_test_add_data_func("/qga/fsfreeze-status", &fix,
-- 
2.17.1
