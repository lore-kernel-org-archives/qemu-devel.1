Received: from eggs.gnu.org ([2001:4830:134:3::10]:59333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBK-0006C0-Cj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBJ-0003q3-4x
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBI-0003pL-VS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9EF31805A530
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:15:52 +0200
Message-Id: <20180531171606.21604-1-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/53] ipmi: Use proper struct reference for KCS
 vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
instead create a kcs structure separate and use that.

There were also some issues in the state transfer.  The inlen field
was not being transferred, so if a transaction was in process during
the transfer it would be messed up.  And the use_irq field was
transferred, but that should come from the configuration.

To fix this, the new VMS_VSTRUCT macros are used so the exact
version of the structure can be specified, depending on what
version was being received.  So an upgrade should work for KCS.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <1524670052-28373-3-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipmi/isa_ipmi_kcs.c | 81 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 689587b65d..a79431554a 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ipmi/ipmi.h"
@@ -422,24 +423,69 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
 }
 
-const VMStateDescription vmstate_ISAIPMIKCSDevice = {
+static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
+{
+    IPMIKCS *ik = opaque;
+
+    /* Make sure all the values are sane. */
+    if (ik->outpos >= MAX_IPMI_MSG_SIZE || ik->outlen >= MAX_IPMI_MSG_SIZE ||
+        ik->outpos >= ik->outlen) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ipmi:kcs: vmstate transfer received bad out values: %d %d\n",
+                      ik->outpos, ik->outlen);
+        ik->outpos = 0;
+        ik->outlen = 0;
+    }
+
+    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ipmi:kcs: vmstate transfer received bad in value: %d\n",
+                      ik->inlen);
+        ik->inlen = 0;
+    }
+
+    return 0;
+}
+
+static bool vmstate_kcs_before_version2(void *opaque, int version)
+{
+    return version <= 1;
+}
+
+static const VMStateDescription vmstate_IPMIKCS = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
+    .version_id = 2,
+    .minimum_version_id = 1,
+    .post_load = ipmi_kcs_vmstate_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
+        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
+        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_irq */
+        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
+        VMSTATE_UINT32(outpos, IPMIKCS),
+        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
+        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
+        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_BOOL(write_end, IPMIKCS),
+        VMSTATE_UINT8(status_reg, IPMIKCS),
+        VMSTATE_UINT8(data_out_reg, IPMIKCS),
+        VMSTATE_INT16(data_in_reg, IPMIKCS),
+        VMSTATE_INT16(cmd_reg, IPMIKCS),
+        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields      = (VMStateField[]) {
-        VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
-        VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
-        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
-        VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
-        VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
-        VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
-        VMSTATE_UINT8_ARRAY(kcs.inmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
-        VMSTATE_BOOL(kcs.write_end, ISAIPMIKCSDevice),
-        VMSTATE_UINT8(kcs.status_reg, ISAIPMIKCSDevice),
-        VMSTATE_UINT8(kcs.data_out_reg, ISAIPMIKCSDevice),
-        VMSTATE_INT16(kcs.data_in_reg, ISAIPMIKCSDevice),
-        VMSTATE_INT16(kcs.cmd_reg, ISAIPMIKCSDevice),
-        VMSTATE_UINT8(kcs.waiting_rsp, ISAIPMIKCSDevice),
+        VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_version2,
+                             0, vmstate_IPMIKCS, IPMIKCS, 1),
+        VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
+                          IPMIKCS, 2),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -450,6 +496,11 @@ static void isa_ipmi_kcs_init(Object *obj)
 
     ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
 
+    /*
+     * Version 1 had an incorrect name, it clashed with the BT
+     * IPMI device, so receive it, but transmit a different
+     * version.
+     */
     vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
-- 
2.17.0
