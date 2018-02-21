Received: from eggs.gnu.org ([2001:4830:134:3::10]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaIO-0006tZ-D8
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaHK-0006Rz-Eh
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45824
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaHK-0006RL-3M
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:42:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJfe4V054389
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:42:09 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9cup5mwb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:53 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:53 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:51 -0500
In-Reply-To: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519241752-28083-13-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 12/13] s390-ccw: use zipl values when no
 boot menu options are present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

If no boot menu options are present, then flag the boot menu to
use the zipl options that were set in the zipl configuration file
(and stored on disk by zipl). These options are found at some
offset prior to the start of the zipl boot menu banner. The zipl
timeout value is limited to a 16-bit unsigned integer and stored
as seconds, so we take care to convert it to milliseconds in order
to conform to the rest of the boot menu functionality. This is
limited to CCW devices.

For reference, the zipl configuration file uses the following
fields in the menu section:

      prompt=1      enable the boot menu
      timeout=X     set the timeout to X seconds

To explicitly disregard any boot menu options, then menu=off or
<bootmenu enable='no' ... /> must be specified.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c          |  5 +++++
 hw/s390x/ipl.h          |  1 +
 pc-bios/s390-ccw/iplb.h |  1 +
 pc-bios/s390-ccw/main.c |  3 ++-
 pc-bios/s390-ccw/menu.c | 14 ++++++++++++++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index a176c4a..a0f4f40 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -233,6 +233,11 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
 
     switch (ipl->iplb.pbt) {
     case S390_IPL_TYPE_CCW:
+        /* In the absence of -boot menu, use zipl parameters */
+        if (!qemu_opt_get(opts, "menu")) {
+            *flags |= QIPL_FLAG_BM_OPTS_ZIPL;
+            return;
+        }
         break;
     default:
         error_report("boot menu is not supported for this device type.");
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 3a37924..1a8adc2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -93,6 +93,7 @@ void s390_reipl_request(void);
 
 /* Boot Menu flags */
 #define QIPL_FLAG_BM_OPTS_CMD   0x80
+#define QIPL_FLAG_BM_OPTS_ZIPL  0x40
 
 /*
  * The QEMU IPL Parameters will be stored at absolute address
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 832bb94..7dfce4f 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -76,6 +76,7 @@ extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 
 /* Boot Menu flags */
 #define QIPL_FLAG_BM_OPTS_CMD   0x80
+#define QIPL_FLAG_BM_OPTS_ZIPL  0x40
 
 /*
  * This definition must be kept in sync with the defininition
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 32ed70e..a7473b0 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -20,6 +20,7 @@ QemuIplParameters qipl;
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "........"
+#define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
 
 /*
  * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
@@ -91,7 +92,7 @@ static void menu_setup(void)
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
-        menu_set_parms(qipl.qipl_flags & QIPL_FLAG_BM_OPTS_CMD,
+        menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
         return;
     }
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 4f84bfe..4fc328d 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -18,6 +18,10 @@
 #define KEYCODE_BACKSP '\177'
 #define KEYCODE_ENTER  '\r'
 
+/* Offsets from zipl fields to zipl banner start */
+#define ZIPL_TIMEOUT_OFFSET 138
+#define ZIPL_FLAG_OFFSET    140
+
 #define TOD_CLOCK_MILLISECOND   0x3e8000
 
 #define LOW_CORE_EXTERNAL_INT_ADDR   0x86
@@ -187,6 +191,16 @@ int menu_get_zipl_boot_index(const char *menu_data)
 {
     size_t len;
     int entries;
+    uint16_t zipl_flag = *(uint16_t *)(menu_data - ZIPL_FLAG_OFFSET);
+    uint16_t zipl_timeout = *(uint16_t *)(menu_data - ZIPL_TIMEOUT_OFFSET);
+
+    if (flag == QIPL_FLAG_BM_OPTS_ZIPL) {
+        if (!zipl_flag) {
+            return 0; /* Boot default */
+        }
+        /* zipl stores timeout as seconds */
+        timeout = zipl_timeout * 1000;
+    }
 
     /* Print and count all menu items, including the banner */
     for (entries = 0; *menu_data; entries++) {
-- 
2.7.4
