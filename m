Received: from eggs.gnu.org ([209.51.188.92]:51042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrU-0004nw-2o
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrO-0006CX-11
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubrG-0005y0-HF
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:46 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXwTL141185
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qntpsee3k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:30 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:28 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:24 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023082407.1011724.1983100830860273401.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 07/10] xics: Handle KVM ICS reset from the
 "simple" ICS code
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

The KVM ICS reset handler simply writes the ICS state to KVM. This
doesn't need the overkill parent_reset logic we have today. Also
we want to use the same ICS type for the KVM and non-KVM case with
pseries.

Call icp_set_kvm_state() from the "simple" ICS reset function.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c     |    4 ++++
 hw/intc/xics_kvm.c |   18 ------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ae5d5ea135b8..49401745c410 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -553,6 +553,10 @@ static void ics_simple_reset(DeviceState *dev)
     ICSStateClass *icsc = ICS_BASE_GET_CLASS(dev);
 
     icsc->parent_reset(dev);
+
+    if (kvm_irqchip_in_kernel()) {
+        ics_set_kvm_state(ICS_BASE(dev));
+    }
 }
 
 static void ics_simple_reset_handler(void *dev)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 642351e5790f..e7b8d4c29ce6 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -280,20 +280,6 @@ void ics_kvm_set_irq(void *opaque, int srcno, int val)
     }
 }
 
-static void ics_kvm_reset(DeviceState *dev)
-{
-    ICSStateClass *icsc = ICS_BASE_GET_CLASS(dev);
-
-    icsc->parent_reset(dev);
-
-    ics_set_kvm_state(ICS_KVM(dev));
-}
-
-static void ics_kvm_reset_handler(void *dev)
-{
-    ics_kvm_reset(dev);
-}
-
 static void ics_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics = ICS_KVM(dev);
@@ -305,8 +291,6 @@ static void ics_kvm_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-
-    qemu_register_reset(ics_kvm_reset_handler, ics);
 }
 
 static void ics_kvm_class_init(ObjectClass *klass, void *data)
@@ -316,8 +300,6 @@ static void ics_kvm_class_init(ObjectClass *klass, void *data)
 
     device_class_set_parent_realize(dc, ics_kvm_realize,
                                     &icsc->parent_realize);
-    device_class_set_parent_reset(dc, ics_kvm_reset,
-                                  &icsc->parent_reset);
 }
 
 static const TypeInfo ics_kvm_info = {
