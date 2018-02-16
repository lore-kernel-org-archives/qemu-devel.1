Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoAx-0006q8-2O
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emoAv-0005NP-Bq
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emoAv-0005Mo-3C
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 17:08:13 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GM898t114236
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:12 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g62tkk3vb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:08:11 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 17:08:10 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 17:07:53 -0500
In-Reply-To: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1518818879-18608-7-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 06/12] s390-ccw: parse and set boot menu
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
 hw/s390x/ipl.c          | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h          |  9 +++++++--
 pc-bios/s390-ccw/iplb.h |  6 ++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 31565ce..c8109f5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -23,6 +23,9 @@
 #include "hw/s390x/ebcdic.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qemu/cutils.h"
+#include "qemu/option.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define KERN_PARM_AREA                  0x010480UL
@@ -219,6 +222,50 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
+{
+    QemuOptsList *plist = qemu_find_opts("boot-opts");
+    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
+    uint8_t *flags;
+    uint32_t *timeout;
+    const char *tmp;
+    unsigned long splash_time = 0;
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
+        if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
+            error_report("splash-time is invalid, forcing it to 0.");
+            splash_time = 0;
+            return;
+        }
+
+        if (splash_time > 0xffffffff) {
+            error_report("splash-time is too large, forcing it to max value.");
+            splash_time = 0xffffffff;
+            return;
+        }
+
+        *timeout = cpu_to_be32(splash_time);
+    }
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
@@ -435,6 +482,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         }
         ipl->iplb.qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
+    s390_ipl_set_boot_menu(&ipl->iplb);
     s390_ipl_prepare_qipl(cpu);
 
 }
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 74469b1..f632c59 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -60,6 +60,9 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
 #define QIPL_ADDRESS  0xcc
 
+#define BOOT_MENU_FLAG_CMD_OPTS  0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
 /*
  * The QEMU IPL Parameters will be stored 32-bit word aligned.
  * Placement of data fields in this area must account for
@@ -67,9 +70,11 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
  * The entire structure must not be larger than 28 bytes.
  */
 struct QemuIplParameters {
-    uint8_t  reserved1[4];
+    uint8_t  boot_menu_flags;
+    uint8_t  reserved1[3];
+    uint32_t boot_menu_timeout;
     uint64_t netboot_start_addr;
-    uint8_t  reserved2[16];
+    uint8_t  reserved2[12];
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index a23237e..0e39aa0 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -81,9 +81,11 @@ extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
  * The entire structure must not be larger than 28 bytes.
  */
 struct QemuIplParameters {
-    uint8_t  reserved1[4];
+    uint8_t  boot_menu_flags;
+    uint8_t  reserved1[3];
+    uint32_t boot_menu_timeout;
     uint64_t netboot_start_addr;
-    uint8_t  reserved2[16];
+    uint8_t  reserved2[12];
 } __attribute__ ((packed));
 typedef struct QemuIplParameters QemuIplParameters;
 
-- 
2.7.4
