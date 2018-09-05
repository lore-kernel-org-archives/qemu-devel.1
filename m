Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREr-0007Bz-Ld
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREp-0008Cz-MW
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxREn-0007f7-0x
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12BD840216E8
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 06:24:07 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 14:23:13 +0800
Message-Id: <20180905062313.4059-7-peterx@redhat.com>
In-Reply-To: <20180905062313.4059-1-peterx@redhat.com>
References: <20180905062313.4059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 6/6] tests: qmp-test: add queue full test
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

We'll need to include "monitor/monitor.h" for the queue length macro,
then we don't need to hard code it.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 91a90d1c9d..9e523a1806 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qmp/qstring.h"
+#include "monitor/monitor.h"
 
 const char common_args[] = "-nodefaults -machine none";
 
@@ -248,6 +249,8 @@ static void test_qmp_oob(void)
     const QListEntry *entry;
     QList *capabilities;
     QString *qstr;
+    gchar *id;
+    int i;
 
     qts = qtest_init_without_qmp_handshake(common_args);
 
@@ -302,6 +305,29 @@ static void test_qmp_oob(void)
     unblock_blocked_cmd();
     recv_cmd_id(qts, "blocks-2");
     recv_cmd_id(qts, "err-2");
+
+    /*
+     * Test queue full.  When that happens, the out-of-band command
+     * will only be able to be handled after the queue is shrinked, so
+     * it'll be processed only after one existing in-band command
+     * finishes.
+     */
+    for (i = 1; i <= QMP_REQ_QUEUE_LEN_MAX; i++) {
+        id = g_strdup_printf("queue-blocks-%d", i);
+        send_cmd_that_blocks(qts, id);
+        g_free(id);
+    }
+    send_oob_cmd_that_fails(qts, "oob-1");
+    unblock_blocked_cmd();
+    recv_cmd_id(qts, "queue-blocks-1");
+    recv_cmd_id(qts, "oob-1");
+    for (i = 2; i <= QMP_REQ_QUEUE_LEN_MAX; i++) {
+        unblock_blocked_cmd();
+        id = g_strdup_printf("queue-blocks-%d", i);
+        recv_cmd_id(qts, id);
+        g_free(id);
+    }
+
     cleanup_blocking_cmd();
 
     qtest_quit(qts);
-- 
2.17.1
