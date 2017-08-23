Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbW-0008Qd-Fu
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkYbV-0005Qd-FC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:34:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 23 Aug 2017 11:33:45 -0500
Message-Id: <20170823163349.11663-3-eblake@redhat.com>
In-Reply-To: <20170823163349.11663-1-eblake@redhat.com>
References: <20170823163349.11663-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] block-backend: Allow more "can inactivate"
 cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Fam Zheng <famz@redhat.com>

These two conditions corresponds to mirror job's source and target,
which need to be allowed as they are part of the non-shared storage
migration workflow: failing to inactivate either will result in a
failure during migration completion.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170823134242.12080-3-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[eblake: improve comment grammar]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/sysemu/block-backend.h |  1 +
 block/block-backend.c          | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

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
diff --git a/block/block-backend.c b/block/block-backend.c
index a3984d2bec..1031742401 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -70,6 +70,7 @@ struct BlockBackend {

     int quiesce_counter;
     VMChangeStateEntry *vmsh;
+    bool force_allow_inactivate;
 };

 typedef struct BlockBackendAIOCB {
@@ -192,17 +193,28 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
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
+    /* Inactivating means no more writes to the image can be done,
+     * even if those writes would be changes invisible to the
+     * guest.  For block job BBs that satisfy this, we can just allow
+     * it.  This is the case for mirror job source, which is required
+     * by libvirt non-shared block migration. */
+    if (!(blk->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))) {
+        return true;
+    }
+
+    return blk->force_allow_inactivate;
 }

 static int blk_root_inactivate(BdrvChild *child)
-- 
2.13.5
