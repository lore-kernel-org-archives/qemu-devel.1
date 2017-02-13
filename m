Received: from eggs.gnu.org ([2001:4830:134:3::10]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLZ-0002n5-4W
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLW-0004L7-9f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Feb 2017 12:54:33 +0300
Message-Id: <1486979689-230770-2-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 01/17] migration: add has_postcopy savevm
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Now postcopy-able states are recognized by not NULL
save_live_complete_postcopy handler. But when we have several different
postcopy-able states, it is not convenient. Ram postcopy may be
disabled, while some other postcopy enabled, in this case Ram state
should behave as it is not postcopy-able.

This patch add separate has_postcopy handler to specify behaviour of
savevm state.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/vmstate.h | 1 +
 migration/ram.c             | 6 ++++++
 migration/savevm.c          | 6 ++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 6233fe2..82b232d 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -46,6 +46,7 @@ typedef struct SaveVMHandlers {
 
     /* This runs both outside and inside the iothread lock.  */
     bool (*is_active)(void *opaque);
+    bool (*has_postcopy)(void *opaque);
 
     /* This runs outside the iothread lock in the migration case, and
      * within the lock in the savevm case.  The callback had better only
diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..c688866 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2589,10 +2589,16 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static bool ram_has_postcopy(void *opaque)
+{
+    return migrate_postcopy_ram();
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_live_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
     .save_live_complete_postcopy = ram_save_complete,
+    .has_postcopy = ram_has_postcopy,
     .save_live_complete_precopy = ram_save_complete,
     .save_live_pending = ram_save_pending,
     .load_state = ram_load,
diff --git a/migration/savevm.c b/migration/savevm.c
index 0199768..8ebb27a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1030,7 +1030,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
          * call that's already run, it might get confused if we call
          * iterate afterwards.
          */
-        if (postcopy && !se->ops->save_live_complete_postcopy) {
+        if (postcopy &&
+            !(se->ops->has_postcopy && se->ops->has_postcopy(se->opaque))) {
             continue;
         }
         if (qemu_file_rate_limit(f)) {
@@ -1118,7 +1119,8 @@ void qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (!se->ops ||
-            (in_postcopy && se->ops->save_live_complete_postcopy) ||
+            (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
             (in_postcopy && !iterable_only) ||
             !se->ops->save_live_complete_precopy) {
             continue;
-- 
1.8.3.1
