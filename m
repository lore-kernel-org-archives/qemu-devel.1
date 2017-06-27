Received: from eggs.gnu.org ([2001:4830:134:3::10]:54724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyy-0007uW-Vt
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyx-0003hY-Vk
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPoyx-0003gr-NE
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:35 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:10 +0200
Message-Id: <1498564100-10045-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 04/14] pc-bios/s390-ccw: Add implementation
 of sbrk()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

To be able to use malloc() and friends from the SLOF libc, we need to
provide an implementation of the sbrk() function. This patch adds such
an implemenation, which has been taken from the SLOF firmware, too.
Since the sbrk() function uses a big array as the heap, we now also
have got to lower the fwbase in hw/s390x/ipl.c accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c            |  2 +-
 pc-bios/s390-ccw/Makefile |  2 +-
 pc-bios/s390-ccw/sbrk.c   | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 pc-bios/s390-ccw/sbrk.c

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 4e6469d..913eee5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -113,7 +113,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
      * even if an external kernel has been defined.
      */
     if (!ipl->kernel || ipl->enforce_bios) {
-        uint64_t fwbase = (MIN(ram_size, 0x80000000U) - 0x200000) & ~0xffffUL;
+        uint64_t fwbase = (MIN(ram_size, 0x80000000U) - 0x400000) & ~0xffffUL;
 
         if (bios_name == NULL) {
             bios_name = ipl->firmware;
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 3371c5b..8fbefe8 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 .PHONY : all clean build-all libc.a
 
 OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
-OBJECTS += libc.a
+OBJECTS += libc.a sbrk.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/sbrk.c b/pc-bios/s390-ccw/sbrk.c
new file mode 100644
index 0000000..2ec1b5f
--- /dev/null
+++ b/pc-bios/s390-ccw/sbrk.c
@@ -0,0 +1,39 @@
+/******************************************************************************
+ * Copyright (c) 2004, 2008 IBM Corporation
+ * All rights reserved.
+ * This program and the accompanying materials
+ * are made available under the terms of the BSD License
+ * which accompanies this distribution, and is available at
+ * http://www.opensource.org/licenses/bsd-license.php
+ *
+ * Contributors:
+ *     IBM Corporation - initial implementation
+ *****************************************************************************/
+
+#include <unistd.h>
+
+#define HEAP_SIZE 0x200000
+
+
+static char heap[HEAP_SIZE];
+static char *actptr;
+
+void *sbrk(int increment)
+{
+	char *oldptr;
+
+	/* Called for the first time? Then init the actual pointer */
+	if (!actptr) {
+		actptr = heap;
+	}
+
+	if (actptr + increment > heap + HEAP_SIZE) {
+		/* Out of memory */
+		return (void *)-1;
+	}
+
+	oldptr = actptr;
+	actptr += increment;
+
+	return oldptr;
+}
-- 
1.8.3.1
