Received: from eggs.gnu.org ([2001:4830:134:3::10]:54653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQf-0001Es-Ll
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eOWQd-0001bC-8M
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eOWQc-0001aR-Vm
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 17:20:03 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBMG8mS057951
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:19:59 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2et1vtswss-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 17:19:59 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 17:19:57 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 17:19:18 -0500
In-Reply-To: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1513030760-26245-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1513030760-26245-4-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/5] s390-ccw: parse and set boot menu
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
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com

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
 hw/s390x/ipl.c          | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h          |  8 +++++--
 pc-bios/s390-ccw/iplb.h |  8 +++++--
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0d06fc1..ed5e8d1 100644
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
@@ -33,6 +35,9 @@
 #define ZIPL_IMAGE_START                0x009000UL
 #define IPL_PSW_MASK                    (PSW_MASK_32 | PSW_MASK_64)
 
+#define BOOT_MENU_FLAG_BOOT_OPTS 0x80
+#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
+
 static bool iplb_extended_needed(void *opaque)
 {
     S390IPLState *ipl = S390_IPL(object_resolve_path(TYPE_S390_IPL, NULL));
@@ -219,6 +224,51 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void s390_ipl_set_boot_menu(uint8_t *boot_menu_flags,
+                                   uint16_t *boot_menu_timeout)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    char *lp = object_property_get_str(OBJECT(machine), "loadparm", NULL);
+    QemuOptsList *plist = qemu_find_opts("boot-opts");
+    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
+    const char *p = qemu_opt_get(opts, "menu");
+    unsigned long timeout = 0;
+
+    if (memcmp(lp, "PROMPT  ", 8) == 0) {
+        *boot_menu_flags = BOOT_MENU_FLAG_BOOT_OPTS;
+
+    } else if (*lp) {
+        /* If loadparm is set to any value, then discard boot menu */
+        return;
+
+    } else if (!p) {
+        /* In the absence of -boot menu, use zipl loader parameters */
+        *boot_menu_flags = BOOT_MENU_FLAG_ZIPL_OPTS;
+
+    } else if (strncmp(p, "on", 2) == 0) {
+        *boot_menu_flags = BOOT_MENU_FLAG_BOOT_OPTS;
+
+        p = qemu_opt_get(opts, "splash-time");
+
+        if (p && qemu_strtoul(p, NULL, 10, &timeout)) {
+            error_report("splash-time value is invalid, forcing it to 0.");
+            return;
+        }
+
+        /* Store timeout value as seconds */
+        timeout /= 1000;
+
+        if (timeout > 0xffff) {
+            error_report("splash-time value is greater than 65535000,"
+                         " forcing it to 65535000.");
+            *boot_menu_timeout = 0xffff;
+            return;
+        }
+
+        *boot_menu_timeout = timeout;
+    }
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
@@ -245,6 +295,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.pbt = S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            s390_ipl_set_boot_menu(&ipl->iplb.ccw.boot_menu_flags,
+                                   &ipl->iplb.ccw.boot_menu_timeout);
         } else if (sd) {
             SCSIBus *bus = scsi_bus_from_device(sd);
             VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
@@ -266,6 +318,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
+            s390_ipl_set_boot_menu(&ipl->iplb.scsi.boot_menu_flags,
+                                   &ipl->iplb.scsi.boot_menu_timeout);
         } else {
             return false; /* unknown device */
         }
@@ -273,6 +327,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
             ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
         }
+
         return true;
     }
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8a705e0..ff3b397 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -17,7 +17,9 @@
 
 struct IplBlockCcw {
     uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint16_t boot_menu_timeout;
+    uint8_t  boot_menu_flags;
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -51,7 +53,9 @@ struct IplBlockQemuScsi {
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
