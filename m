Received: from eggs.gnu.org ([2001:4830:134:3::10]:54994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozK-0008IR-Ot
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPozJ-0003wf-Au
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPozJ-0003wU-2W
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:57 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:17 +0200
Message-Id: <1498564100-10045-12-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 11/14] pc-bios/s390-ccw: Add virtio-net
 driver code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

This virtio-net driver contains the recv() and send() functions
that are required by libnet to receive and send packets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile     |   2 +-
 pc-bios/s390-ccw/virtio-net.c | 125 ++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio.c     |  16 ++++--
 pc-bios/s390-ccw/virtio.h     |  11 ++++
 4 files changed, 149 insertions(+), 5 deletions(-)
 create mode 100644 pc-bios/s390-ccw/virtio-net.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 02b9b08..369bd65 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all libc.a libnet.a
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-net.o
 OBJECTS += libc.a sbrk.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
new file mode 100644
index 0000000..5c2f439
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -0,0 +1,125 @@
+/*
+ * Virtio-net driver for the s390-ccw firmware
+ *
+ * Copyright 2017 Thomas Huth, Red Hat Inc.
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include "libnet/ethernet.h"
+#include "virtio.h"
+
+#define VQ_RX 0         /* Receive queue */
+#define VQ_TX 1         /* Transmit queue */
+
+struct VirtioNetHdr {
+    uint8_t flags;
+    uint8_t gso_type;
+    uint16_t hdr_len;
+    uint16_t gso_size;
+    uint16_t csum_start;
+    uint16_t csum_offset;
+    /*uint16_t num_buffers;*/ /* Only with VIRTIO_NET_F_MRG_RXBUF or VIRTIO1 */
+};
+typedef struct VirtioNetHdr VirtioNetHdr;
+
+static uint16_t rx_last_idx;  /* Last index in receive queue "used" ring */
+
+int socket(int domain, int type, int proto, char *mac_addr)
+{
+    VDev *vdev = virtio_get_device();
+    VRing *rxvq = &vdev->vrings[VQ_RX];
+    void *buf;
+    int i;
+
+    memcpy(mac_addr, vdev->config.net.mac, ETH_ALEN);
+
+    for (i = 0; i < 64; i++) {
+        buf = malloc(ETH_MTU_SIZE + sizeof(VirtioNetHdr));
+        IPL_assert(buf != NULL, "Can not allocate memory for receive buffers");
+        vring_send_buf(rxvq, buf, ETH_MTU_SIZE + sizeof(VirtioNetHdr),
+                       VRING_DESC_F_WRITE);
+    }
+    vring_notify(rxvq);
+
+    return 0;
+}
+
+int send(int fd, const void *buf, int len, int flags)
+{
+    VirtioNetHdr tx_hdr;
+    VDev *vdev = virtio_get_device();
+    VRing *txvq = &vdev->vrings[VQ_TX];
+
+    /* Set up header - we do not use anything special, so simply clear it */
+    memset(&tx_hdr, 0, sizeof(tx_hdr));
+
+    vring_send_buf(txvq, &tx_hdr, sizeof(tx_hdr), VRING_DESC_F_NEXT);
+    vring_send_buf(txvq, (void *)buf, len, VRING_HIDDEN_IS_CHAIN);
+    while (!vr_poll(txvq)) {
+        yield();
+    }
+    if (drain_irqs(txvq->schid)) {
+        puts("send: drain irqs failed");
+        return -1;
+    }
+
+    return len;
+}
+
+int recv(int fd, void *buf, int maxlen, int flags)
+{
+    VDev *vdev = virtio_get_device();
+    VRing *rxvq = &vdev->vrings[VQ_RX];
+    int len, id;
+    uint8_t *pkt;
+
+    if (rx_last_idx == rxvq->used->idx) {
+        return 0;
+    }
+
+    len = rxvq->used->ring[rx_last_idx % rxvq->num].len - sizeof(VirtioNetHdr);
+    if (len > maxlen) {
+        puts("virtio-net: Receive buffer too small");
+        len = maxlen;
+    }
+    id = rxvq->used->ring[rx_last_idx % rxvq->num].id % rxvq->num;
+    pkt = (uint8_t *)(rxvq->desc[id].addr + sizeof(VirtioNetHdr));
+
+#if 0
+    /* Dump packet */
+    printf("\nbuf %p: len=%i\n", (void*)rxvq->desc[id].addr, len);
+    int i;
+    for (i = 0; i < 64; i++) {
+        printf(" %02x", pkt[i]);
+        if ((i%16)==15)
+            printf("\n");
+    }
+    printf("\n");
+#endif
+
+    /* Copy data to destination buffer */
+    memcpy(buf, pkt, len);
+
+    /* Mark buffer as available to the host again */
+    rxvq->avail->ring[rxvq->avail->idx % rxvq->num] = id;
+    rxvq->avail->idx = rxvq->avail->idx + 1;
+    vring_notify(rxvq);
+
+    /* Move index to next entry */
+    rx_last_idx = rx_last_idx + 1;
+
+    return len;
+}
+
+int close(int fd)
+{
+    return 0;
+}
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 6ee93d5..b5219aa 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -69,7 +69,7 @@ static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
  *             Virtio functions                *
  ***********************************************/
 
-static int drain_irqs(SubChannelId schid)
+int drain_irqs(SubChannelId schid)
 {
     Irb irb = {};
     int r = 0;
@@ -148,13 +148,13 @@ static void vring_init(VRing *vr, VqInfo *info)
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
@@ -187,7 +187,7 @@ ulong get_second(void)
     return (get_clock() >> 12) / 1000000;
 }
 
-static int vr_poll(VRing *vr)
+int vr_poll(VRing *vr)
 {
     if (vr->used->idx == vr->used_idx) {
         vring_notify(vr);
@@ -495,6 +495,11 @@ static void virtio_setup_ccw(VDev *vdev)
     run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
 
     switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_NET:
+        vdev->nr_vqs = 3;
+        vdev->cmd_vr_idx = 0;
+        cfg_size = sizeof(vdev->config.net);
+        break;
     case VIRTIO_ID_BLOCK:
         vdev->nr_vqs = 1;
         vdev->cmd_vr_idx = 0;
@@ -549,6 +554,9 @@ void virtio_setup_device(SubChannelId schid)
     virtio_setup_ccw(&vdev);
 
     switch (vdev.senseid.cu_model) {
+    case VIRTIO_ID_NET:
+        sclp_print("Using virtio-net.\n");
+        break;
     case VIRTIO_ID_BLOCK:
         sclp_print("Using virtio-blk.\n");
         if (!virtio_ipl_disk_is_valid()) {
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 1eaf865..b4e0f41 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -254,6 +254,12 @@ struct ScsiDevice {
 };
 typedef struct ScsiDevice ScsiDevice;
 
+struct VirtioNetConfig {
+     uint8_t mac[6];
+     uint16_t status;
+};
+typedef struct VirtioNetConfig VirtioNetConfig;
+
 struct VDev {
     int nr_vqs;
     VRing *vrings;
@@ -266,6 +272,7 @@ struct VDev {
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
+        VirtioNetConfig net;
     } config;
     ScsiDevice *scsi_device;
     bool is_cdrom;
@@ -291,6 +298,10 @@ struct VirtioCmd {
 };
 typedef struct VirtioCmd VirtioCmd;
 
+bool vring_notify(VRing *vr);
+int drain_irqs(SubChannelId schid);
+void vring_send_buf(VRing *vr, void *p, int len, int flags);
+int vr_poll(VRing *vr);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 
 #endif /* VIRTIO_H */
-- 
1.8.3.1
