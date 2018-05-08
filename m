Received: from eggs.gnu.org ([2001:4830:134:3::10]:37757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fG3Oi-0007Cy-TD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fG3Od-0000Wp-92
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:15:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fG3Od-0000WY-0D
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:15:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48EBe2V045090
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 10:15:13 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hubreny4b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:15:13 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 8 May 2018 15:15:11 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue,  8 May 2018 16:15:06 +0200
Message-Id: <20180508141506.56480-1-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] s390x/ipl: Try to detect Linux vs non Linux
 for initial IPL PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>

Right now the IPL device always starts from address 0x10000 (the usual
Linux entry point). To run other guests (e.g. test programs) it is
useful to use the IPL PSW from address 0. We can use the Linux magic
at 0x10008 to decide.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 hw/s390x/ipl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 150f6c0582..c0fed26f03 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -104,7 +104,9 @@ static uint64_t bios_translate_addr(void *opaque, uint64_t srcaddr)
 static void s390_ipl_realize(DeviceState *dev, Error **errp)
 {
     S390IPLState *ipl = S390_IPL(dev);
-    uint64_t pentry = KERN_IMAGE_START;
+    uint64_t *iplpsw;
+    uint64_t pentry;
+    char *magic;
     int kernel_size;
     Error *err = NULL;
 
@@ -156,6 +158,17 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                                NULL, 1, EM_S390, 0, 0);
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
+            /* if this is Linux use KERN_IMAGE_START */
+            magic = rom_ptr(0x10008);
+            if (magic && !memcmp(magic, "S390EP", 6)) {
+                pentry = KERN_IMAGE_START;
+            } else {
+                /* if not Linux use the IPL PSW */
+                iplpsw = rom_ptr(0);
+                if (iplpsw) {
+                    pentry = *iplpsw & 0x7fffffffUL;
+                }
+            }
         }
         if (kernel_size < 0) {
             error_setg(&err, "could not load kernel '%s'", ipl->kernel);
-- 
2.14.2
