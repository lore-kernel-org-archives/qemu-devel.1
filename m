Received: from eggs.gnu.org ([209.51.188.92]:50861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqm-0004Bj-Er
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqk-0005aT-GX
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32904
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubqi-0005WV-HE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:08 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXvsm080785
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:06 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnt8tf3cb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:06 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:04 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:00 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023080049.1011724.15423463482790260696.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 03/10] xics: Handle KVM ICP realize from the
 common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

The realization of KVM ICP currently follows the parent_realize logic,
which is a bit overkill here. Also we want to get rid of the KVM ICP
class. Explicitely call icp_kvm_realize() from the base ICP realize
function.

Note that ICPStateClass::parent_realize is retained because powernv
needs it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |    8 ++++++++
 hw/intc/xics_kvm.c    |   10 +---------
 include/hw/ppc/xics.h |    1 +
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 822d367e6388..acd63ab5e0b9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -349,6 +349,14 @@ static void icp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (kvm_irqchip_in_kernel()) {
+        icp_kvm_realize(dev, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
     qemu_register_reset(icp_reset_handler, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 80321e9b75ab..4eebced516b6 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -115,11 +115,9 @@ int icp_set_kvm_state(ICPState *icp)
     return 0;
 }
 
-static void icp_kvm_realize(DeviceState *dev, Error **errp)
+void icp_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp = ICP(dev);
-    ICPStateClass *icpc = ICP_GET_CLASS(icp);
-    Error *local_err = NULL;
     CPUState *cs;
     KVMEnabledICP *enabled_icp;
     unsigned long vcpu_id;
@@ -129,12 +127,6 @@ static void icp_kvm_realize(DeviceState *dev, Error **errp)
         abort();
     }
 
-    icpc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     cs = icp->cs;
     vcpu_id = kvm_arch_vcpu_id(cs);
 
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index e33282a576d0..ab61dc24010a 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -202,5 +202,6 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
 void icp_get_kvm_state(ICPState *icp);
 int icp_set_kvm_state(ICPState *icp);
 void icp_synchronize_state(ICPState *icp);
+void icp_kvm_realize(DeviceState *dev, Error **errp);
 
 #endif /* XICS_H */
