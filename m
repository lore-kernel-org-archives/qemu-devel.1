Received: from eggs.gnu.org ([2001:4830:134:3::10]:60299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4q-0005O6-LL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4l-00041K-RM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:22 +0000
Message-ID: <20181130144705.77454-6-anton.nefedov@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 5/9] scsi: store unmap offset and nb_sectors
 in request struct
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

it allows to report it in the error handler

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0e9027c8f3..b1133e6293 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1604,8 +1604,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *dat=
a, int ret)
 {
     SCSIDiskReq *r =3D data->r;
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    uint64_t sector_num;
-    uint32_t nb_sectors;
=20
     assert(r->req.aiocb =3D=3D NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
@@ -1613,16 +1611,16 @@ static void scsi_unmap_complete_noio(UnmapCBData *d=
ata, int ret)
     }
=20
     if (data->count > 0) {
-        sector_num =3D ldq_be_p(&data->inbuf[0]);
-        nb_sectors =3D ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
-        if (!check_lba_range(s, sector_num, nb_sectors)) {
+        r->sector =3D ldq_be_p(&data->inbuf[0]);
+        r->sector_count =3D ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
+        if (!check_lba_range(s, r->sector, r->sector_count)) {
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
=20
         r->req.aiocb =3D blk_aio_pdiscard(s->qdev.conf.blk,
-                                        sector_num * s->qdev.blocksize,
-                                        nb_sectors * s->qdev.blocksize,
+                                        r->sector * s->qdev.blocksize,
+                                        r->sector_count * s->qdev.blocksiz=
e,
                                         scsi_unmap_complete, data);
         data->count--;
         data->inbuf +=3D 16;
--=20
2.17.1
