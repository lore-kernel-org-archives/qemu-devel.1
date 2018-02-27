Received: from eggs.gnu.org ([2001:4830:134:3::10]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqh2V-00056p-Mq
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqh2P-0007Mr-Fg
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:19:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57140
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eqh2P-0007Lw-AI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:19:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RFHa59032720
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:19:28 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd8kqku1y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:19:28 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 08:19:27 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 10:19:20 -0500
Message-Id: <1519744760-12337-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] s390-ccw: only print boot menu error if -boot
 menu=on was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, thuth@redhat.com, mihajlov@linux.vnet.ibm.com

It is possible that certain QEMU configurations may not
create an IPLB (such as when -kernel is provided). In
this case, a misleading error message will be printed
stating that the "boot menu is not supported for this
device type".

To amend this, only print this message iff boot menu=on
was provided on the commandline. Otherwise, return silently.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 798e99a..c4addb5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -250,7 +250,9 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     case S390_IPL_TYPE_QEMU_SCSI:
         break;
     default:
-        error_report("boot menu is not supported for this device type.");
+        if (boot_menu) {
+            error_report("boot menu is not supported for this device type.");
+        }
         return;
     }
 
-- 
2.7.4
