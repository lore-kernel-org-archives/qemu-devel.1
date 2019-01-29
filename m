Received: from eggs.gnu.org ([209.51.188.92]:60398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSk-0000Dy-Ii
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSj-0000Ru-LJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSj-0000RJ-Ah
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDRKPW141124
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:30:00 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qanm579e0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:57 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:33 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:11 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-5-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 04/15] s390-bios: Extend find_dev() for
 non-virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

We need a method for finding the subchannel of a dasd device. Let's
modify find_dev to handle this since it mostly does what we need. Up to
this point find_dev has been specific to only virtio devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 67df421..7e3f65e 100644
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
