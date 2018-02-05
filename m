Received: from eggs.gnu.org ([2001:4830:134:3::10]:47637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintg-0005oR-Jn
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintc-0003XF-PE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eintc-0003Wd-HO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15L0auX111974
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 16:01:47 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxwfbbbme-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:01:46 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 16:01:45 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:57:26 -0500
In-Reply-To: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1517864246-11101-13-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 12/12] s390-ccw: interactive boot menu for
 scsi
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

Interactive boot menu for scsi. This follows a similar procedure
as the interactive menu for eckd dasd. An example follows:

    s390x Enumerated Boot Menu.

    3 entries detected. Select from index 0 to 2.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c |  4 ++++
 pc-bios/s390-ccw/main.c    |  1 +
 pc-bios/s390-ccw/menu.c    | 14 ++++++++++++++
 pc-bios/s390-ccw/menu.h    |  1 +
 4 files changed, 20 insertions(+)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index adbef41..13b2936 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -567,6 +567,10 @@ static void ipl_scsi(void)
 
     debug_print_int("program table entries", program_table_entries);
 
+    if (menu_check_flags(BOOT_MENU_FLAG_CMD_OPTS)) {
+        loadparm = menu_get_enum_boot_index(program_table_entries);
+    }
+
     zipl_run(&bmt->bte[loadparm].scsi); /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 76d58cc..3548cd4 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -92,6 +92,7 @@ static void menu_setup(void)
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
+    case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.boot_menu_flags, qipl.boot_menu_timeout);
         return;
     }
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 971f6b6..41a59e3 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -226,6 +226,20 @@ int menu_get_zipl_boot_index(const void *stage2, int offset)
     return get_boot_index(ct - 1);
 }
 
+int menu_get_enum_boot_index(int entries)
+{
+    char tmp[4];
+
+    sclp_print("s390x Enumerated Boot Menu.\n\n");
+
+    sclp_print(itostr(entries, tmp, sizeof(tmp)));
+    sclp_print(" entries detected. Select from boot index 0 to ");
+    sclp_print(itostr(entries - 1, tmp, sizeof(tmp)));
+    sclp_print(".\n\n");
+
+    return get_boot_index(entries);
+}
+
 void menu_set_parms(uint8_t boot_menu_flag, uint16_t boot_menu_timeout)
 {
     flags = boot_menu_flag;
diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
index e8e042f..c08e4cf 100644
--- a/pc-bios/s390-ccw/menu.h
+++ b/pc-bios/s390-ccw/menu.h
@@ -18,6 +18,7 @@
 #define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
 
 int menu_get_zipl_boot_index(const void *stage2, int offset);
+int menu_get_enum_boot_index(int entries);
 void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
 bool menu_check_flags(uint8_t check_flags);
 
-- 
2.7.4
