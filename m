Received: from eggs.gnu.org ([2001:4830:134:3::10]:57454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoT-0006Zb-FJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoR-0007XP-Tj
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:32 +1000
Message-Id: <20170525035132.24268-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/18] xics: add unrealize handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Now that ICPState objects get finalized on CPU unplug, we should unregister
reset handlers as well to avoid a QEMU crash at machine reset time.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c     | 5 +++++
 hw/intc/xics_kvm.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 292fffe..ea35167 100644
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
index dd7f298..14b8f6f 100644
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
-- 
2.9.4
