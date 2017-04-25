Received: from eggs.gnu.org ([2001:4830:134:3::10]:53423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzc-0000Ao-Rv
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2xzY-00016l-FS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d2xzY-00015m-7C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:46:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PAcogV025987
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:43 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a1j61ws4v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 06:46:42 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 25 Apr 2017 11:46:40 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 25 Apr 2017 12:46:24 +0200
In-Reply-To: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
References: <20170425104633.6130-1-cornelia.huck@de.ibm.com>
Message-Id: <20170425104633.6130-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 02/11] hw/s390x/ipl: enable LOADPARM in IPIB
 for a boot device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Farhan Ali <alifm@linux.vnet.ibm.com>, Eugene Dvurechenski <jno@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Insert the LOADPARM value to the IPL Information Parameter Block.

An IPL Information Parameter Block is created when "bootindex" is
specified for a device. If a user specifies "loadparm=", then we
store the loadparm value in the created IPIB for that boot device.

Initial patch from Eugene (jno) Dvurechenski.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/ipl.c | 31 +++++++++++++++++++++++++++++--
 hw/s390x/ipl.h |  3 +++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7978c7d52a..0711ee927a 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -17,8 +17,10 @@
 #include "cpu.h"
 #include "elf.h"
 #include "hw/loader.h"
+#include "hw/boards.h"
 #include "hw/s390x/virtio-ccw.h"
 #include "hw/s390x/css.h"
+#include "hw/s390x/ebcdic.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
 
@@ -243,7 +245,6 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.pbt = S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
-            return true;
         } else if (sd) {
             SCSIBus *bus = scsi_bus_from_device(sd);
             VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
@@ -259,13 +260,39 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
-            return true;
+        } else {
+            return false; /* unknown device */
+        }
+
+        if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
+            ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
         }
+        return true;
     }
 
     return false;
 }
 
+int s390_ipl_set_loadparm(uint8_t *loadparm)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    char *lp = object_property_get_str(OBJECT(machine), "loadparm", NULL);
+
+    if (lp) {
+        int i;
+
+        /* lp is an uppercase string without leading/embedded spaces */
+        for (i = 0; i < 8 && lp[i]; i++) {
+            loadparm[i] = ascii2ebcdic[(uint8_t) lp[i]];
+        }
+
+        g_free(lp);
+        return 0;
+    }
+
+    return -1;
+}
+
 static int load_netboot_image(Error **errp)
 {
     S390IPLState *ipl = get_ipl_device();
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 46930e4c64..8a705e0428 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -57,6 +57,8 @@ struct IplBlockQemuScsi {
 } QEMU_PACKED;
 typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
+#define DIAG308_FLAGS_LP_VALID 0x80
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -82,6 +84,7 @@ union IplParameterBlock {
 } QEMU_PACKED;
 typedef union IplParameterBlock IplParameterBlock;
 
+int s390_ipl_set_loadparm(uint8_t *loadparm);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
-- 
2.11.0
