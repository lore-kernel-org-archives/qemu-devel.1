Received: from eggs.gnu.org ([2001:4830:134:3::10]:34715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dndUL-000427-QZ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 00:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dndUH-0001gk-S3
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 00:23:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dndUH-0001gK-JZ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 00:23:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v814LhfV059011
	for <qemu-devel@nongnu.org>; Fri, 1 Sep 2017 00:23:19 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cpvm6vyfe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 00:23:18 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Fri, 1 Sep 2017 14:23:16 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v814NDUm38797522
	for <qemu-devel@nongnu.org>; Fri, 1 Sep 2017 14:23:13 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v814NDKc001287
	for <qemu-devel@nongnu.org>; Fri, 1 Sep 2017 14:23:13 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Fri,  1 Sep 2017 06:22:57 +0200
In-Reply-To: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1504239778-29893-3-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/3] s390x/pci: fixup ind_offset of msix
 routing entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, agraf@suse.de, richard.henderson@linaro.org, zyimin@linux.vnet.ibm.com

The guest uses the mpcifc instruction to register the aibvo of a zpci
device, which is the starting offset of indicators in the indicator
area and thus remains constant. Each msix vector is an offset from the
aibvo. When we map a msix route to an adapter route, we should not
modify the starting offset, but instead add the vector to the starting
offset to get the absolute offset in the specific route.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 target/s390x/kvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 3d490c5e4b..21ce06966c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2545,14 +2545,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
         return -ENODEV;
     }
 
-    pbdev->routes.adapter.ind_offset = vec;
-
     route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
     route->flags = 0;
     route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
     route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
     route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
-    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
+    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset + vec;
     route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
     return 0;
 }
-- 
2.11.0 (Apple Git-81)
