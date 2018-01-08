Received: from eggs.gnu.org ([2001:4830:134:3::10]:51322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSR-0006ms-AP
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSO-0002Of-8e
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:39 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSO-0002OV-3g
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:36 -0500
Received: by mail-qt0-x244.google.com with SMTP id i40so12055850qti.8
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:36 -0300
Message-Id: <20180108024558.17983-8-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/29] hw/i386/pc: use isa_superio_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/pc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e5c4e48ebb..f9479351f3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -24,12 +24,9 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
-#include "hw/char/serial.h"
-#include "hw/char/parallel.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
 #include "sysemu/cpus.h"
-#include "hw/block/fdc.h"
 #include "hw/ide.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
@@ -41,6 +38,7 @@
 #include "multiboot.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/dma/i8257.h"
+#include "hw/isa/superio.h"
 #include "hw/timer/i8254.h"
 #include "hw/input/i8042.h"
 #include "hw/audio/pcspk.h"
@@ -1523,7 +1521,6 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
                           uint32_t hpet_irqs)
 {
     int i;
-    DriveInfo *fd[MAX_FD];
     DeviceState *hpet = NULL;
     int pit_isa_irq = 0;
     qemu_irq pit_alt_irq = NULL;
@@ -1586,11 +1583,9 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
         pcspk_init(isa_bus, pit);
     }
 
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
-    parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
-
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
-    i8042 = isa_create_simple(isa_bus, "i8042");
+    i8042 = isa_superio_init(isa_bus, MAX_SERIAL_PORTS, 1,
+                             create_fdctrl ? MAX_FD : 0);
     i8042_setup_a20_line(i8042, a20_line[0]);
     if (!no_vmport) {
         vmport_init(isa_bus);
@@ -1608,14 +1603,6 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
     g_free(a20_line);
 
     i8257_dma_init(isa_bus, 0);
-
-    for(i = 0; i < MAX_FD; i++) {
-        fd[i] = drive_get(IF_FLOPPY, 0, i);
-        create_fdctrl |= !!fd[i];
-    }
-    if (create_fdctrl) {
-        fdctrl_init_isa(isa_bus, fd);
-    }
 }
 
 void pc_nic_init(ISABus *isa_bus, PCIBus *pci_bus)
-- 
2.15.1
