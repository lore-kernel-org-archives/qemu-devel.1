Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f87Qn-0005Ea-PW
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f87Qj-0001Hg-FJ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:56:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39944
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f87Qj-0001HS-98
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:56:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3GGkKXB001262
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 12:56:36 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hcxhb40s0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 12:56:36 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 16 Apr 2018 10:56:35 -0600
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 16 Apr 2018 12:56:08 -0400
In-Reply-To: <1523897770-30155-1-git-send-email-walling@linux.ibm.com>
References: <1523897770-30155-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1523897770-30155-3-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/4] pc-bios/s390-ccw: fix loadparm
 initialization and int conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

Rename the loadparm char array in main.c to loadparm_str and
increased the size by one byte to account for a null termination
when converting the loadparm string to an int  via atoui. We
also allow the boot menu to be enabled when loadparm is set to
an empty string or a series of spaces.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/ipl.c          |  4 ++++
 pc-bios/s390-ccw/main.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fdeaec3..8907136 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -352,6 +352,10 @@ int s390_ipl_set_loadparm(uint8_t *loadparm)
             loadparm[i] = ascii2ebcdic[(uint8_t) lp[i]];
         }
 
+        if (i < 8) {
+            memset(loadparm + i, 0x40, 8 - i); /* fill with EBCDIC spaces */
+        }
+
         g_free(lp);
         return 0;
     }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 9d9f8cf..26f9adf 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -15,11 +15,11 @@
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
-static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+static char loadparm_str[9] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 
 #define LOADPARM_PROMPT "PROMPT  "
-#define LOADPARM_EMPTY  "........"
+#define LOADPARM_EMPTY  "        "
 #define BOOT_MENU_FLAG_MASK (QIPL_FLAG_BM_OPTS_CMD | QIPL_FLAG_BM_OPTS_ZIPL)
 
 /*
@@ -45,7 +45,7 @@ void panic(const char *string)
 
 unsigned int get_loadparm_index(void)
 {
-    return atoui(loadparm);
+    return atoui(loadparm_str);
 }
 
 static bool find_dev(Schib *schib, int dev_no)
@@ -80,13 +80,13 @@ static bool find_dev(Schib *schib, int dev_no)
 
 static void menu_setup(void)
 {
-    if (memcmp(loadparm, LOADPARM_PROMPT, 8) == 0) {
+    if (memcmp(loadparm_str, LOADPARM_PROMPT, 8) == 0) {
         menu_set_parms(QIPL_FLAG_BM_OPTS_CMD, 0);
         return;
     }
 
     /* If loadparm was set to any other value, then do not enable menu */
-    if (memcmp(loadparm, LOADPARM_EMPTY, 8) != 0) {
+    if (memcmp(loadparm_str, LOADPARM_EMPTY, 8) != 0) {
         return;
     }
 
@@ -116,8 +116,8 @@ static void virtio_setup(void)
      */
     enable_mss_facility();
 
-    sclp_get_loadparm_ascii(loadparm);
-    memcpy(ldp + 10, loadparm, 8);
+    sclp_get_loadparm_ascii(loadparm_str);
+    memcpy(ldp + 10, loadparm_str, 8);
     sclp_print(ldp);
 
     memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
-- 
2.7.4
