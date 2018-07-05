Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb80z-00008L-5o
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb80x-0001Gl-4U
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb80w-0001Ej-St
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNhUj024202
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:25:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1qa7s2x7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:25:53 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:25:52 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:32 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-5-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 04/15] s390-bios: Extend find_dev() for
 non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

We need a method for finding the subchannel of a dasd device. Let's
modify find_dev to handle this since it mostly does what we need. Up to
this point find_dev has been specific to only virtio devices.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 8ecab93..30f847f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -49,6 +49,12 @@ unsigned int get_loadparm_index(void)
     return atoui(loadparm_str);
 }
 
+/*
+ * Find the subchannel connected to the given device (dev_no) and fill in the
+ * subchannel information block (schib) with the connected subchannel's info.
+ * NOTE: The global variable blk_schid is updated to contain the subchannel
+ * information.
+ */
 static bool find_dev(Schib *schib, int dev_no)
 {
     int i, r;
@@ -62,15 +68,15 @@ static bool find_dev(Schib *schib, int dev_no)
         if (!schib->pmcw.dnv) {
             continue;
         }
-        if (!virtio_is_supported(blk_schid)) {
-            continue;
-        }
+
         /* Skip net devices since no IPLB is created and therefore no
-         * no network bootloader has been loaded
+         * network bootloader has been loaded
          */
-        if (virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
+        if (virtio_is_supported(blk_schid) &&
+            virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
             continue;
         }
+
         if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
             return true;
         }
-- 
2.7.4
