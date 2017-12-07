Received: from eggs.gnu.org ([2001:4830:134:3::10]:51537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN408-00049i-Lc
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN406-0006YU-0x
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:40 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:32902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN405-0006Wm-Jb
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:37 -0500
Received: by mail-pg0-x241.google.com with SMTP id g7so5398122pgs.0
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:37 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:17 -0600
Message-Id: <1512683181-8420-11-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 10/14] ipmi: Add an SMBus IPMI interface
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

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/ipmi/Makefile.objs              |   1 +
 hw/ipmi/smbus_ipmi.c               | 236 +++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 hw/ipmi/smbus_ipmi.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 07aaf77..7791418 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -17,6 +17,7 @@ CONFIG_ISA_IPMI_KCS=y
 CONFIG_PCI_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
 CONFIG_PCI_IPMI_BT=y
+CONFIG_IPMI_SSIF=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 179ca35..7d8d673 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -17,6 +17,7 @@ CONFIG_ISA_IPMI_KCS=y
 CONFIG_PCI_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
 CONFIG_PCI_IPMI_BT=y
+CONFIG_IPMI_SSIF=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
 CONFIG_PARALLEL=y
diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 2d7f080..3cca10b 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -5,3 +5,4 @@ common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
 common-obj-$(CONFIG_PCI_IPMI_KCS) += pci_ipmi_kcs.o
 common-obj-$(CONFIG_ISA_IPMI_BT) += isa_ipmi_bt.o
 common-obj-$(CONFIG_PCI_IPMI_BT) += pci_ipmi_bt.o
+common-obj-$(CONFIG_IPMI_SSIF) += smbus_ipmi.o
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
new file mode 100644
index 0000000..75e26c8
--- /dev/null
+++ b/hw/ipmi/smbus_ipmi.c
@@ -0,0 +1,236 @@
+/*
+ * QEMU IPMI SMBus (SSIF) emulation
+ *
+ * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/i2c/smbus.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/ipmi/ipmi.h"
+
+#define TYPE_SMBUS_IPMI "smbus-ipmi"
+#define SMBUS_IPMI(obj) OBJECT_CHECK(SMBusIPMIDevice, (obj), TYPE_SMBUS_IPMI)
+
+#define SSIF_IPMI_REQUEST                       2
+#define SSIF_IPMI_MULTI_PART_REQUEST_START      6
+#define SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE     7
+#define SSIF_IPMI_RESPONSE                      3
+#define SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE    9
+
+typedef struct SMBusIPMIDevice {
+    SMBusDevice parent;
+
+    IPMIBmc *bmc;
+
+    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t outpos;
+    uint32_t outlen;
+
+    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t inlen;
+
+    /*
+     * This is a response number that we send with the command to make
+     * sure that the response matches the command.
+     */
+    uint8_t waiting_rsp;
+
+    uint32_t uuid;
+} SMBusIPMIDevice;
+
+static void smbus_ipmi_handle_event(IPMIInterface *ii)
+{
+    /* No interrupts, so nothing to do here. */
+}
+
+static void smbus_ipmi_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
+                                  unsigned char *rsp, unsigned int rsp_len)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(ii);
+
+    if (sid->waiting_rsp == msg_id) {
+        sid->waiting_rsp++;
+
+        memcpy(sid->outmsg, rsp, rsp_len);
+        sid->outlen = rsp_len;
+        sid->outpos = 0;
+    }
+}
+
+static void smbus_ipmi_set_atn(IPMIInterface *ii, int val, int irq)
+{
+    /* This is where PEC would go. */
+}
+
+static void smbus_ipmi_set_irq_enable(IPMIInterface *ii, int val)
+{
+}
+
+static void ipmi_quick_cmd(SMBusDevice *dev, uint8_t read)
+{
+}
+
+static void ipmi_send_byte(SMBusDevice *dev, uint8_t val)
+{
+}
+
+static uint8_t ipmi_receive_byte(SMBusDevice *dev)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+
+    if (sid->outpos >= sid->outlen) {
+        return 0;
+    }
+
+    return sid->outmsg[sid->outpos++];
+}
+
+static void ipmi_write_data(SMBusDevice *dev, uint8_t cmd, uint8_t *buf,
+                            int len)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+    IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(sid->bmc);
+
+    if (cmd != SSIF_IPMI_REQUEST) {
+        return;
+    }
+
+    if (len < 3 || len > MAX_IPMI_MSG_SIZE || buf[0] != len - 1) {
+        return;
+    }
+
+    memcpy(sid->inmsg, buf + 1, len - 1);
+    sid->inlen = len;
+
+    sid->outlen = 0;
+    sid->outpos = 0;
+    bk->handle_command(sid->bmc, sid->inmsg, sid->inlen, sizeof(sid->inmsg),
+                       sid->waiting_rsp);
+}
+
+static uint8_t ipmi_read_data(SMBusDevice *dev, uint8_t cmd, int n)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+
+    if (cmd != SSIF_IPMI_RESPONSE) {
+        return 0;
+    }
+
+    if (n == 0) {
+        return sid->outlen;
+    }
+
+    return ipmi_receive_byte(dev);
+}
+
+static const VMStateDescription vmstate_smbus_ipmi = {
+    .name = TYPE_SMBUS_IPMI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_SMBUS_DEVICE(parent, SMBusIPMIDevice),
+        VMSTATE_UINT8(waiting_rsp, SMBusIPMIDevice),
+        VMSTATE_UINT32(outpos, SMBusIPMIDevice),
+        VMSTATE_UINT32(outlen, SMBusIPMIDevice),
+        VMSTATE_UINT8_ARRAY(outmsg, SMBusIPMIDevice, MAX_IPMI_MSG_SIZE),
+        VMSTATE_UINT32(inlen, SMBusIPMIDevice),
+        VMSTATE_UINT8_ARRAY(inmsg, SMBusIPMIDevice, MAX_IPMI_MSG_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void smbus_ipmi_realize(DeviceState *dev, Error **errp)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(dev);
+    IPMIInterface *ii = IPMI_INTERFACE(dev);
+
+    if (!sid->bmc) {
+        error_setg(errp, "IPMI device requires a bmc attribute to be set");
+        return;
+    }
+
+    sid->uuid = ipmi_next_uuid();
+
+    sid->bmc->intf = ii;
+}
+
+static void smbus_ipmi_init(Object *obj)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(obj);
+
+    ipmi_bmc_find_and_link(OBJECT(obj), (Object **) &sid->bmc);
+}
+
+static void smbus_ipmi_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
+{
+    SMBusIPMIDevice *sid = SMBUS_IPMI(ii);
+
+    info->interface_name = "smbus";
+    info->interface_type = IPMI_SMBIOS_SSIF;
+    info->ipmi_spec_major_revision = 2;
+    info->ipmi_spec_minor_revision = 0;
+    info->i2c_slave_address = sid->bmc->slave_addr;
+    info->base_address = sid->parent.i2c.address;
+    info->memspace = IPMI_MEMSPACE_SMBUS;
+    info->register_spacing = 1;
+    info->uuid = sid->uuid;
+}
+
+static void smbus_ipmi_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_CLASS(oc);
+    SMBusDeviceClass *sc = SMBUS_DEVICE_CLASS(oc);
+
+    sc->quick_cmd = ipmi_quick_cmd;
+    sc->send_byte = ipmi_send_byte;
+    sc->receive_byte = ipmi_receive_byte;
+    sc->write_data = ipmi_write_data;
+    sc->read_data = ipmi_read_data;
+    dc->vmsd = &vmstate_smbus_ipmi;
+    dc->realize = smbus_ipmi_realize;
+    iic->set_atn = smbus_ipmi_set_atn;
+    iic->handle_rsp = smbus_ipmi_handle_rsp;
+    iic->handle_if_event = smbus_ipmi_handle_event;
+    iic->set_irq_enable = smbus_ipmi_set_irq_enable;
+    iic->get_fwinfo = smbus_ipmi_get_fwinfo;
+}
+
+static const TypeInfo smbus_ipmi_info = {
+    .name          = TYPE_SMBUS_IPMI,
+    .parent        = TYPE_SMBUS_DEVICE,
+    .instance_size = sizeof(SMBusIPMIDevice),
+    .instance_init = smbus_ipmi_init,
+    .class_init    = smbus_ipmi_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_IPMI_INTERFACE },
+        { }
+    }
+};
+
+static void smbus_ipmi_register_types(void)
+{
+    type_register_static(&smbus_ipmi_info);
+}
+
+type_init(smbus_ipmi_register_types)
-- 
2.7.4
