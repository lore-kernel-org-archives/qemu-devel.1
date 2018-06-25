Received: from eggs.gnu.org ([2001:4830:134:3::10]:53772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXPL5-0006Wr-AQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXPL3-0003QM-4D
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:07:19 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXPL2-0003Q8-T3
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:07:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id 69-v6so9494908wmf.3
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:07:16 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 25 Jun 2018 14:07:06 +0300
Message-Id: <20180625110706.23332-3-sameeh@daynix.com>
In-Reply-To: <20180625110706.23332-1-sameeh@daynix.com>
References: <20180625110706.23332-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC v2 2/2] virtio-net: Example Patch for using BPF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Amnon Ilan <ailan@redhat.com>

From: Sameeh Jubran <sjubran@redhat.com>

This commit is a sample only for using the libbpf in the code and
shouldn't be committed.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 hw/net/Makefile.objs | 4 ++++
 hw/net/virtio-net.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index fa461d4463..0fb271436d 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -37,6 +37,10 @@ obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
 
 obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
+ifeq ($(CONFIG_BPF),y)
+	virtio-net.o-cflags := $(CFLAGS_BPF)
+	virtio-net.o-libs := $(LIBS_BPF)
+endif
 obj-y += vhost_net.o
 
 obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 90502fca7c..b4840838c1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
+#include "standard-headers/linux/libbpf.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -1329,6 +1330,9 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
     VirtQueueElement *elem;
     int32_t num_packets = 0;
     int queue_index = vq2q(virtio_get_queue_index(q->tx_vq));
+
+    struct bpf_object *obj = NULL;
+    bpf_object__load(obj);
     if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         return num_packets;
     }
-- 
2.13.6
