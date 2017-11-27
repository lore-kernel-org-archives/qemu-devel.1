Received: from eggs.gnu.org ([2001:4830:134:3::10]:58974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJQRw-0003Wh-Fk
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJQRt-0003Yy-9j
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:56:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJQRt-0003Vp-2L
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:56:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARKsA4m034370
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 15:56:13 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2egpygrsay-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 15:56:13 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 15:56:11 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 15:55:34 -0500
In-Reply-To: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 3/5] s390-ccw: parse and set boot menu
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

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

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c          | 23 +++++++++++++++++++++++
 hw/s390x/ipl.h          |  8 ++++++--
 pc-bios/s390-ccw/iplb.h |  8 ++++++--
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0d06fc1..0ca9e37 100644
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
@@ -219,6 +221,23 @@ static Property s390_ipl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void s390_ipl_set_boot_menu(uint8_t *boot_menu_enabled,
+                                   uint16_t *boot_menu_timeout)
+{
+    QemuOptsList *plist = qemu_find_opts("boot-opts");
+    QemuOpts *opts = QTAILQ_FIRST(&plist->head);
+    const char *p;
+    long result = 0;
+
+    *boot_menu_enabled = qemu_opt_get_bool(opts, "menu", false);
+
+    if (*boot_menu_enabled) {
+        p = qemu_opt_get(opts, "splash-time");
+        qemu_strtol(p, NULL, 10, &result);
+        *boot_menu_timeout = result;
+    }
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
@@ -245,6 +264,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.pbt = S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            s390_ipl_set_boot_menu(&ipl->iplb.ccw.boot_menu_enabled,
+                                   &ipl->iplb.ccw.boot_menu_timeout);
         } else if (sd) {
             SCSIBus *bus = scsi_bus_from_device(sd);
             VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
@@ -266,6 +287,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
+            s390_ipl_set_boot_menu(&ipl->iplb.scsi.boot_menu_enabled,
+                                   &ipl->iplb.scsi.boot_menu_timeout);
         } else {
             return false; /* unknown device */
         }
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8a705e0..7c960b1 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -17,7 +17,9 @@
 
 struct IplBlockCcw {
     uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint8_t  boot_menu_enabled;
+    uint16_t boot_menu_timeout;
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -51,7 +53,9 @@ struct IplBlockQemuScsi {
     uint32_t lun;
     uint16_t target;
     uint16_t channel;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint8_t  boot_menu_enabled;
+    uint16_t boot_menu_timeout;
     uint8_t  ssid;
     uint16_t devno;
 } QEMU_PACKED;
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 890aed9..658d163 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -14,7 +14,9 @@
 
 struct IplBlockCcw {
     uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint8_t  boot_menu_enabled;
+    uint16_t boot_menu_timeout;
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -48,7 +50,9 @@ struct IplBlockQemuScsi {
     uint32_t lun;
     uint16_t target;
     uint16_t channel;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[74];
+    uint8_t  boot_menu_enabled;
+    uint16_t boot_menu_timeout;
     uint8_t  ssid;
     uint16_t devno;
 } __attribute__ ((packed));
-- 
2.7.4
