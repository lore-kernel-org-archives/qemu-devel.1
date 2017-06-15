Received: from eggs.gnu.org ([2001:4830:134:3::10]:41990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dLKux-0006r8-OG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dLKus-00012D-R2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:53:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56777
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dLKus-00011X-Lr
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 22:53:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5F2rdvi031253
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 22:53:49 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b39wpa67r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 22:53:49 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 15 Jun 2017 12:53:46 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Thu, 15 Jun 2017 08:22:44 +0530
Message-Id: <1497495164-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH] spapr: prevent QEMU crash when CPU
 realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

ICPState objects were being allocated before CPU thread realization.
However commit 9ed656631d73 (xics: setup cpu at realize time) reversed it
by allocating ICPState objects after CPU thread is realized. But it
didn't take care to fix the error path because of which we observe
a SIGSEGV when CPU thread realization fails during cold/hotplug.

Fix this by ensuring that we do object_unparent() of ICPState object
only in case when is was created earlier.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
NOTE: There is another SIGSEGV failure that I am investigating which happens
when CPU realization fails. It appears that that the CPU object isn't getting
fully cleaned up.

 hw/ppc/spapr_cpu_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d6719d5..0d0e959 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -198,13 +198,14 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-        goto error;
+        goto free_icp;
     }
 
     return;
 
-error:
+free_icp:
     object_unparent(obj);
+error:
     error_propagate(errp, local_err);
 }
 
-- 
2.7.4
