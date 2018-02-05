Received: from eggs.gnu.org ([2001:4830:134:3::10]:51311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eidFh-00056j-NW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eidFc-0006zH-Ok
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:39:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eidFc-0006yl-Iv
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 04:39:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E969161461
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 09:39:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  5 Feb 2018 09:39:41 +0000
Message-Id: <20180205093941.21058-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Recover block devices if failure in
 device state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Cc: kwolf@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

In e91d895 I added the new pause-before-switchover mechanism
to allow migration completion to be delayed; this changes the
last state prior to completion to MIGRATE_STATUS_DEVICE rather
than MIGRATE_STATUS_ACTIVE.

Fix the failure path in migration_completion to recover the block
devices if it fails in MIGRATE_STATUS_DEVICE, not just the
MIGRATE_STATUS_ACTIVE that it previously had.

This corresponds to rh bz:
  https://bugzilla.redhat.com/show_bug.cgi?id=1538494
whose symptom is an occasional source crash on a failed migration.

Fixes: e91d8951d59d483f085f
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c99a4e62d7..a5e8bb4a78 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2122,7 +2122,8 @@ fail_invalidate:
     /* If not doing postcopy, vm_start() will be called: let's regain
      * control on images.
      */
-    if (s->state == MIGRATION_STATUS_ACTIVE) {
+    if (s->state == MIGRATION_STATUS_ACTIVE ||
+        s->state == MIGRATION_STATUS_DEVICE) {
         Error *local_err = NULL;
 
         qemu_mutex_lock_iothread();
-- 
2.14.3
