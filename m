Received: from eggs.gnu.org ([2001:4830:134:3::10]:44410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLWIW-0005Xj-0E
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLWIT-0005fe-Ha
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:07:31 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 May 2018 18:07:20 +0200
Message-Id: <20180523160721.14018-2-pbonzini@redhat.com>
In-Reply-To: <20180523160721.14018-1-pbonzini@redhat.com>
References: <20180523160721.14018-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] sheepdog: cleanup repeated expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, qemu-block@nongnu.org

The expression "SD_INODE_SIZE - sizeof(inode.data_vdi_id)" already has a macro
defined for the same value (though with a nicer definition using offsetof).
Replace it.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/sheepdog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 4237132419..23cf5a8430 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2337,7 +2337,7 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     /* we don't need to update entire object */
-    datalen = SD_INODE_SIZE - sizeof(s->inode.data_vdi_id);
+    datalen = SD_INODE_HEADER_SIZE;
     s->inode.vdi_size = offset;
     ret = write_object(fd, s->bs, (char *)&s->inode,
                        vid_to_vdi_oid(s->inode.vdi_id), s->inode.nr_copies,
@@ -2705,7 +2705,7 @@ static int sd_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
      */
     strncpy(s->inode.tag, sn_info->name, sizeof(s->inode.tag));
     /* we don't need to update entire object */
-    datalen = SD_INODE_SIZE - sizeof(s->inode.data_vdi_id);
+    datalen = SD_INODE_HEADER_SIZE;
     inode = g_malloc(datalen);
 
     /* refresh inode. */
@@ -2991,7 +2991,7 @@ static int sd_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
         /* we don't need to read entire object */
         ret = read_object(fd, s->bs, (char *)&inode,
                           vid_to_vdi_oid(vid),
-                          0, SD_INODE_SIZE - sizeof(inode.data_vdi_id), 0,
+                          0, SD_INODE_HEADER_SIZE, 0,
                           s->cache_flags);
 
         if (ret) {
-- 
2.17.0
