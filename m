Received: from eggs.gnu.org ([2001:4830:134:3::10]:59650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNM-0008GR-Mr
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddRNL-0003p2-U6
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddRNL-0003o3-OM
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 21:26:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A46CA85550
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 01:26:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 20:25:32 -0500
Message-Id: <20170804012551.2714-4-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-1-eblake@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/22] tests/libqtest: Clean up how we read
 the QMP greeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

qtest_init() still uses the qtest_qmp_discard_response(s, "") hack to
receive the greeting, even though we have qtest_qmp_receive() since
commit 66e0c7b.  Put it to use.

Bonus: gets rid of an empty format string.  A step towards
compile-time format string checking without triggering
-Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1500645206-13559-9-git-send-email-armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: hoist earlier in series
---
 tests/libqtest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 4a5492a603..7e5425d704 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -230,9 +230,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 QTestState *qtest_init(const char *extra_args)
 {
     QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    QDict *greeting;

     /* Read the QMP greeting and then do the handshake */
-    qtest_qmp_discard_response(s, "");
+    greeting = qtest_qmp_receive(s);
+    QDECREF(greeting);
     qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");

     return s;
-- 
2.13.3
