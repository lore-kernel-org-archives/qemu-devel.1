Received: from eggs.gnu.org ([2001:4830:134:3::10]:47356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDaHG-0004dk-3S
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dDaHC-00052o-FQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:40:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51001
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dDaHC-000522-Ao
	for qemu-devel@nongnu.org; Wed, 24 May 2017 13:40:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4OHdqMB092034
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 13:40:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2anee0rwb1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 13:40:49 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 24 May 2017 13:40:48 -0400
From: Greg Kurz <groug@kaod.org>
Date: Wed, 24 May 2017 19:40:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149564764390.1804.5304274992848891131.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] xics: add unrealize handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>

Now that ICPState objects get finalized on CPU unplug, we should unregister
reset handlers as well to avoid a QEMU crash at machine reset time.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c     |    5 +++++
 hw/intc/xics_kvm.c |    6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 292fffecd376..ea3516794af7 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -357,6 +357,10 @@ static void icp_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(icp_reset, dev);
 }
 
+static void icp_unrealize(DeviceState *dev, Error **errp)
+{
+    qemu_unregister_reset(icp_reset, dev);
+}
 
 static void icp_class_init(ObjectClass *klass, void *data)
 {
@@ -364,6 +368,7 @@ static void icp_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_icp_server;
     dc->realize = icp_realize;
+    dc->unrealize = icp_unrealize;
 }
 
 static const TypeInfo icp_info = {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index dd7f29846235..14b8f6f6e478 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -164,12 +164,18 @@ static void icp_kvm_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(icp_kvm_reset, dev);
 }
 
+static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
+{
+    qemu_unregister_reset(icp_kvm_reset, dev);
+}
+
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ICPStateClass *icpc = ICP_CLASS(klass);
 
     dc->realize = icp_kvm_realize;
+    dc->unrealize = icp_kvm_unrealize;
     icpc->pre_save = icp_get_kvm_state;
     icpc->post_load = icp_set_kvm_state;
     icpc->cpu_setup = icp_kvm_cpu_setup;
