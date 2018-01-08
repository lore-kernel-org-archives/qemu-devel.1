Received: from eggs.gnu.org ([2001:4830:134:3::10]:51366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSX-0006so-DS
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSW-0002UO-C6
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:45 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYNSW-0002U9-7y
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 21:46:44 -0500
Received: by mail-qt0-x243.google.com with SMTP id g10so12057518qtj.12
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 18:46:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  7 Jan 2018 23:45:39 -0300
Message-Id: <20180108024558.17983-11-f4bug@amsat.org>
In-Reply-To: <20180108024558.17983-1-f4bug@amsat.org>
References: <20180108024558.17983-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/29] hw/mips/malta: add fdc37m81x_init()
 which uses isa_superio_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_malta.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 195d7dd59e..bfa79c374d 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -27,14 +27,12 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "hw/isa/superio.h"
 #include "hw/dma/i8257.h"
 #include "hw/char/serial.h"
-#include "hw/char/parallel.h"
-#include "hw/block/fdc.h"
 #include "net/net.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus.h"
-#include "sysemu/block-backend.h"
 #include "hw/block/flash.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
@@ -47,7 +45,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
-#include "hw/input/i8042.h"
 #include "hw/timer/i8254.h"
 #include "sysemu/blockdev.h"
 #include "exec/address-spaces.h"
@@ -980,6 +977,16 @@ static void mips_create_cpu(MaltaState *s, const char *cpu_type,
     }
 }
 
+#define FDC37M81X_SERIAL_COUNT      2
+#define FDC37M81X_DRIVE_COUNT       2
+#define FDC37M81X_PARALLEL_COUNT    1
+
+static ISADevice *fdc37m81x_init(ISABus *isa_bus)
+{
+    return isa_superio_init(isa_bus, FDC37M81X_SERIAL_COUNT,
+                            FDC37M81X_PARALLEL_COUNT, FDC37M81X_DRIVE_COUNT);
+}
+
 static
 void mips_malta_init(MachineState *machine)
 {
@@ -1008,7 +1015,6 @@ void mips_malta_init(MachineState *machine)
     int i;
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    DriveInfo *fd[MAX_FD];
     int fl_idx = 0;
     int fl_sectors = bios_size >> 16;
     int be;
@@ -1215,16 +1221,8 @@ void mips_malta_init(MachineState *machine)
     smbus_eeprom_init(smbus, 8, smbus_eeprom_buf, smbus_eeprom_size);
     g_free(smbus_eeprom_buf);
 
-    /* Super I/O */
-    isa_create_simple(isa_bus, TYPE_I8042);
-
-    serial_hds_isa_init(isa_bus, 0, 2);
-    parallel_hds_isa_init(isa_bus, 1);
-
-    for(i = 0; i < MAX_FD; i++) {
-        fd[i] = drive_get(IF_FLOPPY, 0, i);
-    }
-    fdctrl_init_isa(isa_bus, fd);
+    /* SuperI/O: SMS FDC37M817 */
+    fdc37m81x_init(isa_bus);
 
     /* Network card */
     network_init(pci_bus);
-- 
2.15.1
