Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fdYQY-00085u-N1
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fdYQU-0005a1-JW
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:02:22 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:39764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fdYQU-00059u-Cb
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:02:18 -0400
Received: from player718.ha.ovh.net (unknown [10.109.122.111])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1AE22109BA0
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 12:02:07 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 12 Jul 2018 12:01:49 +0200
Message-ID: <153138970964.331720.14349788349972574256.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] ppc/xics: fix ICP reset path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

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
---
 hw/intc/xics.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index b9f1a3c97214..c90c893228dc 100644
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
