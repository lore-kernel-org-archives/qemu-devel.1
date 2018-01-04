Received: from eggs.gnu.org ([2001:4830:134:3::10]:52074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX6SM-0004RV-Dy
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX6SI-0003SP-4n
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:25:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eX6SH-0003RJ-Tr
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:25:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25FCB2A64
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 14:25:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  4 Jan 2018 14:25:02 +0000
Message-Id: <20180104142502.15175-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi-disk: release AioContext in unaligned
 WRITE SAME case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

scsi_write_same_complete() can retry the write if the request was
unaligned.  Make sure to release the AioContext when that code path is
taken!

This patch fixes a hang when QEMU terminates after an unaligned WRITE
SAME request has been processed with dataplane.  The hang occurs because
iothread_stop_all() cannot acquire the AioContext lock that was leaked
by the IOThread in scsi_write_same_complete().

Fixes: b9e413dd37
       ("block: explicitly acquire aiocontext in aio callbacks that need it").
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Cong Li <coli@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e58833a087..49d2559d93 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1755,6 +1755,7 @@ static void scsi_write_same_complete(void *opaque, int ret)
                                        data->sector << BDRV_SECTOR_BITS,
                                        &data->qiov, 0,
                                        scsi_write_same_complete, data);
+        aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
         return;
     }
 
-- 
2.14.3
