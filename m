Received: from eggs.gnu.org ([2001:4830:134:3::10]:51507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fg59O-0003RU-Ay
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fg59K-0004VN-CK
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:23:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fg59K-0004V2-6a
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 05:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04835402243B
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:23:01 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 19 Jul 2018 10:22:57 +0100
Message-Id: <20180719092257.12703-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] migrate: Fix cancelling state warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've been getting the warning:

migration_iteration_finish: Unknown ending state 2

on a cancel.

I think that's originally due to 39b9e17905c;  although
I've only seen the warning, I think that in some cases
that we could find the VM stays paused after a cancel where
it should restart.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8d56d56930..db6bde7453 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2877,6 +2877,7 @@ static void migration_iteration_finish(MigrationState *s)
         /* Fallthrough */
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_CANCELLING:
         if (s->vm_was_running) {
             vm_start();
         } else {
-- 
2.17.1
