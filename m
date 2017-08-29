Received: from eggs.gnu.org ([2001:4830:134:3::10]:47689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCH-00010l-3P
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCD-0005EX-Nc
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54473
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCD-0005E0-Gj
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0ES4f087643
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmvhgaqte-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:56 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:56 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:00 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-26-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 25/79] blockdev: use drained_begin/end for
 qmp_block_resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: John Snow <jsnow@redhat.com>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1447551

If one tries to issue a block_resize while a guest is busy
accessing the disk, it is possible that qemu may deadlock
when invoking aio_poll from both the main loop and the iothread.

Replace another instance of bdrv_drain_all that doesn't
quite belong.

Cc: qemu-stable@nongnu.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 698bdfa07d66b5ec218a60229e58eae1dcde00e5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 blockdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 78e1204..e8a9a65 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2923,10 +2923,9 @@ void qmp_block_resize(bool has_device, const char *device,
         goto out;
     }
 
-    /* complete all in-flight operations before resizing the device */
-    bdrv_drain_all();
-
+    bdrv_drained_begin(bs);
     ret = blk_truncate(blk, size, errp);
+    bdrv_drained_end(bs);
 
 out:
     blk_unref(blk);
-- 
2.7.4
