Received: from eggs.gnu.org ([2001:4830:134:3::10]:50211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLZ-0002nA-6U
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLW-0004LF-Cj
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Feb 2017 12:54:43 +0300
Message-Id: <1486979689-230770-12-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 11/17] migration: add is_active_iterate handler
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
 include/migration/vmstate.h | 1 +
 migration/savevm.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1047a29..a8add46 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -47,6 +47,7 @@ typedef struct SaveVMHandlers {
     /* This runs both outside and inside the iothread lock.  */
     bool (*is_active)(void *opaque);
     bool (*has_postcopy)(void *opaque);
+    bool (*is_active_iterate)(void *opaque);
 
     /* This runs outside the iothread lock in the migration case, and
      * within the lock in the savevm case.  The callback had better only
diff --git a/migration/savevm.c b/migration/savevm.c
index b5c49bf..54572ef 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1046,6 +1046,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
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
1.8.3.1
