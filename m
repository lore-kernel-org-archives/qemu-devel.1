Received: from eggs.gnu.org ([2001:4830:134:3::10]:49075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqt-0005IA-9b
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUwqs-0007eE-DX
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUwqs-0007da-7Q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:50:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A672307DAB4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 16:50:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  6 Dec 2018 17:49:57 +0100
Message-Id: <1544114998-1513-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1544114998-1513-1-git-send-email-thuth@redhat.com>
References: <1544114998-1513-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 4/5] tests/prom-env: Make test
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, eblake@redhat.com

global_qtest is only needed here for one readl(). Let's replace it
with qtest_readl() and we can remove the global_qtest variable here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/prom-env-test.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 198d007..4821254 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -25,14 +25,14 @@
 #define MAGIC   0xcafec0de
 #define ADDRESS 0x4000
 
-static void check_guest_memory(void)
+static void check_guest_memory(QTestState *qts)
 {
     uint32_t signature;
     int i;
 
     /* Poll until code has run and modified memory. Wait at most 600 seconds */
     for (i = 0; i < 60000; ++i) {
-        signature = readl(ADDRESS);
+        signature = qtest_readl(qts, ADDRESS);
         if (signature == MAGIC) {
             break;
         }
@@ -45,17 +45,16 @@ static void check_guest_memory(void)
 static void test_machine(const void *machine)
 {
     const char *extra_args;
+    QTestState *qts;
 
     /* The pseries firmware boots much faster without the default devices */
     extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";
 
-    global_qtest = qtest_initf("-M %s,accel=tcg %s "
-                               "-prom-env 'use-nvramrc?=true' "
-                               "-prom-env 'nvramrc=%x %x l!' ",
-                               (const char *)machine, extra_args,
-                               MAGIC, ADDRESS);
-    check_guest_memory();
-    qtest_quit(global_qtest);
+    qts = qtest_initf("-M %s,accel=tcg %s -prom-env 'use-nvramrc?=true' "
+                      "-prom-env 'nvramrc=%x %x l!' ", (const char *)machine,
+                      extra_args, MAGIC, ADDRESS);
+    check_guest_memory(qts);
+    qtest_quit(qts);
 }
 
 static void add_tests(const char *machines[])
-- 
1.8.3.1
