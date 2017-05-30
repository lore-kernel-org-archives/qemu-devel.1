Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFizM-0003Ra-T6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFizM-0002X5-0X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:23:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 May 2017 17:22:51 +0200
Message-Id: <1496157773-10779-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
References: <1496157773-10779-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] migration: Inactivate images after
 .save_live_complete_precopy()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Block migration may still access the image during its
.save_live_complete_precopy() implementation, so we should only
inactivate the image afterwards.

Another reason for the change is that inactivating an image fails when
there is still a non-device BlockBackend using it, which includes the
BBs used by block migration. We want to give block migration a chance to
release the BBs before trying to inactivate the image (this will be done
in another patch).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 migration/migration.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ad29e53..77a05d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1820,17 +1820,19 @@ static void migration_completion(MigrationState *s, int current_active_state,
 
         if (!ret) {
             ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+            if (ret >= 0) {
+                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
+                qemu_savevm_state_complete_precopy(s->to_dst_file, false);
+            }
             /*
              * Don't mark the image with BDRV_O_INACTIVE flag if
              * we will go into COLO stage later.
              */
             if (ret >= 0 && !migrate_colo_enabled()) {
                 ret = bdrv_inactivate_all();
-            }
-            if (ret >= 0) {
-                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
-                qemu_savevm_state_complete_precopy(s->to_dst_file, false);
-                s->block_inactive = true;
+                if (ret >= 0) {
+                    s->block_inactive = true;
+                }
             }
         }
         qemu_mutex_unlock_iothread();
-- 
1.8.3.1
