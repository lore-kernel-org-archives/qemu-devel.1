Received: from eggs.gnu.org ([2001:4830:134:3::10]:34206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV66-0004TN-G3
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV65-0007Pe-Ge
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:42 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:08 +0200
Message-Id: <20180504072514.8450-10-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] pc-bios/s390-ccw: fix non-sequential boot
 entries (eckd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

From: Collin Walling <walling@linux.ibm.com>

zIPL boot menu entries can be non-sequential. Let's account
for this issue for the s390 zIPL boot menu. Since this boot
menu is actually an imitation and is not completely capable
of everything the real zIPL menu can do, let's also print a
different banner to the user.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 96eec81e84..aaf5d61ae6 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -158,7 +158,7 @@ static void boot_menu_prompt(bool retry)
     }
 }
 
-static int get_boot_index(int entries)
+static int get_boot_index(bool *valid_entries)
 {
     int boot_index;
     bool retry = false;
@@ -168,7 +168,8 @@ static int get_boot_index(int entries)
         boot_menu_prompt(retry);
         boot_index = get_index();
         retry = true;
-    } while (boot_index < 0 || boot_index >= entries);
+    } while (boot_index < 0 || boot_index >= MAX_BOOT_ENTRIES ||
+             !valid_entries[boot_index]);
 
     sclp_print("\nBooting entry #");
     sclp_print(uitoa(boot_index, tmp, sizeof(tmp)));
@@ -176,7 +177,8 @@ static int get_boot_index(int entries)
     return boot_index;
 }
 
-static void zipl_println(const char *data, size_t len)
+/* Returns the entry number that was printed */
+static int zipl_print_entry(const char *data, size_t len)
 {
     char buf[len + 2];
 
@@ -185,12 +187,15 @@ static void zipl_println(const char *data, size_t len)
     buf[len + 1] = '\0';
 
     sclp_print(buf);
+
+    return buf[0] == ' ' ? atoui(buf + 1) : atoui(buf);
 }
 
 int menu_get_zipl_boot_index(const char *menu_data)
 {
     size_t len;
-    int entries;
+    int entry;
+    bool valid_entries[MAX_BOOT_ENTRIES] = {false};
     uint16_t zipl_flag = *(uint16_t *)(menu_data - ZIPL_FLAG_OFFSET);
     uint16_t zipl_timeout = *(uint16_t *)(menu_data - ZIPL_TIMEOUT_OFFSET);
 
@@ -202,19 +207,25 @@ int menu_get_zipl_boot_index(const char *menu_data)
         timeout = zipl_timeout * 1000;
     }
 
-    /* Print and count all menu items, including the banner */
-    for (entries = 0; *menu_data; entries++) {
+    /* Print banner */
+    sclp_print("s390-ccw zIPL Boot Menu\n\n");
+    menu_data += strlen(menu_data) + 1;
+
+    /* Print entries */
+    while (*menu_data) {
         len = strlen(menu_data);
-        zipl_println(menu_data, len);
+        entry = zipl_print_entry(menu_data, len);
         menu_data += len + 1;
 
-        if (entries < 2) {
+        valid_entries[entry] = true;
+
+        if (entry == 0) {
             sclp_print("\n");
         }
     }
 
     sclp_print("\n");
-    return get_boot_index(entries - 1); /* subtract 1 to exclude banner */
+    return get_boot_index(valid_entries);
 }
 
 
-- 
2.14.3
