Received: from eggs.gnu.org ([2001:4830:134:3::10]:37402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCucq-0007fl-Px
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dCucp-00009d-Gt
	for qemu-devel@nongnu.org; Mon, 22 May 2017 17:12:24 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 22 May 2017 23:12:03 +0200
Message-Id: <20170522211205.14265-12-hpoussin@reactos.org>
In-Reply-To: <20170522211205.14265-1-hpoussin@reactos.org>
References: <20170522211205.14265-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/13] vvfat: limit number of entries in
 root directory in FAT12/FAT16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

FAT12/FAT16 root directory is two sectors in size, which allows only 512 =
directory entries.
Prevent QEMU startup if too much files exist, instead of overflowing root=
 directory.

Also introduce variable root_entries, which will be required for FAT32.

Fixes: https://bugs.launchpad.net/qemu/+bug/1599539/comments/4
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 414bca6dee..5376659010 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -338,8 +338,9 @@ typedef struct BDRVVVFATState {
     unsigned int cluster_size;
     unsigned int sectors_per_cluster;
     unsigned int sectors_per_fat;
-    unsigned int sectors_of_root_directory;
     uint32_t last_cluster_of_root_directory;
+    /* how many entries are available in root directory (0 for FAT32) */
+    uint16_t root_entries;
     uint32_t sector_count; /* total number of sectors of the partition *=
/
     uint32_t cluster_count; /* total number of clusters of this partitio=
n */
     uint32_t max_fat_value;
@@ -786,6 +787,12 @@ static int read_directory(BDRVVVFATState* s, int map=
ping_index)
         int is_dot=3D!strcmp(entry->d_name,".");
         int is_dotdot=3D!strcmp(entry->d_name,"..");
=20
+        if (first_cluster =3D=3D 0 && s->directory.next >=3D s->root_ent=
ries - 1) {
+            fprintf(stderr, "Too many entries in root directory\n");
+            closedir(dir);
+            return -2;
+        }
+
         if(first_cluster =3D=3D 0 && (is_dotdot || is_dot))
             continue;
=20
@@ -859,15 +866,15 @@ static int read_directory(BDRVVVFATState* s, int ma=
pping_index)
         memset(direntry,0,sizeof(direntry_t));
     }
=20
-/* TODO: if there are more entries, bootsector has to be adjusted! */
-#define ROOT_ENTRIES (0x02 * 0x10 * s->sectors_per_cluster)
-    if (mapping_index =3D=3D 0 && s->directory.next < ROOT_ENTRIES) {
+    if (s->fat_type !=3D 32 &&
+        mapping_index =3D=3D 0 &&
+        s->directory.next < s->root_entries) {
         /* root directory */
         int cur =3D s->directory.next;
-        array_ensure_allocated(&(s->directory), ROOT_ENTRIES - 1);
-        s->directory.next =3D ROOT_ENTRIES;
+        array_ensure_allocated(&(s->directory), s->root_entries - 1);
+        s->directory.next =3D s->root_entries;
         memset(array_get(&(s->directory), cur), 0,
-                (ROOT_ENTRIES - cur) * sizeof(direntry_t));
+                (s->root_entries - cur) * sizeof(direntry_t));
     }
=20
     /* re-get the mapping, since s->mapping was possibly realloc()ed */
@@ -932,6 +939,8 @@ static int init_directories(BDRVVVFATState* s,
     /* Now build FAT, and write back information into directory */
     init_fat(s);
=20
+    /* TODO: if there are more entries, bootsector has to be adjusted! *=
/
+    s->root_entries =3D 0x02 * 0x10 * s->sectors_per_cluster;
     s->cluster_count=3Dsector2cluster(s, s->sector_count);
=20
     mapping =3D array_get_next(&(s->mapping));
@@ -1000,7 +1009,6 @@ static int init_directories(BDRVVVFATState* s,
     }
=20
     mapping =3D array_get(&(s->mapping), 0);
-    s->sectors_of_root_directory =3D mapping->end * s->sectors_per_clust=
er;
     s->last_cluster_of_root_directory =3D mapping->end;
=20
     /* the FAT signature */
@@ -1019,7 +1027,7 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->sectors_per_cluster=3Ds->sectors_per_cluster;
     bootsector->reserved_sectors=3Dcpu_to_le16(1);
     bootsector->number_of_fats=3D0x2; /* number of FATs */
-    bootsector->root_entries=3Dcpu_to_le16(s->sectors_of_root_directory*=
0x10);
+    bootsector->root_entries =3D cpu_to_le16(s->root_entries);
     bootsector->total_sectors16=3Ds->sector_count>0xffff?0:cpu_to_le16(s=
->sector_count);
     /* media descriptor: hard disk=3D0xf8, floppy=3D0xf0 */
     bootsector->media_type =3D (s->offset_to_bootsector > 0 ? 0xf8 : 0xf=
0);
--=20
2.11.0
