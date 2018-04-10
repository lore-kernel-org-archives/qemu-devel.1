Received: from eggs.gnu.org ([2001:4830:134:3::10]:32919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f5umF-00014C-Tv
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1f5umE-0000Qx-U4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36398
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1f5umE-0000QV-P4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:01:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3AF149u024061
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 11:01:42 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h8wtd5wg7-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 11:01:40 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 10 Apr 2018 09:01:37 -0600
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 10 Apr 2018 11:01:25 -0400
In-Reply-To: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1523372486-13190-4-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 3/4] pc-bios/s390-ccw: fix non-sequential boot
 entries (eckd)
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

zIPL boot menu entries can be non-sequential. Let's account
for this issue for the s390 zIPL boot menu. Since this boot
menu is actually an imitation and is not completely capable
of everything the real zIPL menu can do, let's also print a
different banner to the user.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reported-by: Vasily Gorbik <gor@linux.ibm.com>
---
 pc-bios/s390-ccw/menu.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 96eec81..083405f 100644
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
@@ -176,21 +177,28 @@ static int get_boot_index(int entries)
     return boot_index;
 }
 
-static void zipl_println(const char *data, size_t len)
+static void zipl_println(const char *data, size_t len, bool *valid_entries)
 {
     char buf[len + 2];
+    int entry;
 
     ebcdic_to_ascii(data, buf, len);
     buf[len] = '\n';
     buf[len + 1] = '\0';
 
     sclp_print(buf);
+
+    entry = buf[0] == ' ' ? atoui(buf + 1) : atoui(buf);
+    valid_entries[entry] = true;
+
+    if (entry == 0)
+        sclp_print("\n");
 }
 
 int menu_get_zipl_boot_index(const char *menu_data)
 {
     size_t len;
-    int entries;
+    bool valid_entries[MAX_BOOT_ENTRIES] = {false};
     uint16_t zipl_flag = *(uint16_t *)(menu_data - ZIPL_FLAG_OFFSET);
     uint16_t zipl_timeout = *(uint16_t *)(menu_data - ZIPL_TIMEOUT_OFFSET);
 
@@ -202,19 +210,19 @@ int menu_get_zipl_boot_index(const char *menu_data)
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
+        zipl_println(menu_data, len, valid_entries);
         menu_data += len + 1;
-
-        if (entries < 2) {
-            sclp_print("\n");
-        }
     }
 
     sclp_print("\n");
-    return get_boot_index(entries - 1); /* subtract 1 to exclude banner */
+    return get_boot_index(valid_entries);
 }
 
 
-- 
2.7.4
