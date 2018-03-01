Received: from eggs.gnu.org ([2001:4830:134:3::10]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNqv-0003os-8k
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNqu-0007EA-76
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:29 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:41 +0100
Message-Id: <20180301130201.24666-8-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/27] s390-ccw: set up interactive boot menu
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, "Collin L. Walling" <walling@linux.vnet.ibm.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

Reads boot menu flag and timeout values from the iplb and
sets the respective fields for the menu.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile   |  2 +-
 pc-bios/s390-ccw/main.c     | 24 ++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.c     | 22 ++++++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |  3 +++
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/s390-ccw/menu.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 9f7904fc20..1712c2d95d 100644
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
index e41b264a6f..32ed70ebdd 100644
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
index 0000000000..1ce33ddf3d
--- /dev/null
+++ b/pc-bios/s390-ccw/menu.c
@@ -0,0 +1,22 @@
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
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 25d4d213ea..6cfd4b2183 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -84,6 +84,9 @@ ulong get_second(void);
 /* bootmap.c */
 void zipl_load(void);
 
+/* menu.c */
+void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
+
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
-- 
2.13.6
