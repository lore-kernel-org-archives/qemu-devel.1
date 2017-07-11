Received: from eggs.gnu.org ([2001:4830:134:3::10]:54641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvep-0004sg-Tt
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvek-00048k-J9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUvek-00048B-B5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:56:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 11 Jul 2017 15:56:29 +0200
Message-Id: <1499781397-19749-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1499781397-19749-1-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/11] pc-bios/s390-ccw: Move virtio-block
 related functions into a separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

The netboot code is going to link against the code from virtio.c, too, so
we've got to move the virtio-block and -scsi related code out of the way.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile        |   2 +-
 pc-bios/s390-ccw/main.c          |   2 +-
 pc-bios/s390-ccw/s390-ccw.h      |   2 +-
 pc-bios/s390-ccw/virtio-blkdev.c | 296 +++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio.c        | 277 +-----------------------------------
 pc-bios/s390-ccw/virtio.h        |   6 +
 6 files changed, 311 insertions(+), 274 deletions(-)
 create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index fb88c13..82b41ef 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 0580eac..401e9db 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -144,7 +144,7 @@ static void virtio_setup(void)
         sclp_print("Network boot device detected\n");
         vdev->netboot_start_addr = iplb.ccw.netboot_start_addr;
     } else {
-        virtio_setup_device(blk_schid);
+        virtio_blk_setup_device(blk_schid);
 
         IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
     }
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 43e2d42..6fdc858 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -74,7 +74,7 @@ void sclp_get_loadparm_ascii(char *loadparm);
 unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
                                  ulong subchan_id, void *load_addr);
 bool virtio_is_supported(SubChannelId schid);
-void virtio_setup_device(SubChannelId schid);
+void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
 int enable_mss_facility(void);
 ulong get_second(void);
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
new file mode 100644
index 0000000..11c5626
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -0,0 +1,296 @@
+/*
+ * Virtio driver bits
+ *
+ * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+#include "virtio.h"
+#include "virtio-scsi.h"
+
+static int virtio_blk_read_many(VDev *vdev, ulong sector, void *load_addr,
+                                int sec_num)
+{
+    VirtioBlkOuthdr out_hdr;
+    u8 status;
+    VRing *vr = &vdev->vrings[vdev->cmd_vr_idx];
+
+    /* Tell the host we want to read */
+    out_hdr.type = VIRTIO_BLK_T_IN;
+    out_hdr.ioprio = 99;
+    out_hdr.sector = virtio_sector_adjust(sector);
+
+    vring_send_buf(vr, &out_hdr, sizeof(out_hdr), VRING_DESC_F_NEXT);
+
+    /* This is where we want to receive data */
+    vring_send_buf(vr, load_addr, virtio_get_block_size() * sec_num,
+                   VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN |
+                   VRING_DESC_F_NEXT);
+
+    /* status field */
+    vring_send_buf(vr, &status, sizeof(u8),
+                   VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN);
+
+    /* Now we can tell the host to read */
+    vring_wait_reply();
+
+    if (drain_irqs(vr->schid)) {
+        /* Well, whatever status is supposed to contain... */
+        status = 1;
+    }
+    return status;
+}
+
+int virtio_read_many(ulong sector, void *load_addr, int sec_num)
+{
+    VDev *vdev = virtio_get_device();
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return virtio_blk_read_many(vdev, sector, load_addr, sec_num);
+    case VIRTIO_ID_SCSI:
+        return virtio_scsi_read_many(vdev, sector, load_addr, sec_num);
+    }
+    panic("\n! No readable IPL device !\n");
+    return -1;
+}
+
+unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
+                                 ulong subchan_id, void *load_addr)
+{
+    u8 status;
+    int sec = rec_list1;
+    int sec_num = ((rec_list2 >> 32) & 0xffff) + 1;
+    int sec_len = rec_list2 >> 48;
+    ulong addr = (ulong)load_addr;
+
+    if (sec_len != virtio_get_block_size()) {
+        return -1;
+    }
+
+    sclp_print(".");
+    status = virtio_read_many(sec, (void *)addr, sec_num);
+    if (status) {
+        panic("I/O Error");
+    }
+    addr += sec_num * virtio_get_block_size();
+
+    return addr;
+}
+
+int virtio_read(ulong sector, void *load_addr)
+{
+    return virtio_read_many(sector, load_addr, 1);
+}
+
+/*
+ * Other supported value pairs, if any, would need to be added here.
+ * Note: head count is always 15.
+ */
+static inline u8 virtio_eckd_sectors_for_block_size(int size)
+{
+    switch (size) {
+    case 512:
+        return 49;
+    case 1024:
+        return 33;
+    case 2048:
+        return 21;
+    case 4096:
+        return 12;
+    }
+    return 0;
+}
+
+VirtioGDN virtio_guessed_disk_nature(void)
+{
+    return virtio_get_device()->guessed_disk_nature;
+}
+
+void virtio_assume_scsi(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
+        vdev->config.blk.blk_size = VIRTIO_SCSI_BLOCK_SIZE;
+        vdev->config.blk.physical_block_exp = 0;
+        vdev->blk_factor = 1;
+        break;
+    case VIRTIO_ID_SCSI:
+        vdev->scsi_block_size = VIRTIO_SCSI_BLOCK_SIZE;
+        break;
+    }
+}
+
+void virtio_assume_iso9660(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        vdev->guessed_disk_nature = VIRTIO_GDN_SCSI;
+        vdev->config.blk.blk_size = VIRTIO_ISO_BLOCK_SIZE;
+        vdev->config.blk.physical_block_exp = 0;
+        vdev->blk_factor = VIRTIO_ISO_BLOCK_SIZE / VIRTIO_SECTOR_SIZE;
+        break;
+    case VIRTIO_ID_SCSI:
+        vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
+        break;
+    }
+}
+
+void virtio_assume_eckd(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    vdev->guessed_disk_nature = VIRTIO_GDN_DASD;
+    vdev->blk_factor = 1;
+    vdev->config.blk.physical_block_exp = 0;
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        vdev->config.blk.blk_size = 4096;
+        break;
+    case VIRTIO_ID_SCSI:
+        vdev->config.blk.blk_size = vdev->scsi_block_size;
+        break;
+    }
+    vdev->config.blk.geometry.heads = 15;
+    vdev->config.blk.geometry.sectors =
+        virtio_eckd_sectors_for_block_size(vdev->config.blk.blk_size);
+}
+
+bool virtio_disk_is_scsi(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    if (vdev->guessed_disk_nature == VIRTIO_GDN_SCSI) {
+        return true;
+    }
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return (vdev->config.blk.geometry.heads == 255)
+            && (vdev->config.blk.geometry.sectors == 63)
+            && (virtio_get_block_size()  == VIRTIO_SCSI_BLOCK_SIZE);
+    case VIRTIO_ID_SCSI:
+        return true;
+    }
+    return false;
+}
+
+bool virtio_disk_is_eckd(void)
+{
+    VDev *vdev = virtio_get_device();
+    const int block_size = virtio_get_block_size();
+
+    if (vdev->guessed_disk_nature == VIRTIO_GDN_DASD) {
+        return true;
+    }
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return (vdev->config.blk.geometry.heads == 15)
+            && (vdev->config.blk.geometry.sectors ==
+                virtio_eckd_sectors_for_block_size(block_size));
+    case VIRTIO_ID_SCSI:
+        return false;
+    }
+    return false;
+}
+
+bool virtio_ipl_disk_is_valid(void)
+{
+    return virtio_disk_is_scsi() || virtio_disk_is_eckd();
+}
+
+int virtio_get_block_size(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return vdev->config.blk.blk_size << vdev->config.blk.physical_block_exp;
+    case VIRTIO_ID_SCSI:
+        return vdev->scsi_block_size;
+    }
+    return 0;
+}
+
+uint8_t virtio_get_heads(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return vdev->config.blk.geometry.heads;
+    case VIRTIO_ID_SCSI:
+        return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
+               ? vdev->config.blk.geometry.heads : 255;
+    }
+    return 0;
+}
+
+uint8_t virtio_get_sectors(void)
+{
+    VDev *vdev = virtio_get_device();
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return vdev->config.blk.geometry.sectors;
+    case VIRTIO_ID_SCSI:
+        return vdev->guessed_disk_nature == VIRTIO_GDN_DASD
+               ? vdev->config.blk.geometry.sectors : 63;
+    }
+    return 0;
+}
+
+uint64_t virtio_get_blocks(void)
+{
+    VDev *vdev = virtio_get_device();
+    const uint64_t factor = virtio_get_block_size() / VIRTIO_SECTOR_SIZE;
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        return vdev->config.blk.capacity / factor;
+    case VIRTIO_ID_SCSI:
+        return vdev->scsi_last_block / factor;
+    }
+    return 0;
+}
+
+void virtio_blk_setup_device(SubChannelId schid)
+{
+    VDev *vdev = virtio_get_device();
+
+    vdev->schid = schid;
+    virtio_setup_ccw(vdev);
+
+    switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_BLOCK:
+        sclp_print("Using virtio-blk.\n");
+        if (!virtio_ipl_disk_is_valid()) {
+            /* make sure all getters but blocksize return 0 for
+             * invalid IPL disk
+             */
+            memset(&vdev->config.blk, 0, sizeof(vdev->config.blk));
+            virtio_assume_scsi();
+        }
+        break;
+    case VIRTIO_ID_SCSI:
+        IPL_assert(vdev->config.scsi.sense_size == VIRTIO_SCSI_SENSE_SIZE,
+            "Config: sense size mismatch");
+        IPL_assert(vdev->config.scsi.cdb_size == VIRTIO_SCSI_CDB_SIZE,
+            "Config: CDB size mismatch");
+
+        sclp_print("Using virtio-scsi.\n");
+        virtio_scsi_setup(vdev);
+        break;
+    default:
+        panic("\n! No IPL device available !\n");
+    }
+}
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 8768331..9d9e61f 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -70,7 +70,7 @@ static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
  *             Virtio functions                *
  ***********************************************/
 
-static int drain_irqs(SubChannelId schid)
+int drain_irqs(SubChannelId schid)
 {
     Irb irb = {};
     int r = 0;
@@ -149,13 +149,13 @@ static void vring_init(VRing *vr, VqInfo *info)
     debug_print_addr("init vr", vr);
 }
 
-static bool vring_notify(VRing *vr)
+bool vring_notify(VRing *vr)
 {
     vr->cookie = virtio_notify(vr->schid, vr->id, vr->cookie);
     return vr->cookie >= 0;
 }
 
-static void vring_send_buf(VRing *vr, void *p, int len, int flags)
+void vring_send_buf(VRing *vr, void *p, int len, int flags)
 {
     /* For follow-up chains we need to keep the first entry point */
     if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
@@ -188,7 +188,7 @@ ulong get_second(void)
     return (get_clock() >> 12) / 1000000;
 }
 
-static int vr_poll(VRing *vr)
+int vr_poll(VRing *vr)
 {
     if (vr->used->idx == vr->used_idx) {
         vring_notify(vr);
@@ -210,7 +210,7 @@ static int vr_poll(VRing *vr)
  *
  * Returns 0 on success, 1 on timeout.
  */
-static int vring_wait_reply(void)
+int vring_wait_reply(void)
 {
     ulong target_second = get_second() + vdev.wait_reply_timeout;
 
@@ -247,242 +247,7 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     return 0;
 }
 
-/***********************************************
- *               Virtio block                  *
- ***********************************************/
-
-static int virtio_blk_read_many(VDev *vdev,
-                                ulong sector, void *load_addr, int sec_num)
-{
-    VirtioBlkOuthdr out_hdr;
-    u8 status;
-    VRing *vr = &vdev->vrings[vdev->cmd_vr_idx];
-
-    /* Tell the host we want to read */
-    out_hdr.type = VIRTIO_BLK_T_IN;
-    out_hdr.ioprio = 99;
-    out_hdr.sector = virtio_sector_adjust(sector);
-
-    vring_send_buf(vr, &out_hdr, sizeof(out_hdr), VRING_DESC_F_NEXT);
-
-    /* This is where we want to receive data */
-    vring_send_buf(vr, load_addr, virtio_get_block_size() * sec_num,
-                   VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN |
-                   VRING_DESC_F_NEXT);
-
-    /* status field */
-    vring_send_buf(vr, &status, sizeof(u8),
-                   VRING_DESC_F_WRITE | VRING_HIDDEN_IS_CHAIN);
-
-    /* Now we can tell the host to read */
-    vring_wait_reply();
-
-    if (drain_irqs(vr->schid)) {
-        /* Well, whatever status is supposed to contain... */
-        status = 1;
-    }
-    return status;
-}
-
-int virtio_read_many(ulong sector, void *load_addr, int sec_num)
-{
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return virtio_blk_read_many(&vdev, sector, load_addr, sec_num);
-    case VIRTIO_ID_SCSI:
-        return virtio_scsi_read_many(&vdev, sector, load_addr, sec_num);
-    }
-    panic("\n! No readable IPL device !\n");
-    return -1;
-}
-
-unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
-                                 ulong subchan_id, void *load_addr)
-{
-    u8 status;
-    int sec = rec_list1;
-    int sec_num = ((rec_list2 >> 32) & 0xffff) + 1;
-    int sec_len = rec_list2 >> 48;
-    ulong addr = (ulong)load_addr;
-
-    if (sec_len != virtio_get_block_size()) {
-        return -1;
-    }
-
-    sclp_print(".");
-    status = virtio_read_many(sec, (void *)addr, sec_num);
-    if (status) {
-        panic("I/O Error");
-    }
-    addr += sec_num * virtio_get_block_size();
-
-    return addr;
-}
-
-int virtio_read(ulong sector, void *load_addr)
-{
-    return virtio_read_many(sector, load_addr, 1);
-}
-
-/*
- * Other supported value pairs, if any, would need to be added here.
- * Note: head count is always 15.
- */
-static inline u8 virtio_eckd_sectors_for_block_size(int size)
-{
-    switch (size) {
-    case 512:
-        return 49;
-    case 1024:
-        return 33;
-    case 2048:
-        return 21;
-    case 4096:
-        return 12;
-    }
-    return 0;
-}
-
-VirtioGDN virtio_guessed_disk_nature(void)
-{
-    return vdev.guessed_disk_nature;
-}
-
-void virtio_assume_scsi(void)
-{
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        vdev.guessed_disk_nature = VIRTIO_GDN_SCSI;
-        vdev.config.blk.blk_size = VIRTIO_SCSI_BLOCK_SIZE;
-        vdev.config.blk.physical_block_exp = 0;
-        vdev.blk_factor = 1;
-        break;
-    case VIRTIO_ID_SCSI:
-        vdev.scsi_block_size = VIRTIO_SCSI_BLOCK_SIZE;
-        break;
-    }
-}
-
-void virtio_assume_iso9660(void)
-{
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        vdev.guessed_disk_nature = VIRTIO_GDN_SCSI;
-        vdev.config.blk.blk_size = VIRTIO_ISO_BLOCK_SIZE;
-        vdev.config.blk.physical_block_exp = 0;
-        vdev.blk_factor = VIRTIO_ISO_BLOCK_SIZE / VIRTIO_SECTOR_SIZE;
-        break;
-    case VIRTIO_ID_SCSI:
-        vdev.scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
-        break;
-    }
-}
-
-void virtio_assume_eckd(void)
-{
-    vdev.guessed_disk_nature = VIRTIO_GDN_DASD;
-    vdev.blk_factor = 1;
-    vdev.config.blk.physical_block_exp = 0;
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        vdev.config.blk.blk_size = 4096;
-        break;
-    case VIRTIO_ID_SCSI:
-        vdev.config.blk.blk_size = vdev.scsi_block_size;
-        break;
-    }
-    vdev.config.blk.geometry.heads = 15;
-    vdev.config.blk.geometry.sectors =
-        virtio_eckd_sectors_for_block_size(vdev.config.blk.blk_size);
-}
-
-bool virtio_disk_is_scsi(void)
-{
-    if (vdev.guessed_disk_nature == VIRTIO_GDN_SCSI) {
-        return true;
-    }
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return (vdev.config.blk.geometry.heads == 255)
-            && (vdev.config.blk.geometry.sectors == 63)
-            && (virtio_get_block_size()  == VIRTIO_SCSI_BLOCK_SIZE);
-    case VIRTIO_ID_SCSI:
-        return true;
-    }
-    return false;
-}
-
-bool virtio_disk_is_eckd(void)
-{
-    const int block_size = virtio_get_block_size();
-
-    if (vdev.guessed_disk_nature == VIRTIO_GDN_DASD) {
-        return true;
-    }
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return (vdev.config.blk.geometry.heads == 15)
-            && (vdev.config.blk.geometry.sectors ==
-                virtio_eckd_sectors_for_block_size(block_size));
-    case VIRTIO_ID_SCSI:
-        return false;
-    }
-    return false;
-}
-
-bool virtio_ipl_disk_is_valid(void)
-{
-    return virtio_disk_is_scsi() || virtio_disk_is_eckd();
-}
-
-int virtio_get_block_size(void)
-{
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return vdev.config.blk.blk_size << vdev.config.blk.physical_block_exp;
-    case VIRTIO_ID_SCSI:
-        return vdev.scsi_block_size;
-    }
-    return 0;
-}
-
-uint8_t virtio_get_heads(void)
-{
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return vdev.config.blk.geometry.heads;
-    case VIRTIO_ID_SCSI:
-        return vdev.guessed_disk_nature == VIRTIO_GDN_DASD
-               ? vdev.config.blk.geometry.heads : 255;
-    }
-    return 0;
-}
-
-uint8_t virtio_get_sectors(void)
-{
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return vdev.config.blk.geometry.sectors;
-    case VIRTIO_ID_SCSI:
-        return vdev.guessed_disk_nature == VIRTIO_GDN_DASD
-               ? vdev.config.blk.geometry.sectors : 63;
-    }
-    return 0;
-}
-
-uint64_t virtio_get_blocks(void)
-{
-    const uint64_t factor = virtio_get_block_size() / VIRTIO_SECTOR_SIZE;
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        return vdev.config.blk.capacity / factor;
-    case VIRTIO_ID_SCSI:
-        return vdev.scsi_last_block / factor;
-    }
-    return 0;
-}
-
-static void virtio_setup_ccw(VDev *vdev)
+void virtio_setup_ccw(VDev *vdev)
 {
     int i, cfg_size = 0;
     unsigned char status = VIRTIO_CONFIG_S_DRIVER_OK;
@@ -544,36 +309,6 @@ static void virtio_setup_ccw(VDev *vdev)
         "Could not write status to host");
 }
 
-void virtio_setup_device(SubChannelId schid)
-{
-    vdev.schid = schid;
-    virtio_setup_ccw(&vdev);
-
-    switch (vdev.senseid.cu_model) {
-    case VIRTIO_ID_BLOCK:
-        sclp_print("Using virtio-blk.\n");
-        if (!virtio_ipl_disk_is_valid()) {
-            /* make sure all getters but blocksize return 0 for
-             * invalid IPL disk
-             */
-            memset(&vdev.config.blk, 0, sizeof(vdev.config.blk));
-            virtio_assume_scsi();
-        }
-        break;
-    case VIRTIO_ID_SCSI:
-        IPL_assert(vdev.config.scsi.sense_size == VIRTIO_SCSI_SENSE_SIZE,
-            "Config: sense size mismatch");
-        IPL_assert(vdev.config.scsi.cdb_size == VIRTIO_SCSI_CDB_SIZE,
-            "Config: CDB size mismatch");
-
-        sclp_print("Using virtio-scsi.\n");
-        virtio_scsi_setup(&vdev);
-        break;
-    default:
-        panic("\n! No IPL device available !\n");
-    }
-}
-
 bool virtio_is_supported(SubChannelId schid)
 {
     vdev.schid = schid;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 1eaf865..024e9a6 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -291,6 +291,12 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+bool vring_notify(VRing *vr);
+int drain_irqs(SubChannelId schid);
+void vring_send_buf(VRing *vr, void *p, int len, int flags);
+int vr_poll(VRing *vr);
+int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
+void virtio_setup_ccw(VDev *vdev);
 
 #endif /* VIRTIO_H */
-- 
1.8.3.1
