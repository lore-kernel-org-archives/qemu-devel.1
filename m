Received: from eggs.gnu.org ([2001:4830:134:3::10]:47212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaIA-0006ml-N9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaH6-00069Y-EI
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaH5-00067O-VD
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:41:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJetMM112844
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:55 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9ds3ujvr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:54 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:52 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:48 -0500
In-Reply-To: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519241752-28083-10-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 09/13] s390-ccw: print zipl boot menu
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
 pc-bios/s390-ccw/menu.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index ba886be..8f50e55 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -15,11 +15,42 @@
 static uint8_t flag;
 static uint64_t timeout;
 
-int menu_get_zipl_boot_index(const char *menu_data)
+static int get_boot_index(int entries)
 {
     return 0; /* implemented next patch */
 }
 
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
+int menu_get_zipl_boot_index(const char *menu_data)
+{
+    size_t len;
+    int entries;
+
+    /* Print and count all menu items, including the banner */
+    for (entries = 0; *menu_data; entries++) {
+        len = strlen(menu_data);
+        zipl_println(menu_data, len);
+        menu_data += len + 1;
+
+        if (entries < 2) {
+            sclp_print("\n");
+        }
+    }
+
+    sclp_print("\n");
+    return get_boot_index(entries - 1); /* subtract 1 to exclude banner */
+}
+
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
 {
     flag = boot_menu_flag;
-- 
2.7.4
