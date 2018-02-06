Received: from eggs.gnu.org ([2001:4830:134:3::10]:43787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ie-0005Ac-J6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ia-0007tv-UR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ia-0007se-Ja
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:15:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JELoa053111
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:15:47 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyg4xpguh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:15:47 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:15:45 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:39 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-19-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 18/54] scsi-disk: release AioContext in
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
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit 24355b79bdaf6ab12f7c610b032fc35ec045cd55)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/scsi-disk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 12431177a7..5e4d2c38f0 100644
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
2.11.0
