Received: from eggs.gnu.org ([2001:4830:134:3::10]:38092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw30-0007hp-L2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAw2z-00063W-QZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 07:56:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Oct 2018 13:55:32 +0200
Message-Id: <20181012115532.12645-9-kwolf@redhat.com>
In-Reply-To: <20181012115532.12645-1-kwolf@redhat.com>
References: <20181012115532.12645-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 8/8] iscsi: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If read-only=3Doff, but auto-read-only=3Don is given, open the volume
read-write if we have the permissions, but instead of erroring out for
read-only volumes, just degrade to read-only.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index bb69faf34a..130ae26f5f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1878,9 +1878,11 @@ static int iscsi_open(BlockDriverState *bs, QDict =
*options, int flags,
     /* Check the write protect flag of the LUN if we want to write */
     if (iscsilun->type =3D=3D TYPE_DISK && (flags & BDRV_O_RDWR) &&
         iscsilun->write_protected) {
-        error_setg(errp, "Cannot open a write protected LUN as read-writ=
e");
-        ret =3D -EACCES;
-        goto out;
+        ret =3D bdrv_apply_auto_read_only(bs, "LUN is write protected", =
errp);
+        if (ret < 0) {
+            goto out;
+        }
+        flags &=3D ~BDRV_O_RDWR;
     }
=20
     iscsi_readcapacity_sync(iscsilun, &local_err);
--=20
2.19.1
