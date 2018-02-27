Received: from eggs.gnu.org ([2001:4830:134:3::10]:34960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eql2G-0004vI-6d
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eql2D-0005n9-3d
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:35:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58804
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eql2C-0005mJ-Pt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:35:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RJYc5Z043980
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:35:31 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gdbcu5ujx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:35:30 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 12:35:27 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 14:35:21 -0500
Message-Id: <1519760121-24594-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] s390/ipl: only print boot menu error if
 -boot menu=on was specified
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

While we're at it, remove trailing periods from error
messages.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 798e99a..d7fb33f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -234,7 +234,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     if (!get_boot_device(0)) {
         if (boot_menu) {
             error_report("boot menu requires a bootindex to be specified for "
-                         "the IPL device.");
+                         "the IPL device");
         }
         return;
     }
@@ -250,7 +250,9 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     case S390_IPL_TYPE_QEMU_SCSI:
         break;
     default:
-        error_report("boot menu is not supported for this device type.");
+        if (boot_menu) {
+            error_report("boot menu is not supported for this device type");
+        }
         return;
     }
 
@@ -263,13 +265,13 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     tmp = qemu_opt_get(opts, "splash-time");
 
     if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
-        error_report("splash-time is invalid, forcing it to 0.");
+        error_report("splash-time is invalid, forcing it to 0");
         *timeout = 0;
         return;
     }
 
     if (splash_time > 0xffffffff) {
-        error_report("splash-time is too large, forcing it to max value.");
+        error_report("splash-time is too large, forcing it to max value");
         *timeout = 0xffffffff;
         return;
     }
-- 
2.7.4
