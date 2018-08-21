Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FY-0003vK-K9
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FU-00081y-7I
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:56 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:16 +0300
Message-Id: <1534844779-118784-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 5/8] scsi: move unmap error checking to the
 complete callback
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

This will help to account the operation in the following commit.

The difference is that we don't call scsi_disk_req_check_error() before
the 1st discard iteration anymore. That function also checks if
the request is cancelled, however it shouldn't get canceled until it
yields in blk_aio() functions anyway.
Same approach is already used for emulate_write_same.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d41eea1..9d10daf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1655,9 +1655,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
     assert(r->req.aiocb == NULL);
-    if (scsi_disk_req_check_error(r, ret, false)) {
-        goto done;
-    }
 
     if (data->count > 0) {
         r->sector = ldq_be_p(&data->inbuf[0]);
@@ -1693,7 +1690,12 @@ static void scsi_unmap_complete(void *opaque, int ret)
     r->req.aiocb = NULL;
 
     aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-    scsi_unmap_complete_noio(data, ret);
+    if (scsi_disk_req_check_error(r, ret, false)) {
+        scsi_req_unref(&r->req);
+        g_free(data);
+    } else {
+        scsi_unmap_complete_noio(data, ret);
+    }
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
-- 
2.7.4
