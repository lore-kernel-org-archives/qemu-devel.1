Received: from eggs.gnu.org ([2001:4830:134:3::10]:41370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkx-0004jV-Of
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkw-0007fw-Pa
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:25 +0200
Message-Id: <1499447335-6125-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 010/100] vvfat: fix field names in FAT12/FAT16
 and FAT32 boot sectors
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

Specification: "FAT: General overview of on-disk format" v1.03, pages 11-=
13
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 88d1879..676cacb 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -217,23 +217,30 @@ typedef struct bootsector_t {
     union {
         struct {
             uint8_t drive_number;
-            uint8_t current_head;
+            uint8_t reserved1;
             uint8_t signature;
             uint32_t id;
             uint8_t volume_label[11];
+            uint8_t fat_type[8];
+            uint8_t ignored[0x1c0];
         } QEMU_PACKED fat16;
         struct {
             uint32_t sectors_per_fat;
             uint16_t flags;
             uint8_t major,minor;
-            uint32_t first_cluster_of_root_directory;
+            uint32_t first_cluster_of_root_dir;
             uint16_t info_sector;
             uint16_t backup_boot_sector;
-            uint16_t ignored;
+            uint8_t reserved[12];
+            uint8_t drive_number;
+            uint8_t reserved1;
+            uint8_t signature;
+            uint32_t id;
+            uint8_t volume_label[11];
+            uint8_t fat_type[8];
+            uint8_t ignored[0x1a4];
         } QEMU_PACKED fat32;
     } u;
-    uint8_t fat_type[8];
-    uint8_t ignored[0x1c0];
     uint8_t magic[2];
 } QEMU_PACKED bootsector_t;
=20
@@ -973,13 +980,13 @@ static int init_directories(BDRVVVFATState* s,
     /* LATER TODO: if FAT32, this is wrong */
     /* drive_number: fda=3D0, hda=3D0x80 */
     bootsector->u.fat16.drive_number =3D s->offset_to_bootsector =3D=3D =
0 ? 0 : 0x80;
-    bootsector->u.fat16.current_head=3D0;
     bootsector->u.fat16.signature=3D0x29;
     bootsector->u.fat16.id=3Dcpu_to_le32(0xfabe1afd);
=20
     memcpy(bootsector->u.fat16.volume_label, s->volume_label,
            sizeof(bootsector->u.fat16.volume_label));
-    memcpy(bootsector->fat_type,(s->fat_type=3D=3D12?"FAT12   ":s->fat_t=
ype=3D=3D16?"FAT16   ":"FAT32   "),8);
+    memcpy(bootsector->u.fat16.fat_type,
+           s->fat_type =3D=3D 12 ? "FAT12   " : "FAT16   ", 8);
     bootsector->magic[0]=3D0x55; bootsector->magic[1]=3D0xaa;
=20
     return 0;
--=20
1.8.3.1
