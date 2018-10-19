Received: from eggs.gnu.org ([2001:4830:134:3::10]:54848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbY4-0007zo-Mp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbY3-0002im-Rj
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:39:08 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:39:03 +0100
Message-Id: <1539981546-10596-6-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 5/8] block: Fix potential Null pointer
 dereferences in vvfat.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

The calls to find_mapping_for_cluster() may return NULL but it
isn't always checked for before dereferencing the value returned.
Additionally, add some asserts to cover cases where NULL can't
be returned but which might not be obvious at first glance.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 block/vvfat.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841a5c3c..19f6725054a0 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -100,6 +100,7 @@ static inline void array_free(array_t* array)
 /* does not automatically grow */
 static inline void* array_get(array_t* array,unsigned int index) {
     assert(index < array->next);
+    assert(array->pointer);
     return array->pointer + index * array->item_size;
 }
 
@@ -108,8 +109,7 @@ static inline int array_ensure_allocated(array_t* array, int index)
     if((index + 1) * array->item_size > array->size) {
         int new_size = (index + 32) * array->item_size;
         array->pointer = g_realloc(array->pointer, new_size);
-        if (!array->pointer)
-            return -1;
+        assert(array->pointer);
         memset(array->pointer + array->size, 0, new_size - array->size);
         array->size = new_size;
         array->next = index + 1;
@@ -2261,6 +2261,9 @@ static mapping_t* insert_mapping(BDRVVVFATState* s,
     }
     if (index >= s->mapping.next || mapping->begin > begin) {
         mapping = array_insert(&(s->mapping), index, 1);
+        if (mapping == NULL) {
+            return NULL;
+        }
         mapping->path = NULL;
         adjust_mapping_indices(s, index, +1);
     }
@@ -2428,6 +2431,9 @@ static int commit_direntries(BDRVVVFATState* s,
     direntry_t* direntry = array_get(&(s->directory), dir_index);
     uint32_t first_cluster = dir_index == 0 ? 0 : begin_of_direntry(direntry);
     mapping_t* mapping = find_mapping_for_cluster(s, first_cluster);
+    if (mapping == NULL) {
+        return -1;
+    }
 
     int factor = 0x10 * s->sectors_per_cluster;
     int old_cluster_count, new_cluster_count;
@@ -2494,6 +2500,9 @@ DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapp
         direntry = array_get(&(s->directory), first_dir_index + i);
         if (is_directory(direntry) && !is_dot(direntry)) {
             mapping = find_mapping_for_cluster(s, first_cluster);
+            if (mapping == NULL) {
+                return -1;
+            }
             assert(mapping->mode & MODE_DIRECTORY);
             ret = commit_direntries(s, first_dir_index + i,
                 array_index(&(s->mapping), mapping));
@@ -2522,6 +2531,10 @@ static int commit_one_file(BDRVVVFATState* s,
     assert(offset < size);
     assert((offset % s->cluster_size) == 0);
 
+    if (mapping == NULL) {
+        return -1;
+    }
+
     for (i = s->cluster_size; i < offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
@@ -2668,8 +2681,12 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
         if (commit->action == ACTION_RENAME) {
             mapping_t* mapping = find_mapping_for_cluster(s,
                     commit->param.rename.cluster);
-            char* old_path = mapping->path;
+            char *old_path;
 
+            if (mapping == NULL) {
+                return -1;
+            }
+            old_path = mapping->path;
             assert(commit->path);
             mapping->path = commit->path;
             if (rename(old_path, mapping->path))
@@ -2690,10 +2707,15 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
                         direntry_t* d = direntry + i;
 
                         if (is_file(d) || (is_directory(d) && !is_dot(d))) {
+                            int l;
+                            char *new_path;
                             mapping_t* m = find_mapping_for_cluster(s,
                                     begin_of_direntry(d));
-                            int l = strlen(m->path);
-                            char* new_path = g_malloc(l + diff + 1);
+                            if (m == NULL) {
+                                return -1;
+                            }
+                            l = strlen(m->path);
+                            new_path = g_malloc(l + diff + 1);
 
                             assert(!strncmp(m->path, mapping->path, l2));
 
@@ -3193,6 +3215,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
 
     backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
                                    &error_abort);
+    assert(backing);
     *(void**) backing->opaque = s;
 
     bdrv_set_backing_hd(s->bs, backing, &error_abort);
-- 
1.8.3.1
