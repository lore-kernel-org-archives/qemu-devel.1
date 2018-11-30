Received: from eggs.gnu.org ([2001:4830:134:3::10]:60214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4n-0005Lq-99
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4i-00040Q-OW
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:29 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:21 +0000
Message-ID: <20181130144705.77454-5-anton.nefedov@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 4/9] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/ide/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 04e22e751d..8da77ff3e3 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -441,6 +441,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
     TrimAIOCB *iocb =3D opaque;
     IDEState *s =3D iocb->s;
=20
+    if (iocb->i >=3D 0) {
+        if (ret >=3D 0) {
+            block_acct_done(blk_get_stats(s->blk), &s->acct);
+        } else {
+            block_acct_failed(blk_get_stats(s->blk), &s->acct);
+        }
+    }
+
     if (ret >=3D 0) {
         while (iocb->j < iocb->qiov->niov) {
             int j =3D iocb->j;
@@ -458,10 +466,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                 }
=20
                 if (!ide_sect_range_ok(s, sector, count)) {
+                    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_U=
NMAP);
                     iocb->ret =3D -EINVAL;
                     goto done;
                 }
=20
+                block_acct_start(blk_get_stats(s->blk), &s->acct,
+                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNM=
AP);
+
                 /* Got an entry! Submit and exit.  */
                 iocb->aiocb =3D blk_aio_pdiscard(s->blk,
                                                sector << BDRV_SECTOR_BITS,
--=20
2.17.1
