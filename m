Received: from eggs.gnu.org ([2001:4830:134:3::10]:35285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWU-0004IB-Aq
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWT-0005nm-Ek
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1camWT-0005nO-8W
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:13 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55CEE51469
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 16:52:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  6 Feb 2017 17:51:49 +0100
Message-Id: <1486399909-16338-7-git-send-email-quintela@redhat.com>
In-Reply-To: <1486399909-16338-1-git-send-email-quintela@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] postcopy: Recover block devices on early
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

An early postcopy failure can be recovered from as long as we know
we haven't sent the command to run the destination.
We have to undo the bdrv_inactivate_all by calling
bdrv_invalidate_cache_all

Note that I'm not using ms->block_inactive because once we've
sent the postcopy package we dont want anything else to try
and recover the block storage on the source; the destination
might have started writing to it.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170202155909.31784-3-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 619ccc4..2b179c6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1601,6 +1601,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
     int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    bool restart_block = false;
     migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);

@@ -1620,6 +1621,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     if (ret < 0) {
         goto fail;
     }
+    restart_block = true;

     /*
      * Cause any non-postcopiable, but iterative devices to
@@ -1676,6 +1678,18 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)

     /* <><> end of stuff going into the package */

+    /* Last point of recovery; as soon as we send the package the destination
+     * can open devices and potentially start running.
+     * Lets just check again we've not got any errors.
+     */
+    ret = qemu_file_get_error(ms->to_dst_file);
+    if (ret) {
+        error_report("postcopy_start: Migration stream errored (pre package)");
+        goto fail_closefb;
+    }
+
+    restart_block = false;
+
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
         goto fail_closefb;
@@ -1713,6 +1727,17 @@ fail_closefb:
 fail:
     migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                           MIGRATION_STATUS_FAILED);
+    if (restart_block) {
+        /* A failure happened early enough that we know the destination hasn't
+         * accessed block devices, so we're safe to recover.
+         */
+        Error *local_err = NULL;
+
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
     qemu_mutex_unlock_iothread();
     return -1;
 }
-- 
2.7.4
