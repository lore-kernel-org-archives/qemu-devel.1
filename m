Received: from eggs.gnu.org ([2001:4830:134:3::10]:41841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTNvr-0006NO-Ud
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTNvo-0005MG-Ss
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:48:40 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 14 Jun 2018 10:48:28 +0200
Message-Id: <1528966108-28324-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Optimize the s390-ccw bios
 for size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

Since we're storing the firmware blobs in the QEMU git repository, it
would be nice if the blobs would be a little bit smaller. By using -Os
and -fno-asynchronous-unwind-tables the size of the s390-ccw.img can be
decreased by ca. 4kB, and the size of s390-netboot.img even by ca. 45kB.
The change of speed of the firmware should not really matter compared to
a binary that has been compiled with -O2 since the firmware still starts
very fast.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 439e3cc..f22a5ca 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -13,6 +13,7 @@ OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
 	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o
 
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
+QEMU_CFLAGS += -Os -fno-asynchronous-unwind-tables
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
 QEMU_CFLAGS += $(call cc-option, $(QEMU_CFLAGS), -fno-stack-protector)
-- 
1.8.3.1
