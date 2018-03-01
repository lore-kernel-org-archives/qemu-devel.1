Received: from eggs.gnu.org ([2001:4830:134:3::10]:58481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNqs-0003lo-Ib
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNqq-0007Ae-7G
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:26 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:40 +0100
Message-Id: <20180301130201.24666-7-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/27] s390-ccw: parse and set boot menu
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, "Collin L. Walling" <walling@linux.vnet.ibm.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c          | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h          |  9 +++++++--
 pc-bios/s390-ccw/iplb.h |  9 +++++++--
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 79f5a58adb..ee2039dc69 100644
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
@@ -219,6 +222,54 @@ static Property s390_ipl_properties[] = {
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
+    if (!get_boot_device(0)) {
+        if (boot_menu) {
+            error_report("boot menu requires a bootindex to be specified for "
+                         "the IPL device.");
+        }
+        return;
+    }
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
@@ -435,6 +486,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
         }
         ipl->qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
+    s390_ipl_set_boot_menu(ipl);
     s390_ipl_prepare_qipl(cpu);
 }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 5cc3b770d4..d6c6f75b76 100644
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
index 31d2934762..832bb94440 100644
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
2.13.6
