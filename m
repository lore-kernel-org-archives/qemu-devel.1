Received: from eggs.gnu.org ([2001:4830:134:3::10]:55423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68J-0001Mu-SQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68I-0006sN-7C
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68H-0006s9-VG
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:54 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19188A3B41
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:54 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhUx020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:53 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:38 +0000
Message-Id: <20170124184742.1639-12-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] migration: re-active images while
 migration been canceled after inactive them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

commit fe904ea8242cbae2d7e69c052c754b8f5f1ba1d6 fixed a case
which migration aborted QEMU because it didn't regain the control
of images while some errors happened.

Actually, there are another two cases can trigger the same error reports:
" bdrv_co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed",

Case 1, codes path:
migration_thread()
    migration_completion()
        bdrv_inactivate_all() ----------------> inactivate images
        qemu_savevm_state_complete_precopy()
            socket_writev_buffer() --------> error because destination fails
                qemu_fflush() ----------------> set error on migration stream
-> qmp_migrate_cancel() ----------------> user cancelled migration concurrently
    -> migrate_set_state() ------------------> set migrate CANCELLIN
    migration_completion() -----------------> go on to fail_invalidate
	if (s->state == MIGRATION_STATUS_ACTIVE) -> Jump this branch

Case 2, codes path:
migration_thread()
    migration_completion()
        bdrv_inactivate_all() ----------------> inactivate images
    migreation_completion() finished
-> qmp_migrate_cancel() ---------------> user cancelled migration concurrently
    qemu_mutex_lock_iothread();
    qemu_bh_schedule (s->cleanup_bh);

As we can see from above, qmp_migrate_cancel can slip in whenever
migration_thread does not hold the global lock. If this happens after
bdrv_inactive_all() been called, the above error reports will appear.

To prevent this, we can call bdrv_invalidate_cache_all() in qmp_migrate_cancel()
directly if we find images become inactive.

Besides, bdrv_invalidate_cache_all() in migration_completion() doesn't have the
protection of big lock, fix it by add the missing qemu_mutex_lock_iothread();

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-Id: <1485244792-11248-1-git-send-email-zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/migration.h |  3 +++
 migration/migration.c         | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7881e89..af9135f 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -180,6 +180,9 @@ struct MigrationState
     /* Flag set once the migration thread is running (and needs joining) */
     bool migration_thread_running;
 
+    /* Flag set once the migration thread called bdrv_inactivate_all */
+    bool block_inactive;
+
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
diff --git a/migration/migration.c b/migration/migration.c
index 7dcb7d7..f8a4500 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1006,6 +1006,16 @@ static void migrate_fd_cancel(MigrationState *s)
     if (s->state == MIGRATION_STATUS_CANCELLING && f) {
         qemu_file_shutdown(f);
     }
+    if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
+        Error *local_err = NULL;
+
+        bdrv_invalidate_cache_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        } else {
+            s->block_inactive = false;
+        }
+    }
 }
 
 void add_migration_state_change_notifier(Notifier *notify)
@@ -1745,6 +1755,7 @@ static void migration_completion(MigrationState *s, int current_active_state,
             if (ret >= 0) {
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
                 qemu_savevm_state_complete_precopy(s->to_dst_file, false);
+                s->block_inactive = true;
             }
         }
         qemu_mutex_unlock_iothread();
@@ -1795,10 +1806,14 @@ fail_invalidate:
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         Error *local_err = NULL;
 
+        qemu_mutex_lock_iothread();
         bdrv_invalidate_cache_all(&local_err);
         if (local_err) {
             error_report_err(local_err);
+        } else {
+            s->block_inactive = false;
         }
+        qemu_mutex_unlock_iothread();
     }
 
 fail:
-- 
2.9.3
