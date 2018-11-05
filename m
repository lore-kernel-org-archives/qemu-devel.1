Received: from eggs.gnu.org ([2001:4830:134:3::10]:36166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gJmaL-0007ET-1s
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gJmaH-0003Af-AR
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:39:00 -0500
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Mon,  5 Nov 2018 21:38:38 +0000
Message-Id: <1541453919-25973-5-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v5 4/5] block: Fix potential Null pointer
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
 block/vvfat.c | 50 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841a5c3c..263274d9739a 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -100,30 +100,26 @@ static inline void array_free(array_t* array)
 /* does not automatically grow */
 static inline void* array_get(array_t* array,unsigned int index) {
     assert(index < array->next);
+    assert(array->pointer);
     return array->pointer + index * array->item_size;
 }
 
-static inline int array_ensure_allocated(array_t* array, int index)
+static inline void array_ensure_allocated(array_t *array, int index)
 {
     if((index + 1) * array->item_size > array->size) {
         int new_size = (index + 32) * array->item_size;
         array->pointer = g_realloc(array->pointer, new_size);
-        if (!array->pointer)
-            return -1;
+        assert(array->pointer);
         memset(array->pointer + array->size, 0, new_size - array->size);
         array->size = new_size;
         array->next = index + 1;
     }
-
-    return 0;
 }
 
 static inline void* array_get_next(array_t* array) {
     unsigned int next = array->next;
 
-    if (array_ensure_allocated(array, next) < 0)
-        return NULL;
-
+    array_ensure_allocated(array, next);
     array->next = next + 1;
     return array_get(array, next);
 }
@@ -2428,16 +2424,13 @@ static int commit_direntries(BDRVVVFATState* s,
     direntry_t* direntry = array_get(&(s->directory), dir_index);
     uint32_t first_cluster = dir_index == 0 ? 0 : begin_of_direntry(direntry);
     mapping_t* mapping = find_mapping_for_cluster(s, first_cluster);
-
     int factor = 0x10 * s->sectors_per_cluster;
     int old_cluster_count, new_cluster_count;
-    int current_dir_index = mapping->info.dir.first_dir_index;
-    int first_dir_index = current_dir_index;
+    int current_dir_index;
+    int first_dir_index;
     int ret, i;
     uint32_t c;
 
-DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapping->path, parent_mapping_index));
-
     assert(direntry);
     assert(mapping);
     assert(mapping->begin == first_cluster);
@@ -2445,6 +2438,15 @@ DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapp
     assert(mapping->mode & MODE_DIRECTORY);
     assert(dir_index == 0 || is_directory(direntry));
 
+    if (mapping == NULL) {
+        return -1;
+    }
+
+DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n",
+        mapping->path, parent_mapping_index));
+
+    current_dir_index = mapping->info.dir.first_dir_index;
+    first_dir_index = current_dir_index;
     mapping->info.dir.parent_mapping_index = parent_mapping_index;
 
     if (first_cluster == 0) {
@@ -2494,6 +2496,9 @@ DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapp
         direntry = array_get(&(s->directory), first_dir_index + i);
         if (is_directory(direntry) && !is_dot(direntry)) {
             mapping = find_mapping_for_cluster(s, first_cluster);
+            if (mapping == NULL) {
+                return -1;
+            }
             assert(mapping->mode & MODE_DIRECTORY);
             ret = commit_direntries(s, first_dir_index + i,
                 array_index(&(s->mapping), mapping));
@@ -2522,6 +2527,10 @@ static int commit_one_file(BDRVVVFATState* s,
     assert(offset < size);
     assert((offset % s->cluster_size) == 0);
 
+    if (mapping == NULL) {
+        return -1;
+    }
+
     for (i = s->cluster_size; i < offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
@@ -2668,8 +2677,12 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
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
@@ -2690,10 +2703,15 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
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
 
-- 
1.8.3.1
