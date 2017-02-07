Received: from eggs.gnu.org ([2001:4830:134:3::10]:57884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7LC-0000YJ-GY
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cb7L5-00079a-0N
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:05:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Feb 2017 18:05:34 +0300
Message-Id: <1486479940-163258-12-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486479940-163258-1-git-send-email-vsementsov@virtuozzo.com>
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
index da62a73..6049deb 100644
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
index d1bab59..94783e5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1034,6 +1034,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
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
