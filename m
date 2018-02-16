Received: from eggs.gnu.org ([2001:4830:134:3::10]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoB7-00072i-4U
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoB2-0005Sw-J4
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emoB2-0005SE-98
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GM6n0F007767
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:19 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g62yw2nrb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:19 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 17:08:17 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 17:07:59 -0500
In-Reply-To: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1518818879-18608-13-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 12/12] s390-ccw: interactive boot menu for
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
index 4c6ccf3..05d3308 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -568,6 +568,10 @@ static void ipl_scsi(void)
     debug_print_int("program table entries", program_table_entries);
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
+    if (menu_check_flags(BOOT_MENU_FLAG_CMD_OPTS)) {
+        loadparm = menu_get_enum_boot_index(program_table_entries);
+    }
+
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index c643a6b..2226871 100644
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
index 14410a8..d104327 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -215,6 +215,20 @@ int menu_get_zipl_boot_index(const void *stage2, int offset)
     return get_boot_index(ct - 1);
 }
 
+int menu_get_enum_boot_index(int entries)
+{
+    char tmp[4];
+
+    sclp_print("s390x Enumerated Boot Menu.\n\n");
+
+    sclp_print(uitoa(entries, tmp, sizeof(tmp)));
+    sclp_print(" entries detected. Select from boot index 0 to ");
+    sclp_print(uitoa(entries - 1, tmp, sizeof(tmp)));
+    sclp_print(".\n\n");
+
+    return get_boot_index(entries);
+}
+
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
 {
     flags = boot_menu_flag;
diff --git a/pc-bios/s390-ccw/menu.h b/pc-bios/s390-ccw/menu.h
index c603de3..790516c 100644
--- a/pc-bios/s390-ccw/menu.h
+++ b/pc-bios/s390-ccw/menu.h
@@ -18,6 +18,7 @@
 #define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
 
 int menu_get_zipl_boot_index(const void *stage2, int offset);
+int menu_get_enum_boot_index(int entries);
 void menu_set_parms(uint8_t boot_menu_flags, uint32_t boot_menu_timeout);
 bool menu_check_flags(uint8_t check_flags);
 
-- 
2.7.4
