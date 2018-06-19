Received: from eggs.gnu.org ([2001:4830:134:3::10]:41774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNR-000774-IS
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNQ-0001nV-EY
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:26 +0200
Message-Id: <20180619120434.25062-5-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] s390x/ipl: Try to detect Linux vs non
 Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Right now the IPL device always starts from address 0x10000 (the usual
Linux entry point). To run other guests (e.g. test programs) it is
useful to use the IPL PSW from address 0. We can use the Linux magic
at 0x10008 to decide.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20180612125933.262679-1-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 04245b5258..0d67349004 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -29,6 +29,7 @@
 #include "exec/exec-all.h"
 
 #define KERN_IMAGE_START                0x010000UL
+#define LINUX_MAGIC_ADDR                0x010008UL
 #define KERN_PARM_AREA                  0x010480UL
 #define INITRD_START                    0x800000UL
 #define INITRD_PARM_START               0x010408UL
@@ -105,7 +106,9 @@ static uint64_t bios_translate_addr(void *opaque, uint64_t srcaddr)
 static void s390_ipl_realize(DeviceState *dev, Error **errp)
 {
     S390IPLState *ipl = S390_IPL(dev);
-    uint64_t pentry = KERN_IMAGE_START;
+    uint32_t *ipl_psw;
+    uint64_t pentry;
+    char *magic;
     int kernel_size;
     Error *err = NULL;
 
@@ -157,10 +160,24 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                                NULL, 1, EM_S390, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
-        }
-        if (kernel_size < 0) {
-            error_setg(&err, "could not load kernel '%s'", ipl->kernel);
-            goto error;
+            if (kernel_size < 0) {
+                error_setg(&err, "could not load kernel '%s'", ipl->kernel);
+                goto error;
+            }
+            /* if this is Linux use KERN_IMAGE_START */
+            magic = rom_ptr(LINUX_MAGIC_ADDR);
+            if (magic && !memcmp(magic, "S390EP", 6)) {
+                pentry = KERN_IMAGE_START;
+            } else {
+                /* if not Linux load the address of the (short) IPL PSW */
+                ipl_psw = rom_ptr(4);
+                if (ipl_psw) {
+                    pentry = be32_to_cpu(*ipl_psw) & 0x7fffffffUL;
+                } else {
+                    error_setg(&err, "Could not get IPL PSW");
+                    goto error;
+                }
+            }
         }
         /*
          * Is it a Linux kernel (starting at 0x10000)? If yes, we fill in the
-- 
2.14.4
