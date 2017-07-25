Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BZ-0002Jc-0r
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BY-0004bP-63
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da7BX-0004ax-PW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:16:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6ACEA23D7
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:16:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:22 -0500
Message-Id: <20170725211523.3998-12-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/12] tests/libqtest: Clean up how we read
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
Cc: stefanha@redhat.com, armbru@redhat.com

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
 tests/libqtest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 1b57cedca1..b0fcbf2872 100644
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
