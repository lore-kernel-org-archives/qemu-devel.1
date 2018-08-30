Received: from eggs.gnu.org ([2001:4830:134:3::10]:54805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvPCN-0006qH-VL
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvP8Y-0005R0-3Q
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvP8X-0005QX-RT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7UFdGU6030721
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:33 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp2120.oracle.com with ESMTP id 2m2y2pwhhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjWLW014069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:32 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjWL2020756
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:32 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Thu, 30 Aug 2018 16:47:08 +0100
Message-Id: <1535644031-848-6-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 5/8] block: Fix potential Null pointer
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

The calls to bdrv_new_open_driver(), find_mapping_for_cluster(),
and array_get_next() may return NULL but it isn't always checked for
before dereferencing the value returned.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
---
 block/vvfat.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841a5c3c..0f1f10a2f94b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -448,6 +448,9 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
 
     for(i=0;i<number_of_entries;i++) {
         entry=array_get_next(&(s->directory));
+        if (entry == NULL) {
+            continue;
+        }
         entry->attributes=0xf;
         entry->reserved[0]=0;
         entry->begin=0;
@@ -665,6 +668,9 @@ static inline void fat_set(BDRVVVFATState* s,unsigned int cluster,uint32_t value
     } else {
         int offset = (cluster*3/2);
         unsigned char* p = array_get(&(s->fat), offset);
+        if (p == NULL) {
+            return;
+        }
         switch (cluster&1) {
         case 0:
                 p[0] = value&0xff;
@@ -730,6 +736,9 @@ static inline direntry_t* create_short_and_long_name(BDRVVVFATState* s,
 
     if(is_dot) {
         entry=array_get_next(&(s->directory));
+        if (entry == NULL) {
+            return NULL;
+        }
         memset(entry->name, 0x20, sizeof(entry->name));
         memcpy(entry->name,filename,strlen(filename));
         return entry;
@@ -844,6 +853,12 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
         /* create mapping for this file */
         if(!is_dot && !is_dotdot && (S_ISDIR(st.st_mode) || st.st_size)) {
             s->current_mapping = array_get_next(&(s->mapping));
+            if (s->current_mapping == NULL) {
+                fprintf(stderr, "Failed to create mapping for file\n");
+                g_free(buffer);
+                closedir(dir);
+                return -2;
+            }
             s->current_mapping->begin=0;
             s->current_mapping->end=st.st_size;
             /*
@@ -941,6 +956,9 @@ static int init_directories(BDRVVVFATState* s,
     /* add volume label */
     {
         direntry_t* entry=array_get_next(&(s->directory));
+        if (entry == NULL) {
+            return -1;
+        }
         entry->attributes=0x28; /* archive | volume label */
         memcpy(entry->name, s->volume_label, sizeof(entry->name));
     }
@@ -953,6 +971,9 @@ static int init_directories(BDRVVVFATState* s,
     s->cluster_count=sector2cluster(s, s->sector_count);
 
     mapping = array_get_next(&(s->mapping));
+    if (mapping == NULL) {
+        return -1;
+    }
     mapping->begin = 0;
     mapping->dir_index = 0;
     mapping->info.dir.parent_mapping_index = -1;
@@ -1630,6 +1651,9 @@ static void schedule_rename(BDRVVVFATState* s,
         uint32_t cluster, char* new_path)
 {
     commit_t* commit = array_get_next(&(s->commits));
+    if (commit == NULL) {
+        return;
+    }
     commit->path = new_path;
     commit->param.rename.cluster = cluster;
     commit->action = ACTION_RENAME;
@@ -1639,6 +1663,9 @@ static void schedule_writeout(BDRVVVFATState* s,
         int dir_index, uint32_t modified_offset)
 {
     commit_t* commit = array_get_next(&(s->commits));
+    if (commit == NULL) {
+        return;
+    }
     commit->path = NULL;
     commit->param.writeout.dir_index = dir_index;
     commit->param.writeout.modified_offset = modified_offset;
@@ -1649,6 +1676,9 @@ static void schedule_new_file(BDRVVVFATState* s,
         char* path, uint32_t first_cluster)
 {
     commit_t* commit = array_get_next(&(s->commits));
+    if (commit == NULL) {
+        return;
+    }
     commit->path = path;
     commit->param.new_file.first_cluster = first_cluster;
     commit->action = ACTION_NEW_FILE;
@@ -1657,6 +1687,9 @@ static void schedule_new_file(BDRVVVFATState* s,
 static void schedule_mkdir(BDRVVVFATState* s, uint32_t cluster, char* path)
 {
     commit_t* commit = array_get_next(&(s->commits));
+    if (commit == NULL) {
+        return;
+    }
     commit->path = path;
     commit->param.mkdir.cluster = cluster;
     commit->action = ACTION_MKDIR;
@@ -2261,6 +2294,9 @@ static mapping_t* insert_mapping(BDRVVVFATState* s,
     }
     if (index >= s->mapping.next || mapping->begin > begin) {
         mapping = array_insert(&(s->mapping), index, 1);
+        if (mapping == NULL) {
+            return NULL;
+        }
         mapping->path = NULL;
         adjust_mapping_indices(s, index, +1);
     }
@@ -2428,6 +2464,9 @@ static int commit_direntries(BDRVVVFATState* s,
     direntry_t* direntry = array_get(&(s->directory), dir_index);
     uint32_t first_cluster = dir_index == 0 ? 0 : begin_of_direntry(direntry);
     mapping_t* mapping = find_mapping_for_cluster(s, first_cluster);
+    if (mapping == NULL) {
+        return -1;
+    }
 
     int factor = 0x10 * s->sectors_per_cluster;
     int old_cluster_count, new_cluster_count;
@@ -2494,6 +2533,9 @@ DLOG(fprintf(stderr, "commit_direntries for %s, parent_mapping_index %d\n", mapp
         direntry = array_get(&(s->directory), first_dir_index + i);
         if (is_directory(direntry) && !is_dot(direntry)) {
             mapping = find_mapping_for_cluster(s, first_cluster);
+            if (mapping == NULL) {
+                return -1;
+            }
             assert(mapping->mode & MODE_DIRECTORY);
             ret = commit_direntries(s, first_dir_index + i,
                 array_index(&(s->mapping), mapping));
@@ -2522,6 +2564,10 @@ static int commit_one_file(BDRVVVFATState* s,
     assert(offset < size);
     assert((offset % s->cluster_size) == 0);
 
+    if (mapping == NULL) {
+        return -1;
+    }
+
     for (i = s->cluster_size; i < offset; i += s->cluster_size)
         c = modified_fat_get(s, c);
 
@@ -2668,6 +2714,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
         if (commit->action == ACTION_RENAME) {
             mapping_t* mapping = find_mapping_for_cluster(s,
                     commit->param.rename.cluster);
+            if (mapping == NULL) {
+                return -1;
+            }
             char* old_path = mapping->path;
 
             assert(commit->path);
@@ -2692,6 +2741,9 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
                         if (is_file(d) || (is_directory(d) && !is_dot(d))) {
                             mapping_t* m = find_mapping_for_cluster(s,
                                     begin_of_direntry(d));
+                            if (m == NULL) {
+                                return -3;
+                            }
                             int l = strlen(m->path);
                             char* new_path = g_malloc(l + diff + 1);
 
@@ -3193,6 +3245,10 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
 
     backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
                                    &error_abort);
+    if (!backing) {
+        ret = -EINVAL;
+        goto err;
+    }
     *(void**) backing->opaque = s;
 
     bdrv_set_backing_hd(s->bs, backing, &error_abort);
-- 
1.8.3.1
