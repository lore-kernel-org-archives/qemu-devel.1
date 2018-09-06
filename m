Received: from eggs.gnu.org ([2001:4830:134:3::10]:41407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIn-0008Eq-Dk
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxnIj-0008QQ-UI
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 01:58:01 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  6 Sep 2018 06:57:34 +0100
Message-Id: <20180906055736.20256-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/3] scsi: move lsi53c895a structures and
 defines into separate lsi53c895a.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, thuth@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

There is also one small change to the new header file which is the addition
of the previously missing LSI53C810 define.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/lsi53c895a.c         | 116 +-----------------------------------
 include/hw/scsi/lsi53c895a.h | 137 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 115 deletions(-)
 create mode 100644 include/hw/scsi/lsi53c895a.h

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 955ba94800..edb0b13e23 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -18,6 +18,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
+#include "hw/scsi/lsi53c895a.h"
 #include "sysemu/dma.h"
 #include "qemu/log.h"
 
@@ -186,124 +187,9 @@ static const char *names[] = {
 #define PHASE_MI          7
 #define PHASE_MASK        7
 
-/* Maximum length of MSG IN data.  */
-#define LSI_MAX_MSGIN_LEN 8
-
 /* Flag set if this is a tagged command.  */
 #define LSI_TAG_VALID     (1 << 16)
 
-typedef struct lsi_request {
-    SCSIRequest *req;
-    uint32_t tag;
-    uint32_t dma_len;
-    uint8_t *dma_buf;
-    uint32_t pending;
-    int out;
-    QTAILQ_ENTRY(lsi_request) next;
-} lsi_request;
-
-typedef struct {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    MemoryRegion mmio_io;
-    MemoryRegion ram_io;
-    MemoryRegion io_io;
-    AddressSpace pci_io_as;
-
-    int carry; /* ??? Should this be an a visible register somewhere?  */
-    int status;
-    /* Action to take at the end of a MSG IN phase.
-       0 = COMMAND, 1 = disconnect, 2 = DATA OUT, 3 = DATA IN.  */
-    int msg_action;
-    int msg_len;
-    uint8_t msg[LSI_MAX_MSGIN_LEN];
-    /* 0 if SCRIPTS are running or stopped.
-     * 1 if a Wait Reselect instruction has been issued.
-     * 2 if processing DMA from lsi_execute_script.
-     * 3 if a DMA operation is in progress.  */
-    int waiting;
-    SCSIBus bus;
-    int current_lun;
-    /* The tag is a combination of the device ID and the SCSI tag.  */
-    uint32_t select_tag;
-    int command_complete;
-    QTAILQ_HEAD(, lsi_request) queue;
-    lsi_request *current;
-
-    uint32_t dsa;
-    uint32_t temp;
-    uint32_t dnad;
-    uint32_t dbc;
-    uint8_t istat0;
-    uint8_t istat1;
-    uint8_t dcmd;
-    uint8_t dstat;
-    uint8_t dien;
-    uint8_t sist0;
-    uint8_t sist1;
-    uint8_t sien0;
-    uint8_t sien1;
-    uint8_t mbox0;
-    uint8_t mbox1;
-    uint8_t dfifo;
-    uint8_t ctest2;
-    uint8_t ctest3;
-    uint8_t ctest4;
-    uint8_t ctest5;
-    uint8_t ccntl0;
-    uint8_t ccntl1;
-    uint32_t dsp;
-    uint32_t dsps;
-    uint8_t dmode;
-    uint8_t dcntl;
-    uint8_t scntl0;
-    uint8_t scntl1;
-    uint8_t scntl2;
-    uint8_t scntl3;
-    uint8_t sstat0;
-    uint8_t sstat1;
-    uint8_t scid;
-    uint8_t sxfer;
-    uint8_t socl;
-    uint8_t sdid;
-    uint8_t ssid;
-    uint8_t sfbr;
-    uint8_t stest1;
-    uint8_t stest2;
-    uint8_t stest3;
-    uint8_t sidl;
-    uint8_t stime0;
-    uint8_t respid0;
-    uint8_t respid1;
-    uint32_t mmrs;
-    uint32_t mmws;
-    uint32_t sfs;
-    uint32_t drs;
-    uint32_t sbms;
-    uint32_t dbms;
-    uint32_t dnad64;
-    uint32_t pmjad1;
-    uint32_t pmjad2;
-    uint32_t rbc;
-    uint32_t ua;
-    uint32_t ia;
-    uint32_t sbc;
-    uint32_t csbc;
-    uint32_t scratch[18]; /* SCRATCHA-SCRATCHR */
-    uint8_t sbr;
-    uint32_t adder;
-
-    /* Script ram is stored as 32-bit words in host byteorder.  */
-    uint32_t script_ram[2048];
-} LSIState;
-
-#define TYPE_LSI53C810  "lsi53c810"
-#define TYPE_LSI53C895A "lsi53c895a"
-
-#define LSI53C895A(obj) \
-    OBJECT_CHECK(LSIState, (obj), TYPE_LSI53C895A)
 
 static inline int lsi_irq_on_rsl(LSIState *s)
 {
diff --git a/include/hw/scsi/lsi53c895a.h b/include/hw/scsi/lsi53c895a.h
new file mode 100644
index 0000000000..d80cb78c69
--- /dev/null
+++ b/include/hw/scsi/lsi53c895a.h
@@ -0,0 +1,137 @@
+/*
+ * QEMU LSI53C895A SCSI Host Bus Adapter emulation
+ *
+ * Copyright (c) 2006 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the LGPL.
+ */
+
+#ifndef LSI_H
+#define LSI_H
+
+#include "qemu/osdep.h"
+
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "hw/scsi/scsi.h"
+
+/* Maximum length of MSG IN data.  */
+#define LSI_MAX_MSGIN_LEN 8
+
+typedef struct lsi_request {
+    SCSIRequest *req;
+    uint32_t tag;
+    uint32_t dma_len;
+    uint8_t *dma_buf;
+    uint32_t pending;
+    int out;
+    QTAILQ_ENTRY(lsi_request) next;
+} lsi_request;
+
+typedef struct {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion mmio_io;
+    MemoryRegion ram_io;
+    MemoryRegion io_io;
+    AddressSpace pci_io_as;
+
+    int carry; /* ??? Should this be an a visible register somewhere?  */
+    int status;
+    /* Action to take at the end of a MSG IN phase.
+       0 = COMMAND, 1 = disconnect, 2 = DATA OUT, 3 = DATA IN.  */
+    int msg_action;
+    int msg_len;
+    uint8_t msg[LSI_MAX_MSGIN_LEN];
+    /* 0 if SCRIPTS are running or stopped.
+     * 1 if a Wait Reselect instruction has been issued.
+     * 2 if processing DMA from lsi_execute_script.
+     * 3 if a DMA operation is in progress.  */
+    int waiting;
+    SCSIBus bus;
+    int current_lun;
+    /* The tag is a combination of the device ID and the SCSI tag.  */
+    uint32_t select_tag;
+    int command_complete;
+    QTAILQ_HEAD(, lsi_request) queue;
+    lsi_request *current;
+
+    uint32_t dsa;
+    uint32_t temp;
+    uint32_t dnad;
+    uint32_t dbc;
+    uint8_t istat0;
+    uint8_t istat1;
+    uint8_t dcmd;
+    uint8_t dstat;
+    uint8_t dien;
+    uint8_t sist0;
+    uint8_t sist1;
+    uint8_t sien0;
+    uint8_t sien1;
+    uint8_t mbox0;
+    uint8_t mbox1;
+    uint8_t dfifo;
+    uint8_t ctest2;
+    uint8_t ctest3;
+    uint8_t ctest4;
+    uint8_t ctest5;
+    uint8_t ccntl0;
+    uint8_t ccntl1;
+    uint32_t dsp;
+    uint32_t dsps;
+    uint8_t dmode;
+    uint8_t dcntl;
+    uint8_t scntl0;
+    uint8_t scntl1;
+    uint8_t scntl2;
+    uint8_t scntl3;
+    uint8_t sstat0;
+    uint8_t sstat1;
+    uint8_t scid;
+    uint8_t sxfer;
+    uint8_t socl;
+    uint8_t sdid;
+    uint8_t ssid;
+    uint8_t sfbr;
+    uint8_t stest1;
+    uint8_t stest2;
+    uint8_t stest3;
+    uint8_t sidl;
+    uint8_t stime0;
+    uint8_t respid0;
+    uint8_t respid1;
+    uint32_t mmrs;
+    uint32_t mmws;
+    uint32_t sfs;
+    uint32_t drs;
+    uint32_t sbms;
+    uint32_t dbms;
+    uint32_t dnad64;
+    uint32_t pmjad1;
+    uint32_t pmjad2;
+    uint32_t rbc;
+    uint32_t ua;
+    uint32_t ia;
+    uint32_t sbc;
+    uint32_t csbc;
+    uint32_t scratch[18]; /* SCRATCHA-SCRATCHR */
+    uint8_t sbr;
+    uint32_t adder;
+
+    /* Script ram is stored as 32-bit words in host byteorder.  */
+    uint32_t script_ram[2048];
+} LSIState;
+
+#define TYPE_LSI53C810  "lsi53c810"
+#define LSI53C810(obj) \
+    OBJECT_CHECK(LSIState, (obj), TYPE_LSI53C810)
+
+#define TYPE_LSI53C895A "lsi53c895a"
+#define LSI53C895A(obj) \
+    OBJECT_CHECK(LSIState, (obj), TYPE_LSI53C895A)
+
+#endif
-- 
2.11.0
