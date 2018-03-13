Received: from eggs.gnu.org ([2001:4830:134:3::10]:34712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFz-0000mZ-Hx
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evrFx-0005o3-TU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1evrFx-0005nY-Nv
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:49 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 13 Mar 2018 17:14:37 -0400
Message-Id: <20180313211441.5179-10-jsnow@redhat.com>
In-Reply-To: <20180313211441.5179-1-jsnow@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 09/13] migration: add is_active_iterate handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
to disable them and stop transporting empty sections there is a new
savevm handler.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20180313180320.339796-10-vsementsov@virtuozzo.com
---
 include/migration/register.h | 9 +++++++++
 migration/savevm.c           | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index 9436a87678..f6f12f9b1a 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -26,6 +26,15 @@ typedef struct SaveVMHandlers {
     bool (*is_active)(void *opaque);
     bool (*has_postcopy)(void *opaque);
 
+    /* is_active_iterate
+     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
+     * it returns false. For example, it is needed for only-postcopy-states,
+     * which needs to be handled by qemu_savevm_state_setup and
+     * qemu_savevm_state_pending, but do not need iterations until not in
+     * postcopy stage.
+     */
+    bool (*is_active_iterate)(void *opaque);
+
     /* This runs outside the iothread lock in the migration case, and
      * within the lock in the savevm case.  The callback had better only
      * use data that is local to the migration thread or protected
diff --git a/migration/savevm.c b/migration/savevm.c
index cd5944b81f..a60819ec2e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1028,6 +1028,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
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
2.14.3
