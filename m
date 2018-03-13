Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiY-0006E4-Kd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiX-00041v-M2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:26 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiX-00041M-Fe
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id s206so16180520wme.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:47:01 +0100
Message-Id: <20180313224719.4954-52-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 51/69] hw/i386/pc: Factor out the superio code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-26-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 72 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 853a01d791..d36bac8c89 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1517,6 +1517,44 @@ static const MemoryRegionOps ioportF0_io_ops = {
     },
 };
 
+static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
+{
+    int i;
+    DriveInfo *fd[MAX_FD];
+    qemu_irq *a20_line;
+    ISADevice *i8042, *port92, *vmmouse;
+
+    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
+    parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
+
+    for (i = 0; i < MAX_FD; i++) {
+        fd[i] = drive_get(IF_FLOPPY, 0, i);
+        create_fdctrl |= !!fd[i];
+    }
+    if (create_fdctrl) {
+        fdctrl_init_isa(isa_bus, fd);
+    }
+
+    i8042 = isa_create_simple(isa_bus, "i8042");
+    if (!no_vmport) {
+        vmport_init(isa_bus);
+        vmmouse = isa_try_create(isa_bus, "vmmouse");
+    } else {
+        vmmouse = NULL;
+    }
+    if (vmmouse) {
+        DeviceState *dev = DEVICE(vmmouse);
+        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
+        qdev_init_nofail(dev);
+    }
+    port92 = isa_create_simple(isa_bus, "port92");
+
+    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
+    i8042_setup_a20_line(i8042, a20_line[0]);
+    port92_init(port92, a20_line[1]);
+    g_free(a20_line);
+}
+
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           ISADevice **rtc_state,
                           bool create_fdctrl,
@@ -1525,13 +1563,11 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           uint32_t hpet_irqs)
 {
     int i;
-    DriveInfo *fd[MAX_FD];
     DeviceState *hpet = NULL;
     int pit_isa_irq = 0;
     qemu_irq pit_alt_irq = NULL;
     qemu_irq rtc_irq = NULL;
-    qemu_irq *a20_line;
-    ISADevice *i8042, *port92, *vmmouse, *pit = NULL;
+    ISADevice *pit = NULL;
     MemoryRegion *ioport80_io = g_new(MemoryRegion, 1);
     MemoryRegion *ioportF0_io = g_new(MemoryRegion, 1);
 
@@ -1588,36 +1624,10 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         pcspk_init(isa_bus, pit);
     }
 
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
-    parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
-
-    a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
-    i8042 = isa_create_simple(isa_bus, "i8042");
-    i8042_setup_a20_line(i8042, a20_line[0]);
-    if (!no_vmport) {
-        vmport_init(isa_bus);
-        vmmouse = isa_try_create(isa_bus, "vmmouse");
-    } else {
-        vmmouse = NULL;
-    }
-    if (vmmouse) {
-        DeviceState *dev = DEVICE(vmmouse);
-        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
-        qdev_init_nofail(dev);
-    }
-    port92 = isa_create_simple(isa_bus, "port92");
-    port92_init(port92, a20_line[1]);
-    g_free(a20_line);
-
     i8257_dma_init(isa_bus, 0);
 
-    for(i = 0; i < MAX_FD; i++) {
-        fd[i] = drive_get(IF_FLOPPY, 0, i);
-        create_fdctrl |= !!fd[i];
-    }
-    if (create_fdctrl) {
-        fdctrl_init_isa(isa_bus, fd);
-    }
+    /* Super I/O */
+    pc_superio_init(isa_bus, create_fdctrl, no_vmport);
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
-- 
2.14.3
