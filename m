Received: from eggs.gnu.org ([2001:4830:134:3::10]:34372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMz-0002Mg-6L
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMx-0005JA-56
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMx-0005Hh-07
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 938C28182D20
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EEEE1C65E
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:06 +0200
Message-Id: <20180703153728.2175-11-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 10/32] tests/test-qga: Demonstrate the
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-11-armbru@redhat.com>
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
