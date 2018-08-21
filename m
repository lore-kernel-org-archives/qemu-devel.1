Received: from eggs.gnu.org ([2001:4830:134:3::10]:48785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FW-0003t2-9a
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FS-0007ya-0N
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:54 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:15 +0300
Message-Id: <1534844779-118784-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 4/8] scsi: store unmap offset and nb_sectors
 in request struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

it allows to report it in the error handler

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5ae7baa..d41eea1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1653,8 +1653,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
 {
     SCSIDiskReq *r = data->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    uint64_t sector_num;
-    uint32_t nb_sectors;
 
     assert(r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
@@ -1662,16 +1660,16 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
     }
 
     if (data->count > 0) {
-        sector_num = ldq_be_p(&data->inbuf[0]);
-        nb_sectors = ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
-        if (!check_lba_range(s, sector_num, nb_sectors)) {
+        r->sector = ldq_be_p(&data->inbuf[0]);
+        r->sector_count = ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
+        if (!check_lba_range(s, r->sector, r->sector_count)) {
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
 
         r->req.aiocb = blk_aio_pdiscard(s->qdev.conf.blk,
-                                        sector_num * s->qdev.blocksize,
-                                        nb_sectors * s->qdev.blocksize,
+                                        r->sector * s->qdev.blocksize,
+                                        r->sector_count * s->qdev.blocksize,
                                         scsi_unmap_complete, data);
         data->count--;
         data->inbuf += 16;
-- 
2.7.4
