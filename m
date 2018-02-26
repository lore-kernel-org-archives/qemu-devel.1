Received: from eggs.gnu.org ([2001:4830:134:3::10]:43960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqGFY-0005H8-DS
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqGFX-0002aZ-Gv
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:43:16 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 26 Feb 2018 11:42:32 +0100
Message-Id: <1519641757-12396-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1519641757-12396-1-git-send-email-thuth@redhat.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL-for-s390x 09/14] s390-ccw: print zipl boot menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

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
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index c1d242f..730d44e 100644
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
1.8.3.1
