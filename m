Received: from eggs.gnu.org ([2001:4830:134:3::10]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeN-0001O9-Sr
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeM-0003X4-J5
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:27 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:06 +0200
Message-Id: <20170515203114.9477-7-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] vvfat: fix field names in FAT12/FAT16
 boot sector
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

Specification: "FAT: General overview of on-disk format" v1.03, page 11
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index f60d2a3889..348cffe1c4 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -218,10 +218,12 @@ typedef struct bootsector_t {
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
@@ -233,8 +235,6 @@ typedef struct bootsector_t {
             uint16_t ignored;
         } QEMU_PACKED fat32;
     } u;
-    uint8_t fat_type[8];
-    uint8_t ignored[0x1c0];
     uint8_t magic[2];
 } QEMU_PACKED bootsector_t;
=20
@@ -972,13 +972,13 @@ static int init_directories(BDRVVVFATState* s,
=20
     /* LATER TODO: if FAT32, this is wrong */
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
2.11.0
