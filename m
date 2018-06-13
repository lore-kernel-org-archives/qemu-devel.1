Received: from eggs.gnu.org ([2001:4830:134:3::10]:59349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pF-0003LF-IS
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pE-00075g-HG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:44:53 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 13 Jun 2018 20:44:22 +0300
Message-Id: <1528911866-37489-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/8] scsi: store unmap offset and nb_sectors
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, berto@igalia.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

it allows to report it in the error handler

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ded23d3..b08ce8a 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1642,8 +1642,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
 {
     SCSIDiskReq *r = data->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    uint64_t sector_num;
-    uint32_t nb_sectors;
 
     assert(r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
@@ -1651,16 +1649,16 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
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
