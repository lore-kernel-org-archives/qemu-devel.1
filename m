Received: from eggs.gnu.org ([2001:4830:134:3::10]:43491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoB4-00071U-40
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoAz-0005Qk-7s
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emoAz-0005QJ-3X
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GM5552018555
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:16 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g63tggskk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:15 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 17:08:13 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 17:07:56 -0500
In-Reply-To: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1518818879-18608-10-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 09/12] s390-ccw: print zipl boot menu
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

When the boot menu options are present and the guest's
disk has been configured by the zipl tool, then the user
will be presented with an interactive boot menu with
labeled entries. An example of what the menu might look
like:

zIPL v1.37.1-build-20170714 interactive boot menu.

  0. default (linux-4.13.0)

  1. linux-4.13.0
  2. performance
  3. kvm

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 5790e0c..9631ac0 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -10,13 +10,60 @@
  */
 
 #include "menu.h"
+#include "s390-ccw.h"
+
+/* Offsets from zipl fields to zipl banner start */
+#define ZIPL_TIMEOUT_OFFSET 138
+#define ZIPL_FLAG_OFFSET    140
 
 static uint8_t flags;
 static uint64_t timeout;
 
+static int get_boot_index(int entries)
+{
+    return 0; /* Implemented next patch */
+}
+
+static void zipl_println(const char *data, size_t len)
+{
+    char buf[len + 2];
+
+    ebcdic_to_ascii(data, buf, len);
+    buf[len] = '\n';
+    buf[len + 1] = '\0';
+
+    sclp_print(buf);
+}
+
 int menu_get_zipl_boot_index(const void *stage2, int offset)
 {
-    return 0; /* implemented next patch */
+    const char *data = stage2 + offset;
+    uint16_t zipl_flag = *(uint16_t *)(data - ZIPL_FLAG_OFFSET);
+    uint16_t zipl_timeout = *(uint16_t *)(data - ZIPL_TIMEOUT_OFFSET);
+    size_t len;
+    int ct;
+
+    if (flags & BOOT_MENU_FLAG_ZIPL_OPTS) {
+        if (!zipl_flag) {
+            return 0; /* Boot default */
+        }
+        timeout = zipl_timeout * 1000;
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
+    return get_boot_index(ct - 1);
 }
 
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
-- 
2.7.4
