Received: from eggs.gnu.org ([2001:4830:134:3::10]:44427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLWIY-0005ZX-Hh
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLWIU-0005fp-Hu
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:07:34 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 May 2018 18:07:21 +0200
Message-Id: <20180523160721.14018-3-pbonzini@redhat.com>
In-Reply-To: <20180523160721.14018-1-pbonzini@redhat.com>
References: <20180523160721.14018-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] sheepdog: remove huge BSS object
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

block/sheepdog.o has a 4M static variable that is 90% of QEMU's whole .bss
section.  Replace it with a heap-allocated block, and make it smaller too
since only the inode header is actually being used.

bss size goes down from 4464280 to 269976.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/sheepdog.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 23cf5a8430..2068166e3e 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2940,13 +2940,14 @@ static int sd_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
     QEMUSnapshotInfo *sn_tab = NULL;
     unsigned wlen, rlen;
     int found = 0;
-    static SheepdogInode inode;
+    SheepdogInode *inode;
     unsigned long *vdi_inuse;
     unsigned int start_nr;
     uint64_t hval;
     uint32_t vid;
 
     vdi_inuse = g_malloc(max);
+    inode = g_malloc(SD_INODE_HEADER_SIZE);
 
     fd = connect_to_sdog(s, &local_err);
     if (fd < 0) {
@@ -2989,7 +2990,7 @@ static int sd_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
         }
 
         /* we don't need to read entire object */
-        ret = read_object(fd, s->bs, (char *)&inode,
+        ret = read_object(fd, s->bs, (char *)inode,
                           vid_to_vdi_oid(vid),
                           0, SD_INODE_HEADER_SIZE, 0,
                           s->cache_flags);
@@ -2998,17 +2999,17 @@ static int sd_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab)
             continue;
         }
 
-        if (!strcmp(inode.name, s->name) && is_snapshot(&inode)) {
-            sn_tab[found].date_sec = inode.snap_ctime >> 32;
-            sn_tab[found].date_nsec = inode.snap_ctime & 0xffffffff;
-            sn_tab[found].vm_state_size = inode.vm_state_size;
-            sn_tab[found].vm_clock_nsec = inode.vm_clock_nsec;
+        if (!strcmp(inode->name, s->name) && is_snapshot(inode)) {
+            sn_tab[found].date_sec = inode->snap_ctime >> 32;
+            sn_tab[found].date_nsec = inode->snap_ctime & 0xffffffff;
+            sn_tab[found].vm_state_size = inode->vm_state_size;
+            sn_tab[found].vm_clock_nsec = inode->vm_clock_nsec;
 
             snprintf(sn_tab[found].id_str, sizeof(sn_tab[found].id_str),
-                     "%" PRIu32, inode.snap_id);
+                     "%" PRIu32, inode->snap_id);
             pstrcpy(sn_tab[found].name,
-                    MIN(sizeof(sn_tab[found].name), sizeof(inode.tag)),
-                    inode.tag);
+                    MIN(sizeof(sn_tab[found].name), sizeof(inode->tag)),
+                    inode->tag);
             found++;
         }
     }
@@ -3019,6 +3019,7 @@ out:
     *psn_tab = sn_tab;
 
     g_free(vdi_inuse);
+    g_free(inode);
 
     if (ret < 0) {
         return ret;
-- 
2.17.0
