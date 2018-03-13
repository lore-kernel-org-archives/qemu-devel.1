Received: from eggs.gnu.org ([2001:4830:134:3::10]:58287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiL-0005yF-01
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiJ-0003kq-R2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:12 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsiJ-0003jP-Kc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:11 -0400
Received: by mail-wr0-x242.google.com with SMTP id v65so2494159wrc.11
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:49 +0100
Message-Id: <20180313224719.4954-40-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/69] hw/isa/superio: Add a keyboard/mouse
 controller (8042)
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

Since the PC87312 inherits this abstract model, we remove the I8042
instance in the PREP machine.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20180308223946.26784-14-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c     | 3 +++
 hw/ppc/prep.c            | 1 -
 include/hw/isa/superio.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

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
index df774bd384..5c78503069 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -641,7 +641,6 @@ static void ppc_prep_init(MachineState *machine)
                      hd[2 * i],
 		     hd[2 * i + 1]);
     }
-    isa_create_simple(isa_bus, TYPE_I8042);
 
     cpu = POWERPC_CPU(first_cpu);
     sysctrl->reset_irq = cpu->env.irq_inputs[PPC6xx_INPUT_HRESET];
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
-- 
2.14.3
