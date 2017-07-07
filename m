Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkp-0004Ys-GK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWko-0007Zv-HT
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:20 +0200
Message-Id: <1499447335-6125-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 005/100] vvfat: fix qemu-img map and qemu-img
 convert
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

- bs->total_sectors is the number of sectors of the whole disk
- s->sector_count is the number of sectors of the FAT partition

This fixes the following assert in qemu-img map:
qemu-img.c:2641: get_block_status: Assertion `nb_sectors' failed.

This also fixes an infinite loop in qemu-img convert.

Fixes: 4480e0f924a42e1db8b8cfcac4d0634dd1bb27a0
Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
Cc: qemu-stable@nongnu.org
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 8ab647c..040fb71 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2968,8 +2968,7 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t off=
set, uint64_t bytes,
 static int64_t coroutine_fn vvfat_co_get_block_status(BlockDriverState *=
bs,
 	int64_t sector_num, int nb_sectors, int *n, BlockDriverState **file)
 {
-    BDRVVVFATState* s =3D bs->opaque;
-    *n =3D s->sector_count - sector_num;
+    *n =3D bs->total_sectors - sector_num;
     if (*n > nb_sectors) {
         *n =3D nb_sectors;
     } else if (*n < 0) {
--=20
1.8.3.1
