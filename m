Received: from eggs.gnu.org ([2001:4830:134:3::10]:53732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3IE-0003xv-Hc
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3IB-0006Qp-DN
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee3IB-0006QK-65
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIO2o6013924
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:30 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp9fxt6g3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:29 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:27:28 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:26:49 -0500
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516732013-18272-7-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 06/10] s390-ccw: set up interactive boot
 menu parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

Reads boot menu flag and timeout values from the iplb and
sets the respective fields for the menu.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/Makefile |  2 +-
 pc-bios/s390-ccw/iplb.h   |  3 +++
 pc-bios/s390-ccw/main.c   | 21 +++++++++++++++++++++
 pc-bios/s390-ccw/menu.c   | 26 ++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h   | 23 +++++++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/menu.c
 create mode 100644 pc-bios/s390-ccw/menu.h

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 9f7904f..1712c2d 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o menu.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index fe909d2..da29e6e 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -81,6 +81,9 @@ extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
 
+#define LOADPARM_PROMPT "PROMPT  "
+#define LOADPARM_EMPTY  "........"
+
 static inline bool store_iplb(IplParameterBlock *iplb)
 {
     register unsigned long addr asm("0") = (unsigned long) iplb;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a8ef120..709e5ef 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -11,6 +11,7 @@
 #include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "menu.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
@@ -73,6 +74,25 @@ static bool find_dev(Schib *schib, int dev_no)
     return false;
 }
 
+static void menu_setup(void)
+{
+    if (memcmp(loadparm, LOADPARM_PROMPT, 8) == 0) {
+        menu_set_parms(BOOT_MENU_FLAG_BOOT_OPTS, 0);
+        return;
+    }
+
+    /* If loadparm was set to any other value, then do not enable menu */
+    if (memcmp(loadparm, LOADPARM_EMPTY, 8) != 0) {
+        return;
+    }
+
+    switch (iplb.pbt) {
+    case S390_IPL_TYPE_CCW:
+        menu_set_parms(iplb.ccw.boot_menu_flags, iplb.ccw.boot_menu_timeout);
+        return;
+    }
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
@@ -113,6 +133,7 @@ static void virtio_setup(void)
         default:
             panic("List-directed IPL not supported yet!\n");
         }
+        menu_setup();
     } else {
         for (ssid = 0; ssid < 0x3; ssid++) {
             blk_schid.ssid = ssid;
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
new file mode 100644
index 0000000..e15a7f2
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU S390 Interactive Boot Menu
+ *
+ * Copyright 2017 IBM Corp.
+ * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "menu.h"
+
+static uint8_t flags;
+static uint64_t timeout;
+
+void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
+{
+    flags = boot_menu_flag;
+    timeout = boot_menu_timeout;
+}
+
+int menu_check_flags(uint8_t check_flags)
+{
+    return flags & check_flags;
+}
diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
new file mode 100644
index 0000000..04b1db1
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU S390 Interactive Boot Menu
+ *
+ * Copyright 2017 IBM Corp.
+ * Author: Collin L. Walling <walling@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef MENU_H
+#define MENU_H
+
+#include "libc.h"
+
+#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
+void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
+bool menu_check_flags(uint8_t check_flags);
+
+#endif /* MENU_H */
-- 
2.7.4
