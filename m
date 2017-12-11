Received: from eggs.gnu.org ([2001:4830:134:3::10]:54685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQi-0001G4-8J
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQd-0001bw-TU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eOWQd-0001b0-Ki
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:03 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBMGIbb069561
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:20:01 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eswubdggt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:20:00 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 17:19:59 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 17:19:20 -0500
In-Reply-To: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1513030760-26245-6-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 5/5] s390-ccw: interactive boot menu for scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com

Interactive boot menu for scsi. This follows the same procedure
as the interactive menu for eckd dasd. An example follows:

    s390x Enumerated Boot Menu.

    3 entries detected. Select from index 0 to 2.

    Please choose:

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c |  9 ++++++---
 pc-bios/s390-ccw/main.c    |  2 ++
 pc-bios/s390-ccw/menu.c    | 14 ++++++++++++++
 pc-bios/s390-ccw/menu.h    |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index c817cf8..78e41ab 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -552,15 +552,18 @@ static void ipl_scsi(void)
         }
 
         program_table_entries++;
-        if (program_table_entries == loadparm + 1) {
-            break; /* selected entry found */
-        }
     }
 
     debug_print_int("program table entries", program_table_entries);
 
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
+    if (menu_check_flags(BOOT_MENU_FLAG_BOOT_OPTS)) {
+        loadparm = menu_get_enum_boot_index(program_table_entries);
+    }
+
+    prog_table_entry = (ScsiBlockPtr *)(sec + pte_len * (loadparm + 1));
+
     zipl_run(prog_table_entry); /* no return */
 }
 
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index fb0ef92..2a697a0 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -112,6 +112,8 @@ static void virtio_setup(void)
             vdev->selected_scsi_device.lun = iplb.scsi.lun;
             blk_schid.ssid = iplb.scsi.ssid & 0x3;
             found = find_dev(&schib, iplb.scsi.devno);
+            menu_set_parms(iplb.scsi.boot_menu_flags,
+                            iplb.scsi.boot_menu_timeout);
             break;
         default:
             panic("List-directed IPL not supported yet!\n");
diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index d707afb..49876c1 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -211,6 +211,20 @@ int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms)
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
index a8727fa..4373b0c 100644
--- a/pc-bios/s390-ccw/menu.h
+++ b/pc-bios/s390-ccw/menu.h
@@ -24,5 +24,6 @@ typedef struct ZiplParms {
 void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
 bool menu_check_flags(uint8_t check_flags);
 int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms);
+int menu_get_enum_boot_index(int entries);
 
 #endif /* MENU_H */
-- 
2.7.4
