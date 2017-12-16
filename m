Received: from eggs.gnu.org ([2001:4830:134:3::10]:43245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQK6C-0000kf-VH
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 16:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eQK6B-0003nk-TC
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 16:34:24 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 16 Dec 2017 22:29:51 +0100
Message-Id: <20171216213004.30393-3-hpoussin@reactos.org>
In-Reply-To: <20171216213004.30393-1-hpoussin@reactos.org>
References: <20171216213004.30393-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/15] serial/parallel: move object
 structures to header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>

We are now able to embed serial/parallel ports in another object.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/char/parallel.c       | 31 +-----------------------------
 hw/char/serial-isa.c     | 13 +------------
 hw/ppc/pnv.c             |  2 +-
 include/hw/char/isa.h    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/char/serial.h |  1 -
 5 files changed, 53 insertions(+), 44 deletions(-)
 create mode 100644 include/hw/char/isa.h

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index f79dc76543..6b36d425ff 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -28,6 +28,7 @@
 #include "chardev/char-parallel.h"
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
+#include "hw/char/isa.h"
 #include "hw/i386/pc.h"
 #include "sysemu/sysemu.h"
 
@@ -67,36 +68,6 @@
 
 #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
 
-typedef struct ParallelState {
-    MemoryRegion iomem;
-    uint8_t dataw;
-    uint8_t datar;
-    uint8_t status;
-    uint8_t control;
-    qemu_irq irq;
-    int irq_pending;
-    CharBackend chr;
-    int hw_driver;
-    int epp_timeout;
-    uint32_t last_read_offset; /* For debugging */
-    /* Memory-mapped interface */
-    int it_shift;
-    PortioList portio_list;
-} ParallelState;
-
-#define TYPE_ISA_PARALLEL "isa-parallel"
-#define ISA_PARALLEL(obj) \
-    OBJECT_CHECK(ISAParallelState, (obj), TYPE_ISA_PARALLEL)
-
-typedef struct ISAParallelState {
-    ISADevice parent_obj;
-
-    uint32_t index;
-    uint32_t iobase;
-    uint32_t isairq;
-    ParallelState state;
-} ISAParallelState;
-
 static void parallel_update_irq(ParallelState *s)
 {
     if (s->irq_pending)
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index d7c5cc11fe..2c6cf81790 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -26,18 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/char/serial.h"
-#include "hw/isa/isa.h"
-
-#define ISA_SERIAL(obj) OBJECT_CHECK(ISASerialState, (obj), TYPE_ISA_SERIAL)
-
-typedef struct ISASerialState {
-    ISADevice parent_obj;
-
-    uint32_t index;
-    uint32_t iobase;
-    uint32_t isairq;
-    SerialState state;
-} ISASerialState;
+#include "hw/char/isa.h"
 
 static const int isa_serial_io[MAX_SERIAL_PORTS] = {
     0x3f8, 0x2f8, 0x3e8, 0x2e8
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c35c439d81..91d8e36cac 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -41,7 +41,7 @@
 #include "hw/ppc/pnv_xscom.h"
 
 #include "hw/isa/isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/isa.h"
 #include "hw/timer/mc146818rtc.h"
 
 #include <libfdt.h>
diff --git a/include/hw/char/isa.h b/include/hw/char/isa.h
new file mode 100644
index 0000000000..39f7be41c5
--- /dev/null
+++ b/include/hw/char/isa.h
@@ -0,0 +1,50 @@
+#ifndef HW_CHAR_ISA_H
+#define HW_CHAR_ISA_H
+
+#include "qemu-common.h"
+#include "hw/char/serial.h"
+#include "hw/isa/isa.h"
+
+typedef struct ParallelState {
+    MemoryRegion iomem;
+    uint8_t dataw;
+    uint8_t datar;
+    uint8_t status;
+    uint8_t control;
+    qemu_irq irq;
+    int irq_pending;
+    CharBackend chr;
+    int hw_driver;
+    int epp_timeout;
+    uint32_t last_read_offset; /* For debugging */
+    /* Memory-mapped interface */
+    int it_shift;
+    PortioList portio_list;
+} ParallelState;
+
+typedef struct ISAParallelState {
+    ISADevice parent_obj;
+
+    uint32_t index;
+    uint32_t iobase;
+    uint32_t isairq;
+    ParallelState state;
+} ISAParallelState;
+
+#define TYPE_ISA_PARALLEL "isa-parallel"
+#define ISA_PARALLEL(obj) \
+    OBJECT_CHECK(ISAParallelState, (obj), TYPE_ISA_PARALLEL)
+
+typedef struct ISASerialState {
+    ISADevice parent_obj;
+
+    uint32_t index;
+    uint32_t iobase;
+    uint32_t isairq;
+    SerialState state;
+} ISASerialState;
+
+#define TYPE_ISA_SERIAL "isa-serial"
+#define ISA_SERIAL(obj) OBJECT_CHECK(ISASerialState, (obj), TYPE_ISA_SERIAL)
+
+#endif
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index c4daf11a14..ec7da3d7f6 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -95,7 +95,6 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
                             Chardev *chr, enum device_endian end);
 
 /* serial-isa.c */
-#define TYPE_ISA_SERIAL "isa-serial"
 void serial_hds_isa_init(ISABus *bus, int from, int to);
 
 #endif
-- 
2.11.0
