Received: from eggs.gnu.org ([2001:4830:134:3::10]:47488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintZ-0005jY-N6
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintW-0003Rc-Mx
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53374
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eintW-0003RD-II
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:42 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15KxVq9049418
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 16:01:40 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxuympprx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:01:40 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 16:01:39 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:57:20 -0500
In-Reply-To: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1517864246-11101-7-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 06/12] s390-ccw: parse and set boot menu
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

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

Any value set for loadparm will override all boot menu options.
If loadparm=PROMPT, then the menu will be enabled without a
timeout.

The absence of any boot options on the command line will flag
to later use the zipl boot loader values.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h          |  7 ++++++-
 pc-bios/s390-ccw/iplb.h |  4 +++-
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 3e3c3b8..227dccb 100644
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
@@ -219,6 +221,53 @@ static Property s390_ipl_properties[] = {
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
+    case S390_IPL_TYPE_QEMU_SCSI:
+        flags = &iplb->qipl.boot_menu_flags;
+        timeout = &iplb->qipl.boot_menu_timeout;
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
+        *flags = BOOT_MENU_FLAG_CMD_OPTS;
+
+        tmp = qemu_opt_get(opts, "splash-time");
+
+        if (tmp && qemu_strtoul(tmp, NULL, 10, &result)) {
+            error_report("splash-time value is invalid, forcing it to 0.");
+            *timeout = 0;
+            return;
+        }
+
+        result = (result + 500) / 1000; /* Round and convert to seconds */
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
@@ -273,6 +322,9 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
             ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
         }
+
+        s390_ipl_set_boot_menu(&ipl->iplb);
+
         return true;
     }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 68dcaf8..90c0ed3 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -58,8 +58,13 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
 #define DIAG308_FLAGS_LP_VALID 0x80
 
+#define BOOT_MENU_FLAG_CMD_OPTS  0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
 struct QemuIplParameters {
-    uint8_t  reserved1[4];
+    uint8_t  boot_menu_flags;
+    uint8_t  reserved1;
+    uint16_t boot_menu_timeout;
     uint64_t netboot_start_addr;
     uint8_t  reserved2[16];
 } QEMU_PACKED;
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 12f6e40..0bbc1ac 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -73,7 +73,9 @@ typedef struct IplParameterBlock IplParameterBlock;
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 
 struct QemuIplParameters {
-    uint8_t  reserved1[4];
+    uint8_t  boot_menu_flags;
+    uint8_t  reserved1;
+    uint16_t boot_menu_timeout;
     uint64_t netboot_start_addr;
     uint8_t  reserved2[16];
 } __attribute__ ((packed));
-- 
2.7.4
