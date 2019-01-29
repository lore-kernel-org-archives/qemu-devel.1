Received: from eggs.gnu.org ([209.51.188.92]:60075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSL-0008Hn-1v
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSK-0008V2-67
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40384
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSJ-0008Tr-Mp
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:29:36 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDQvhA020991
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:34 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qaqhegx4q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:34 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:33 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:10 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-4-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 03/15] s390-bios: decouple common boot logic
 from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Create a boot_setup function to handle getting boot information from
the machine/hypervisor. This decouples common boot logic from the
virtio code path and allows us to make use of it for the real dasd boot
scenario.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index e82fe2c..67df421 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -14,16 +14,17 @@
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
-IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
+IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
+static bool have_iplb;
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
 #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
 
 /*
- * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
+ * Principles of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
  * after list-directed-IPL and ccw-IPL.
  */
@@ -111,23 +112,33 @@ static void css_setup(void)
     enable_mss_facility();
 }
 
+/*
+ * Collect various pieces of information from the hypervisor/hardware that
+ * we'll use to determine exactly how we'll boot.
+ */
+static void boot_setup(void)
+{
+    char lpmsg[] = "LOADPARM=[________]\n";
+
+    sclp_get_loadparm_ascii(loadparm_str);
+    memcpy(lpmsg + 10, loadparm_str, 8);
+    sclp_print(lpmsg);
+
+    have_iplb = store_iplb(&iplb);
+}
+
 static void virtio_setup(void)
 {
     Schib schib;
     int ssid;
     bool found = false;
     uint16_t dev_no;
-    char ldp[] = "LOADPARM=[________]\n";
     VDev *vdev = virtio_get_device();
     QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
 
-    sclp_get_loadparm_ascii(loadparm_str);
-    memcpy(ldp + 10, loadparm_str, LOADPARM_LEN);
-    sclp_print(ldp);
-
     memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
 
-    if (store_iplb(&iplb)) {
+    if (have_iplb) {
         switch (iplb.pbt) {
         case S390_IPL_TYPE_CCW:
             dev_no = iplb.ccw.devno;
@@ -174,6 +185,7 @@ int main(void)
 {
     sclp_setup();
     css_setup();
+    boot_setup();
     virtio_setup();
 
     zipl_load(); /* no return */
-- 
2.7.4
