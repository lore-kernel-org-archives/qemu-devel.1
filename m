Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3IN-00046Y-3i
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3IJ-0006Ug-W8
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee3IJ-0006UN-O5
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIO1Cl009832
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:37 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp780smvm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:36 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:27:36 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:26:53 -0500
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516732013-18272-11-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 10/10] s390-ccw: interactive boot menu for
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

Interactive boot menu for scsi. This follows a similar procedure
as the interactive menu for eckd dasd. An example follows:

    s390x Enumerated Boot Menu.

    3 entries detected. Select from index 0 to 2.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c |  9 +++++++++
 pc-bios/s390-ccw/main.c    |  3 +++
 pc-bios/s390-ccw/menu.c    | 14 ++++++++++++++
 pc-bios/s390-ccw/menu.h    |  1 +
 4 files changed, 27 insertions(+)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 7d7e0c5..87bf6ba 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -537,6 +537,7 @@ static void ipl_scsi(void)
     ScsiMbr *mbr = (void *)sec;
     BootMapTable *bmt = (void *)sec;
     unsigned int loadparm = get_loadparm_index();
+    int entries = 0;
 
     /* Grab the MBR */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -558,6 +559,14 @@ static void ipl_scsi(void)
 
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
+    if (menu_check_flags(BOOT_MENU_FLAG_BOOT_OPTS)) {
+        while (bmt->bte[entries].scsi.blockno) {
+            entries++;
+        }
+        debug_print_int("program table entries", entries);
+        loadparm = menu_get_enum_boot_index(entries);
+    }
+
     debug_print_int("loadparm index", loadparm);
 
     zipl_run(&bmt->bte[loadparm].scsi); /* no return */
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 709e5ef..808d111 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -90,6 +90,9 @@ static void menu_setup(void)
     case S390_IPL_TYPE_CCW:
         menu_set_parms(iplb.ccw.boot_menu_flags, iplb.ccw.boot_menu_timeout);
         return;
+    case S390_IPL_TYPE_QEMU_SCSI:
+        menu_set_parms(iplb.scsi.boot_menu_flags, iplb.scsi.boot_menu_timeout);
+        return;
     }
 }
 
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 24d4bba..9e54346 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -214,6 +214,20 @@ int menu_get_zipl_boot_index(const void *stage2, int offset)
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
index f4a1068..e6788f2 100644
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
