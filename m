Received: from eggs.gnu.org ([2001:4830:134:3::10]:46735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaHt-0006gR-Qg
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eoaH5-000675-7g
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:42:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52750
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eoaH4-000650-O9
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:41:54 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1LJfNTM120087
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:53 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g9d075gfv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 14:41:53 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 21 Feb 2018 14:41:52 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 14:35:45 -0500
In-Reply-To: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519241752-28083-7-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v8 06/13] s390-ccw: parse and set boot menu
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

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h          |  9 +++++++--
 pc-bios/s390-ccw/iplb.h |  9 +++++++--
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 79f5a58..a176c4a 100644
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
@@ -219,6 +222,46 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void s390_ipl_set_boot_menu(S390IPLState *ipl)
+{
+    QemuOptsList *plist = qemu_find_opts("boot-opts");
+    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
+    uint8_t *flags = &ipl->qipl.qipl_flags;
+    uint32_t *timeout = &ipl->qipl.boot_menu_timeout;
+    const char *tmp;
+    unsigned long splash_time = 0;
+
+    switch (ipl->iplb.pbt) {
+    case S390_IPL_TYPE_CCW:
+        break;
+    default:
+        error_report("boot menu is not supported for this device type.");
+        return;
+    }
+
+    if (!boot_menu) {
+        return;
+    }
+
+    *flags |= QIPL_FLAG_BM_OPTS_CMD;
+
+    tmp = qemu_opt_get(opts, "splash-time");
+
+    if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
+        error_report("splash-time is invalid, forcing it to 0.");
+        *timeout = 0;
+        return;
+    }
+
+    if (splash_time > 0xffffffff) {
+        error_report("splash-time is too large, forcing it to max value.");
+        *timeout = 0xffffffff;
+        return;
+    }
+
+    *timeout = cpu_to_be32(splash_time);
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
@@ -435,6 +478,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         }
         ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
+    s390_ipl_set_boot_menu(ipl);
     s390_ipl_prepare_qipl(cpu);
 }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 08926a3..3a37924 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -91,6 +91,9 @@ void s390_reipl_request(void);
 
 #define QIPL_ADDRESS  0xcc
 
+/* Boot Menu flags */
+#define QIPL_FLAG_BM_OPTS_CMD   0x80
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
@@ -104,9 +107,11 @@ void s390_reipl_request(void);
  * in pc-bios/s390-ccw/iplb.h.
  */
 struct QemuIplParameters {
-    uint8_t  reserved1[4];
+    uint8_t  qipl_flags;
+    uint8_t  reserved1[3];
     uint64_t netboot_start_addr;
-    uint8_t  reserved2[16];
+    uint32_t boot_menu_timeout;
+    uint8_t  reserved2[12];
 } QEMU_PACKED;
 typedef struct QemuIplParameters QemuIplParameters;
 
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 31d2934..832bb94 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -74,14 +74,19 @@ extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 
 #define QIPL_ADDRESS  0xcc
 
+/* Boot Menu flags */
+#define QIPL_FLAG_BM_OPTS_CMD   0x80
+
 /*
  * This definition must be kept in sync with the defininition
  * in hw/s390x/ipl.h
  */
 struct QemuIplParameters {
-    uint8_t  reserved1[4];
+    uint8_t  qipl_flags;
+    uint8_t  reserved1[3];
     uint64_t netboot_start_addr;
-    uint8_t  reserved2[16];
+    uint32_t boot_menu_timeout;
+    uint8_t  reserved2[12];
 } __attribute__ ((packed));
 typedef struct QemuIplParameters QemuIplParameters;
 
-- 
2.7.4
