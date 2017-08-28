Received: from eggs.gnu.org ([2001:4830:134:3::10]:55434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2q-00085D-6O
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2n-0006BC-1C
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmF2m-0006Ab-Mh
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S83eqJ012880
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmfb282xg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:10 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:05:08 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7S855TH41353400
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:05:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v7S84uMU026017
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:56 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:04:46 +0200
In-Reply-To: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
Message-Id: <1503907487-2764-4-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/4] s390x/pci: fixup ind_offset of msix
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

The aibvo of zpci device should be constant after issued mpcifc
registering irqs instruction. Each msix vector should offset from the
aibvo. But for flic adapter interrupt, we should use the absolute
offset within the aibv. So let's use the aibvo+vector to fixup msix
routing entry.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
---
 target/s390x/kvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e348bfb7cc..c08b7757e7 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2515,14 +2515,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
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
