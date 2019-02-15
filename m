Received: from eggs.gnu.org ([209.51.188.92]:50950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqv-0004Hx-G3
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqu-0005m1-L6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54360
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubqu-0005lZ-9f
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXwla061459
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qnv8j9eb1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:19 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:18 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:12 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023081228.1011724.12474992370439652538.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 05/10] xics: Drop the KVM ICP class
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

The KVM ICP class isn't used anymore. Drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c    |   18 ------------------
 include/hw/ppc/xics.h |    3 ---
 2 files changed, 21 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 4eebced516b6..fae4ac431f2f 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -152,23 +152,6 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
     QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
 
-static void icp_kvm_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    ICPStateClass *icpc = ICP_CLASS(klass);
-
-    device_class_set_parent_realize(dc, icp_kvm_realize,
-                                    &icpc->parent_realize);
-}
-
-static const TypeInfo icp_kvm_info = {
-    .name = TYPE_KVM_ICP,
-    .parent = TYPE_ICP,
-    .instance_size = sizeof(ICPState),
-    .class_init = icp_kvm_class_init,
-    .class_size = sizeof(ICPStateClass),
-};
-
 /*
  * ICS-KVM
  */
@@ -425,7 +408,6 @@ fail:
 static void xics_kvm_register_types(void)
 {
     type_register_static(&ics_kvm_info);
-    type_register_static(&icp_kvm_info);
 }
 
 type_init(xics_kvm_register_types)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index ab61dc24010a..fae54e6f28ae 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -50,9 +50,6 @@ typedef struct XICSFabric XICSFabric;
 #define TYPE_ICP "icp"
 #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
 
-#define TYPE_KVM_ICP "icp-kvm"
-#define KVM_ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_KVM_ICP)
-
 #define TYPE_PNV_ICP "pnv-icp"
 #define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
 
