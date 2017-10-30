Received: from eggs.gnu.org ([2001:4830:134:3::10]:43242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D09-0006Lw-OC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9D03-0006cG-H3
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:33:25 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Oct 2017 19:33:04 +0300
Message-Id: <20171030163309.75770-10-vsementsov@virtuozzo.com>
In-Reply-To: <20171030163309.75770-1-vsementsov@virtuozzo.com>
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v8 09/14] migration: add is_active_iterate
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

Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
to disable them and stop transporting empty sections there is a new
savevm handler.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/register.h | 1 +
 migration/savevm.c           | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9436a87678..cafbeb64b5 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -25,6 +25,7 @@ typedef struct SaveVMHandlers {
     /* This runs both outside and inside the iothread lock.  */
     bool (*is_active)(void *opaque);
     bool (*has_postcopy)(void *opaque);
+    bool (*is_active_iterate)(void *opaque);
 
     /* This runs outside the iothread lock in the migration case, and
      * within the lock in the savevm case.  The callback had better only
diff --git a/migration/savevm.c b/migration/savevm.c
index f6b62cb202..9bbfb3fa1b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1026,6 +1026,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
                 continue;
             }
         }
+        if (se->ops && se->ops->is_active_iterate) {
+            if (!se->ops->is_active_iterate(se->opaque)) {
+                continue;
+            }
+        }
         /*
          * In the postcopy phase, any device that doesn't know how to
          * do postcopy should have saved it's state in the _complete
-- 
2.11.1
