Received: from eggs.gnu.org ([2001:4830:134:3::10]:57456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sw-00056q-9G
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sr-0002BY-PD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55502
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7sr-0002AV-DI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:17 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGdg06041275
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:16 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgu8rx3bb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:16 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:15 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:23 -0500
In-Reply-To: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516034665-27606-7-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 6/8] s390-ccw: interactive boot menu for
 eckd dasd (print menu)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

Prints the menu data starting from the zIPL menu banner.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c |  3 +--
 pc-bios/s390-ccw/menu.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/menu.h    |  1 +
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index fb8ff80..f894760 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -269,8 +269,7 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
         return 0;
     }
 
-    zipl_parms.menu_start++; /* make compiler happy -- does nothing vital */
-    return 0; /* implemented next patch */
+    return menu_get_zipl_boot_index(s2_cur_blk, zipl_parms);
 }
 
 static void run_eckd_boot_script(block_number_t mbr_block_nr,
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index e15a7f2..30470b3 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -10,10 +10,52 @@
  */
 
 #include "menu.h"
+#include "s390-ccw.h"
 
 static uint8_t flags;
 static uint64_t timeout;
 
+static void zipl_println(const char *data, size_t len)
+{
+    char buf[len + 1];
+
+    ebcdic_to_ascii(data, buf, len);
+    buf[len] = '\n';
+    buf[len + 1] = '\0';
+
+    sclp_print(buf);
+}
+
+int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms)
+{
+    const char *data = stage2 + zipl_parms.menu_start;
+    size_t len;
+    int ct;
+
+    if (flags & BOOT_MENU_FLAG_ZIPL_OPTS) {
+        if (zipl_parms.flag) {
+            timeout = zipl_parms.timeout;
+        } else {
+            return 0; /* Boot default */
+        }
+    }
+
+    /* Print and count all menu items, including the banner */
+    for (ct = 0; *data; ct++) {
+        len = strlen(data);
+        zipl_println(data, len);
+        data += len + 1;
+
+        if (ct < 2) {
+            sclp_print("\n");
+        }
+    }
+
+    sclp_print("\n");
+
+    return 0; /* return user input next patch */
+}
+
 void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
 {
     flags = boot_menu_flag;
diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
index 3a8a487..c6615aa 100644
--- a/pc-bios/s390-ccw/menu.h
+++ b/pc-bios/s390-ccw/menu.h
@@ -27,6 +27,7 @@ typedef struct ZiplParms {
     uint64_t menu_start;
 } ZiplParms;
 
+int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms);
 void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
 bool menu_check_flags(uint8_t check_flags);
 
-- 
2.7.4
