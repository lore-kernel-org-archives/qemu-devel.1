Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3ot-0001vr-D2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3oq-00053V-6E
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:03 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:38285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3op-00052w-RY
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:00 -0500
Received: by mail-pg0-x22b.google.com with SMTP id f12so5368379pgo.5
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:34:59 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:45 -0600
Message-Id: <1512682489-4474-4-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 3/7] ipmi: Split out KCS-specific code from ISA
 KCS code
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

Get ready for PCI and other KCS interfaces.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/Makefile.objs      |   2 +-
 hw/ipmi/ipmi_kcs.c         | 375 ++++++++++++++++++++++++++++++++++++++++++
 hw/ipmi/isa_ipmi_kcs.c     | 394 +++------------------------------------------
 include/hw/ipmi/ipmi_kcs.h |  75 +++++++++
 4 files changed, 473 insertions(+), 373 deletions(-)
 create mode 100644 hw/ipmi/ipmi_kcs.c
 create mode 100644 include/hw/ipmi/ipmi_kcs.h

diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
index 1b422bb..6835d2f 100644
--- a/hw/ipmi/Makefile.objs
+++ b/hw/ipmi/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-$(CONFIG_IPMI) += ipmi.o
+common-obj-$(CONFIG_IPMI) += ipmi.o ipmi_kcs.o
 common-obj-$(CONFIG_IPMI_LOCAL) += ipmi_bmc_sim.o
 common-obj-$(CONFIG_IPMI_EXTERN) += ipmi_bmc_extern.o
 common-obj-$(CONFIG_ISA_IPMI_KCS) += isa_ipmi_kcs.o
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
new file mode 100644
index 0000000..cb22dee
--- /dev/null
+++ b/hw/ipmi/ipmi_kcs.c
@@ -0,0 +1,375 @@
+/*
+ * QEMU IPMI KCS emulation
+ *
+ * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
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
+#include "qapi/error.h"
+#include "hw/ipmi/ipmi_kcs.h"
+
+#define IPMI_KCS_OBF_BIT        0
+#define IPMI_KCS_IBF_BIT        1
+#define IPMI_KCS_SMS_ATN_BIT    2
+#define IPMI_KCS_CD_BIT         3
+
+#define IPMI_KCS_OBF_MASK          (1 << IPMI_KCS_OBF_BIT)
+#define IPMI_KCS_GET_OBF(d)        (((d) >> IPMI_KCS_OBF_BIT) & 0x1)
+#define IPMI_KCS_SET_OBF(d, v)     (d) = (((d) & ~IPMI_KCS_OBF_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_OBF_BIT))
+#define IPMI_KCS_IBF_MASK          (1 << IPMI_KCS_IBF_BIT)
+#define IPMI_KCS_GET_IBF(d)        (((d) >> IPMI_KCS_IBF_BIT) & 0x1)
+#define IPMI_KCS_SET_IBF(d, v)     (d) = (((d) & ~IPMI_KCS_IBF_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_IBF_BIT))
+#define IPMI_KCS_SMS_ATN_MASK      (1 << IPMI_KCS_SMS_ATN_BIT)
+#define IPMI_KCS_GET_SMS_ATN(d)    (((d) >> IPMI_KCS_SMS_ATN_BIT) & 0x1)
+#define IPMI_KCS_SET_SMS_ATN(d, v) (d) = (((d) & ~IPMI_KCS_SMS_ATN_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_SMS_ATN_BIT))
+#define IPMI_KCS_CD_MASK           (1 << IPMI_KCS_CD_BIT)
+#define IPMI_KCS_GET_CD(d)         (((d) >> IPMI_KCS_CD_BIT) & 0x1)
+#define IPMI_KCS_SET_CD(d, v)      (d) = (((d) & ~IPMI_KCS_CD_MASK) | \
+                                       (((v) & 1) << IPMI_KCS_CD_BIT))
+
+#define IPMI_KCS_IDLE_STATE        0
+#define IPMI_KCS_READ_STATE        1
+#define IPMI_KCS_WRITE_STATE       2
+#define IPMI_KCS_ERROR_STATE       3
+
+#define IPMI_KCS_GET_STATE(d)    (((d) >> 6) & 0x3)
+#define IPMI_KCS_SET_STATE(d, v) ((d) = ((d) & ~0xc0) | (((v) & 0x3) << 6))
+
+#define IPMI_KCS_ABORT_STATUS_CMD       0x60
+#define IPMI_KCS_WRITE_START_CMD        0x61
+#define IPMI_KCS_WRITE_END_CMD          0x62
+#define IPMI_KCS_READ_CMD               0x68
+
+#define IPMI_KCS_STATUS_NO_ERR          0x00
+#define IPMI_KCS_STATUS_ABORTED_ERR     0x01
+#define IPMI_KCS_STATUS_BAD_CC_ERR      0x02
+#define IPMI_KCS_STATUS_LENGTH_ERR      0x06
+
+static void ipmi_kcs_raise_irq(IPMIKCS *ik)
+{
+    if (ik->use_irq && ik->irqs_enabled && ik->raise_irq) {
+        ik->raise_irq(ik);
+    }
+}
+
+static void ipmi_kcs_lower_irq(IPMIKCS *ik)
+{
+    if (ik->lower_irq) {
+        ik->lower_irq(ik);
+    }
+}
+
+#define SET_OBF() \
+    do {                                                                      \
+        IPMI_KCS_SET_OBF(ik->status_reg, 1);                                  \
+        if (!ik->obf_irq_set) {                                               \
+            ik->obf_irq_set = 1;                                              \
+            if (!ik->atn_irq_set) {                                           \
+                ipmi_kcs_raise_irq(ik);                                  \
+            }                                                                 \
+        }                                                                     \
+    } while (0)
+
+static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+
+    ik->do_wake = 1;
+    while (ik->do_wake) {
+        ik->do_wake = 0;
+        iic->handle_if_event(ii);
+    }
+}
+
+static void ipmi_kcs_handle_event(IPMIInterface *ii)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    if (ik->cmd_reg == IPMI_KCS_ABORT_STATUS_CMD) {
+        if (IPMI_KCS_GET_STATE(ik->status_reg) != IPMI_KCS_ERROR_STATE) {
+            ik->waiting_rsp++; /* Invalidate the message */
+            ik->outmsg[0] = IPMI_KCS_STATUS_ABORTED_ERR;
+            ik->outlen = 1;
+            ik->outpos = 0;
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
+            SET_OBF();
+        }
+        goto out;
+    }
+
+    switch (IPMI_KCS_GET_STATE(ik->status_reg)) {
+    case IPMI_KCS_IDLE_STATE:
+        if (ik->cmd_reg == IPMI_KCS_WRITE_START_CMD) {
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_WRITE_STATE);
+            ik->cmd_reg = -1;
+            ik->write_end = 0;
+            ik->inlen = 0;
+            SET_OBF();
+        }
+        break;
+
+    case IPMI_KCS_READ_STATE:
+    handle_read:
+        if (ik->outpos >= ik->outlen) {
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_IDLE_STATE);
+            SET_OBF();
+        } else if (ik->data_in_reg == IPMI_KCS_READ_CMD) {
+            ik->data_out_reg = ik->outmsg[ik->outpos];
+            ik->outpos++;
+            SET_OBF();
+        } else {
+            ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
+            ik->outlen = 1;
+            ik->outpos = 0;
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
+            SET_OBF();
+            goto out;
+        }
+        break;
+
+    case IPMI_KCS_WRITE_STATE:
+        if (ik->data_in_reg != -1) {
+            /*
+             * Don't worry about input overrun here, that will be
+             * handled in the BMC.
+             */
+            if (ik->inlen < sizeof(ik->inmsg)) {
+                ik->inmsg[ik->inlen] = ik->data_in_reg;
+            }
+            ik->inlen++;
+        }
+        if (ik->write_end) {
+            IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ik->bmc);
+            ik->outlen = 0;
+            ik->write_end = 0;
+            ik->outpos = 0;
+            bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
+                               ik->waiting_rsp);
+            goto out_noibf;
+        } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
+            ik->cmd_reg = -1;
+            ik->write_end = 1;
+        }
+        SET_OBF();
+        break;
+
+    case IPMI_KCS_ERROR_STATE:
+        if (ik->data_in_reg != -1) {
+            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
+            ik->data_in_reg = IPMI_KCS_READ_CMD;
+            goto handle_read;
+        }
+        break;
+    }
+
+    if (ik->cmd_reg != -1) {
+        /* Got an invalid command */
+        ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
+        ik->outlen = 1;
+        ik->outpos = 0;
+        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
+    }
+
+ out:
+    ik->cmd_reg = -1;
+    ik->data_in_reg = -1;
+    IPMI_KCS_SET_IBF(ik->status_reg, 0);
+ out_noibf:
+    return;
+}
+
+static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
+                                unsigned char *rsp, unsigned int rsp_len)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    if (ik->waiting_rsp == msg_id) {
+        ik->waiting_rsp++;
+        if (rsp_len > sizeof(ik->outmsg)) {
+            ik->outmsg[0] = rsp[0];
+            ik->outmsg[1] = rsp[1];
+            ik->outmsg[2] = IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
+            ik->outlen = 3;
+        } else {
+            memcpy(ik->outmsg, rsp, rsp_len);
+            ik->outlen = rsp_len;
+        }
+        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
+        ik->data_in_reg = IPMI_KCS_READ_CMD;
+        ipmi_kcs_signal(ik, ii);
+    }
+}
+
+
+static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IPMIInterface *ii = opaque;
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+    uint32_t ret;
+
+    switch (addr & 1) {
+    case 0:
+        ret = ik->data_out_reg;
+        IPMI_KCS_SET_OBF(ik->status_reg, 0);
+        if (ik->obf_irq_set) {
+            ik->obf_irq_set = 0;
+            if (!ik->atn_irq_set) {
+                ipmi_kcs_lower_irq(ik);
+            }
+        }
+        break;
+    case 1:
+        ret = ik->status_reg;
+        if (ik->atn_irq_set) {
+            ik->atn_irq_set = 0;
+            if (!ik->obf_irq_set) {
+                ipmi_kcs_lower_irq(ik);
+            }
+        }
+        break;
+    }
+    return ret;
+}
+
+static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    IPMIInterface *ii = opaque;
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    if (IPMI_KCS_GET_IBF(ik->status_reg)) {
+        return;
+    }
+
+    switch (addr & 1) {
+    case 0:
+        ik->data_in_reg = val;
+        break;
+
+    case 1:
+        ik->cmd_reg = val;
+        break;
+    }
+    IPMI_KCS_SET_IBF(ik->status_reg, 1);
+    ipmi_kcs_signal(ik, ii);
+}
+
+const MemoryRegionOps ipmi_kcs_io_ops = {
+    .read = ipmi_kcs_ioport_read,
+    .write = ipmi_kcs_ioport_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
+    if (val) {
+        if (irq && !ik->atn_irq_set) {
+            ik->atn_irq_set = 1;
+            if (!ik->obf_irq_set) {
+                ipmi_kcs_raise_irq(ik);
+            }
+        }
+    } else {
+        if (ik->atn_irq_set) {
+            ik->atn_irq_set = 0;
+            if (!ik->obf_irq_set) {
+                ipmi_kcs_lower_irq(ik);
+            }
+        }
+    }
+}
+
+static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    ik->irqs_enabled = val;
+}
+
+static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
+{
+    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
+    IPMIKCS *ik = iic->get_backend_data(ii);
+
+    ik->io_length = 2;
+    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs", 2);
+}
+
+const VMStateDescription vmstate_IPMIKCS = {
+    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
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
+void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info)
+{
+    info->interface_name = "kcs";
+    info->interface_type = IPMI_SMBIOS_KCS;
+    info->ipmi_spec_major_revision = 2;
+    info->ipmi_spec_minor_revision = 0;
+    info->base_address = ik->io_base;
+    info->i2c_slave_address = ik->bmc->slave_addr;
+    info->register_length = ik->io_length;
+    info->register_spacing = 1;
+    info->memspace = IPMI_MEMSPACE_IO;
+    info->irq_type = IPMI_LEVEL_IRQ;
+}
+
+void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
+{
+    iic->init = ipmi_kcs_init;
+    iic->set_atn = ipmi_kcs_set_atn;
+    iic->handle_rsp = ipmi_kcs_handle_rsp;
+    iic->handle_if_event = ipmi_kcs_handle_event;
+    iic->set_irq_enable = ipmi_kcs_set_irq_enable;
+}
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index c887251..d1a5956 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -1,7 +1,7 @@
 /*
  * QEMU ISA IPMI KCS emulation
  *
- * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
+ * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -21,339 +21,12 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hw.h"
-#include "hw/ipmi/ipmi.h"
+#include "hw/ipmi/ipmi_kcs.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
-
-#define IPMI_KCS_OBF_BIT        0
-#define IPMI_KCS_IBF_BIT        1
-#define IPMI_KCS_SMS_ATN_BIT    2
-#define IPMI_KCS_CD_BIT         3
-
-#define IPMI_KCS_OBF_MASK          (1 << IPMI_KCS_OBF_BIT)
-#define IPMI_KCS_GET_OBF(d)        (((d) >> IPMI_KCS_OBF_BIT) & 0x1)
-#define IPMI_KCS_SET_OBF(d, v)     (d) = (((d) & ~IPMI_KCS_OBF_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_OBF_BIT))
-#define IPMI_KCS_IBF_MASK          (1 << IPMI_KCS_IBF_BIT)
-#define IPMI_KCS_GET_IBF(d)        (((d) >> IPMI_KCS_IBF_BIT) & 0x1)
-#define IPMI_KCS_SET_IBF(d, v)     (d) = (((d) & ~IPMI_KCS_IBF_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_IBF_BIT))
-#define IPMI_KCS_SMS_ATN_MASK      (1 << IPMI_KCS_SMS_ATN_BIT)
-#define IPMI_KCS_GET_SMS_ATN(d)    (((d) >> IPMI_KCS_SMS_ATN_BIT) & 0x1)
-#define IPMI_KCS_SET_SMS_ATN(d, v) (d) = (((d) & ~IPMI_KCS_SMS_ATN_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_SMS_ATN_BIT))
-#define IPMI_KCS_CD_MASK           (1 << IPMI_KCS_CD_BIT)
-#define IPMI_KCS_GET_CD(d)         (((d) >> IPMI_KCS_CD_BIT) & 0x1)
-#define IPMI_KCS_SET_CD(d, v)      (d) = (((d) & ~IPMI_KCS_CD_MASK) | \
-                                       (((v) & 1) << IPMI_KCS_CD_BIT))
-
-#define IPMI_KCS_IDLE_STATE        0
-#define IPMI_KCS_READ_STATE        1
-#define IPMI_KCS_WRITE_STATE       2
-#define IPMI_KCS_ERROR_STATE       3
-
-#define IPMI_KCS_GET_STATE(d)    (((d) >> 6) & 0x3)
-#define IPMI_KCS_SET_STATE(d, v) ((d) = ((d) & ~0xc0) | (((v) & 0x3) << 6))
-
-#define IPMI_KCS_ABORT_STATUS_CMD       0x60
-#define IPMI_KCS_WRITE_START_CMD        0x61
-#define IPMI_KCS_WRITE_END_CMD          0x62
-#define IPMI_KCS_READ_CMD               0x68
-
-#define IPMI_KCS_STATUS_NO_ERR          0x00
-#define IPMI_KCS_STATUS_ABORTED_ERR     0x01
-#define IPMI_KCS_STATUS_BAD_CC_ERR      0x02
-#define IPMI_KCS_STATUS_LENGTH_ERR      0x06
-
-typedef struct IPMIKCS {
-    IPMIBmc *bmc;
-
-    bool do_wake;
-
-    qemu_irq irq;
-
-    uint32_t io_base;
-    unsigned long io_length;
-    MemoryRegion io;
-
-    bool obf_irq_set;
-    bool atn_irq_set;
-    bool use_irq;
-    bool irqs_enabled;
-
-    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
-    uint32_t outpos;
-    uint32_t outlen;
-
-    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
-    uint32_t inlen;
-    bool write_end;
-
-    uint8_t status_reg;
-    uint8_t data_out_reg;
-
-    int16_t data_in_reg; /* -1 means not written */
-    int16_t cmd_reg;
-
-    /*
-     * This is a response number that we send with the command to make
-     * sure that the response matches the command.
-     */
-    uint8_t waiting_rsp;
-} IPMIKCS;
-
-#define SET_OBF() \
-    do {                                                                      \
-        IPMI_KCS_SET_OBF(ik->status_reg, 1);                                  \
-        if (ik->use_irq && ik->irqs_enabled && !ik->obf_irq_set) {            \
-            ik->obf_irq_set = 1;                                              \
-            if (!ik->atn_irq_set) {                                           \
-                qemu_irq_raise(ik->irq);                                      \
-            }                                                                 \
-        }                                                                     \
-    } while (0)
-
-static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-
-    ik->do_wake = 1;
-    while (ik->do_wake) {
-        ik->do_wake = 0;
-        iic->handle_if_event(ii);
-    }
-}
-
-static void ipmi_kcs_handle_event(IPMIInterface *ii)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    if (ik->cmd_reg == IPMI_KCS_ABORT_STATUS_CMD) {
-        if (IPMI_KCS_GET_STATE(ik->status_reg) != IPMI_KCS_ERROR_STATE) {
-            ik->waiting_rsp++; /* Invalidate the message */
-            ik->outmsg[0] = IPMI_KCS_STATUS_ABORTED_ERR;
-            ik->outlen = 1;
-            ik->outpos = 0;
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
-            SET_OBF();
-        }
-        goto out;
-    }
-
-    switch (IPMI_KCS_GET_STATE(ik->status_reg)) {
-    case IPMI_KCS_IDLE_STATE:
-        if (ik->cmd_reg == IPMI_KCS_WRITE_START_CMD) {
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_WRITE_STATE);
-            ik->cmd_reg = -1;
-            ik->write_end = 0;
-            ik->inlen = 0;
-            SET_OBF();
-        }
-        break;
-
-    case IPMI_KCS_READ_STATE:
-    handle_read:
-        if (ik->outpos >= ik->outlen) {
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_IDLE_STATE);
-            SET_OBF();
-        } else if (ik->data_in_reg == IPMI_KCS_READ_CMD) {
-            ik->data_out_reg = ik->outmsg[ik->outpos];
-            ik->outpos++;
-            SET_OBF();
-        } else {
-            ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
-            ik->outlen = 1;
-            ik->outpos = 0;
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
-            SET_OBF();
-            goto out;
-        }
-        break;
-
-    case IPMI_KCS_WRITE_STATE:
-        if (ik->data_in_reg != -1) {
-            /*
-             * Don't worry about input overrun here, that will be
-             * handled in the BMC.
-             */
-            if (ik->inlen < sizeof(ik->inmsg)) {
-                ik->inmsg[ik->inlen] = ik->data_in_reg;
-            }
-            ik->inlen++;
-        }
-        if (ik->write_end) {
-            IPMIBmcClass *bk = IPMI_BMC_GET_CLASS(ik->bmc);
-            ik->outlen = 0;
-            ik->write_end = 0;
-            ik->outpos = 0;
-            bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
-                               ik->waiting_rsp);
-            goto out_noibf;
-        } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
-            ik->cmd_reg = -1;
-            ik->write_end = 1;
-        }
-        SET_OBF();
-        break;
-
-    case IPMI_KCS_ERROR_STATE:
-        if (ik->data_in_reg != -1) {
-            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
-            ik->data_in_reg = IPMI_KCS_READ_CMD;
-            goto handle_read;
-        }
-        break;
-    }
-
-    if (ik->cmd_reg != -1) {
-        /* Got an invalid command */
-        ik->outmsg[0] = IPMI_KCS_STATUS_BAD_CC_ERR;
-        ik->outlen = 1;
-        ik->outpos = 0;
-        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
-    }
-
- out:
-    ik->cmd_reg = -1;
-    ik->data_in_reg = -1;
-    IPMI_KCS_SET_IBF(ik->status_reg, 0);
- out_noibf:
-    return;
-}
-
-static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-                                unsigned char *rsp, unsigned int rsp_len)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    if (ik->waiting_rsp == msg_id) {
-        ik->waiting_rsp++;
-        if (rsp_len > sizeof(ik->outmsg)) {
-            ik->outmsg[0] = rsp[0];
-            ik->outmsg[1] = rsp[1];
-            ik->outmsg[2] = IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
-            ik->outlen = 3;
-        } else {
-            memcpy(ik->outmsg, rsp, rsp_len);
-            ik->outlen = rsp_len;
-        }
-        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
-        ik->data_in_reg = IPMI_KCS_READ_CMD;
-        ipmi_kcs_signal(ik, ii);
-    }
-}
-
-
-static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
-{
-    IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-    uint32_t ret;
-
-    switch (addr & 1) {
-    case 0:
-        ret = ik->data_out_reg;
-        IPMI_KCS_SET_OBF(ik->status_reg, 0);
-        if (ik->obf_irq_set) {
-            ik->obf_irq_set = 0;
-            if (!ik->atn_irq_set) {
-                qemu_irq_lower(ik->irq);
-            }
-        }
-        break;
-    case 1:
-        ret = ik->status_reg;
-        if (ik->atn_irq_set) {
-            ik->atn_irq_set = 0;
-            if (!ik->obf_irq_set) {
-                qemu_irq_lower(ik->irq);
-            }
-        }
-        break;
-    }
-    return ret;
-}
-
-static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
-                                  unsigned size)
-{
-    IPMIInterface *ii = opaque;
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    if (IPMI_KCS_GET_IBF(ik->status_reg)) {
-        return;
-    }
-
-    switch (addr & 1) {
-    case 0:
-        ik->data_in_reg = val;
-        break;
-
-    case 1:
-        ik->cmd_reg = val;
-        break;
-    }
-    IPMI_KCS_SET_IBF(ik->status_reg, 1);
-    ipmi_kcs_signal(ik, ii);
-}
-
-const MemoryRegionOps ipmi_kcs_io_ops = {
-    .read = ipmi_kcs_ioport_read,
-    .write = ipmi_kcs_ioport_write,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
-    if (val) {
-        if (irq && !ik->atn_irq_set && ik->use_irq && ik->irqs_enabled) {
-            ik->atn_irq_set = 1;
-            if (!ik->obf_irq_set) {
-                qemu_irq_raise(ik->irq);
-            }
-        }
-    } else {
-        if (ik->atn_irq_set) {
-            ik->atn_irq_set = 0;
-            if (!ik->obf_irq_set) {
-                qemu_irq_lower(ik->irq);
-            }
-        }
-    }
-}
-
-static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    ik->irqs_enabled = val;
-}
-
-static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
-{
-    IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
-    IPMIKCS *ik = iic->get_backend_data(ii);
-
-    ik->io_length = 2;
-    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs", 2);
-}
-
 #define TYPE_ISA_IPMI_KCS "isa-ipmi-kcs"
 #define ISA_IPMI_KCS(obj) OBJECT_CHECK(ISAIPMIKCSDevice, (obj), \
                                        TYPE_ISA_IPMI_KCS)
@@ -361,36 +34,32 @@ static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
 typedef struct ISAIPMIKCSDevice {
     ISADevice dev;
     int32_t isairq;
+    qemu_irq irq;
     IPMIKCS kcs;
     uint32_t uuid;
 } ISAIPMIKCSDevice;
 
-static void ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
+static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
 {
     ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
 
-    info->interface_name = "kcs";
-    info->interface_type = IPMI_SMBIOS_KCS;
-    info->ipmi_spec_major_revision = 2;
-    info->ipmi_spec_minor_revision = 0;
-    info->base_address = iik->kcs.io_base;
-    info->i2c_slave_address = iik->kcs.bmc->slave_addr;
-    info->register_length = iik->kcs.io_length;
-    info->register_spacing = 1;
-    info->memspace = IPMI_MEMSPACE_IO;
-    info->irq_type = IPMI_LEVEL_IRQ;
+    ipmi_kcs_get_fwinfo(&iik->kcs, info);
     info->interrupt_number = iik->isairq;
     info->uuid = iik->uuid;
 }
 
-static void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
+static void isa_ipmi_kcs_raise_irq(IPMIKCS *ik)
 {
-    iic->init = ipmi_kcs_init;
-    iic->set_atn = ipmi_kcs_set_atn;
-    iic->handle_rsp = ipmi_kcs_handle_rsp;
-    iic->handle_if_event = ipmi_kcs_handle_event;
-    iic->set_irq_enable = ipmi_kcs_set_irq_enable;
-    iic->get_fwinfo = ipmi_kcs_get_fwinfo;
+    ISAIPMIKCSDevice *iik = ik->opaque;
+
+    qemu_irq_raise(iik->irq);
+}
+
+static void isa_ipmi_kcs_lower_irq(IPMIKCS *ik)
+{
+    ISAIPMIKCSDevice *iik = ik->opaque;
+
+    qemu_irq_lower(iik->irq);
 }
 
 static void ipmi_isa_realize(DeviceState *dev, Error **errp)
@@ -408,14 +77,17 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     iik->uuid = ipmi_next_uuid();
 
     iik->kcs.bmc->intf = ii;
+    iik->kcs.opaque = iik;
 
     iic->init(ii, errp);
     if (*errp)
         return;
 
     if (iik->isairq > 0) {
-        isa_init_irq(isadev, &iik->kcs.irq, iik->isairq);
+        isa_init_irq(isadev, &iik->irq, iik->isairq);
         iik->kcs.use_irq = 1;
+        iik->kcs.raise_irq = isa_ipmi_kcs_raise_irq;
+        iik->kcs.lower_irq = isa_ipmi_kcs_lower_irq;
     }
 
     qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
@@ -423,29 +95,6 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
 }
 
-static const VMStateDescription vmstate_IPMIKCS = {
-    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
-        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
-        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
-        VMSTATE_BOOL(use_irq, IPMIKCS),
-        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
-        VMSTATE_UINT32(outpos, IPMIKCS),
-        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
-        VMSTATE_UINT32(inlen, IPMIKCS),
-        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
-        VMSTATE_BOOL(write_end, IPMIKCS),
-        VMSTATE_UINT8(status_reg, IPMIKCS),
-        VMSTATE_UINT8(data_out_reg, IPMIKCS),
-        VMSTATE_INT16(data_in_reg, IPMIKCS),
-        VMSTATE_INT16(cmd_reg, IPMIKCS),
-        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static int isa_ipmi_kcs_load_old(QEMUFile *f, void *opaque, int version_id)
 {
     ISAIPMIKCSDevice *iik = opaque;
@@ -522,6 +171,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
 
     iic->get_backend_data = isa_ipmi_kcs_get_backend_data;
     ipmi_kcs_class_init(iic);
+    iic->get_fwinfo = isa_ipmi_kcs_get_fwinfo;
 }
 
 static const TypeInfo isa_ipmi_kcs_info = {
diff --git a/include/hw/ipmi/ipmi_kcs.h b/include/hw/ipmi/ipmi_kcs.h
new file mode 100644
index 0000000..af596be
--- /dev/null
+++ b/include/hw/ipmi/ipmi_kcs.h
@@ -0,0 +1,75 @@
+/*
+ * QEMU IPMI KCS emulation
+ *
+ * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
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
+
+#ifndef HW_IPMI_KCS_H
+#define HW_IPMI_KCS_H
+
+#include "hw/hw.h"
+#include "hw/ipmi/ipmi.h"
+
+typedef struct IPMIKCS {
+    IPMIBmc *bmc;
+
+    bool do_wake;
+
+    bool obf_irq_set;
+    bool atn_irq_set;
+    bool irqs_enabled;
+
+    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t outpos;
+    uint32_t outlen;
+
+    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
+    uint32_t inlen;
+    bool write_end;
+
+    uint8_t status_reg;
+    uint8_t data_out_reg;
+
+    int16_t data_in_reg; /* -1 means not written */
+    int16_t cmd_reg;
+
+    /*
+     * This is a response number that we send with the command to make
+     * sure that the response matches the command.
+     */
+    uint8_t waiting_rsp;
+
+    uint32_t io_base;
+    unsigned long io_length;
+    MemoryRegion io;
+
+    void (*raise_irq)(struct IPMIKCS *ik);
+    void (*lower_irq)(struct IPMIKCS *ik);
+    void *opaque;
+
+    bool use_irq;
+} IPMIKCS;
+
+void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info);
+void ipmi_kcs_class_init(IPMIInterfaceClass *iic);
+extern const VMStateDescription vmstate_IPMIKCS;
+
+#endif /* HW_IPMI_KCS_H */
-- 
2.7.4
