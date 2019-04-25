Received: from eggs.gnu.org ([209.51.188.92]:58380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJw-0003DY-Tc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJv-0003e4-JV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:48 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:20 +0200
Message-Id: <20190425132134.2839-6-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/19] s390-bios: Decouple channel i/o logic
 from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Create a separate library for channel i/o related code. This decouples
channel i/o operations from virtio and allows us to make use of them for
the real dasd boot path.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-6-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile    |  2 +-
 pc-bios/s390-ccw/cio.c       | 44 ++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h       |  3 +++
 pc-bios/s390-ccw/main.c      |  1 +
 pc-bios/s390-ccw/netboot.mak |  2 +-
 pc-bios/s390-ccw/netmain.c   |  1 +
 pc-bios/s390-ccw/s390-ccw.h  |  1 -
 pc-bios/s390-ccw/virtio.c    | 27 ++--------------------
 8 files changed, 53 insertions(+), 28 deletions(-)
 create mode 100644 pc-bios/s390-ccw/cio.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 1eb316b02f1f..12ad9c1d5813 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 .PHONY : all clean build-all
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
+	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o
 
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
diff --git a/pc-bios/s390-ccw/cio.c b/pc-bios/s390-ccw/cio.c
new file mode 100644
index 000000000000..87c6b34e88af
--- /dev/null
+++ b/pc-bios/s390-ccw/cio.c
@@ -0,0 +1,44 @@
+/*
+ * S390 Channel I/O
+ *
+ * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ * Copyright (c) 2019 IBM Corp.
+ *
+ * Author(s): Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+#include "cio.h"
+
+static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
+
+int enable_mss_facility(void)
+{
+    int ret;
+    ChscAreaSda *sda_area = (ChscAreaSda *) chsc_page;
+
+    memset(sda_area, 0, PAGE_SIZE);
+    sda_area->request.length = 0x0400;
+    sda_area->request.code = 0x0031;
+    sda_area->operation_code = 0x2;
+
+    ret = chsc(sda_area);
+    if ((ret == 0) && (sda_area->response.code == 0x0001)) {
+        return 0;
+    }
+    return -EIO;
+}
+
+void enable_subchannel(SubChannelId schid)
+{
+    Schib schib;
+
+    stsch_err(schid, &schib);
+    schib.pmcw.ena = 1;
+    msch(schid, &schib);
+}
diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index ed5b2cbf72db..218fd96ea3a6 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -213,6 +213,9 @@ typedef struct irb {
     __u32 emw[8];
 }  __attribute__ ((packed, aligned(4))) Irb;
 
+int enable_mss_facility(void);
+void enable_subchannel(SubChannelId schid);
+
 /*
  * Some S390 specific IO instructions as inline
  */
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 67df42191b94..10f04c69068f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 14e96b2aa611..5eefb7c28939 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,7 +1,7 @@
 
 SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-NETOBJS := start.o sclp.o virtio.o virtio-net.o jump2ipl.o netmain.o \
+NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o \
 	   libnet.a libc.a
 
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 0392131c27b3..5189c0fc39e5 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -33,6 +33,7 @@
 #include <pxelinux.h>
 
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 
 #define DEFAULT_BOOT_RETRIES 10
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 241c6d0b69be..b39ee5d32314 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -72,7 +72,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
 bool virtio_is_supported(SubChannelId schid);
 void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
-int enable_mss_facility(void);
 u64 get_clock(void);
 ulong get_second(void);
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cdb66f459e15..aa9da7253fb2 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
 #include "bswap.h"
@@ -20,8 +21,6 @@ static VRing block[VIRTIO_MAX_VQS];
 static char ring_area[VIRTIO_RING_SIZE * VIRTIO_MAX_VQS]
                      __attribute__((__aligned__(PAGE_SIZE)));
 
-static char chsc_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
-
 static VDev vdev = {
     .nr_vqs = 1,
     .vrings = block,
@@ -94,14 +93,9 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
 {
     Ccw1 ccw = {};
     CmdOrb orb = {};
-    Schib schib;
     int r;
 
-    /* start command processing */
-    stsch_err(vdev->schid, &schib);
-    /* enable the subchannel for IPL device */
-    schib.pmcw.ena = 1;
-    msch(vdev->schid, &schib);
+    enable_subchannel(vdev->schid);
 
     /* start subchannel command */
     orb.fmt = 1;
@@ -343,20 +337,3 @@ bool virtio_is_supported(SubChannelId schid)
     }
     return false;
 }
-
-int enable_mss_facility(void)
-{
-    int ret;
-    ChscAreaSda *sda_area = (ChscAreaSda *) chsc_page;
-
-    memset(sda_area, 0, PAGE_SIZE);
-    sda_area->request.length = 0x0400;
-    sda_area->request.code = 0x0031;
-    sda_area->operation_code = 0x2;
-
-    ret = chsc(sda_area);
-    if ((ret == 0) && (sda_area->response.code == 0x0001)) {
-        return 0;
-    }
-    return -EIO;
-}
-- 
2.17.2
