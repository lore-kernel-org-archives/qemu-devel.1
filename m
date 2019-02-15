Received: from eggs.gnu.org ([209.51.188.92]:50854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqm-0004Be-CL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqi-0005Yq-Lx
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubqg-0005RM-Hw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:08 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXtUN076644
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qntdh6xkb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:01 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:39:58 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:39:54 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023079461.1011724.12644984391500635645.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 02/10] xics: Handle KVM ICP reset from the
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

The KVM ICP reset handler simply writes the ICP state to KVM. This
doesn't need the overkill parent_reset logic we have today. Call
icp_set_kvm_state() from the base ICP reset function instead.

Since there are no other users for ICPStateClass::parent_reset, and
it isn't currently expected to change, drop it as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |   12 ++++--------
 hw/intc/xics_kvm.c    |   11 -----------
 include/hw/ppc/xics.h |    1 -
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 988b53abd17d..822d367e6388 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -289,7 +289,7 @@ static const VMStateDescription vmstate_icp_server = {
     },
 };
 
-static void icp_reset(DeviceState *dev)
+static void icp_reset_handler(void *dev)
 {
     ICPState *icp = ICP(dev);
 
@@ -299,13 +299,10 @@ static void icp_reset(DeviceState *dev)
 
     /* Make all outputs are deasserted */
     qemu_set_irq(icp->output, 0);
-}
 
-static void icp_reset_handler(void *dev)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-
-    dc->reset(dev);
+    if (kvm_irqchip_in_kernel()) {
+        icp_set_kvm_state(ICP(dev));
+    }
 }
 
 static void icp_realize(DeviceState *dev, Error **errp)
@@ -370,7 +367,6 @@ static void icp_class_init(ObjectClass *klass, void *data)
 
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
-    dc->reset = icp_reset;
 }
 
 static const TypeInfo icp_info = {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 7efa99b8b434..80321e9b75ab 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -115,15 +115,6 @@ int icp_set_kvm_state(ICPState *icp)
     return 0;
 }
 
-static void icp_kvm_reset(DeviceState *dev)
-{
-    ICPStateClass *icpc = ICP_GET_CLASS(dev);
-
-    icpc->parent_reset(dev);
-
-    icp_set_kvm_state(ICP(dev));
-}
-
 static void icp_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp = ICP(dev);
@@ -176,8 +167,6 @@ static void icp_kvm_class_init(ObjectClass *klass, void *data)
 
     device_class_set_parent_realize(dc, icp_kvm_realize,
                                     &icpc->parent_realize);
-    device_class_set_parent_reset(dc, icp_kvm_reset,
-                                  &icpc->parent_reset);
 }
 
 static const TypeInfo icp_kvm_info = {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3236ccec924c..e33282a576d0 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -65,7 +65,6 @@ struct ICPStateClass {
     DeviceClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceReset parent_reset;
 };
 
 struct ICPState {
