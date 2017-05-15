Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeQ-0001Q4-Fq
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeP-0003Z7-86
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:30 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:11 +0200
Message-Id: <20170515203114.9477-12-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/13] vvfat: limit number of entries in root
 directory in FAT12/FAT16
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

Also introduce variable root_entries, which will be required if we suppor=
t loading
a custom bootsector (bootsect.img).

Fixes: https://bugs.launchpad.net/qemu/+bug/1599539/comments/4
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 98978df404..7b21d6bb21 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -331,8 +331,9 @@ typedef struct BDRVVVFATState {
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
@@ -846,6 +847,12 @@ static int read_directory(BDRVVVFATState* s, int map=
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
@@ -919,15 +926,15 @@ static int read_directory(BDRVVVFATState* s, int ma=
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
     /* reset the mapping, since s->mapping was possibly realloc()ed */
@@ -992,6 +999,8 @@ static int init_directories(BDRVVVFATState* s,
     /* Now build FAT, and write back information into directory */
     init_fat(s);
=20
+    /* TODO: if there are more entries, bootsector has to be adjusted! *=
/
+    s->root_entries =3D 0x02 * 0x10 * s->sectors_per_cluster;
     s->cluster_count=3Dsector2cluster(s, s->sector_count);
=20
     mapping =3D array_get_next(&(s->mapping));
@@ -1060,7 +1069,6 @@ static int init_directories(BDRVVVFATState* s,
     }
=20
     mapping =3D array_get(&(s->mapping), 0);
-    s->sectors_of_root_directory =3D mapping->end * s->sectors_per_clust=
er;
     s->last_cluster_of_root_directory =3D mapping->end;
=20
     /* the FAT signature */
@@ -1079,7 +1087,7 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->sectors_per_cluster=3Ds->sectors_per_cluster;
     bootsector->reserved_sectors=3Dcpu_to_le16(1);
     bootsector->number_of_fats=3D0x2; /* number of FATs */
-    bootsector->root_entries=3Dcpu_to_le16(s->sectors_of_root_directory*=
0x10);
+    bootsector->root_entries =3D cpu_to_le16(s->root_entries);
     bootsector->total_sectors16=3Ds->sector_count>0xffff?0:cpu_to_le16(s=
->sector_count);
     bootsector->media_type =3D (s->offset_to_bootsector > 0 ? 0xf8 : 0xf=
0);
     s->fat.pointer[0] =3D bootsector->media_type;
--=20
2.11.0
