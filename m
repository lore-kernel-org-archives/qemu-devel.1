Received: from eggs.gnu.org ([2001:4830:134:3::10]:60081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfr-0000nF-LF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfq-0007KE-9n
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:06:02 +0100
Message-Id: <20181112170603.23986-14-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/14] block: Fix potential Null pointer
 dereferences in vvfat.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Liam Merwick <Liam.Merwick@oracle.com>

The calls to find_mapping_for_cluster() may return NULL but it
isn't always checked for before dereferencing the value returned.
Additionally, add some asserts to cover cases where NULL can't
be returned but which might not be obvious at first glance.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Message-id: 1541453919-25973-5-git-send-email-Liam.Merwick@oracle.com
[mreitz: Dropped superfluous check of "mapping" following an assertion
         that it is not NULL, and fixed some indentation]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vvfat.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index e4df255d58..1de5de1db4 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -100,30 +100,26 @@ static inline void array_free(array_t* array)
 /* does not automatically grow */
 static inline void* array_get(array_t* array,unsigned int index) {
     assert(index < array->next);
+    assert(array->pointer);
     return array->pointer + index * array->item_size;
 }
=20
-static inline int array_ensure_allocated(array_t* array, int index)
+static inline void array_ensure_allocated(array_t *array, int index)
 {
     if((index + 1) * array->item_size > array->size) {
         int new_size =3D (index + 32) * array->item_size;
         array->pointer =3D g_realloc(array->pointer, new_size);
-        if (!array->pointer)
-            return -1;
+        assert(array->pointer);
         memset(array->pointer + array->size, 0, new_size - array->size);
         array->size =3D new_size;
         array->next =3D index + 1;
     }
-
-    return 0;
 }
=20
 static inline void* array_get_next(array_t* array) {
     unsigned int next =3D array->next;
=20
-    if (array_ensure_allocated(array, next) < 0)
-        return NULL;
-
+    array_ensure_allocated(array, next);
     array->next =3D next + 1;
     return array_get(array, next);
 }
@@ -2422,16 +2418,13 @@ static int commit_direntries(BDRVVVFATState* s,
     direntry_t* direntry =3D array_get(&(s->directory), dir_index);
     uint32_t first_cluster =3D dir_index =3D=3D 0 ? 0 : begin_of_direntr=
y(direntry);
     mapping_t* mapping =3D find_mapping_for_cluster(s, first_cluster);
-
     int factor =3D 0x10 * s->sectors_per_cluster;
     int old_cluster_count, new_cluster_count;
-    int current_dir_index =3D mapping->info.dir.first_dir_index;
-    int first_dir_index =3D current_dir_index;
+    int current_dir_index;
+    int first_dir_index;
     int ret, i;
     uint32_t c;
=20
-DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\=
n", mapping->path, parent_mapping_index));
-
     assert(direntry);
     assert(mapping);
     assert(mapping->begin =3D=3D first_cluster);
@@ -2439,6 +2432,11 @@ DLOG(fprintf(stderr, "commit_direntries for %s, pa=
rent_mapping_index %d\n", mapp
     assert(mapping->mode & MODE_DIRECTORY);
     assert(dir_index =3D=3D 0 || is_directory(direntry));
=20
+    DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index=
 %d\n",
+                 mapping->path, parent_mapping_index));
+
+    current_dir_index =3D mapping->info.dir.first_dir_index;
+    first_dir_index =3D current_dir_index;
     mapping->info.dir.parent_mapping_index =3D parent_mapping_index;
=20
     if (first_cluster =3D=3D 0) {
@@ -2488,6 +2486,9 @@ DLOG(fprintf(stderr, "commit_direntries for %s, par=
ent_mapping_index %d\n", mapp
         direntry =3D array_get(&(s->directory), first_dir_index + i);
         if (is_directory(direntry) && !is_dot(direntry)) {
             mapping =3D find_mapping_for_cluster(s, first_cluster);
+            if (mapping =3D=3D NULL) {
+                return -1;
+            }
             assert(mapping->mode & MODE_DIRECTORY);
             ret =3D commit_direntries(s, first_dir_index + i,
                 array_index(&(s->mapping), mapping));
@@ -2516,6 +2517,10 @@ static int commit_one_file(BDRVVVFATState* s,
     assert(offset < size);
     assert((offset % s->cluster_size) =3D=3D 0);
=20
+    if (mapping =3D=3D NULL) {
+        return -1;
+    }
+
     for (i =3D s->cluster_size; i < offset; i +=3D s->cluster_size)
         c =3D modified_fat_get(s, c);
=20
@@ -2662,8 +2667,12 @@ static int handle_renames_and_mkdirs(BDRVVVFATStat=
e* s)
         if (commit->action =3D=3D ACTION_RENAME) {
             mapping_t* mapping =3D find_mapping_for_cluster(s,
                     commit->param.rename.cluster);
-            char* old_path =3D mapping->path;
+            char *old_path;
=20
+            if (mapping =3D=3D NULL) {
+                return -1;
+            }
+            old_path =3D mapping->path;
             assert(commit->path);
             mapping->path =3D commit->path;
             if (rename(old_path, mapping->path))
@@ -2684,10 +2693,15 @@ static int handle_renames_and_mkdirs(BDRVVVFATSta=
te* s)
                         direntry_t* d =3D direntry + i;
=20
                         if (is_file(d) || (is_directory(d) && !is_dot(d)=
)) {
+                            int l;
+                            char *new_path;
                             mapping_t* m =3D find_mapping_for_cluster(s,
                                     begin_of_direntry(d));
-                            int l =3D strlen(m->path);
-                            char* new_path =3D g_malloc(l + diff + 1);
+                            if (m =3D=3D NULL) {
+                                return -1;
+                            }
+                            l =3D strlen(m->path);
+                            new_path =3D g_malloc(l + diff + 1);
=20
                             assert(!strncmp(m->path, mapping->path, l2))=
;
=20
--=20
2.19.1
