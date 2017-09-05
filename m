Received: from eggs.gnu.org ([2001:4830:134:3::10]:44220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpArE-0006ac-20
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpAr9-0003bb-BA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpAr9-0003b1-3N
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85AAFBE022547
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 06:13:18 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csq84htfe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 06:13:17 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 20:13:15 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v85ADDt042270922
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 20:13:13 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v85ADD95011966
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 20:13:13 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue,  5 Sep 2017 12:12:59 +0200
In-Reply-To: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1504606380-49341-3-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/3] s390x/pci: fixup ind_offset of msix
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
index ebbeb4d6b3..931b85fe3d 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2546,14 +2546,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
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
