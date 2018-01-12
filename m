Received: from eggs.gnu.org ([2001:4830:134:3::10]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYv-0007bF-Gy
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYu-0005XL-Jh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:53 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:51 +0100
Message-Id: <1515756676-3860-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 27/52] scsi-disk: release AioContext in
 unaligned WRITE SAME case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

scsi_write_same_complete() can retry the write if the request was
unaligned.  Make sure to release the AioContext when that code path is
taken!

This patch fixes a hang when QEMU terminates after an unaligned WRITE
SAME request has been processed with dataplane.  The hang occurs because
iothread_stop_all() cannot acquire the AioContext lock that was leaked
by the IOThread in scsi_write_same_complete().

Fixes: b9e413dd37 ("block: explicitly acquire aiocontext in aio callbacks that need it").
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org
Reported-by: Cong Li <coli@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180104142502.15175-1-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e58833a..49d2559 100644
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
1.8.3.1
