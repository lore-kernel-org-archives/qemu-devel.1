Received: from eggs.gnu.org ([209.51.188.92]:43883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3Sg-0007hl-Ms
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3Se-00056Z-Ni
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hC3Sb-0004m9-MH
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34EQYFH005540
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 10:35:16 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnk2m2wnx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:35:14 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 4 Apr 2019 15:35:12 +0100
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  4 Apr 2019 10:34:35 -0400
In-Reply-To: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1554388475-18329-17-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v6 16/16] s390-bios: Use control unit type to
 find bootable devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

When the user does not specify which device to boot from then we end
up guessing. Instead of simply grabbing the first available device let's
be a little bit smarter and only choose devices that might be bootable
like disk, and not console devices.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 3c449ad..03e90e3 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -21,6 +21,7 @@ static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
+static uint16_t cutype;
 LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
 
 #define LOADPARM_PROMPT "PROMPT  "
@@ -58,6 +59,9 @@ unsigned int get_loadparm_index(void)
  * subchannel information block (schib) with the connected subchannel's info.
  * NOTE: The global variable blk_schid is updated to contain the subchannel
  * information.
+ *
+ * If the caller gives dev_no=-1 then the user did not specify a boot device.
+ * In this case we'll just use the first potentially bootable device we find.
  */
 static bool find_subch(int dev_no)
 {
@@ -74,16 +78,33 @@ static bool find_subch(int dev_no)
             continue;
         }
 
-        /* Skip net devices since no IPLB is created and therefore no
-         * network bootloader has been loaded
-         */
         enable_subchannel(blk_schid);
-        if (virtio_is_supported(blk_schid) &&
-            virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
-            continue;
+        cutype = cu_type(blk_schid);
+
+        /* No specific devno given, just return 1st possibly bootable device */
+        if (dev_no < 0) {
+            switch (cutype) {
+            case CU_TYPE_VIRTIO:
+                if (virtio_is_supported(blk_schid)) {
+                    /*
+                     * Skip net devices since no IPLB is created and therefore
+                     * no network bootloader has been loaded
+                     */
+                    if (virtio_get_device_type() != VIRTIO_ID_NET) {
+                        return true;
+                    }
+                }
+                continue;
+            case CU_TYPE_DASD_3990:
+            case CU_TYPE_DASD_2107:
+                return true;
+            default:
+                continue;
+            }
         }
 
-        if ((dev_no < 0) || (schib.pmcw.dev == dev_no)) {
+        /* Caller asked for a specific devno */
+        if (schib.pmcw.dev == dev_no) {
             return true;
         }
     }
@@ -200,15 +221,12 @@ static void virtio_setup(void)
 
 int main(void)
 {
-    uint16_t cutype;
-
     sclp_setup();
     css_setup();
     boot_setup();
     find_boot_device();
     enable_subchannel(blk_schid);
 
-    cutype = cu_type(blk_schid);
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-- 
2.7.4
