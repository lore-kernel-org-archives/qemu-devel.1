Received: from eggs.gnu.org ([2001:4830:134:3::10]:47476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintZ-0005im-4z
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintY-0003T2-0K
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36954
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eintX-0003SN-K4
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:43 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15KxWTj080085
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 16:01:40 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fxwe037f3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:01:39 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 16:01:38 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:57:21 -0500
In-Reply-To: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1517864246-11101-8-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 07/12] s390-ccw: set up interactive boot
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

Reads boot menu flag and timeout values from the iplb and
sets the respective fields for the menu.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile |  2 +-
 pc-bios/s390-ccw/main.c   | 24 ++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.c   | 26 ++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h   | 23 +++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
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
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 825a1a3..76d58cc 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -11,6 +11,7 @@
 #include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "menu.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
@@ -18,6 +19,9 @@ IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 
+#define LOADPARM_PROMPT "PROMPT  "
+#define LOADPARM_EMPTY  "........"
+
 /*
  * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
@@ -74,6 +78,25 @@ static bool find_dev(Schib *schib, int dev_no)
     return false;
 }
 
+static void menu_setup(void)
+{
+    if (memcmp(loadparm, LOADPARM_PROMPT, 8) == 0) {
+        menu_set_parms(BOOT_MENU_FLAG_CMD_OPTS, 0);
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
+        menu_set_parms(qipl.boot_menu_flags, qipl.boot_menu_timeout);
+        return;
+    }
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
@@ -117,6 +140,7 @@ static void virtio_setup(void)
         default:
             panic("List-directed IPL not supported yet!\n");
         }
+        menu_setup();
     } else {
         for (ssid = 0; ssid < 0x3; ssid++) {
             blk_schid.ssid = ssid;
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
new file mode 100644
index 0000000..e87aec6
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU S390 Interactive Boot Menu
+ *
+ * Copyright 2018 IBM Corp.
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
index 0000000..6ff9a0e
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU S390 Interactive Boot Menu
+ *
+ * Copyright 2018 IBM Corp.
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
+#define BOOT_MENU_FLAG_CMD_OPTS  0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
+void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
+bool menu_check_flags(uint8_t check_flags);
+
+#endif /* MENU_H */
-- 
2.7.4
