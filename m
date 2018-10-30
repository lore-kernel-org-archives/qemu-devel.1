Received: from eggs.gnu.org ([2001:4830:134:3::10]:37685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVL-00031H-39
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVI-0005rs-GR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHZVI-0005k6-8Q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3ECA9307C94A
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 19:16:26 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Oct 2018 20:16:19 +0100
Message-Id: <20181030191620.32168-8-armbru@redhat.com>
In-Reply-To: <20181030191620.32168-1-armbru@redhat.com>
References: <20181030191620.32168-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] tests: qmp-test: add queue full test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

We'll need to include "monitor/monitor.h" for the queue length macro,
then we don't need to hard code it.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20181009062718.1914-7-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qmp-test.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index cc9907b525..6989acbca4 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qmp/qstring.h"
+#include "monitor/monitor.h"
=20
 const char common_args[] =3D "-nodefaults -machine none";
=20
@@ -218,6 +219,8 @@ static void test_qmp_oob(void)
     const QListEntry *entry;
     QList *capabilities;
     QString *qstr;
+    gchar *id;
+    int i;
=20
     qts =3D qtest_init_without_qmp_handshake(common_args);
=20
@@ -272,6 +275,29 @@ static void test_qmp_oob(void)
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
+    for (i =3D 1; i <=3D QMP_REQ_QUEUE_LEN_MAX; i++) {
+        id =3D g_strdup_printf("queue-blocks-%d", i);
+        send_cmd_that_blocks(qts, id);
+        g_free(id);
+    }
+    send_oob_cmd_that_fails(qts, "oob-1");
+    unblock_blocked_cmd();
+    recv_cmd_id(qts, "queue-blocks-1");
+    recv_cmd_id(qts, "oob-1");
+    for (i =3D 2; i <=3D QMP_REQ_QUEUE_LEN_MAX; i++) {
+        unblock_blocked_cmd();
+        id =3D g_strdup_printf("queue-blocks-%d", i);
+        recv_cmd_id(qts, id);
+        g_free(id);
+    }
+
     cleanup_blocking_cmd();
=20
     qtest_quit(qts);
--=20
2.17.2
