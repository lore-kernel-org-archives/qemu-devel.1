Received: from eggs.gnu.org ([2001:4830:134:3::10]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkz-0004lG-3O
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkx-0007gY-Ad
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:24 +0200
Message-Id: <1499447335-6125-10-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 009/100] vvfat: introduce offset_to_bootsector,
 offset_to_fat and offset_to_root_dir
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

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

- offset_to_bootsector is the number of sectors up to FAT bootsector
- offset_to_fat is the number of sectors up to first File Allocation Tabl=
e
- offset_to_root_dir is the number of sectors up to root directory sector

Replace first_sectors_number - 1 by offset_to_bootsector.
Replace first_sectors_number by offset_to_fat.
Replace faked_sectors by offset_to_rootdir.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 70 ++++++++++++++++++++++++++++++++++++-----------------=
------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 18d9559..88d1879 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -319,22 +319,24 @@ static void print_mapping(const struct mapping_t* m=
apping);
 typedef struct BDRVVVFATState {
     CoMutex lock;
     BlockDriverState* bs; /* pointer to parent */
-    unsigned int first_sectors_number; /* 1 for a single partition, 0x40=
 for a disk with partition table */
     unsigned char first_sectors[0x40*0x200];
=20
     int fat_type; /* 16 or 32 */
     array_t fat,directory,mapping;
     char volume_label[11];
=20
+    uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */
+
     unsigned int cluster_size;
     unsigned int sectors_per_cluster;
     unsigned int sectors_per_fat;
     unsigned int sectors_of_root_directory;
     uint32_t last_cluster_of_root_directory;
-    unsigned int faked_sectors; /* how many sectors are faked before fil=
e data */
     uint32_t sector_count; /* total number of sectors of the partition *=
/
     uint32_t cluster_count; /* total number of clusters of this partitio=
n */
     uint32_t max_fat_value;
+    uint32_t offset_to_fat;
+    uint32_t offset_to_root_dir;
=20
     int current_fd;
     mapping_t* current_mapping;
@@ -393,15 +395,15 @@ static void init_mbr(BDRVVVFATState *s, int cyls, i=
nt heads, int secs)
     partition->attributes=3D0x80; /* bootable */
=20
     /* LBA is used when partition is outside the CHS geometry */
-    lba  =3D sector2CHS(&partition->start_CHS, s->first_sectors_number -=
 1,
+    lba  =3D sector2CHS(&partition->start_CHS, s->offset_to_bootsector,
                      cyls, heads, secs);
     lba |=3D sector2CHS(&partition->end_CHS,   s->bs->total_sectors - 1,
                      cyls, heads, secs);
=20
     /*LBA partitions are identified only by start/length_sector_long not=
 by CHS*/
-    partition->start_sector_long  =3D cpu_to_le32(s->first_sectors_numbe=
r - 1);
+    partition->start_sector_long  =3D cpu_to_le32(s->offset_to_bootsecto=
r);
     partition->length_sector_long =3D cpu_to_le32(s->bs->total_sectors
-                                                - s->first_sectors_numbe=
r + 1);
+                                                - s->offset_to_bootsecto=
r);
=20
     /* FAT12/FAT16/FAT32 */
     /* DOS uses different types when partition is LBA,
@@ -822,12 +824,12 @@ static int read_directory(BDRVVVFATState* s, int ma=
pping_index)
=20
 static inline uint32_t sector2cluster(BDRVVVFATState* s,off_t sector_num=
)
 {
-    return (sector_num-s->faked_sectors)/s->sectors_per_cluster;
+    return (sector_num - s->offset_to_root_dir) / s->sectors_per_cluster=
;
 }
=20
 static inline off_t cluster2sector(BDRVVVFATState* s, uint32_t cluster_n=
um)
 {
-    return s->faked_sectors + s->sectors_per_cluster * cluster_num;
+    return s->offset_to_root_dir + s->sectors_per_cluster * cluster_num;
 }
=20
 static int init_directories(BDRVVVFATState* s,
@@ -854,6 +856,9 @@ static int init_directories(BDRVVVFATState* s,
     i =3D 1+s->sectors_per_cluster*0x200*8/s->fat_type;
     s->sectors_per_fat=3D(s->sector_count+i)/i; /* round up */
=20
+    s->offset_to_fat =3D s->offset_to_bootsector + 1;
+    s->offset_to_root_dir =3D s->offset_to_fat + s->sectors_per_fat * 2;
+
     array_init(&(s->mapping),sizeof(mapping_t));
     array_init(&(s->directory),sizeof(direntry_t));
=20
@@ -867,7 +872,6 @@ static int init_directories(BDRVVVFATState* s,
     /* Now build FAT, and write back information into directory */
     init_fat(s);
=20
-    s->faked_sectors=3Ds->first_sectors_number+s->sectors_per_fat*2;
     s->cluster_count=3Dsector2cluster(s, s->sector_count);
=20
     mapping =3D array_get_next(&(s->mapping));
@@ -945,7 +949,8 @@ static int init_directories(BDRVVVFATState* s,
=20
     s->current_mapping =3D NULL;
=20
-    bootsector=3D(bootsector_t*)(s->first_sectors+(s->first_sectors_numb=
er-1)*0x200);
+    bootsector =3D (bootsector_t *)(s->first_sectors
+                                  + s->offset_to_bootsector * 0x200);
     bootsector->jump[0]=3D0xeb;
     bootsector->jump[1]=3D0x3e;
     bootsector->jump[2]=3D0x90;
@@ -956,16 +961,18 @@ static int init_directories(BDRVVVFATState* s,
     bootsector->number_of_fats=3D0x2; /* number of FATs */
     bootsector->root_entries=3Dcpu_to_le16(s->sectors_of_root_directory*=
0x10);
     bootsector->total_sectors16=3Ds->sector_count>0xffff?0:cpu_to_le16(s=
->sector_count);
-    bootsector->media_type=3D(s->first_sectors_number>1?0xf8:0xf0); /* m=
edia descriptor (f8=3Dhd, f0=3D3.5 fd)*/
+    /* media descriptor: hard disk=3D0xf8, floppy=3D0xf0 */
+    bootsector->media_type =3D (s->offset_to_bootsector > 0 ? 0xf8 : 0xf=
0);
     s->fat.pointer[0] =3D bootsector->media_type;
     bootsector->sectors_per_fat=3Dcpu_to_le16(s->sectors_per_fat);
     bootsector->sectors_per_track =3D cpu_to_le16(secs);
     bootsector->number_of_heads =3D cpu_to_le16(heads);
-    bootsector->hidden_sectors=3Dcpu_to_le32(s->first_sectors_number=3D=3D=
1?0:0x3f);
+    bootsector->hidden_sectors =3D cpu_to_le32(s->offset_to_bootsector);
     bootsector->total_sectors=3Dcpu_to_le32(s->sector_count>0xffff?s->se=
ctor_count:0);
=20
     /* LATER TODO: if FAT32, this is wrong */
-    bootsector->u.fat16.drive_number=3Ds->first_sectors_number=3D=3D1?0:=
0x80; /* fda=3D0, hda=3D0x80 */
+    /* drive_number: fda=3D0, hda=3D0x80 */
+    bootsector->u.fat16.drive_number =3D s->offset_to_bootsector =3D=3D =
0 ? 0 : 0x80;
     bootsector->u.fat16.current_head=3D0;
     bootsector->u.fat16.signature=3D0x29;
     bootsector->u.fat16.id=3Dcpu_to_le32(0xfabe1afd);
@@ -1122,7 +1129,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
             secs =3D s->fat_type =3D=3D 12 ? 18 : 36;
             s->sectors_per_cluster =3D 1;
         }
-        s->first_sectors_number =3D 1;
         cyls =3D 80;
         heads =3D 2;
     } else {
@@ -1130,7 +1136,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
         if (!s->fat_type) {
             s->fat_type =3D 16;
         }
-        s->first_sectors_number =3D 0x40;
+        s->offset_to_bootsector =3D 0x3f;
         cyls =3D s->fat_type =3D=3D 12 ? 64 : 1024;
         heads =3D 16;
         secs =3D 63;
@@ -1166,7 +1172,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
     fprintf(stderr, "vvfat %s chs %d,%d,%d\n",
             dirname, cyls, heads, secs);
=20
-    s->sector_count =3D cyls * heads * secs - (s->first_sectors_number -=
 1);
+    s->sector_count =3D cyls * heads * secs - s->offset_to_bootsector;
=20
     if (qemu_opt_get_bool(opts, "rw", false)) {
         if (!bdrv_is_read_only(bs)) {
@@ -1196,7 +1202,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
         goto fail;
     }
=20
-    s->sector_count =3D s->faked_sectors + s->sectors_per_cluster*s->clu=
ster_count;
+    s->sector_count =3D s->offset_to_root_dir
+                    + s->sectors_per_cluster * s->cluster_count;
=20
     /* Disable migration when vvfat is used rw */
     if (s->qcow) {
@@ -1212,7 +1219,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *=
options, int flags,
         }
     }
=20
-    if (s->first_sectors_number =3D=3D 0x40) {
+    if (s->offset_to_bootsector > 0) {
         init_mbr(s, cyls, heads, secs);
     }
=20
@@ -1425,15 +1432,24 @@ static int vvfat_read(BlockDriverState *bs, int64=
_t sector_num,
             }
 DLOG(fprintf(stderr, "sector %d not allocated\n", (int)sector_num));
         }
-        if(sector_num<s->faked_sectors) {
-            if(sector_num<s->first_sectors_number)
-                memcpy(buf+i*0x200,&(s->first_sectors[sector_num*0x200])=
,0x200);
-            else if(sector_num-s->first_sectors_number<s->sectors_per_fa=
t)
-                memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first=
_sectors_number)*0x200]),0x200);
-            else if(sector_num-s->first_sectors_number-s->sectors_per_fa=
t<s->sectors_per_fat)
-                memcpy(buf+i*0x200,&(s->fat.pointer[(sector_num-s->first=
_sectors_number-s->sectors_per_fat)*0x200]),0x200);
+        if (sector_num < s->offset_to_root_dir) {
+            if (sector_num < s->offset_to_fat) {
+                memcpy(buf + i * 0x200,
+                       &(s->first_sectors[sector_num * 0x200]),
+                       0x200);
+            } else if (sector_num < s->offset_to_fat + s->sectors_per_fa=
t) {
+                memcpy(buf + i * 0x200,
+                       &(s->fat.pointer[(sector_num
+                                       - s->offset_to_fat) * 0x200]),
+                       0x200);
+            } else if (sector_num < s->offset_to_root_dir) {
+                memcpy(buf + i * 0x200,
+                       &(s->fat.pointer[(sector_num - s->offset_to_fat
+                                       - s->sectors_per_fat) * 0x200]),
+                       0x200);
+            }
         } else {
-            uint32_t sector=3Dsector_num-s->faked_sectors,
+            uint32_t sector =3D sector_num - s->offset_to_root_dir,
             sector_offset_in_cluster=3D(sector%s->sectors_per_cluster),
             cluster_num=3Dsector/s->sectors_per_cluster;
             if(cluster_num > s->cluster_count || read_cluster(s, cluster=
_num) !=3D 0) {
@@ -2045,7 +2061,7 @@ DLOG(checkpoint());
         memcpy(s->fat2, s->fat.pointer, size);
     }
     check =3D vvfat_read(s->bs,
-            s->first_sectors_number, s->fat2, s->sectors_per_fat);
+            s->offset_to_fat, s->fat2, s->sectors_per_fat);
     if (check) {
         fprintf(stderr, "Could not copy fat\n");
         return 0;
@@ -2864,7 +2880,7 @@ DLOG(checkpoint());
      * - do not allow to write non-ASCII filenames
      */
=20
-    if (sector_num < s->first_sectors_number)
+    if (sector_num < s->offset_to_fat)
         return -1;
=20
     for (i =3D sector2cluster(s, sector_num);
--=20
1.8.3.1
