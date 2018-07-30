Received: from eggs.gnu.org ([2001:4830:134:3::10]:39378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cJ-0003P0-SD
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cF-0004Ux-SB
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cF-0004Un-NE
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:32:58 +0200
Message-Id: <20180730083317.11765-5-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/23] libqtest: Clean up how we read the
 QMP greeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

qtest_init() still uses the qtest_qmp_discard_response(s, "") hack to
receive the greeting, even though we have qtest_qmp_receive() since
commit 66e0c7b187e.  Put it to use.

Bonus: gets rid of an empty format string.  A step towards
compile-time format string checking without triggering
-Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 071d7eb7b1..c2c08a890c 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -249,9 +249,11 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
 QTestState *qtest_init(const char *extra_args)
 {
     QTestState *s = qtest_init_without_qmp_handshake(false, extra_args);
+    QDict *greeting;
 
     /* Read the QMP greeting and then do the handshake */
-    qtest_qmp_discard_response(s, "");
+    greeting = qtest_qmp_receive(s);
+    qobject_unref(greeting);
     qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
 
     return s;
-- 
2.17.1
