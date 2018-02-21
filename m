Received: from eggs.gnu.org ([2001:4830:134:3::10]:47434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaIJ-0006rt-Er
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaHF-0006MP-D5
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaHF-0006Kv-0C
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:42:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJegRh042481
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:42:03 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9ejrscxa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:55 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:54 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:52 -0500
In-Reply-To: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519241752-28083-14-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 13/13] s390-ccw: interactive boot menu for
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
 hw/s390x/ipl.c              |  1 +
 pc-bios/s390-ccw/bootmap.c  |  4 ++++
 pc-bios/s390-ccw/main.c     |  1 +
 pc-bios/s390-ccw/menu.c     | 14 ++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 5 files changed, 21 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index a0f4f40..566248e 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -238,6 +238,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
             *flags |= QIPL_FLAG_BM_OPTS_ZIPL;
             return;
         }
+    case S390_IPL_TYPE_QEMU_SCSI:
         break;
     default:
         error_report("boot menu is not supported for this device type.");
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 2701ae6..81dbd4a 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -568,6 +568,10 @@ static void ipl_scsi(void)
     debug_print_int("program table entries", program_table_entries);
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
+    if (menu_is_enabled()) {
+        loadparm = menu_get_enum_boot_index(program_table_entries);
+    }
+
     debug_print_int("loadparm", loadparm);
     IPL_assert(loadparm <= MAX_TABLE_ENTRIES, "loadparm value greater than"
                " maximum number of boot entries allowed");
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a7473b0..9d9f8cf 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -92,6 +92,7 @@ static void menu_setup(void)
 
     switch (iplb.pbt) {
     case S390_IPL_TYPE_CCW:
+    case S390_IPL_TYPE_QEMU_SCSI:
         menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
                        qipl.boot_menu_timeout);
         return;
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 4fc328d..16b5310 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -217,6 +217,20 @@ int menu_get_zipl_boot_index(const char *menu_data)
     return get_boot_index(entries - 1); /* subtract 1 to exclude banner */
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
     flag = boot_menu_flag;
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 56b0c2a..cfcaf3c 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -91,6 +91,7 @@ void zipl_load(void);
 void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
 bool menu_is_enabled(void);
 int menu_get_zipl_boot_index(const char *menu_data);
+int menu_get_enum_boot_index(int entries);
 
 static inline void fill_hex(char *out, unsigned char val)
 {
-- 
2.7.4
