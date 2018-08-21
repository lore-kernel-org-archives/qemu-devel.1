Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3Fa-0003wv-6H
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FV-00083J-RI
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:58 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:17 +0300
Message-Id: <1534844779-118784-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 6/8] scsi: account unmap operations
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 9d10daf..0aac137 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1664,6 +1664,10 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
             goto done;
         }
 
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                         r->sector_count * s->qdev.blocksize,
+                         BLOCK_ACCT_UNMAP);
+
         r->req.aiocb = blk_aio_pdiscard(s->qdev.conf.blk,
                                         r->sector * s->qdev.blocksize,
                                         r->sector_count * s->qdev.blocksize,
@@ -1690,10 +1694,11 @@ static void scsi_unmap_complete(void *opaque, int ret)
     r->req.aiocb = NULL;
 
     aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-    if (scsi_disk_req_check_error(r, ret, false)) {
+    if (scsi_disk_req_check_error(r, ret, true)) {
         scsi_req_unref(&r->req);
         g_free(data);
     } else {
+        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         scsi_unmap_complete_noio(data, ret);
     }
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
@@ -1740,10 +1745,12 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     return;
 
 invalid_param_len:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
     scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
     return;
 
 invalid_field:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
     scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
 }
 
-- 
2.7.4
