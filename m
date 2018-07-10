Received: from eggs.gnu.org ([2001:4830:134:3::10]:40946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub9-0003IC-Rf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcub8-0003Th-Rp
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcub8-0003TI-J8
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09D1040214E2
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:15 +0100
Message-Id: <20180710153016.131258-15-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] tests: hide stderr for postcopy recovery
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

We dumped something when network failure happens.  We should avoid those
messages to be dumped when running the tests:

  $ ./tests/migration-test -p /x86_64/migration/postcopy/recovery
  /x86_64/migration/postcopy/recovery: qemu-system-x86_64: check_section_footer: Read section footer failed: -5
  qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
  qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
  OK

After the patch:

  $ ./tests/migration-test -p /x86_64/migration/postcopy/recovery
  /x86_64/migration/postcopy/recovery: OK

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-11-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index d8b2633fce..086f727b34 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -572,12 +572,13 @@ static void test_deprecated(void)
 }
 
 static int migrate_postcopy_prepare(QTestState **from_ptr,
-                                     QTestState **to_ptr)
+                                     QTestState **to_ptr,
+                                     bool hide_error)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, false)) {
+    if (test_migrate_start(&from, &to, uri, hide_error)) {
         return -1;
     }
 
@@ -624,7 +625,7 @@ static void test_postcopy(void)
 {
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to)) {
+    if (migrate_postcopy_prepare(&from, &to, false)) {
         return;
     }
     migrate_postcopy_start(from, to);
@@ -636,7 +637,7 @@ static void test_postcopy_recovery(void)
     QTestState *from, *to;
     char *uri;
 
-    if (migrate_postcopy_prepare(&from, &to)) {
+    if (migrate_postcopy_prepare(&from, &to, true)) {
         return;
     }
 
-- 
2.17.1
