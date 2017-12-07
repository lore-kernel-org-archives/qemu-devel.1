Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3ot-0001vx-Fd
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3or-00054h-8x
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:03 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3or-00053r-0A
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:35:01 -0500
Received: by mail-pg0-x242.google.com with SMTP id e14so5366255pgr.9
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:35:00 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:47 -0600
Message-Id: <1512682489-4474-6-git-send-email-minyard@acm.org>
In-Reply-To: <1512682489-4474-1-git-send-email-minyard@acm.org>
References: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 5/7] ipmi: Allow a size value to be passed for
 I/O space
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

PCI device I/O must be >= 8 bytes in length or they don't work.
Allow the size to be passed in, the default size of 2 or 3
won't work.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bt.c          | 19 +++++++++++++++----
 hw/ipmi/ipmi_kcs.c         | 23 +++++++++++++++++++----
 hw/ipmi/isa_ipmi_bt.c      |  2 +-
 hw/ipmi/isa_ipmi_kcs.c     |  2 +-
 include/hw/ipmi/ipmi.h     |  7 ++++++-
 include/hw/ipmi/ipmi_bt.h  |  1 +
 include/hw/ipmi/ipmi_kcs.h |  1 +
 7 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index e07e10a..130ef24 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -187,7 +187,7 @@ static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
     IPMIBT *ib = iic->get_backend_data(ii);
     uint32_t ret = 0xff;
 
-    switch (addr & 3) {
+    switch (addr & ib->size_mask) {
     case 0:
         ret = ib->control_reg;
         break;
@@ -206,6 +206,9 @@ static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigned size)
     case 2:
         ret = ib->mask_reg;
         break;
+    default:
+        ret = 0xff;
+        break;
     }
     return ret;
 }
@@ -228,7 +231,7 @@ static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
-    switch (addr & 3) {
+    switch (addr & ib->size_mask) {
     case 0:
         if (IPMI_BT_GET_CLR_WR(val)) {
             ib->inlen = 0;
@@ -283,6 +286,9 @@ static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t val,
             ipmi_bt_lower_irq(ib);
         }
         break;
+    default:
+        /* Ignore. */
+        break;
     }
 }
 
@@ -344,14 +350,19 @@ static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
     ib->irqs_enabled = val;
 }
 
-static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
+static void ipmi_bt_init(IPMIInterface *ii, unsigned int min_size, Error **errp)
 {
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIBT *ib = iic->get_backend_data(ii);
 
+    if (min_size == 0) {
+        min_size = 4;
+    }
+    ib->size_mask = min_size - 1;
     ib->io_length = 3;
 
-    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt", 3);
+    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt",
+                          min_size);
 }
 
 const VMStateDescription vmstate_IPMIBT = {
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index cb22dee..ec6dc39 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -230,7 +230,7 @@ static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
     IPMIKCS *ik = iic->get_backend_data(ii);
     uint32_t ret;
 
-    switch (addr & 1) {
+    switch (addr & ik->size_mask) {
     case 0:
         ret = ik->data_out_reg;
         IPMI_KCS_SET_OBF(ik->status_reg, 0);
@@ -241,6 +241,7 @@ static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
             }
         }
         break;
+
     case 1:
         ret = ik->status_reg;
         if (ik->atn_irq_set) {
@@ -250,6 +251,9 @@ static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsigned size)
             }
         }
         break;
+
+    default:
+        ret = 0xff;
     }
     return ret;
 }
@@ -265,7 +269,7 @@ static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    switch (addr & 1) {
+    switch (addr & ik->size_mask) {
     case 0:
         ik->data_in_reg = val;
         break;
@@ -273,6 +277,10 @@ static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     case 1:
         ik->cmd_reg = val;
         break;
+
+    default:
+        /* Ignore. */
+        break;
     }
     IPMI_KCS_SET_IBF(ik->status_reg, 1);
     ipmi_kcs_signal(ik, ii);
@@ -319,13 +327,20 @@ static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
     ik->irqs_enabled = val;
 }
 
-static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
+/* min_size must be a power of 2. */
+static void ipmi_kcs_init(IPMIInterface *ii, unsigned int min_size,
+                          Error **errp)
 {
     IPMIInterfaceClass *iic = IPMI_INTERFACE_GET_CLASS(ii);
     IPMIKCS *ik = iic->get_backend_data(ii);
 
+    if (min_size == 0) {
+        min_size = 2;
+    }
+    ik->size_mask = min_size - 1;
     ik->io_length = 2;
-    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs", 2);
+    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-kcs",
+                          min_size);
 }
 
 const VMStateDescription vmstate_IPMIKCS = {
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index b711eca..a98e0ea 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -80,7 +80,7 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     iib->bt.bmc->intf = ii;
     iib->bt.opaque = iib;
 
-    iic->init(ii, errp);
+    iic->init(ii, 0, errp);
     if (*errp)
         return;
 
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index d1a5956..ab6f62e 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -79,7 +79,7 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     iik->kcs.bmc->intf = ii;
     iik->kcs.opaque = iik;
 
-    iic->init(ii, errp);
+    iic->init(ii, 0, errp);
     if (*errp)
         return;
 
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 0affe5a..0f62ea3 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -121,7 +121,12 @@ typedef struct IPMIInterface {
 typedef struct IPMIInterfaceClass {
     InterfaceClass parent;
 
-    void (*init)(struct IPMIInterface *s, Error **errp);
+    /*
+     * min_size is the requested I/O size and must be a power of 2.
+     * This is so PCI (or other busses) can request a bigger range.
+     * Use 0 for the default.
+     */
+    void (*init)(struct IPMIInterface *s, unsigned int min_size, Error **errp);
 
     /*
      * Perform various operations on the hardware.  If checkonly is
diff --git a/include/hw/ipmi/ipmi_bt.h b/include/hw/ipmi/ipmi_bt.h
index 16066a7..d1e2abe 100644
--- a/include/hw/ipmi/ipmi_bt.h
+++ b/include/hw/ipmi/ipmi_bt.h
@@ -57,6 +57,7 @@ typedef struct IPMIBT {
     uint32_t io_base;
     unsigned long io_length;
     MemoryRegion io;
+    unsigned long size_mask;
 
     void (*raise_irq)(struct IPMIBT *ib);
     void (*lower_irq)(struct IPMIBT *ib);
diff --git a/include/hw/ipmi/ipmi_kcs.h b/include/hw/ipmi/ipmi_kcs.h
index af596be..8c75e86 100644
--- a/include/hw/ipmi/ipmi_kcs.h
+++ b/include/hw/ipmi/ipmi_kcs.h
@@ -60,6 +60,7 @@ typedef struct IPMIKCS {
     uint32_t io_base;
     unsigned long io_length;
     MemoryRegion io;
+    unsigned long size_mask;
 
     void (*raise_irq)(struct IPMIKCS *ik);
     void (*lower_irq)(struct IPMIKCS *ik);
-- 
2.7.4
