Received: from eggs.gnu.org ([2001:4830:134:3::10]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaIA-0006mV-BL
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaH6-00069E-9C
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaH5-00066f-Jy
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:41:55 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJdOLY107193
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:54 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9ds3ujv4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:53 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:52 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:46 -0500
In-Reply-To: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519241752-28083-8-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 07/13] s390-ccw: set up interactive boot
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
 pc-bios/s390-ccw/Makefile   |  2 +-
 pc-bios/s390-ccw/main.c     | 24 ++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.c     | 27 +++++++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |  4 ++++
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/menu.c

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
index e41b264..32ed70e 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -18,6 +18,9 @@ IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 
+#define LOADPARM_PROMPT "PROMPT  "
+#define LOADPARM_EMPTY  "........"
+
 /*
  * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
@@ -74,6 +77,26 @@ static bool find_dev(Schib *schib, int dev_no)
     return false;
 }
 
+static void menu_setup(void)
+{
+    if (memcmp(loadparm, LOADPARM_PROMPT, 8) == 0) {
+        menu_set_parms(QIPL_FLAG_BM_OPTS_CMD, 0);
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
+        menu_set_parms(qipl.qipl_flags & QIPL_FLAG_BM_OPTS_CMD,
+                       qipl.boot_menu_timeout);
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
index 0000000..03d91ea
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.c
@@ -0,0 +1,27 @@
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
+#include "libc.h"
+#include "s390-ccw.h"
+
+static uint8_t flag;
+static uint64_t timeout;
+
+void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
+{
+    flag = boot_menu_flag;
+    timeout = boot_menu_timeout;
+}
+
+bool menu_is_enabled(void)
+{
+    return flag;
+}
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 25d4d21..09cc840 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -84,6 +84,10 @@ ulong get_second(void);
 /* bootmap.c */
 void zipl_load(void);
 
+/* menu.c */
+void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
+bool menu_is_enabled(void);
+
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
-- 
2.7.4
