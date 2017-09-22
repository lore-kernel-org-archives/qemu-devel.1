Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1s-0002ix-Ct
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1q-0002AX-8s
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvN1q-00029w-14
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:25:58 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 14:25:00 +0200
Message-Id: <20170922122505.9413-14-quintela@redhat.com>
In-Reply-To: <20170922122505.9413-1-quintela@redhat.com>
References: <20170922122505.9413-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/18] migration: add has_postcopy savevm handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Now postcopy-able states are recognized by not NULL
save_live_complete_postcopy handler. But when we have several different
postcopy-able states, it is not convenient. Ram postcopy may be
disabled, while some other postcopy enabled, in this case Ram state
should behave as it is not postcopy-able.

This patch add separate has_postcopy handler to specify behaviour of
savevm state.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/register.h | 1 +
 migration/ram.c              | 6 ++++++
 migration/savevm.c           | 6 ++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a0f1edd8c7..f4f7bdc177 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -24,6 +24,7 @@ typedef struct SaveVMHandlers {
 
     /* This runs both outside and inside the iothread lock.  */
     bool (*is_active)(void *opaque);
+    bool (*has_postcopy)(void *opaque);
 
     /* This runs outside the iothread lock in the migration case, and
      * within the lock in the savevm case.  The callback had better only
diff --git a/migration/ram.c b/migration/ram.c
index bb369e72d4..cedbeae48d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2849,11 +2849,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool ram_has_postcopy(void *opaque)
+{
+    return migrate_postcopy_ram();
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
     .save_live_complete_postcopy = ram_save_complete,
     .save_live_complete_precopy = ram_save_complete,
+    .has_postcopy = ram_has_postcopy,
     .save_live_pending = ram_save_pending,
     .load_state = ram_load,
     .save_cleanup = ram_save_cleanup,
diff --git a/migration/savevm.c b/migration/savevm.c
index 7a55023d1a..9a48b7b4cb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1008,7 +1008,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
          * call that's already run, it might get confused if we call
          * iterate afterwards.
          */
-        if (postcopy && !se->ops->save_live_complete_postcopy) {
+        if (postcopy &&
+            !(se->ops->has_postcopy && se->ops->has_postcopy(se->opaque))) {
             continue;
         }
         if (qemu_file_rate_limit(f)) {
@@ -1097,7 +1098,8 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
-            (in_postcopy && se->ops->save_live_complete_postcopy) ||
+            (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
             (in_postcopy && !iterable_only) ||
             !se->ops->save_live_complete_precopy) {
             continue;
-- 
2.13.5
