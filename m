Received: from eggs.gnu.org ([2001:4830:134:3::10]:46631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3on-0001q7-Sw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3om-00051S-U0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:57 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:41056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3om-00051F-NO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:56 -0500
Received: by mail-pg0-x244.google.com with SMTP id o2so5362295pgc.8
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:34:56 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:44 -0600
Message-Id: <1512682489-4474-3-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 2/7] ipmi: Use proper struct reference for BT
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
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The vmstate for isa_ipmi_bt was referencing into the bt structure,
instead create a bt structure separate and use that.

The version 1 of the BT transfer was fairly broken, if a migration
occured during an IPMI operation, it is likely the migration would
be corrupted because I misunderstood the VMSTATE_VBUFFER_UINT32()
handling, I thought it handled transferring the length field,
too.  So I just remove support for that.  I doubt anyone is using
it at this point.

This also removes the transfer of use_irq, since that should come
from configuration.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/isa_ipmi_bt.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 13a8c09..c78ec6d 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -451,22 +451,39 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
 }
 
-static const VMStateDescription vmstate_ISAIPMIBTDevice = {
-    .name = TYPE_IPMI_INTERFACE,
+
+const VMStateDescription vmstate_IPMIBT = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "bt",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields      = (VMStateField[]) {
-        VMSTATE_BOOL(bt.obf_irq_set, ISAIPMIBTDevice),
-        VMSTATE_BOOL(bt.atn_irq_set, ISAIPMIBTDevice),
-        VMSTATE_BOOL(bt.use_irq, ISAIPMIBTDevice),
-        VMSTATE_BOOL(bt.irqs_enabled, ISAIPMIBTDevice),
-        VMSTATE_UINT32(bt.outpos, ISAIPMIBTDevice),
-        VMSTATE_VBUFFER_UINT32(bt.outmsg, ISAIPMIBTDevice, 1, NULL, bt.outlen),
-        VMSTATE_VBUFFER_UINT32(bt.inmsg, ISAIPMIBTDevice, 1, NULL, bt.inlen),
-        VMSTATE_UINT8(bt.control_reg, ISAIPMIBTDevice),
-        VMSTATE_UINT8(bt.mask_reg, ISAIPMIBTDevice),
-        VMSTATE_UINT8(bt.waiting_rsp, ISAIPMIBTDevice),
-        VMSTATE_UINT8(bt.waiting_seq, ISAIPMIBTDevice),
+        VMSTATE_BOOL(obf_irq_set, IPMIBT),
+        VMSTATE_BOOL(atn_irq_set, IPMIBT),
+        VMSTATE_BOOL(irqs_enabled, IPMIBT),
+        VMSTATE_UINT32(outpos, IPMIBT),
+        VMSTATE_UINT32(outlen, IPMIBT),
+        VMSTATE_UINT8_ARRAY(outmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32(inlen, IPMIBT),
+        VMSTATE_UINT8_ARRAY(inmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT8(control_reg, IPMIBT),
+        VMSTATE_UINT8(mask_reg, IPMIBT),
+        VMSTATE_UINT8(waiting_rsp, IPMIBT),
+        VMSTATE_UINT8(waiting_seq, IPMIBT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_ISAIPMIBTDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-bt",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    /*
+     * Version 1 had messed up the array transfer, it's not even usable
+     * because it used VMSTATE_VBUFFER_UINT32, but it did not transfer
+     * the buffer length, so random things would happen.
+     */
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT(bt, ISAIPMIBTDevice, 1, vmstate_IPMIBT, IPMIBT),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
