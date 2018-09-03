Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXl-0007d7-6i
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fwgXg-0000QE-Qs
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fwgXc-0000P3-W0
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6233B4001389
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 04:32:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Sep 2018 12:31:49 +0800
Message-Id: <20180903043149.4076-8-peterx@redhat.com>
In-Reply-To: <20180903043149.4076-1-peterx@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 7/7] tests: add oob functional test for
 test-qmp-cmds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Straightforward test just to let the test-qmp-cmds be complete.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/test-qmp-cmds.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index ab414fa0c9..23c68c7944 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -122,6 +122,21 @@ static void test_dispatch_cmd(void)
     qobject_unref(req);
 }
 
+static void test_dispatch_cmd_oob(void)
+{
+    QDict *req = qdict_new();
+    QDict *resp;
+
+    qdict_put_str(req, "exec-oob", "test-flags-command");
+
+    resp = qmp_dispatch(&qmp_commands, QOBJECT(req), true);
+    assert(resp != NULL);
+    assert(!qdict_haskey(resp, "error"));
+
+    qobject_unref(resp);
+    qobject_unref(req);
+}
+
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
@@ -287,6 +302,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
+    g_test_add_func("/qmp/dispatch_cmd_oob", test_dispatch_cmd_oob);
     g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failure);
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
-- 
2.17.1
