Received: from eggs.gnu.org ([2001:4830:134:3::10]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DI-0007MI-Ro
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DG-0004QA-UX
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4DG-0004Pp-NQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:38 -0500
Received: by mail-wm0-x244.google.com with SMTP id s206so1072720wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:40:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:46 +0100
Message-Id: <20180308223946.26784-26-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/25] hw/i386/pc: Factor out the superio code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/pc.c | 72 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cdcdfafe8e..20fa62f5d6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1519,6 +1519,44 @@ static const MemoryRegionOps ioportF0_io_ops = {
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
@@ -1527,13 +1565,11 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
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
 
@@ -1590,36 +1626,10 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
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
 
 void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
-- 
2.16.2
