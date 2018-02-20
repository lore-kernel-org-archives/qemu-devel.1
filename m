Received: from eggs.gnu.org ([2001:4830:134:3::10]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCru-00054B-Re
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eoCrt-0000US-L3
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:42:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 20 Feb 2018 18:41:54 +0000
Message-Id: <20180220184159.16483-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
References: <20180220184159.16483-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 06/11] macio: move macio related structures
 and defines into separate macio.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c         | 43 +------------------------
 hw/ppc/mac.h                  |  3 --
 hw/ppc/mac_newworld.c         |  1 +
 hw/ppc/mac_oldworld.c         |  1 +
 include/hw/misc/macio/macio.h | 75 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 45 deletions(-)
 create mode 100644 include/hw/misc/macio/macio.h

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 1c10d8a1d7..4e502ede2e 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -30,48 +30,7 @@
 #include "hw/pci/pci.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/char/escc.h"
-
-#define TYPE_MACIO "macio"
-#define MACIO(obj) OBJECT_CHECK(MacIOState, (obj), TYPE_MACIO)
-
-typedef struct MacIOState
-{
-    /*< private >*/
-    PCIDevice parent;
-    /*< public >*/
-
-    MemoryRegion bar;
-    CUDAState cuda;
-    DBDMAState dbdma;
-    ESCCState escc;
-    MemoryRegion *pic_mem;
-    uint64_t frequency;
-} MacIOState;
-
-#define OLDWORLD_MACIO(obj) \
-    OBJECT_CHECK(OldWorldMacIOState, (obj), TYPE_OLDWORLD_MACIO)
-
-typedef struct OldWorldMacIOState {
-    /*< private >*/
-    MacIOState parent_obj;
-    /*< public >*/
-
-    qemu_irq irqs[7];
-
-    MacIONVRAMState nvram;
-    MACIOIDEState ide[2];
-} OldWorldMacIOState;
-
-#define NEWWORLD_MACIO(obj) \
-    OBJECT_CHECK(NewWorldMacIOState, (obj), TYPE_NEWWORLD_MACIO)
-
-typedef struct NewWorldMacIOState {
-    /*< private >*/
-    MacIOState parent_obj;
-    /*< public >*/
-    qemu_irq irqs[7];
-    MACIOIDEState ide[2];
-} NewWorldMacIOState;
+#include "hw/misc/macio/macio.h"
 
 /*
  * The mac-io has two interfaces to the ESCC. One is called "escc-legacy",
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 5b5fffdff3..a02f797598 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -47,9 +47,6 @@
 
 
 /* MacIO */
-#define TYPE_OLDWORLD_MACIO "macio-oldworld"
-#define TYPE_NEWWORLD_MACIO "macio-newworld"
-
 #define TYPE_MACIO_IDE "macio-ide"
 #define MACIO_IDE(obj) OBJECT_CHECK(MACIOIDEState, (obj), TYPE_MACIO_IDE)
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 5e82158759..396216954e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -60,6 +60,7 @@
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
+#include "hw/misc/macio/macio.h"
 #include "hw/ppc/openpic.h"
 #include "hw/ide.h"
 #include "hw/loader.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 06a61220cb..5903ff47d3 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -37,6 +37,7 @@
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
+#include "hw/misc/macio/macio.h"
 #include "hw/ide.h"
 #include "hw/loader.h"
 #include "elf.h"
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
new file mode 100644
index 0000000000..e1e249f898
--- /dev/null
+++ b/include/hw/misc/macio/macio.h
@@ -0,0 +1,75 @@
+/*
+ * PowerMac MacIO device emulation
+ *
+ * Copyright (c) 2005-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef MACIO_H
+#define MACIO_H
+
+#include "hw/misc/macio/cuda.h"
+#include "hw/ppc/mac_dbdma.h"
+
+#define TYPE_MACIO "macio"
+#define MACIO(obj) OBJECT_CHECK(MacIOState, (obj), TYPE_MACIO)
+
+typedef struct MacIOState {
+    /*< private >*/
+    PCIDevice parent;
+    /*< public >*/
+
+    MemoryRegion bar;
+    CUDAState cuda;
+    DBDMAState dbdma;
+    ESCCState escc;
+    MemoryRegion *pic_mem;
+    uint64_t frequency;
+} MacIOState;
+
+#define TYPE_OLDWORLD_MACIO "macio-oldworld"
+#define OLDWORLD_MACIO(obj) \
+    OBJECT_CHECK(OldWorldMacIOState, (obj), TYPE_OLDWORLD_MACIO)
+
+typedef struct OldWorldMacIOState {
+    /*< private >*/
+    MacIOState parent_obj;
+    /*< public >*/
+
+    qemu_irq irqs[7];
+
+    MacIONVRAMState nvram;
+    MACIOIDEState ide[2];
+} OldWorldMacIOState;
+
+#define TYPE_NEWWORLD_MACIO "macio-newworld"
+#define NEWWORLD_MACIO(obj) \
+    OBJECT_CHECK(NewWorldMacIOState, (obj), TYPE_NEWWORLD_MACIO)
+
+typedef struct NewWorldMacIOState {
+    /*< private >*/
+    MacIOState parent_obj;
+    /*< public >*/
+    qemu_irq irqs[7];
+    MACIOIDEState ide[2];
+} NewWorldMacIOState;
+
+#endif /* MACIO_H */
-- 
2.11.0
