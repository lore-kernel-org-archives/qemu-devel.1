Received: from eggs.gnu.org ([2001:4830:134:3::10]:55607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJn2-0001YY-5u
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZJn1-00033J-Fh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZJn1-000330-9X
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:59:15 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  2 Feb 2017 15:59:09 +0000
Message-Id: <20170202155909.31784-3-dgilbert@redhat.com>
In-Reply-To: <20170202155909.31784-1-dgilbert@redhat.com>
References: <20170202155909.31784-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] postcopy: Recover block devices on early
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: zhang.zhanghailiang@huawei.com

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
---
 migration/migration.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 2766d2f..283677c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1605,6 +1605,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
     int64_t time_at_stop = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    bool restart_block = false;
     migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
@@ -1624,6 +1625,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     if (ret < 0) {
         goto fail;
     }
+    restart_block = true;
 
     /*
      * Cause any non-postcopiable, but iterative devices to
@@ -1680,6 +1682,18 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
 
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
@@ -1717,6 +1731,17 @@ fail_closefb:
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
2.9.3
