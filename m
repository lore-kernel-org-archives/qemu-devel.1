Received: from eggs.gnu.org ([2001:4830:134:3::10]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveS-0000Wa-77
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveO-0000Mk-6C
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYveK-0000CM-LP
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8E2FA4055
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:21:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:22 +0100
Message-Id: <1545063690-10116-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] tests/pvpanic: Make the pvpanic test
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

We want to get rid of global_qtest in the long run, thus do not
use the wrappers like inb() and outb() here anymore.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pvpanic-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 7461a72..ff9176a 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -15,13 +15,16 @@ static void test_panic(void)
 {
     uint8_t val;
     QDict *response, *data;
+    QTestState *qts;
 
-    val = inb(0x505);
+    qts = qtest_init("-device pvpanic");
+
+    val = qtest_inb(qts, 0x505);
     g_assert_cmpuint(val, ==, 1);
 
-    outb(0x505, 0x1);
+    qtest_outb(qts, 0x505, 0x1);
 
-    response = qmp_receive();
+    response = qtest_qmp_receive(qts);
     g_assert(qdict_haskey(response, "event"));
     g_assert_cmpstr(qdict_get_str(response, "event"), ==, "GUEST_PANICKED");
     g_assert(qdict_haskey(response, "data"));
@@ -29,6 +32,8 @@ static void test_panic(void)
     g_assert(qdict_haskey(data, "action"));
     g_assert_cmpstr(qdict_get_str(data, "action"), ==, "pause");
     qobject_unref(response);
+
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
@@ -38,10 +43,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic/panic", test_panic);
 
-    qtest_start("-device pvpanic");
     ret = g_test_run();
 
-    qtest_end();
-
     return ret;
 }
-- 
1.8.3.1
