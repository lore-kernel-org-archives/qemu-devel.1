Received: from eggs.gnu.org ([2001:4830:134:3::10]:46661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3op-0001rJ-82
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3oo-00052F-7M
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:59 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3on-00051q-UP
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:58 -0500
Received: by mail-pg0-x244.google.com with SMTP id w7so5364854pgv.6
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:34:57 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:43 -0600
Message-Id: <1512682489-4474-2-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 1/7] ipmi: Use proper struct reference for KCS
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

The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
instead create a kcs structure separate and use that.

There was also some issues in the state transfer.  The inlen field
was not being transferred, so if a transaction was in process during
the transfer it would be messed up.  And the use_irq field was
transferred, but that should come from the configuration.  This
also fixes those issues and is tested under heavy load.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/isa_ipmi_kcs.c | 75 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 15 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 8044497..c887251 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -423,24 +423,69 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
 }
 
-const VMStateDescription vmstate_ISAIPMIKCSDevice = {
-    .name = TYPE_IPMI_INTERFACE,
+static const VMStateDescription vmstate_IPMIKCS = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
     .version_id = 1,
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
+        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
+        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
+        VMSTATE_BOOL(use_irq, IPMIKCS),
+        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
+        VMSTATE_UINT32(outpos, IPMIKCS),
+        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32(inlen, IPMIKCS),
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
+static int isa_ipmi_kcs_load_old(QEMUFile *f, void *opaque, int version_id)
+{
+    ISAIPMIKCSDevice *iik = opaque;
+    IPMIKCS *k = &iik->kcs;
+    unsigned int i;
+
+    if (version_id != 1) {
+        return -EINVAL;
+    }
+
+    k->obf_irq_set = qemu_get_byte(f);
+    k->atn_irq_set = qemu_get_byte(f);
+    qemu_get_byte(f); /* Used to be use_irq, but that's not a good idea. */
+    k->irqs_enabled = qemu_get_byte(f);
+    k->outpos = qemu_get_be32(f);
+    for (i = 0; i < MAX_IPMI_MSG_SIZE; i++) {
+        k->outmsg[i] = qemu_get_byte(f);
+    }
+    k->inlen = 0; /* This was forgotten on version 1, just reset it. */
+    for (i = 0; i < MAX_IPMI_MSG_SIZE; i++) {
+        k->inmsg[i] = qemu_get_byte(f);
+    }
+    k->write_end = qemu_get_byte(f);
+    k->status_reg = qemu_get_byte(f);
+    k->data_out_reg = qemu_get_byte(f);
+    k->data_in_reg = qemu_get_be16(f);
+    k->cmd_reg = qemu_get_be16(f);
+    k->waiting_rsp = qemu_get_byte(f);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .minimum_version_id_old = 1,
+    .load_state_old = isa_ipmi_kcs_load_old,
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
