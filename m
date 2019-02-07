Received: from eggs.gnu.org ([209.51.188.92]:49939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grp7e-0004kg-3Z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grp7d-0007SH-Ad
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:14:06 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  7 Feb 2019 13:13:57 -0600
Message-Id: <20190207191357.6665-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] nbd/server: Kill pointless shadowed variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

lgtm.com pointed out that commit 678ba275 introduced a shadowed
declaration of local variable 'bs'; thankfully, the inner 'bs'
obtained by 'blk_bs(blk)' matches the outer one given that we had
'blk_insert_bs(blk, bs, errp)' a few lines earlier, and there are
no later uses of 'bs' beyond the scope of the 'if (bitmap)' to
care if we change the value stored in 'bs' while traveling the
backing chain to find a bitmap.  So simply get rid of the extra
declaration.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

I plan to queue this through my NBD tree, unless the trivial
tree happens to do a pull request first.

 nbd/server.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 838c150d8ca..0910d09a6d4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1495,7 +1495,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,

     if (bitmap) {
         BdrvDirtyBitmap *bm =3D NULL;
-        BlockDriverState *bs =3D blk_bs(blk);

         while (true) {
             bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
--=20
2.20.1
