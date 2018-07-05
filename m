Received: from eggs.gnu.org ([2001:4830:134:3::10]:49918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1faumm-0004Jh-4F
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fauml-0002Nu-3c
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:18:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1faumk-0002Mr-Vc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 23:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A50881A4EAD
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 03:18:22 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  5 Jul 2018 11:17:55 +0800
Message-Id: <20180705031755.3254-10-peterx@redhat.com>
In-Reply-To: <20180705031755.3254-1-peterx@redhat.com>
References: <20180705031755.3254-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 9/9] tests: hide stderr for postcopy
 recovery test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 182fc88e93..96e69dab99 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -567,12 +567,13 @@ static void test_deprecated(void)
 }
 
 static void migrate_postcopy_prepare(QTestState **from_ptr,
-                                     QTestState **to_ptr)
+                                     QTestState **to_ptr,
+                                     bool hide_error)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    test_migrate_start(&from, &to, uri, false);
+    test_migrate_start(&from, &to, uri, hide_error);
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
@@ -615,7 +616,7 @@ static void test_postcopy(void)
 {
     QTestState *from, *to;
 
-    migrate_postcopy_prepare(&from, &to);
+    migrate_postcopy_prepare(&from, &to, false);
     migrate_postcopy_start(from, to);
     migrate_postcopy_complete(from, to);
 }
@@ -625,7 +626,7 @@ static void test_postcopy_recovery(void)
     QTestState *from, *to;
     char *uri;
 
-    migrate_postcopy_prepare(&from, &to);
+    migrate_postcopy_prepare(&from, &to, true);
 
     /* Turn postcopy speed down, 4K/s is slow enough on any machines */
     migrate_set_parameter(from, "max-postcopy-bandwidth", "4096");
-- 
2.17.1
