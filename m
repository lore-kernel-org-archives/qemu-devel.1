Received: from eggs.gnu.org ([2001:4830:134:3::10]:56696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyDR3-0002KS-GD
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cyDQz-0001kf-Kj
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:15:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cyDQz-0001k0-Cx
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 04:15:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3C88tA0076858
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:15:23 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29sb7c3hw4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:15:23 -0400
Received: from localhost
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 12 Apr 2017 13:45:20 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 13:45:07 +0530
Message-Id: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] spapr-cpu-core: Release ICPState object during
 CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

Recent commits that re-organized ICPState object missed to destroy
the object when CPU is unrealized. Fix this so that CPU unplug
doesn't abort QEMU.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 2e689b5..4389ef4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -127,6 +127,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         spapr_cpu_destroy(cpu);
+        object_unparent(cpu->intc);
         cpu_remove_sync(cs);
         object_unparent(obj);
     }
-- 
2.7.4
