Received: from eggs.gnu.org ([2001:4830:134:3::10]:43326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPK-0006JG-RH
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPJ-0007pD-Rz
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPJ-0007mN-KN
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:46 +0100
Message-Id: <20180420145249.32435-11-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 10/13] serial-isa: Use MAX_ISA_SERIAL_PORTS
 instead of MAX_SERIAL_PORTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The ISA serial port handling in serial-isa.c imposes a limit
of 4 serial ports. This is because we only know of 4 IO port
and IRQ settings for them, and is unrelated to the generic
MAX_SERIAL_PORTS limit, though they happen to both be set at
4 currently.

Use a new MAX_ISA_SERIAL_PORTS wherever that is the correct
limit to be checking against.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/serial.h |  3 +++
 hw/char/serial-isa.c     | 10 +++++-----
 hw/i386/pc.c             |  2 +-
 hw/mips/mips_r4k.c       |  2 +-
 hw/ppc/pnv.c             |  2 +-
 hw/sparc64/sun4u.c       |  2 +-
 6 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index c4daf11a14..0acfbbc382 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -95,6 +95,9 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
                             Chardev *chr, enum device_endian end);
 
 /* serial-isa.c */
+
+#define MAX_ISA_SERIAL_PORTS 4
+
 #define TYPE_ISA_SERIAL "isa-serial"
 void serial_hds_isa_init(ISABus *bus, int from, int to);
 
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index eb5996159d..116b7b2e69 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -39,10 +39,10 @@ typedef struct ISASerialState {
     SerialState state;
 } ISASerialState;
 
-static const int isa_serial_io[MAX_SERIAL_PORTS] = {
+static const int isa_serial_io[MAX_ISA_SERIAL_PORTS] = {
     0x3f8, 0x2f8, 0x3e8, 0x2e8
 };
-static const int isa_serial_irq[MAX_SERIAL_PORTS] = {
+static const int isa_serial_irq[MAX_ISA_SERIAL_PORTS] = {
     4, 3, 4, 3
 };
 
@@ -56,9 +56,9 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     if (isa->index == -1) {
         isa->index = index;
     }
-    if (isa->index >= MAX_SERIAL_PORTS) {
+    if (isa->index >= MAX_ISA_SERIAL_PORTS) {
         error_setg(errp, "Max. supported number of ISA serial ports is %d.",
-                   MAX_SERIAL_PORTS);
+                   MAX_ISA_SERIAL_PORTS);
         return;
     }
     if (isa->iobase == -1) {
@@ -138,7 +138,7 @@ void serial_hds_isa_init(ISABus *bus, int from, int to)
     int i;
 
     assert(from >= 0);
-    assert(to <= MAX_SERIAL_PORTS);
+    assert(to <= MAX_ISA_SERIAL_PORTS);
 
     for (i = from; i < to; ++i) {
         if (serial_hd(i)) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d36bac8c89..b297a5d63b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1524,7 +1524,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
     qemu_irq *a20_line;
     ISADevice *i8042, *port92, *vmmouse;
 
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
+    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
 
     for (i = 0; i < MAX_FD; i++) {
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index aeadc4a340..e04b49d3c5 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -274,7 +274,7 @@ void mips_r4k_init(MachineState *machine)
 
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
 
-    serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
+    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
 
     isa_vga_init(isa_bus);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 98ee3c607a..549cfccdcb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -648,7 +648,7 @@ static void pnv_init(MachineState *machine)
     pnv->isa_bus = pnv_isa_create(pnv->chips[0]);
 
     /* Create serial port */
-    serial_hds_isa_init(pnv->isa_bus, 0, MAX_SERIAL_PORTS);
+    serial_hds_isa_init(pnv->isa_bus, 0, MAX_ISA_SERIAL_PORTS);
 
     /* Create an RTC ISA device too */
     mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9b441f704b..1bede85370 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -298,7 +298,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
                        0, NULL, 115200, serial_hd(i), DEVICE_BIG_ENDIAN);
         i++;
     }
-    serial_hds_isa_init(s->isa_bus, i, MAX_SERIAL_PORTS);
+    serial_hds_isa_init(s->isa_bus, i, MAX_ISA_SERIAL_PORTS);
 
     /* Parallel ports */
     parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
-- 
2.17.0
