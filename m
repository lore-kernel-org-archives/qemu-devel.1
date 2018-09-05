Received: from eggs.gnu.org ([2001:4830:134:3::10]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREo-00079A-RM
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREl-00084m-1U
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxREj-0007Mg-Jf
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F62E40216E6
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 06:23:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 14:23:12 +0800
Message-Id: <20180905062313.4059-6-peterx@redhat.com>
In-Reply-To: <20180905062313.4059-1-peterx@redhat.com>
References: <20180905062313.4059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 5/6] tests: add oob functional test for
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
