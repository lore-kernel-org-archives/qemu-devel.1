Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Y3l-0002un-K1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1Y3g-0008NH-Og
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1Y3g-0008Ms-K7
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:57:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DA32402314E
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 13:57:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 29 Mar 2018 14:57:30 +0100
Message-Id: <20180329135730.95774-3-dgilbert@redhat.com>
In-Reply-To: <20180329135730.95774-1-dgilbert@redhat.com>
References: <20180329135730.95774-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] migration: Don't activate block devices if
 using -S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Activating the block devices causes the locks to be taken on
the backing file.  If we're running with -S and the destination libvirt
hasn't started the destination with 'cont', it's expecting the locks are
still untaken.

Don't activate the block devices if we're not going to autostart the VM;
'cont' already will do that anyway.

bz: https://bugzilla.redhat.com/show_bug.cgi?id=1560854
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180328170207.49512-1-dgilbert@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 52a5092add..58bd382730 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -306,13 +306,21 @@ static void process_incoming_migration_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
-    /* Make sure all file formats flush their mutable metadata.
-     * If we get an error here, just don't restart the VM yet. */
-    bdrv_invalidate_cache_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        local_err = NULL;
-        autostart = false;
+    /* Only fire up the block code now if we're going to restart the
+     * VM, else 'cont' will do it.
+     * This causes file locking to happen; so we don't want it to happen
+     * unless we really are starting the VM.
+     */
+    if (autostart && (!global_state_received() ||
+        global_state_get_runstate() == RUN_STATE_RUNNING)) {
+        /* Make sure all file formats flush their mutable metadata.
+         * If we get an error here, just don't restart the VM yet. */
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+            autostart = false;
+        }
     }
 
     /*
-- 
2.14.3
