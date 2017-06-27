Received: from eggs.gnu.org ([2001:4830:134:3::10]:55103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozU-0008S1-DF
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozR-00040s-TQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozR-00040L-Lj
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:20 +0200
Message-Id: <1498564100-10045-15-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 14/14] pc-bios/s390-ccw: Wire up the
 netload code
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

Link the libnet.a to the s390-ccw.elf file, call netload() instead of
the external network boot image, and jump to loaded kernel at address 0,
so that we can finally do a full network boot with the s390-ccw firmware
now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile  |  2 +-
 pc-bios/s390-ccw/bootmap.c | 10 +++++++++-
 pc-bios/s390-ccw/main.c    |  3 +--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 369bd65..827d7be 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 .PHONY : all clean build-all libc.a libnet.a
 
 OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-net.o
-OBJECTS += libc.a sbrk.o
+OBJECTS += libnet.a libc.a sbrk.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 523fa78..32befda 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -11,6 +11,7 @@
 #include "s390-ccw.h"
 #include "bootmap.h"
 #include "virtio.h"
+#include "libnet/netapps.h"
 
 #ifdef DEBUG
 /* #define DEBUG_FALLBACK */
@@ -744,7 +745,14 @@ void zipl_load(void)
     }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
-        jump_to_IPL_code(vdev->netboot_start_addr);
+        long len;
+
+        len = netload();
+        if (len < 0) {
+            panic("Network loading failed");
+        }
+        sclp_print("Netload done, starting kernel...\n");
+        asm volatile (" lpsw 0(%0) " : : "r"(0) : "memory");
     }
 
     ipl_scsi();
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 1cacc1b..b058e1b 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -150,12 +150,11 @@ static void virtio_setup(void)
 
     IPL_assert(found, "No virtio device found");
 
+    virtio_setup_device(blk_schid);
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         sclp_print("Network boot device detected\n");
         vdev->netboot_start_addr = iplb.ccw.netboot_start_addr;
     } else {
-        virtio_setup_device(blk_schid);
-
         IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
     }
 }
-- 
1.8.3.1
