Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cx-00073F-TV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cw-00048A-Sw
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:19 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:34 +0100
Message-Id: <20180308223946.26784-14-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 13/25] hw/isa/superio: Add a keyboard/mouse
 controller (8042)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PReP" <qemu-ppc@nongnu.org>

Since the PC87312 inherits this abstract model, we remove the I8042
instance in the PREP machine.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/isa/superio.h | 1 +
 hw/isa/isa-superio.c     | 3 +++
 hw/ppc/prep.c            | 1 -
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index e8007b9eee..2fc33bf3d3 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -30,6 +30,7 @@ typedef struct ISASuperIODevice {
     ISADevice *parallel[MAX_PARALLEL_PORTS];
     ISADevice *serial[MAX_SERIAL_PORTS];
     ISADevice *floppy;
+    ISADevice *kbc;
 } ISASuperIODevice;
 
 typedef struct ISASuperIOFuncs {
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 4b5e280b38..041b47bdbf 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -17,6 +17,7 @@
 #include "sysemu/blockdev.h"
 #include "chardev/char.h"
 #include "hw/isa/superio.h"
+#include "hw/input/i8042.h"
 #include "hw/char/serial.h"
 #include "trace.h"
 
@@ -143,6 +144,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
                                     k->floppy.get_irq(sio, 0) : -1);
     }
 
+    /* Keyboard, mouse */
+    sio->kbc = isa_create_simple(bus, TYPE_I8042);
 }
 
 static void isa_superio_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 610ec7ec32..96d319b87c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -642,7 +642,6 @@ static void ppc_prep_init(MachineState *machine)
                      hd[2 * i],
 		     hd[2 * i + 1]);
     }
-    isa_create_simple(isa_bus, TYPE_I8042);
 
     cpu = POWERPC_CPU(first_cpu);
     sysctrl->reset_irq = cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];
-- 
2.16.2
