Received: from eggs.gnu.org ([2001:4830:134:3::10]:38474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1n-0003iY-VY
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1l-0004so-52
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fha1l-0004sY-0t
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0B7240200AA
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:33:24 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 23 Jul 2018 20:33:05 +0800
Message-Id: <20180723123305.24792-5-peterx@redhat.com>
In-Reply-To: <20180723123305.24792-1-peterx@redhat.com>
References: <20180723123305.24792-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 4/4] tests: torture release-ram in
 postcopy test
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

The release-ram capability will run some extra code for postcopy to
release used ram right away, let's just turn that on for the postcopy
unix test always to torture that code path too to make sure release-ram
feature won't break again.  The recovery test needs to turn that off
since release-ram cannot coop with that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/migration-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index e079e0bdb6..deaec431fe 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -572,8 +572,9 @@ static void test_deprecated(void)
 }
 
 static int migrate_postcopy_prepare(QTestState **from_ptr,
-                                     QTestState **to_ptr,
-                                     bool hide_error)
+                                    QTestState **to_ptr,
+                                    bool hide_error,
+                                    bool release_ram)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -582,6 +583,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         return -1;
     }
 
+    if (release_ram) {
+        migrate_set_capability(from, "release-ram", "true");
+    }
+
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-blocktime", "true");
@@ -625,7 +630,7 @@ static void test_postcopy(void)
 {
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to, false)) {
+    if (migrate_postcopy_prepare(&from, &to, false, true)) {
         return;
     }
     migrate_postcopy_start(from, to);
@@ -637,7 +642,8 @@ static void test_postcopy_recovery(void)
     QTestState *from, *to;
     char *uri;
 
-    if (migrate_postcopy_prepare(&from, &to, true)) {
+    /* The release-ram feature cannot work with postcopy recovery. */
+    if (migrate_postcopy_prepare(&from, &to, true, false)) {
         return;
     }
 
-- 
2.17.1
