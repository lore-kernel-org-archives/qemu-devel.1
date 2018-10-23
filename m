Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gEmvq-0008M6-Rg
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 23:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gEmvn-0000nV-Ld
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 23:00:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gEmvl-0000kq-J3
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 23:00:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id q1-v6so3587313pfh.10
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 20:00:25 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Oct 2018 20:00:18 -0700
Message-Id: <1540263618-18344-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] usb: ohci: make num_ports to an unsinged
 integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

This can avoid setting OCHIState.num_ports to a negative num.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/usb/hcd-ohci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 66656a1..c34cf5b 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -57,7 +57,7 @@ typedef struct {
     qemu_irq irq;
     MemoryRegion mem;
     AddressSpace *as;
-    int num_ports;
+    uint32_t num_ports;
     const char *name;
 
     QEMUTimer *eof_timer;
@@ -1850,7 +1850,7 @@ static USBBusOps ohci_bus_ops = {
 };
 
 static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
-                          int num_ports, dma_addr_t localmem_base,
+                          uint32_t num_ports, dma_addr_t localmem_base,
                           char *masterbus, uint32_t firstport,
                           AddressSpace *as, Error **errp)
 {
@@ -1860,7 +1860,7 @@ static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
     ohci->as = as;
 
     if (num_ports > OHCI_MAX_PORTS) {
-        error_setg(errp, "OHCI num-ports=%d is too big (limit is %d ports)",
+        error_setg(errp, "OHCI num-ports=%u is too big (limit is %u ports)",
                    num_ports, OHCI_MAX_PORTS);
         return;
     }
-- 
1.8.3.1
