Received: from eggs.gnu.org ([2001:4830:134:3::10]:59358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pG-0003LG-2k
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fT9pF-000787-4y
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 13:44:54 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 13 Jun 2018 20:44:23 +0300
Message-Id: <1528911866-37489-6-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1528911866-37489-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/8] scsi: move unmap error checking to the
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, berto@igalia.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

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
index b08ce8a..0b68a8d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1644,9 +1644,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
     assert(r->req.aiocb == NULL);
-    if (scsi_disk_req_check_error(r, ret, false)) {
-        goto done;
-    }
 
     if (data->count > 0) {
         r->sector = ldq_be_p(&data->inbuf[0]);
@@ -1682,7 +1679,12 @@ static void scsi_unmap_complete(void *opaque, int ret)
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
