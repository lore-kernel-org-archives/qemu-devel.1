Received: from eggs.gnu.org ([2001:4830:134:3::10]:48750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb819-0000EH-MU
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb816-0001b9-2u
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb815-0001Yf-Nn
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNfC3022042
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:26:02 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1qb18xrw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:26:02 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:26:01 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:39 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-12-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 11/15] s390-bios: Refactor virtio to run channel
 programs via cio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Now that we have a Channel I/O library let's modify virtio boot code to
make use of it for running channel programs.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/virtio.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index aa9da72..5fb49e2 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -92,30 +92,13 @@ int drain_irqs(SubChannelId schid)
 static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
 {
     Ccw1 ccw = {};
-    CmdOrb orb = {};
-    int r;
-
-    enable_subchannel(vdev->schid);
-
-    /* start subchannel command */
-    orb.fmt = 1;
-    orb.cpa = (u32)(long)&ccw;
-    orb.lpm = 0x80;
 
     ccw.cmd_code = cmd;
     ccw.cda = (long)ptr;
     ccw.count = len;
 
-    r = ssch(vdev->schid, &orb);
-    /*
-     * XXX Wait until device is done processing the CCW. For now we can
-     *     assume that a simple tsch will have finished the CCW processing,
-     *     but the architecture allows for asynchronous operation
-     */
-    if (!r) {
-        r = drain_irqs(vdev->schid);
-    }
-    return r;
+    enable_subchannel(vdev->schid);
+    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
 }
 
 static void vring_init(VRing *vr, VqInfo *info)
-- 
2.7.4
