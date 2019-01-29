Received: from eggs.gnu.org ([209.51.188.92]:60186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSO-0008KD-BD
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSN-00007Y-4e
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSM-00006m-VD
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:39 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDQwiH020025
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:38 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqcv1fkv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:38 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:37 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:14 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-8-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 07/15] s390-bios: Decouple channel i/o logic
 from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Create a separate library for channel i/o related code. This decouples
channel i/o operations from virtio and allows us to make use of them for
the real dasd boot path.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/Makefile        |  2 +-
 pc-bios/s390-ccw/cio.c           | 41 ++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/cio.h           |  3 +++
 pc-bios/s390-ccw/main.c          |  1 +
 pc-bios/s390-ccw/netboot.mak     |  2 +-
 pc-bios/s390-ccw/netmain.c       |  1 +
 pc-bios/s390-ccw/s390-ccw.h      |  1 -
 pc-bios/s390-ccw/virtio-blkdev.c |  1 +
 pc-bios/s390-ccw/virtio.c        | 27 ++------------------------
 9 files changed, 51 insertions(+), 28 deletions(-)
 create mode 100644 pc-bios/s390-ccw/cio.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 1eb316b..12ad9c1 100644
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
index 0000000..095f79b
--- /dev/null
+++ b/pc-bios/s390-ccw/cio.c
@@ -0,0 +1,41 @@
+/*
+ * S390 Channel I/O
+ *
+ * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
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
index a48eee5..7b07d75 100644
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
index 2457752..1bc61b5 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 14e96b2..5eefb7c 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,7 +1,7 @@
 
 SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-NETOBJS := start.o sclp.o virtio.o virtio-net.o jump2ipl.o netmain.o \
+NETOBJS := start.o sclp.o cio.o virtio.o virtio-net.o jump2ipl.o netmain.o \
 	   libnet.a libc.a
 
 LIBC_INC := -nostdinc -I$(SLOF_DIR)/lib/libc/include
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 0392131..5189c0f 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -33,6 +33,7 @@
 #include <pxelinux.h>
 
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 
 #define DEFAULT_BOOT_RETRIES 10
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 241c6d0..b39ee5d 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -72,7 +72,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
 bool virtio_is_supported(SubChannelId schid);
 void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
-int enable_mss_facility(void);
 u64 get_clock(void);
 ulong get_second(void);
 
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 11c5626..d2e7fcd 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -10,6 +10,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "cio.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
 
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cdb66f4..aa9da72 100644
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
2.7.4
