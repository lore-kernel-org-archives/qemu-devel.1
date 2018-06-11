Received: from eggs.gnu.org ([2001:4830:134:3::10]:44179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSNFM-0003NH-3M
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSNFH-0003YA-7q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:52:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56606
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSNFH-0003Xu-2B
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:52:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5BDmpxa073576
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 09:52:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jht7qrc78-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 09:52:29 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Jun 2018 14:52:28 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Jun 2018 15:52:23 +0200
Message-Id: <20180611135223.81865-1-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 1/1] s390x/ipl: Try to detect Linux vs non
 Linux for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>

Right now the IPL device always starts from address 0x10000 (the usual
Linux entry point). To run other guests (e.g. test programs) it is
useful to use the IPL PSW from address 0. We can use the Linux magic
at 0x10008 to decide.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
v1->v2:
	- use LINUX_MAGIC_ADDR define
	- use assert for valid iplpsw pointer
	- add endianess conversion
 hw/s390x/ipl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 04245b5258..3790153fa9 100644
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
+    uint64_t *iplpsw;
+    uint64_t pentry;
+    char *magic;
     int kernel_size;
     Error *err = NULL;
 
@@ -157,6 +160,16 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                                NULL, 1, EM_S390, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
+            /* if this is Linux use KERN_IMAGE_START */
+            magic = rom_ptr(LINUX_MAGIC_ADDR);
+            if (magic && !memcmp(magic, "S390EP", 6)) {
+                pentry = KERN_IMAGE_START;
+            } else {
+                /* if not Linux use the IPL PSW */
+                iplpsw = rom_ptr(0);
+                assert(iplpsw);
+                pentry = be64_to_cpu(*iplpsw) & 0x7fffffffUL;
+            }
         }
         if (kernel_size < 0) {
             error_setg(&err, "could not load kernel '%s'", ipl->kernel);
-- 
2.17.0
