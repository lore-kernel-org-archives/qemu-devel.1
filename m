Received: from eggs.gnu.org ([2001:4830:134:3::10]:40038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1S-0001ER-VN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1Q-00051o-Io
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 16 Jul 2018 18:38:06 +1000
Message-Id: <20180716083809.17115-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180716083809.17115-1-david@gibson.dropbear.id.au>
References: <20180716083809.17115-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 3/6] ppc/xics: fix ICP reset path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Recent cleanup in commit a028dd423ee6 dropped the ICPStateClass::reset
handler. It is now up to child ICP classes to call the DeviceClass::reset
handler of the parent class, thanks to device_class_set_parent_reset().
This is a better object programming pattern, but unfortunately it causes
QEMU to crash during CPU hotplug:

(qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
Segmentation fault (core dumped)

When the hotplug path tries to reset the ICP device, we end up calling:

static void icp_kvm_reset(DeviceState *dev)
{
    ICPStateClass *icpc = ICP_GET_CLASS(dev);

    icpc->parent_reset(dev);

but icpc->parent_reset is NULL... This happens because icp_kvm_class_init()
calls:

    device_class_set_parent_reset(dc, icp_kvm_reset,
                                  &icpc->parent_reset);

but dc->reset, ie, DeviceClass::reset for the TYPE_ICP type, is
itself NULL.

This patch hence sets DeviceClass::reset for the TYPE_ICP type to
point to icp_reset(). It then registers a reset handler that calls
DeviceClass::reset. If the ICP subtype has configured its own reset
handler with device_class_set_parent_reset(), this ensures it will
be called first and it can then call ICPStateClass::parent_reset
safely. This fixes the reset path for the TYPE_KVM_ICP type, which
is the only subtype that defines its own reset function.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Fixes: a028dd423ee6dfd091a8c63028240832bf10f671
Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b9f1a3c972..c90c893228 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -291,7 +291,7 @@ static const VMStateDescription vmstate_icp_server = {
     },
 };
 
-static void icp_reset(void *dev)
+static void icp_reset(DeviceState *dev)
 {
     ICPState *icp = ICP(dev);
 
@@ -303,6 +303,13 @@ static void icp_reset(void *dev)
     qemu_set_irq(icp->output, 0);
 }
 
+static void icp_reset_handler(void *dev)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    dc->reset(dev);
+}
+
 static void icp_realize(DeviceState *dev, Error **errp)
 {
     ICPState *icp = ICP(dev);
@@ -345,7 +352,7 @@ static void icp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qemu_register_reset(icp_reset, dev);
+    qemu_register_reset(icp_reset_handler, dev);
     vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
@@ -354,7 +361,7 @@ static void icp_unrealize(DeviceState *dev, Error **errp)
     ICPState *icp = ICP(dev);
 
     vmstate_unregister(NULL, &vmstate_icp_server, icp);
-    qemu_unregister_reset(icp_reset, dev);
+    qemu_unregister_reset(icp_reset_handler, dev);
 }
 
 static void icp_class_init(ObjectClass *klass, void *data)
@@ -363,6 +370,7 @@ static void icp_class_init(ObjectClass *klass, void *data)
 
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
+    dc->reset = icp_reset;
 }
 
 static const TypeInfo icp_info = {
-- 
2.17.1
