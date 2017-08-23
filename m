Received: from eggs.gnu.org ([2001:4830:134:3::10]:53070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVw4-0004Qk-JL
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVw3-00020O-M0
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:43:08 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 23 Aug 2017 21:42:40 +0800
Message-Id: <20170823134242.12080-3-famz@redhat.com>
In-Reply-To: <20170823134242.12080-1-famz@redhat.com>
References: <20170823134242.12080-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/4] block-backend: Allow more "can
 inactivate" cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

These two conditions corresponds to mirror job's source and target,
which need to be allowed as they are part of the non-shared storage
migration workflow: failing to inactivate either will result in a
failure during migration completion.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c          | 21 ++++++++++++++++-----
 include/sysemu/block-backend.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index a3984d2bec..48f5356657 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -70,6 +70,7 @@ struct BlockBackend {
 
     int quiesce_counter;
     VMChangeStateEntry *vmsh;
+    bool force_allow_inactivate;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -192,17 +193,27 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
     }
 }
 
+void blk_set_force_allow_inactivate(BlockBackend *blk)
+{
+    blk->force_allow_inactivate = true;
+}
+
 static bool blk_can_inactivate(BlockBackend *blk)
 {
-    /* Only inactivate BlockBackends for guest devices (which are inactive at
-     * this point because the VM is stopped) and unattached monitor-owned
-     * BlockBackends. If there is still any other user like a block job, then
-     * we simply can't inactivate the image. */
+    /* If it is a guest device, inactivate is ok. */
     if (blk->dev || blk_name(blk)[0]) {
         return true;
     }
 
-    return false;
+    /* Inactivating means no more write to the image can be done, even if it's
+     * guest invisible change. For block job BBs that satisfy this, we can just
+     * allow it.  This is the case for mirror job source, which is required by
+     * libvirt non-shared block migration. */
+    if (!(blk->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))) {
+        return true;
+    }
+
+    return blk->force_allow_inactivate;
 }
 
 static int blk_root_inactivate(BdrvChild *child)
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 4a3730596b..aadc733daf 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -241,5 +241,6 @@ void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
 void blk_io_limits_disable(BlockBackend *blk);
 void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
+void blk_set_force_allow_inactivate(BlockBackend *blk);
 
 #endif
-- 
2.13.5
