Received: from eggs.gnu.org ([2001:4830:134:3::10]:53217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJOVF-000696-PI
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJOVC-0005LZ-Mr
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57675
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJOVC-0005L9-Gx
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 13:51:34 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARIn899018303
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:51:33 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egp8jx3sb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 13:51:32 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 13:51:31 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 13:50:59 -0500
In-Reply-To: <1511808659-8846-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1511808659-8846-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1511808659-8846-5-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 4/4] s390-ccw: interactive boot menu for scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Interactive boot menu for scsi. This follows the same procedure
as the interactive menu for eckd dasd. An example follows:

    s390x Enumerated Boot Menu.

    3 entries detected. Select from index 0 to 2.

    Please choose:

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c  |  9 ++++++---
 pc-bios/s390-ccw/menu.c     | 14 ++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 3aea6e0..a917e9d 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -558,15 +558,18 @@ static void ipl_scsi(void)
         }
 
         program_table_entries++;
-        if (program_table_entries == loadparm + 1) {
-            break; /* selected entry found */
-        }
     }
 
     debug_print_int("program table entries", program_table_entries);
 
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
+    if (menu_is_enabled()) {
+        loadparm = menu_get_enum_boot_index(program_table_entries);
+    }
+
+    prog_table_entry = (ScsiBlockPtr *)(sec + pte_len * (loadparm + 1));
+
     zipl_run(prog_table_entry); /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 0bd0be6..cb82d61 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -96,6 +96,20 @@ int menu_get_zipl_boot_index(const char *data)
     return menu_get_boot_index(i - 1);
 }
 
+int menu_get_enum_boot_index(int entries)
+{
+    char tmp[4];
+
+    sclp_print("s390x Enumerated Boot Menu.\n\n");
+
+    sclp_print(itostr(entries, tmp));
+    sclp_print(" entries detected. Select from boot index 0 to ");
+    sclp_print(itostr(entries - 1, tmp));
+    sclp_print(".\n\n");
+
+    return menu_get_boot_index(entries);
+}
+
 void menu_enable(uint16_t boot_menu_timeout)
 {
     timeout = boot_menu_timeout;
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 3a9c873..1a410a6 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -89,6 +89,7 @@ void zipl_load(void);
 void menu_enable(uint16_t boot_menu_timeout);
 int menu_is_enabled(void);
 int menu_get_zipl_boot_index(const char *data);
+int menu_get_enum_boot_index(int entries);
 
 static inline void fill_hex(char *out, unsigned char val)
 {
-- 
2.7.4
