Received: from eggs.gnu.org ([2001:4830:134:3::10]:50979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveS-0000WX-4q
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveN-0000Ls-Kn
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYveK-0000EO-KQ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1732389AEF
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:21:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:23 +0100
Message-Id: <1545063690-10116-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] tests/boot-serial: Get rid of
 global_qtest variable
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

The test does not use any of the functions that require global_qtest,
so we can simply get rid of this global variable here.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 8ec6aed..366fe51 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -161,6 +161,7 @@ static void test_machine(const void *data)
     char codetmp[] = "/tmp/qtest-boot-serial-cXXXXXX";
     const char *codeparam = "";
     const uint8_t *code = NULL;
+    QTestState *qts;
     int ser_fd;
 
     ser_fd = mkstemp(serialtmp);
@@ -189,11 +190,11 @@ static void test_machine(const void *data)
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    global_qtest = qtest_initf("%s %s -M %s,accel=tcg:kvm "
-                               "-chardev file,id=serial0,path=%s "
-                               "-no-shutdown -serial chardev:serial0 %s",
-                               codeparam, code ? codetmp : "",
-                               test->machine, serialtmp, test->extra);
+    qts = qtest_initf("%s %s -M %s,accel=tcg:kvm -no-shutdown "
+                      "-chardev file,id=serial0,path=%s "
+                      "-serial chardev:serial0 %s",
+                      codeparam, code ? codetmp : "", test->machine,
+                      serialtmp, test->extra);
     if (code) {
         unlink(codetmp);
     }
@@ -204,7 +205,7 @@ static void test_machine(const void *data)
     }
     unlink(serialtmp);
 
-    qtest_quit(global_qtest);
+    qtest_quit(qts);
 
     close(ser_fd);
 }
-- 
1.8.3.1
