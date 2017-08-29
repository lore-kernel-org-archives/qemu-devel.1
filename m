Received: from eggs.gnu.org ([2001:4830:134:3::10]:47859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCN-00019q-Kg
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCK-0005Nr-Ff
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41680
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCK-0005Mx-AK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBJ4019642
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:03 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmsfn2w69-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:03 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:03 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:07 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1503965694-10794-33-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 32/79] vvfat: fix qemu-img map and qemu-img
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
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Kevin Wolf <kwolf@redhat.com>

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
(cherry picked from commit 139921aaa77c435104308ad53b631a00c3b65ae8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/vvfat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 8b4e4eb..7d08f65 100644
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
2.7.4
