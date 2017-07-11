Received: from eggs.gnu.org ([2001:4830:134:3::10]:54725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvf3-000565-LL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUvf2-0004HL-Eu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUvf2-0004H1-5M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:57:08 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 11 Jul 2017 15:56:36 +0200
Message-Id: <1499781397-19749-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1499781397-19749-1-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/11] pc-bios/s390-ccw: Add virtio-net
 driver code
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

The driver provides the recv() and send() functions which will
be required by SLOF's libnet code for receiving and sending
packets.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/netboot.mak  |   2 +-
 pc-bios/s390-ccw/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio.c     |   5 ++
 pc-bios/s390-ccw/virtio.h     |  12 +++-
 4 files changed, 151 insertions(+), 3 deletions(-)
 create mode 100644 pc-bios/s390-ccw/virtio-net.c

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index 1eaa0d8..dd9119a 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -1,7 +1,7 @@
 
 SLOF_DIR := $(SRC_PATH)/roms/SLOF
 
-NETOBJS := start.o sclp.o virtio.o netmain.o sbrk.o libc.a
+NETOBJS := start.o sclp.o virtio.o virtio-net.o netmain.o sbrk.o libc.a
 
 LIBC_INC := -I$(SLOF_DIR)/lib/libc/include
 LIBNET_INC := -I$(SLOF_DIR)/lib/libnet
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
new file mode 100644
index 0000000..ff7f4da
--- /dev/null
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -0,0 +1,135 @@
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
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <ethernet.h>
+#include "s390-ccw.h"
+#include "virtio.h"
+
+#ifndef DEBUG_VIRTIO_NET
+#define DEBUG_VIRTIO_NET 0
+#endif
+
+#define VIRTIO_NET_F_MAC_BIT  (1 << 5)
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
+int virtio_net_init(void *mac_addr)
+{
+    VDev *vdev = virtio_get_device();
+    VRing *rxvq = &vdev->vrings[VQ_RX];
+    void *buf;
+    int i;
+
+    vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
+    virtio_setup_ccw(vdev);
+
+    IPL_assert(vdev->guest_features[0] & VIRTIO_NET_F_MAC_BIT,
+               "virtio-net device does not support the MAC address feature");
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
+#if DEBUG_VIRTIO_NET   /* Dump packet */
+    int i;
+    printf("\nbuf %p: len=%i\n", (void *)rxvq->desc[id].addr, len);
+    for (i = 0; i < 64; i++) {
+        printf(" %02x", pkt[i]);
+        if ((i % 16) == 15) {
+            printf("\n");
+        }
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
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 18fc5d1..c890a03 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -266,6 +266,11 @@ void virtio_setup_ccw(VDev *vdev)
     run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0);
 
     switch (vdev->senseid.cu_model) {
+    case VIRTIO_ID_NET:
+        vdev->nr_vqs = 2;
+        vdev->cmd_vr_idx = 0;
+        cfg_size = sizeof(vdev->config.net);
+        break;
     case VIRTIO_ID_BLOCK:
         vdev->nr_vqs = 1;
         vdev->cmd_vr_idx = 0;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index a00a320..19fceb6 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -11,8 +11,6 @@
 #ifndef VIRTIO_H
 #define VIRTIO_H
 
-#include "s390-ccw.h"
-
 /* Status byte for guest to report progress, and synchronize features. */
 /* We have seen device and processed generic fields (VIRTIO_CONFIG_F_VIRTIO) */
 #define VIRTIO_CONFIG_S_ACKNOWLEDGE     1
@@ -227,6 +225,13 @@ struct ScsiDevice {
 };
 typedef struct ScsiDevice ScsiDevice;
 
+struct VirtioNetConfig {
+    uint8_t mac[6];
+    /* uint16_t status; */               /* Only with VIRTIO_NET_F_STATUS */
+    /* uint16_t max_virtqueue_pairs; */  /* Only with VIRTIO_NET_F_MQ */
+};
+typedef struct VirtioNetConfig VirtioNetConfig;
+
 struct VDev {
     int nr_vqs;
     VRing *vrings;
@@ -239,6 +244,7 @@ struct VDev {
     union {
         VirtioBlkConfig blk;
         VirtioScsiConfig scsi;
+        VirtioNetConfig net;
     } config;
     ScsiDevice *scsi_device;
     bool is_cdrom;
@@ -273,4 +279,6 @@ int vring_wait_reply(void);
 int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd);
 void virtio_setup_ccw(VDev *vdev);
 
+int virtio_net_init(void *mac_addr);
+
 #endif /* VIRTIO_H */
-- 
1.8.3.1
