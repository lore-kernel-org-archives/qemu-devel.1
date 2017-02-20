Received: from eggs.gnu.org ([2001:4830:134:3::10]:48747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfoor-0006Ec-9z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfoop-00079M-TC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41763
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfoop-00079D-MI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:19:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEJ9nb119669
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:19:59 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28r00g5w6k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:19:58 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 14:19:56 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 15:19:42 +0100
In-Reply-To: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220141943.8426-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 4/5] pc-bios/s390-ccw: Use the ccw bios to
 start the network boot
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

We want to use the ccw bios to start final network boot. To do
this we use ccw bios to detect if the boot device is a virtio
network device and retrieve the start address of the
network boot image.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c |  8 +++++++-
 pc-bios/s390-ccw/iplb.h    |  3 ++-
 pc-bios/s390-ccw/main.c    | 20 ++++++++++++++------
 pc-bios/s390-ccw/virtio.c  |  1 +
 pc-bios/s390-ccw/virtio.h  |  1 +
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 611102e3ef..b21c877b53 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -724,11 +724,17 @@ static void zipl_load_vscsi(void)
 
 void zipl_load(void)
 {
-    if (virtio_get_device()->is_cdrom) {
+    VDev *vdev = virtio_get_device();
+
+    if (vdev->is_cdrom) {
         ipl_iso_el_torito();
         panic("\n! Cannot IPL this ISO image !\n");
     }
 
+    if (virtio_get_device_type() == VIRTIO_ID_NET) {
+        jump_to_IPL_code(vdev->netboot_start_addr);
+    }
+
     ipl_scsi();
 
     switch (virtio_get_device_type()) {
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 86abc56a90..890aed9ece 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -13,7 +13,8 @@
 #define IPLB_H
 
 struct IplBlockCcw {
-    uint8_t  reserved0[85];
+    uint64_t netboot_start_addr;
+    uint8_t  reserved0[77];
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 345b848752..0946766d86 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -53,6 +53,12 @@ static bool find_dev(Schib *schib, int dev_no)
         if (!virtio_is_supported(blk_schid)) {
             continue;
         }
+        /* Skip net devices since no IPLB is created and therefore no
+         * no network bootloader has been loaded
+         */
+        if (virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
+            continue;
+        }
         if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
             return true;
         }
@@ -67,6 +73,7 @@ static void virtio_setup(void)
     int ssid;
     bool found = false;
     uint16_t dev_no;
+    VDev *vdev = virtio_get_device();
 
     /*
      * We unconditionally enable mss support. In every sane configuration,
@@ -85,9 +92,6 @@ static void virtio_setup(void)
             found = find_dev(&schib, dev_no);
             break;
         case S390_IPL_TYPE_QEMU_SCSI:
-        {
-            VDev *vdev = virtio_get_device();
-
             vdev->scsi_device_selected = true;
             vdev->selected_scsi_device.channel = iplb.scsi.channel;
             vdev->selected_scsi_device.target = iplb.scsi.target;
@@ -95,7 +99,6 @@ static void virtio_setup(void)
             blk_schid.ssid = iplb.scsi.ssid & 0x3;
             found = find_dev(&schib, iplb.scsi.devno);
             break;
-        }
         default:
             panic("List-directed IPL not supported yet!\n");
         }
@@ -111,9 +114,14 @@ static void virtio_setup(void)
 
     IPL_assert(found, "No virtio device found");
 
-    virtio_setup_device(blk_schid);
+    if (virtio_get_device_type() == VIRTIO_ID_NET) {
+        sclp_print("Network boot device detected\n");
+        vdev->netboot_start_addr = iplb.ccw.netboot_start_addr;
+    } else {
+        virtio_setup_device(blk_schid);
 
-    IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
+        IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
+    }
 }
 
 int main(void)
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index b333734955..6ee93d56db 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -585,6 +585,7 @@ bool virtio_is_supported(SubChannelId schid)
         switch (vdev.senseid.cu_model) {
         case VIRTIO_ID_BLOCK:
         case VIRTIO_ID_SCSI:
+        case VIRTIO_ID_NET:
             return true;
         }
     }
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index eb35ea5faf..3388a423e5 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -276,6 +276,7 @@ struct VDev {
     uint8_t scsi_dev_heads;
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
+    uint64_t netboot_start_addr;
 };
 typedef struct VDev VDev;
 
-- 
2.11.0
