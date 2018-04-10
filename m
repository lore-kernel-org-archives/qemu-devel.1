Received: from eggs.gnu.org ([2001:4830:134:3::10]:33939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5uo8-0002Rp-Tm
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5uo3-0001PF-AT
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:03:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f5uo3-0001P1-6N
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:03:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0A4E406E96B
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 15:03:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Apr 2018 16:03:29 +0100
Message-Id: <20180410150329.47586-2-dgilbert@redhat.com>
In-Reply-To: <20180410150329.47586-1-dgilbert@redhat.com>
References: <20180410150329.47586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] Revert "migration: Don't activate block
 devices if using -S"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This reverts commit 0746a92612276aee69e66dfe6782b0f882d221d5.
Discussion with kwolf suggests this is actually an API change that
we need to gate on a capability.  Push to 2.13.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 58bd382730..52a5092add 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -306,21 +306,13 @@ static void process_incoming_migration_bh(void *opaque)
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
-    /* Only fire up the block code now if we're going to restart the
-     * VM, else 'cont' will do it.
-     * This causes file locking to happen; so we don't want it to happen
-     * unless we really are starting the VM.
-     */
-    if (autostart && (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING)) {
-        /* Make sure all file formats flush their mutable metadata.
-         * If we get an error here, just don't restart the VM yet. */
-        bdrv_invalidate_cache_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-            autostart = false;
-        }
+    /* Make sure all file formats flush their mutable metadata.
+     * If we get an error here, just don't restart the VM yet. */
+    bdrv_invalidate_cache_all(&local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        local_err = NULL;
+        autostart = false;
     }
 
     /*
-- 
2.16.2
