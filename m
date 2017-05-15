Received: from eggs.gnu.org ([2001:4830:134:3::10]:35014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeO-0001Od-7M
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeM-0003XN-WC
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:28 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:01 +0200
Message-Id: <20170515203114.9477-2-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/13] vvfat: fix qemu-img map and qemu-img
 convert
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

- bs->total_sectors is the number of sectors of the whole disk
- s->sector_count is the number of sectors of the FAT partition

This fixes the following assert in qemu-img map:
qemu-img.c:2641: get_block_status: Assertion `nb_sectors' failed.

This also fixes an infinite loop in qemu-img convert.

Fixes: 4480e0f924a42e1db8b8cfcac4d0634dd1bb27a0
Fixes: https://bugs.launchpad.net/qemu/+bug/1599539
Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index af5153d27d..dfa2a242e1 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2958,8 +2958,7 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t off=
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
2.11.0
