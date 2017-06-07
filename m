Received: from eggs.gnu.org ([2001:4830:134:3::10]:44816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeZx-0000Um-HQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeZt-0000a2-Es
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:09 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:53045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIeZt-0000Ze-7l
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:05 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 3684E3E5E7
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:17:04 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Jun 2017 19:17:00 +0200
Message-ID: <149685582071.12025.6876143197982490443.stgit@bahia.lan>
In-Reply-To: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 2/5] xics: add reset() handler to
 ICPStateClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Taking into account that qemu_set_irq() returns immediatly if its first
argument is NULL, icp_kvm_reset() largely duplicates icp_reset().

This patch introduces a reset() handler, so that the common logic can
be implemented in icp_reset() only.

While there we can also drop icp_kvm_realize() and icp_kvm_unrealize(). This
causes icp-kvm to be realized in icp_realize(), which sets icp->xics, but
it has no impact.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |    5 +++++
 hw/intc/xics_kvm.c    |   27 ++-------------------------
 include/hw/ppc/xics.h |    1 +
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index ea3516794af7..ec73f02144c9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -325,6 +325,7 @@ static const VMStateDescription vmstate_icp_server = {
 static void icp_reset(void *dev)
 {
     ICPState *icp = ICP(dev);
+    ICPStateClass *icpc = ICP_GET_CLASS(icp);
 
     icp->xirr = 0;
     icp->pending_priority = 0xff;
@@ -332,6 +333,10 @@ static void icp_reset(void *dev)
 
     /* Make all outputs are deasserted */
     qemu_set_irq(icp->output, 0);
+
+    if (icpc->reset) {
+        icpc->reset(icp);
+    }
 }
 
 static void icp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 14b8f6f6e478..45bf110b51e6 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -110,19 +110,8 @@ static int icp_set_kvm_state(ICPState *icp, int version_id)
     return 0;
 }
 
-static void icp_kvm_reset(void *dev)
+static void icp_kvm_reset(ICPState *icp)
 {
-    ICPState *icp = ICP(dev);
-
-    icp->xirr = 0;
-    icp->pending_priority = 0xff;
-    icp->mfrr = 0xff;
-
-    /* Make all outputs as deasserted only if the CPU thread is in use */
-    if (icp->output) {
-        qemu_set_irq(icp->output, 0);
-    }
-
     icp_set_kvm_state(icp, 1);
 }
 
@@ -159,26 +148,14 @@ static void icp_kvm_cpu_setup(ICPState *icp, PowerPCCPU *cpu)
     QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
 }
 
-static void icp_kvm_realize(DeviceState *dev, Error **errp)
-{
-    qemu_register_reset(icp_kvm_reset, dev);
-}
-
-static void icp_kvm_unrealize(DeviceState *dev, Error **errp)
-{
-    qemu_unregister_reset(icp_kvm_reset, dev);
-}
-
 static void icp_kvm_class_init(ObjectClass *klass, void *data)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
     ICPStateClass *icpc = ICP_CLASS(klass);
 
-    dc->realize = icp_kvm_realize;
-    dc->unrealize = icp_kvm_unrealize;
     icpc->pre_save = icp_get_kvm_state;
     icpc->post_load = icp_set_kvm_state;
     icpc->cpu_setup = icp_kvm_cpu_setup;
+    icpc->reset = icp_kvm_reset;
 }
 
 static const TypeInfo icp_kvm_info = {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index a3073f90533a..40a506eacfb4 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -69,6 +69,7 @@ struct ICPStateClass {
     void (*pre_save)(ICPState *s);
     int (*post_load)(ICPState *s, int version_id);
     void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
+    void (*reset)(ICPState *icp);
 };
 
 struct ICPState {
