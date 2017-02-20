Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfoos-0006FX-I1
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfooo-00078i-Hu
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52802
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfooo-00078B-C7
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:19:58 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEJAkW084762
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:19:57 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r16cajja-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:19:57 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 14:19:55 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 15:19:41 +0100
In-Reply-To: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220141943.8426-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 3/5] s390x/ipl: Load network boot image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Load the network boot image into guest RAM when the boot
device selected is a network device. Use some of the reserved
space in IplBlockCcw to store the start address of the netboot
image.

A user could also use 'chreipl'(diag 308/5) to change the boot device.
So every time we update the IPLB, we need to verify if the selected
boot device is a network device so we can appropriately load the
network boot image.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/ipl.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.h |  4 ++-
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fd656718a7..80e05cc7a5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -20,6 +20,7 @@
 #include "hw/s390x/virtio-ccw.h"
 #include "hw/s390x/css.h"
 #include "ipl.h"
+#include "qemu/error-report.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define KERN_PARM_AREA                  0x010480UL
@@ -227,6 +228,12 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
                 TYPE_VIRTIO_CCW_DEVICE);
         SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
                                                             TYPE_SCSI_DEVICE);
+        VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
+                                                          TYPE_VIRTIO_NET);
+
+        if (vn) {
+            ipl->netboot = true;
+        }
         if (virtio_ccw_dev) {
             CcwDevice *ccw_dev = CCW_DEVICE(virtio_ccw_dev);
 
@@ -259,12 +266,84 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
     return false;
 }
 
+static int load_netboot_image(void)
+{
+
+    S390IPLState *ipl = get_ipl_device();
+    char *netboot_filename;
+    MemoryRegion *sysmem =  get_system_memory();
+    MemoryRegion *mr = NULL;
+    void *ram_ptr = NULL;
+    int img_size = -1;
+
+    mr = memory_region_find(sysmem, 0, 1).mr;
+    if (!mr) {
+        error_report("Failed to find memory region at address 0");
+        goto out;
+    }
+
+    ram_ptr = memory_region_get_ram_ptr(mr);
+    if (!ram_ptr) {
+        error_report("No RAM found");
+        goto unref_mr;
+    }
+
+    netboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->netboot_fw);
+    if (netboot_filename == NULL) {
+        error_report("Could not find network bootloader");
+        goto unref_mr;
+    }
+
+    img_size = load_elf_ram(netboot_filename, NULL, NULL, &ipl->start_addr,
+                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
+
+    if (img_size < 0) {
+        img_size = load_image_size(netboot_filename, ram_ptr, ram_size);
+        ipl->start_addr = KERN_IMAGE_START;
+    }
+
+    g_free(netboot_filename);
+
+unref_mr:
+    memory_region_unref(mr);
+out:
+    return img_size;
+}
+
+static bool is_virtio_net_device(IplParameterBlock *iplb)
+{
+    uint8_t cssid;
+    uint8_t ssid;
+    uint16_t devno;
+    uint16_t schid;
+    SubchDev *sch = NULL;
+
+    if (iplb->pbt != S390_IPL_TYPE_CCW) {
+        return false;
+    }
+
+    devno = be16_to_cpu(iplb->ccw.devno);
+    ssid = iplb->ccw.ssid & 3;
+
+    for (schid = 0; schid < MAX_SCHID; schid++) {
+        for (cssid = 0; cssid < MAX_CSSID; cssid++) {
+            sch = css_find_subch(1, cssid, ssid, schid);
+
+            if (sch && sch->devno == devno) {
+                return sch->id.cu_model == VIRTIO_ID_NET;
+            }
+        }
+    }
+   return false;
+}
+
 void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl = get_ipl_device();
 
     ipl->iplb = *iplb;
     ipl->iplb_valid = true;
+    ipl->netboot = is_virtio_net_device(iplb);
 }
 
 IplParameterBlock *s390_ipl_get_iplb(void)
@@ -298,6 +377,13 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
             ipl->iplb_valid = s390_gen_initial_iplb(ipl);
         }
     }
+    if (ipl->netboot) {
+        if (load_netboot_image() < 0) {
+            error_report("Failed to load network bootloader");
+            vm_stop(RUN_STATE_INTERNAL_ERROR);
+        }
+        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;
+    }
 }
 
 static void s390_ipl_reset(DeviceState *dev)
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 4ad9a7c05e..46930e4c64 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -16,7 +16,8 @@
 #include "cpu.h"
 
 struct IplBlockCcw {
-    uint8_t  reserved0[85];
+    uint64_t netboot_start_addr;
+    uint8_t  reserved0[77];
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -100,6 +101,7 @@ struct S390IPLState {
     IplParameterBlock iplb;
     bool iplb_valid;
     bool reipl_requested;
+    bool netboot;
 
     /*< public >*/
     char *kernel;
-- 
2.11.0
