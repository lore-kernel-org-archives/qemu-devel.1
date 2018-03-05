Received: from eggs.gnu.org ([2001:4830:134:3::10]:49674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWp-0004qu-VW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWn-0001ts-UP
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:15 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esxWn-0001tU-Dv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 16:20:13 -0500
Received: by mail-wm0-x243.google.com with SMTP id t74so18848656wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 13:20:13 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 18:19:27 -0300
Message-Id: <20180305211928.466-22-f4bug@amsat.org>
In-Reply-To: <20180305211928.466-1-f4bug@amsat.org>
References: <20180305211928.466-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 21/22] hw/alpha/dp264: Use the
 TYPE_SMC37C669_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/alpha-softmmu.mak |  3 +++
 hw/alpha/dp264.c                  | 10 ++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index 3740adc5e9..bbe361f01a 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -7,6 +7,9 @@ CONFIG_SERIAL_ISA=y
 CONFIG_I82374=y
 CONFIG_I8254=y
 CONFIG_I8257=y
+CONFIG_PARALLEL=y
+CONFIG_PARALLEL_ISA=y
+CONFIG_FDC=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
 CONFIG_IDE_CORE=y
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index ffad678ea7..80b987f7fb 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -19,8 +19,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
-#include "hw/input/i8042.h"
-#include "hw/char/serial.h"
+#include "hw/isa/superio.h"
 #include "hw/dma/i8257.h"
 #include "qemu/cutils.h"
 
@@ -83,14 +82,10 @@ static void clipper_init(MachineState *machine)
     mc146818_rtc_init(isa_bus, 1900, rtc_irq);
 
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    isa_create_simple(isa_bus, TYPE_I8042);
 
     /* VGA setup.  Don't bother loading the bios.  */
     pci_vga_init(pci_bus);
 
-    /* Serial code setup.  */
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
-
     /* Network setup.  e1000 is good enough, failing Tulip support.  */
     for (i = 0; i < nb_nics; i++) {
         pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
@@ -99,6 +94,9 @@ static void clipper_init(MachineState *machine)
     /* 2 82C37 (dma) */
     isa_create_simple(isa_bus, "i82374");
 
+    /* Super I/O */
+    isa_create_simple(isa_bus, TYPE_SMC37C669_SUPERIO);
+
     /* IDE disk setup.  */
     {
         DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-- 
2.16.2
