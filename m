Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb818-0000DP-PI
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb817-0001dB-4M
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb816-0001ax-Kt
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNfp1022048
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:26:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1qb18xs1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:26:03 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:26:02 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:40 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-13-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 12/15] s390-bios: Use control unit type to
 determine boot method
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

The boot method is different depending on which device type we are
booting from. Let's examine the control unit type to determine if we're
a virtio device. We'll eventually add a case to check for a real dasd device
here as well.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 20c30c6..e4236c0 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -204,9 +204,16 @@ int main(void)
     cio_setup();
     boot_setup();
     find_boot_device();
+    enable_subchannel(blk_schid);
 
-    virtio_setup();
-    zipl_load(); /* no return */
+    switch (cu_type(blk_schid)) {
+    case 0x3832:  /* Virtio device */
+        virtio_setup();
+        zipl_load(); /* no return */
+        break;
+    default:
+        panic("Attempting to boot from unexpected device type\n");
+    }
 
     panic("Failed to load OS from hard disk\n");
     return 0; /* make compiler happy */
-- 
2.7.4
