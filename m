Received: from eggs.gnu.org ([2001:4830:134:3::10]:53757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3IG-0003zg-Im
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3ID-0006Rt-E8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee3ID-0006Rl-9W
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIQHN1140772
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:32 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fp7dg0yay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:32 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:27:31 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:26:51 -0500
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516732013-18272-9-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 08/10] s390-ccw: print zipl boot menu
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
---
 pc-bios/s390-ccw/menu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index de12c73..174285e 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -10,13 +10,62 @@
  */
 
 #include "menu.h"
+#include "s390-ccw.h"
 
 static uint8_t flags;
 static uint64_t timeout;
 
+/* Offsets from zipl fields to zipl banner start */
+#define ZIPL_TIMEOUT_OFFSET 138
+#define ZIPL_FLAG_OFFSET    140
+
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
+    uint16_t flag;
+    size_t len;
+    int ct;
+
+    flag = *(uint16_t *)(data - ZIPL_FLAG_OFFSET);
+
+    if (flags & BOOT_MENU_FLAG_ZIPL_OPTS) {
+        if (flag) {
+            timeout = *(uint16_t *)(data - ZIPL_TIMEOUT_OFFSET);
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
+    return get_boot_index(ct - 1);
 }
 
 void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
-- 
2.7.4
