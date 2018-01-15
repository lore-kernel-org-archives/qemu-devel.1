Received: from eggs.gnu.org ([2001:4830:134:3::10]:57497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sz-0005BK-AY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sv-0002Ib-6Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7su-0002Gu-V7
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGgjbi008683
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:19 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgu7up04p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:19 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:18 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:25 -0500
In-Reply-To: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516034665-27606-9-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 8/8] s390-ccw: interactive boot menu for scsi
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

Interactive boot menu for scsi. This follows the same procedure
as the interactive menu for eckd dasd. An example follows:

    s390x Enumerated Boot Menu.

    3 entries detected. Select from index 0 to 2.

    Please choose:

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c |  9 ++++++---
 pc-bios/s390-ccw/main.c    |  3 +++
 pc-bios/s390-ccw/menu.c    | 14 ++++++++++++++
 pc-bios/s390-ccw/menu.h    |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index f894760..5b622de 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -589,15 +589,18 @@ static void ipl_scsi(void)
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
index c219b7f..007d96f 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -214,6 +214,20 @@ int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms)
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
index c6615aa..0c65009 100644
--- a/pc-bios/s390-ccw/menu.h
+++ b/pc-bios/s390-ccw/menu.h
@@ -28,6 +28,7 @@ typedef struct ZiplParms {
 } ZiplParms;
 
 int menu_get_zipl_boot_index(const void *stage2, ZiplParms zipl_parms);
+int menu_get_enum_boot_index(int entries);
 void menu_set_parms(uint8_t boot_menu_flags, uint16_t boot_menu_timeout);
 bool menu_check_flags(uint8_t check_flags);
 
-- 
2.7.4
