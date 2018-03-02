Received: from eggs.gnu.org ([2001:4830:134:3::10]:57994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1erma8-00050G-8F
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1erma6-0005Ku-TJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:26:48 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1erma6-0005Jo-MX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:26:46 -0500
Received: by mail-ot0-x241.google.com with SMTP id l5so9007452otf.9
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 07:26:46 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri,  2 Mar 2018 09:26:36 -0600
Message-Id: <1520004397-28521-2-git-send-email-minyard@acm.org>
In-Reply-To: <1520004397-28521-1-git-send-email-minyard@acm.org>
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 1/2] ipmi: Use proper struct reference for
 KCS vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
instead create a kcs structure separate and use that.

There were also some issues in the state transfer.  The inlen field
was not being transferred, so if a transaction was in process during
the transfer it would be messed up.  And the use_irq field was
transferred, but that should come from the configuration.  And the
name on the man VMStateDescription was incorrect, it needed to be
differentiated from the BT one.

To fix this, a new VMStateDescription is added that is hopefully
correct, and the old one is kept (modified to remove use_irq) in
a way that it can be received from the remote but will not be sent.
So an upgrade should work for KCS.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 689587b..2a2784d 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -422,14 +422,86 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
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
+        ik->outpos = 0;
+        ik->outlen = 0;
+    }
+
+    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
+        ik->inlen = 0;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_IPMIKCS = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = ipmi_kcs_vmstate_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
+        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
+        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
+        VMSTATE_UINT32(outpos, IPMIKCS),
+        VMSTATE_UINT32(outlen, IPMIKCS),
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
+static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .fields      = (VMStateField[]) {
+        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+/*
+ * Old version of the vmstate transfer that has a number of issues.
+ * We changed the vm state description name, so we need a separate
+ * structure and need to register it separately.
+ */
+static int ipmi_kcs_v1_vmstate_post_load(void *opaque, int version)
+{
+    ISAIPMIKCSDevice *iik = opaque;
+
+    return ipmi_kcs_vmstate_post_load(&iik->kcs, version);
+}
+
+static bool ipmi_kcs_v1_vmstate_needed(void *opaque)
+{
+    /* Never transmit this, it is just for receiving old versions. */
+    return false;
+}
+
+const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = ipmi_kcs_v1_vmstate_post_load,
+    .needed = ipmi_kcs_v1_vmstate_needed,
     .fields      = (VMStateField[]) {
         VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
         VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
-        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
+        VMSTATE_UNUSED(1), /* Was use_irq */
         VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
         VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
         VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
@@ -451,6 +523,7 @@ static void isa_ipmi_kcs_init(Object *obj)
     ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
 
     vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
+    vmstate_register(NULL, 0, &vmstate_v1_ISAIPMIKCSDevice, iik);
 }
 
 static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
-- 
2.7.4
