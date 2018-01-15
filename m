Received: from eggs.gnu.org ([2001:4830:134:3::10]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sq-0004xU-5M
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eb7sp-00027v-1Q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eb7so-00026q-Pb
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:45:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGiuoR008257
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:11 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fh00agacv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:45:10 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 09:45:09 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:44:20 -0500
In-Reply-To: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516034665-27606-4-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/8] s390-ccw: parse and set boot menu
 options
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

Set boot menu options for an s390 guest and store them in
the iplb. These options are set via the QEMU command line
option:

    -boot menu=on|off[,splash-time=X]

or via the libvirt domain xml:

    <os>
      <bootmenu enable='yes|no' timeout='X'/>
    </os>

Where X represents some positive integer representing
milliseconds.

A loadparm other than 'prompt' will disable the menu and
just boot the specified entry.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h          | 11 ++++++++--
 pc-bios/s390-ccw/iplb.h |  8 ++++++--
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0d06fc1..81ba9ed 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -23,6 +23,8 @@
 #include "hw/s390x/ebcdic.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qemu/cutils.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define KERN_PARM_AREA                  0x010480UL
@@ -219,6 +221,55 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
+{
+    QemuOptsList *plist = qemu_find_opts("boot-opts");
+    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
+    uint8_t *flags;
+    uint16_t *timeout;
+    const char *tmp;
+    unsigned long result = 0;
+
+    switch (iplb->pbt) {
+    case S390_IPL_TYPE_CCW:
+        flags = &iplb->ccw.boot_menu_flags;
+        timeout = &iplb->ccw.boot_menu_timeout;
+        break;
+    case S390_IPL_TYPE_QEMU_SCSI:
+        flags = &iplb->scsi.boot_menu_flags;
+        timeout = &iplb->scsi.boot_menu_timeout;
+        break;
+    default:
+        error_report("boot menu is not supported for this device type.");
+        return;
+    }
+
+    /* In the absence of -boot menu, use zipl parameters */
+    if (!qemu_opt_get(opts, "menu")) {
+        *flags = BOOT_MENU_FLAG_ZIPL_OPTS;
+    } else if (boot_menu) {
+        *flags = BOOT_MENU_FLAG_BOOT_OPTS;
+
+        tmp = qemu_opt_get(opts, "splash-time");
+
+        if (tmp && qemu_strtoul(tmp, NULL, 10, &result)) {
+            error_report("splash-time value is invalid, forcing it to 0.");
+            return;
+        }
+
+        result /= 1000; /* Store timeout value as seconds */
+
+        if (result > 0xffff) {
+            error_report("splash-time value is greater than 65535000,"
+                         " forcing it to 65535000.");
+            *timeout = 0xffff;
+            return;
+        }
+
+        *timeout = cpu_to_be16(result);
+    }
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
@@ -273,6 +324,9 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
             ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
         }
+
+        s390_ipl_set_boot_menu(&ipl->iplb);
+
         return true;
     }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8a705e0..48e82cf 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -15,9 +15,14 @@
 #include "hw/qdev.h"
 #include "cpu.h"
 
+#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
 struct IplBlockCcw {
     uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint16_t boot_menu_timeout;
+    uint8_t  boot_menu_flags;
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -51,7 +56,9 @@ struct IplBlockQemuScsi {
     uint32_t lun;
     uint16_t target;
     uint16_t channel;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint16_t boot_menu_timeout;
+    uint8_t  boot_menu_flags;
     uint8_t  ssid;
     uint16_t devno;
 } QEMU_PACKED;
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 890aed9..fe909d2 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -14,7 +14,9 @@
 
 struct IplBlockCcw {
     uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint16_t boot_menu_timeout;
+    uint8_t  boot_menu_flags;
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -48,7 +50,9 @@ struct IplBlockQemuScsi {
     uint32_t lun;
     uint16_t target;
     uint16_t channel;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint16_t boot_menu_timeout;
+    uint8_t  boot_menu_flags;
     uint8_t  ssid;
     uint16_t devno;
 } __attribute__ ((packed));
-- 
2.7.4
