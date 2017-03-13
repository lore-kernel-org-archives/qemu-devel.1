Received: from eggs.gnu.org ([2001:4830:134:3::10]:35152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNe-0005iU-HV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cnRNd-0002uR-Mk
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:55:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Mar 2017 15:55:01 +0100
Message-Id: <1489416908-3771-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
References: <1489416908-3771-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] vvfat: React to bdrv_is_allocated() errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

If bdrv_is_allocated() fails, we should react to that failure.
For 2 of the 3 callers, reporting the error was easy.  But in
cluster_was_modified() and its lone caller
get_cluster_count_for_direntry(), it's rather invasive to update
the logic to pass the error back; so there, I went with merely
documenting the issue by changing the return type to bool (in
all likelihood, treating the cluster as modified will then
trigger a read which will also fail, and eventually get to an
error - but given the appalling number of abort() calls in this
code, I'm not making it any worse).

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index aa61c32..af5153d 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1394,7 +1394,13 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
 	   return -1;
 	if (s->qcow) {
 	    int n;
-            if (bdrv_is_allocated(s->qcow->bs, sector_num, nb_sectors-i, &n)) {
+            int ret;
+            ret = bdrv_is_allocated(s->qcow->bs, sector_num,
+                                    nb_sectors - i, &n);
+            if (ret < 0) {
+                return ret;
+            }
+            if (ret) {
                 DLOG(fprintf(stderr, "sectors %d+%d allocated\n",
                              (int)sector_num, n));
                 if (bdrv_read(s->qcow, sector_num, buf + i * 0x200, n)) {
@@ -1668,7 +1674,8 @@ static inline uint32_t modified_fat_get(BDRVVVFATState* s,
     }
 }
 
-static inline int cluster_was_modified(BDRVVVFATState* s, uint32_t cluster_num)
+static inline bool cluster_was_modified(BDRVVVFATState *s,
+                                        uint32_t cluster_num)
 {
     int was_modified = 0;
     int i, dummy;
@@ -1683,7 +1690,13 @@ static inline int cluster_was_modified(BDRVVVFATState* s, uint32_t cluster_num)
                                          1, &dummy);
     }
 
-    return was_modified;
+    /*
+     * Note that this treats failures to learn allocation status the
+     * same as if an allocation has occurred.  It's as safe as
+     * anything else, given that a failure to learn allocation status
+     * will probably result in more failures.
+     */
+    return !!was_modified;
 }
 
 static const char* get_basename(const char* path)
@@ -1833,6 +1846,9 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
                     int res;
 
                     res = bdrv_is_allocated(s->qcow->bs, offset + i, 1, &dummy);
+                    if (res < 0) {
+                        return -1;
+                    }
                     if (!res) {
                         res = vvfat_read(s->bs, offset, s->cluster_buffer, 1);
                         if (res) {
-- 
1.8.3.1
