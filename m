Received: from eggs.gnu.org ([2001:4830:134:3::10]:41536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qx-0001xo-77
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qr-0005AG-8V
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qq-00058r-Tu
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8X6S109608
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ak40pc7w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:42 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:24 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-61-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 60/81] s390x/kvm: fix small race reboot vs. cmma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Right now we reset all devices before we reset the cmma states.  This
can result in the host kernel discarding guest pages that were
previously in the unused state but already contain a bios or a -kernel
file before the cmma reset has finished.  This race results in random
guest crashes or hangs during very early reboot.

Fixes: 1cd4e0f6f0a6 ("s390x/cmma: clean up cmma reset")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
(cherry picked from commit 1a0e4c8b02ea510508970c333ee610a90b921cbb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/s390-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 0a96347..7a3a7fe 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -204,8 +204,8 @@ void s390_machine_reset(void)
 {
     S390CPU *ipl_cpu = S390_CPU(qemu_get_cpu(0));
 
-    qemu_devices_reset();
     s390_cmma_reset();
+    qemu_devices_reset();
     s390_crypto_reset();
 
     /* all cpus are stopped - configure and start the ipl cpu only */
-- 
2.7.4
