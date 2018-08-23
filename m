Received: from eggs.gnu.org ([2001:4830:134:3::10]:46634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ivanovrkasha@gmail.com>) id 1fspoM-0006rl-7J
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ivanovrkasha@gmail.com>) id 1fspoI-0001tr-5e
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:38:06 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:38527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ivanovrkasha@gmail.com>)
	id 1fspoH-0001tN-Uf
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:38:02 -0400
Received: by mail-lj1-x22e.google.com with SMTP id p6-v6so4191487ljc.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 06:38:01 -0700 (PDT)
From: Arkasha <ivanovrkasha@gmail.com>
Date: Thu, 23 Aug 2018 16:37:42 +0300
Message-Id: <1535031462-15030-1-git-send-email-ivanovrkasha@gmail.com>
Subject: [Qemu-devel] [PATCH V2] block: increased maximum size of vvfat
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru, Arkasha <ivanovrkasha@gmail.com>

This fixes the problem of the impossibility to create
FAT16 disks larger than 504 mb:
The change CHS made it possible to obtain a larger disk.
Also, auto-detection of disk parameters was added depending
on the volume of the connected files:
The size of all folders and files on the created disk is calculated
and the size of the FAT table is added.
This size allows to choose the future size of the FAT drive
from the standard limitations.

Signed-off-by: Arkasha <ivanovrkasha@gmail.com>
---
 block/vvfat.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 10 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index fc41841..4409233 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -77,6 +77,47 @@ static void checkpoint(void);
 #define DIR_KANJI_FAKE 0x05
 #define DIR_FREE 0x00
 
+static bool check_size(uint32_t offset_to_bootsector, int cyls, int heads,
+                      int secs, uint8_t sectors_per_cluster, int fat_type,
+                      long int sum, long int size_disk)
+{
+    uint32_t sector_count = cyls * heads * secs - offset_to_bootsector;
+    int i = 1 + sectors_per_cluster * 0x200 * 8 / fat_type;
+    uint16_t sectors_per_fat = (sector_count + i) / i;
+    /*size + FAT1 and FAT2 table size*/
+    if ((sum + sectors_per_fat * 512 * 2) < size_disk) {
+        return true;
+    }
+    return false;
+}
+
+static long int find_size(const char *dirname, unsigned int cluster)
+{
+    long int sum = 0;
+    DIR *dir = opendir(dirname);
+    struct dirent *entry;
+    while ((entry = readdir(dir))) {
+        unsigned int length = strlen(dirname) + 2 + strlen(entry->d_name);
+        char *buffer;
+        struct stat st;
+        buffer = g_malloc(length);
+        snprintf(buffer, length, "%s/%s", dirname, entry->d_name);
+        if (stat(buffer, &st) < 0) {
+            g_free(buffer);
+            continue;
+        }
+        if (strcmp(entry->d_name, ".") && strcmp(entry->d_name, "..")
+                                            && S_ISDIR(st.st_mode)) {
+            sum += find_size(buffer, cluster);
+        }
+        g_free(buffer);
+        sum += (st.st_size + cluster - 1) / (cluster) * (cluster);
+    }
+    closedir(dir);
+    return sum;
+}
+
+
 /* dynamic array functions */
 typedef struct array_t {
     char* pointer;
@@ -948,8 +988,6 @@ static int init_directories(BDRVVVFATState* s,
     /* Now build FAT, and write back information into directory */
     init_fat(s);
 
-    /* TODO: if there are more entries, bootsector has to be adjusted! */
-    s->root_entries = 0x02 * 0x10 * s->sectors_per_cluster;
     s->cluster_count=sector2cluster(s, s->sector_count);
 
     mapping = array_get_next(&(s->mapping));
@@ -1154,12 +1192,12 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVVVFATState *s = bs->opaque;
     int cyls, heads, secs;
+    long int size_disk;
     bool floppy;
     const char *dirname, *label;
     QemuOpts *opts;
     Error *local_err = NULL;
     int ret;
-
 #ifdef DEBUG
     vvv = s;
 #endif
@@ -1181,6 +1219,29 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
     floppy = qemu_opt_get_bool(opts, "floppy", false);
+    unsigned int cluster;
+    long int sum = 0;
+    if (floppy) {
+        if (!s->fat_type) {
+            s->sectors_per_cluster = 2;
+        } else {
+            s->sectors_per_cluster = 1;
+        }
+    } else if (s->fat_type == 12) {
+        s->offset_to_bootsector = 0x3f;
+        s->sectors_per_cluster = 0x10;
+    } else {
+        s->offset_to_bootsector = 0x3f;
+        /* LATER TODO: if FAT32, adjust */
+        s->sectors_per_cluster = 0x80;
+    }
+
+    cluster = s->sectors_per_cluster * 0x200;
+    sum += find_size(dirname, cluster);
+    /* TODO: if there are more entries, bootsector has to be adjusted! */
+    s->root_entries = 0x02 * 0x10 * s->sectors_per_cluster;
+    /*File size + boot sector size + root directory size*/
+    sum += 512 + s->root_entries * 32;
 
     memset(s->volume_label, ' ', sizeof(s->volume_label));
     label = qemu_opt_get(opts, "label");
@@ -1201,24 +1262,41 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         if (!s->fat_type) {
             s->fat_type = 12;
             secs = 36;
-            s->sectors_per_cluster = 2;
         } else {
             secs = s->fat_type == 12 ? 18 : 36;
-            s->sectors_per_cluster = 1;
         }
         cyls = 80;
         heads = 2;
     } else {
-        /* 32MB or 504MB disk*/
         if (!s->fat_type) {
             s->fat_type = 16;
         }
-        s->offset_to_bootsector = 0x3f;
+        size_disk = 528482304;
         cyls = s->fat_type == 12 ? 64 : 1024;
         heads = 16;
         secs = 63;
-    }
+        if (!check_size(s->offset_to_bootsector, cyls, heads,
+                               secs, s->sectors_per_cluster,
+                               s->fat_type, sum, size_disk)) {
+            if (s->fat_type > 12) {
+                size_disk = 4294950912;
+                cyls = 8322;
+                heads = 16;
+                secs = 63;
 
+            } else {
+                fprintf(stderr, "Requires Fat16 or Fat32\n");
+                return -2;
+            }
+            if (!check_size(s->offset_to_bootsector, cyls, heads,
+                                   secs, s->sectors_per_cluster,
+                                   s->fat_type, sum, size_disk)) {
+                fprintf(stderr, "Folder is larger than %f GB\n",
+                                (float)size_disk / 1073741824);
+                return -2;
+            }
+        }
+    }
     switch (s->fat_type) {
     case 32:
         warn_report("FAT32 has not been tested. You are welcome to do so!");
@@ -1235,8 +1313,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->bs = bs;
 
-    /* LATER TODO: if FAT32, adjust */
-    s->sectors_per_cluster=0x10;
 
     s->current_cluster=0xffffffff;
 
-- 
2.7.4
