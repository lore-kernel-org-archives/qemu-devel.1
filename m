Received: from eggs.gnu.org ([2001:4830:134:3::10]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiao.w.wang@intel.com>) id 1gCPSA-0006TZ-Fa
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiao.w.wang@intel.com>) id 1gCPS6-0008Uy-PA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:32:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:20618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiao.w.wang@intel.com>)
	id 1gCPS5-0008RS-2d
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:32:01 -0400
From: Xiao Wang <xiao.w.wang@intel.com>
Date: Tue, 16 Oct 2018 21:23:26 +0800
Message-Id: <20181016132327.121839-2-xiao.w.wang@intel.com>
In-Reply-To: <20181016132327.121839-1-xiao.w.wang@intel.com>
References: <20181016132327.121839-1-xiao.w.wang@intel.com>
Subject: [Qemu-devel] [RFC 1/2] vhost-vfio: introduce vhost-vfio net client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mst@redhat.com, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, cunming.liang@intel.com, xiaolong.ye@intel.com, zhihong.wang@intel.com, dan.daly@intel.com, Xiao Wang <xiao.w.wang@intel.com>

Following the patch (vhost: introduce mdev based hardware vhost backend)
https://lwn.net/Articles/750770/, which defines a generic mdev device for
vDPA (vhost data path acceleration), this patch set introduces a new net
client type: vhost-vfio.

Currently we have 2 types of vhost backends in QEMU: vhost kernel and
vhost-user. To implement a kernel space HW vhost, the above patch provides
a generic mdev device for vDPA purpose, this vDPA mdev device exposes to
user space a non-vendor-specific configuration interface for setting up
a vhost HW accelerator, this patch set introduces a third vhost backend
called vhost-vfio based on the vDPA mdev interface.

vhost-vfio net client will set up a vDPA mdev device which is specified
by a "sysfsdev" parameter, during the net client init, the device will be
opened and parsed using VFIO API, the VFIO device fd and device BAR region
pointers for BAR0 and BAR1 will be kept in a VhostVFIO structure.

This device initialization will provide a channel for the next patch to
pass vhost messages to vDPA kernel driver.

Vhost-vfio usage:

    qemu-system-x86_64 -cpu host -enable-kvm \
    <snip>
    -mem-prealloc \
    -netdev type=vhost-vfio,sysfsdev=/sys/bus/mdev/devices/$UUID,id=mynet\
    -device virtio-net-pci,netdv=mynet,page-per-vq=on \

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 hw/net/vhost_net.c                |  56 ++++++-
 hw/virtio/vhost.c                 |  15 ++
 include/hw/virtio/vhost-backend.h |   6 +-
 include/hw/virtio/vhost-vfio.h    |  35 ++++
 include/hw/virtio/vhost.h         |   2 +
 include/net/vhost-vfio.h          |  17 ++
 linux-headers/linux/vhost.h       |   9 ++
 net/Makefile.objs                 |   1 +
 net/clients.h                     |   3 +
 net/net.c                         |   1 +
 net/vhost-vfio.c                  | 327 ++++++++++++++++++++++++++++++++++++++
 qapi/net.json                     |  22 ++-
 12 files changed, 488 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/virtio/vhost-vfio.h
 create mode 100644 include/net/vhost-vfio.h
 create mode 100644 net/vhost-vfio.c

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63..76ba8a32 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -17,6 +17,7 @@
 #include "net/net.h"
 #include "net/tap.h"
 #include "net/vhost-user.h"
+#include "net/vhost-vfio.h"
 
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
@@ -87,6 +88,37 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
+/* Features supported by vhost vfio. */
+static const int vfio_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+
+    VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_CSUM,
+    VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_GSO,
+    VIRTIO_NET_F_GUEST_TSO4,
+    VIRTIO_NET_F_GUEST_TSO6,
+    VIRTIO_NET_F_GUEST_ECN,
+    VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_HOST_TSO4,
+    VIRTIO_NET_F_HOST_TSO6,
+    VIRTIO_NET_F_HOST_ECN,
+    VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
+
+    /* This bit implies RARP isn't sent by QEMU out of band */
+    VIRTIO_NET_F_GUEST_ANNOUNCE,
+
+    VIRTIO_NET_F_MQ,
+
+    VHOST_INVALID_FEATURE_BIT
+};
+
 static const int *vhost_net_get_feature_bits(struct vhost_net *net)
 {
     const int *feature_bits = 0;
@@ -98,6 +130,9 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
     case NET_CLIENT_DRIVER_VHOST_USER:
         feature_bits = user_feature_bits;
         break;
+    case NET_CLIENT_DRIVER_VHOST_VFIO:
+        feature_bits = vfio_feature_bits;
+        break;
     default:
         error_report("Feature bits not defined for this type: %d",
                 net->nc->info->type);
@@ -296,6 +331,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int r, e, i;
 
     if (!k->set_guest_notifiers) {
@@ -304,8 +340,6 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
-        struct vhost_net *net;
-
         net = get_vhost_net(ncs[i].peer);
         vhost_net_set_vq_index(net, i * 2);
 
@@ -341,6 +375,11 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         }
     }
 
+    net = get_vhost_net(ncs[0].peer);
+    if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_VFIO) {
+        r = vhost_set_state(&net->dev, VHOST_DEVICE_S_RUNNING);
+    }         // FIXME: support other device type too
+
     return 0;
 
 err_start:
@@ -362,8 +401,14 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int i, r;
 
+    net = get_vhost_net(ncs[0].peer);
+    if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_VFIO) {
+        r = vhost_set_state(&net->dev, VHOST_DEVICE_S_STOPPED);
+    }
+
     for (i = 0; i < total_queues; i++) {
         vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
     }
@@ -385,7 +430,8 @@ int vhost_net_notify_migration_done(struct vhost_net *net, char* mac_addr)
 {
     const VhostOps *vhost_ops = net->dev.vhost_ops;
 
-    assert(vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
+    assert(vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER ||
+		    vhost_ops->backend_type == VHOST_BACKEND_TYPE_VFIO);
     assert(vhost_ops->vhost_migration_done);
 
     return vhost_ops->vhost_migration_done(&net->dev, mac_addr);
@@ -418,6 +464,10 @@ VHostNetState *get_vhost_net(NetClientState *nc)
         vhost_net = vhost_user_get_vhost_net(nc);
         assert(vhost_net);
         break;
+    case NET_CLIENT_DRIVER_VHOST_VFIO:
+        vhost_net = vhost_vfio_get_vhost_net(nc);
+        assert(vhost_net);
+        break;
     default:
         break;
     }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d4cb5894..269cd498 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1598,3 +1598,18 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
 
     return -1;
 }
+
+/*
+ * XXX:
+ * state:
+ * 0 - stop
+ * 1 - start
+ */
+int vhost_set_state(struct vhost_dev *hdev, int state)
+{
+    if (hdev->vhost_ops->vhost_set_state) {
+        return hdev->vhost_ops->vhost_set_state(hdev, state);
+    }
+
+    return -1;
+}
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 81283ec5..89590ae6 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -17,7 +17,8 @@ typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_NONE = 0,
     VHOST_BACKEND_TYPE_KERNEL = 1,
     VHOST_BACKEND_TYPE_USER = 2,
-    VHOST_BACKEND_TYPE_MAX = 3,
+    VHOST_BACKEND_TYPE_VFIO = 3,
+    VHOST_BACKEND_TYPE_MAX = 4,
 } VhostBackendType;
 
 typedef enum VhostSetConfigType {
@@ -104,6 +105,8 @@ typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
 typedef bool (*vhost_backend_mem_section_filter_op)(struct vhost_dev *dev,
                                                 MemoryRegionSection *section);
 
+typedef int (*vhost_set_state_op)(struct vhost_dev *dev, int state);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -142,6 +145,7 @@ typedef struct VhostOps {
     vhost_crypto_create_session_op vhost_crypto_create_session;
     vhost_crypto_close_session_op vhost_crypto_close_session;
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
+    vhost_set_state_op vhost_set_state;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/hw/virtio/vhost-vfio.h b/include/hw/virtio/vhost-vfio.h
new file mode 100644
index 00000000..3ec0dfe2
--- /dev/null
+++ b/include/hw/virtio/vhost-vfio.h
@@ -0,0 +1,35 @@
+/*
+ * vhost-vfio
+ *
+ *  Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_VIRTIO_VHOST_VFIO_H
+#define HW_VIRTIO_VHOST_VFIO_H
+
+#include "hw/virtio/virtio.h"
+
+typedef struct VhostVFIONotifyCtx {
+    int qid;
+    int kick_fd;
+    void *addr;
+    MemoryRegion mr;
+} VhostVFIONotifyCtx;
+
+typedef struct VhostVFIO {
+    uint64_t bar0_offset;
+    uint64_t bar0_size;
+    uint64_t bar1_offset;
+    uint64_t bar1_size;
+    int device_fd;
+    int group_fd;
+    int container_fd;
+
+    VhostVFIONotifyCtx notify[VIRTIO_QUEUE_MAX];
+} VhostVFIO;
+
+#endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a7f449fa..db202d1d 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,8 @@ bool vhost_has_free_slot(void);
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
+int vhost_set_state(struct vhost_dev *hdev, int state);
+
 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 int vhost_dev_get_config(struct vhost_dev *dev, uint8_t *config,
                          uint32_t config_len);
diff --git a/include/net/vhost-vfio.h b/include/net/vhost-vfio.h
new file mode 100644
index 00000000..6d757284
--- /dev/null
+++ b/include/net/vhost-vfio.h
@@ -0,0 +1,17 @@
+/*
+ * vhost-vfio.h
+ *
+ * Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_VFIO_H
+#define VHOST_VFIO_H
+
+struct vhost_net;
+struct vhost_net *vhost_vfio_get_vhost_net(NetClientState *nc);
+
+#endif /* VHOST_VFIO_H */
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index e336395d..289f46a4 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -207,4 +207,13 @@ struct vhost_scsi_target {
 #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
 #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
 
+
+/* VHOST_DEVICE specific defines */
+
+#define VHOST_DEVICE_SET_STATE _IOW(VHOST_VIRTIO, 0x70, __u64)
+
+#define VHOST_DEVICE_S_STOPPED 0
+#define VHOST_DEVICE_S_RUNNING 1
+#define VHOST_DEVICE_S_MAX     2
+
 #endif
diff --git a/net/Makefile.objs b/net/Makefile.objs
index b2bf88a0..94f1e9dd 100644
--- a/net/Makefile.objs
+++ b/net/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-y += dump.o
 common-obj-y += eth.o
 common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
 common-obj-$(CONFIG_POSIX) += vhost-user.o
+common-obj-$(CONFIG_LINUX) += vhost-vfio.o
 common-obj-$(CONFIG_SLIRP) += slirp.o
 common-obj-$(CONFIG_VDE) += vde.o
 common-obj-$(CONFIG_NETMAP) += netmap.o
diff --git a/net/clients.h b/net/clients.h
index a6ef267e..7b3cbb4e 100644
--- a/net/clients.h
+++ b/net/clients.h
@@ -61,4 +61,7 @@ int net_init_netmap(const Netdev *netdev, const char *name,
 int net_init_vhost_user(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp);
 
+int net_init_vhost_vfio(const Netdev *netdev, const char *name,
+                        NetClientState *peer, Error **errp);
+
 #endif /* QEMU_NET_CLIENTS_H */
diff --git a/net/net.c b/net/net.c
index 2a313399..5430ab38 100644
--- a/net/net.c
+++ b/net/net.c
@@ -952,6 +952,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
         [NET_CLIENT_DRIVER_HUBPORT]   = net_init_hubport,
 #ifdef CONFIG_VHOST_NET_USED
         [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
+        [NET_CLIENT_DRIVER_VHOST_VFIO] = net_init_vhost_vfio,
 #endif
 #ifdef CONFIG_L2TPV3
         [NET_CLIENT_DRIVER_L2TPV3]    = net_init_l2tpv3,
diff --git a/net/vhost-vfio.c b/net/vhost-vfio.c
new file mode 100644
index 00000000..2814e53b
--- /dev/null
+++ b/net/vhost-vfio.c
@@ -0,0 +1,327 @@
+/*
+ * vhost-vfio.c
+ *
+ * Copyright(c) 2017-2018 Intel Corporation. All rights reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "clients.h"
+#include "net/vhost_net.h"
+#include "net/vhost-vfio.h"
+#include "hw/virtio/vhost-vfio.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-net.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "trace.h"
+
+typedef struct VhostVFIOState {
+    NetClientState nc;
+    VhostVFIO vhost_vfio;
+    VHostNetState *vhost_net;
+} VhostVFIOState;
+
+VHostNetState *vhost_vfio_get_vhost_net(NetClientState *nc)
+{
+    VhostVFIOState *s = DO_UPCAST(VhostVFIOState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VFIO);
+    return s->vhost_net;
+}
+
+static int vhost_vfio_start(int queues, NetClientState *ncs[], void *be)
+{
+    VhostNetOptions options;
+    struct vhost_net *net = NULL;
+    VhostVFIOState *s;
+    int max_queues;
+    int i;
+
+    options.backend_type = VHOST_BACKEND_TYPE_VFIO;
+
+    for (i = 0; i < queues; i++) {
+        assert(ncs[i]->info->type == NET_CLIENT_DRIVER_VHOST_VFIO);
+
+        s = DO_UPCAST(VhostVFIOState, nc, ncs[i]);
+
+        options.net_backend = ncs[i];
+        options.opaque      = be;
+        options.busyloop_timeout = 0;
+        net = vhost_net_init(&options);
+        if (!net) {
+            error_report("failed to init vhost_net for queue %d", i);
+            goto err;
+        }
+
+        if (i == 0) {
+            max_queues = vhost_net_get_max_queues(net);
+            if (queues > max_queues) {
+                error_report("you are asking more queues than supported: %d",
+                             max_queues);
+                goto err;
+            }
+        }
+
+        if (s->vhost_net) {
+            vhost_net_cleanup(s->vhost_net);
+            g_free(s->vhost_net);
+        }
+        s->vhost_net = net;
+    }
+
+    return 0;
+
+err:
+    if (net)
+        vhost_net_cleanup(net);
+
+    for (i = 0; i < queues; i++) {
+        s = DO_UPCAST(VhostVFIOState, nc, ncs[i]);
+        if (s->vhost_net)
+            vhost_net_cleanup(s->vhost_net);
+    }
+
+    return -1;
+}
+
+static ssize_t vhost_vfio_receive(NetClientState *nc, const uint8_t *buf,
+                                  size_t size)
+{
+    /* In case of RARP (message size is 60) notify backup to send a fake RARP.
+       This fake RARP will be sent by backend only for guest
+       without GUEST_ANNOUNCE capability.
+     */
+    if (size == 60) {
+        VhostVFIOState *s = DO_UPCAST(VhostVFIOState, nc, nc);
+        int r;
+        static int display_rarp_failure = 1;
+        char mac_addr[6];
+
+        /* extract guest mac address from the RARP message */
+        memcpy(mac_addr, &buf[6], 6);
+
+        r = vhost_net_notify_migration_done(s->vhost_net, mac_addr);
+
+        if ((r != 0) && (display_rarp_failure)) {
+            fprintf(stderr,
+                    "Vhost vfio backend fails to broadcast fake RARP\n");
+            fflush(stderr);
+            display_rarp_failure = 0;
+        }
+    }
+
+    return size;
+}
+
+static void vhost_vfio_cleanup(NetClientState *nc)
+{
+    VhostVFIOState *s = DO_UPCAST(VhostVFIOState, nc, nc);
+
+    if (s->vhost_net) {
+        vhost_net_cleanup(s->vhost_net);
+        g_free(s->vhost_net);
+        s->vhost_net = NULL;
+    }
+    if (nc->queue_index == 0) {
+	    if (s->vhost_vfio.device_fd != -1) {
+		    close(s->vhost_vfio.device_fd);
+		    s->vhost_vfio.device_fd = -1;
+	    }
+	    if (s->vhost_vfio.group_fd != -1) {
+		    close(s->vhost_vfio.group_fd);
+		    s->vhost_vfio.group_fd = -1;
+	    }
+	    if (s->vhost_vfio.container_fd != -1) {
+		    close(s->vhost_vfio.container_fd);
+		    s->vhost_vfio.container_fd = -1;
+	    }
+    }
+
+    qemu_purge_queued_packets(nc);
+}
+
+static NetClientInfo net_vhost_vfio_info = {
+        .type = NET_CLIENT_DRIVER_VHOST_VFIO,
+        .size = sizeof(VhostVFIOState),
+        .receive = vhost_vfio_receive,
+        .cleanup = vhost_vfio_cleanup,
+};
+
+// XXX: to be cleaned up, rely on QEMU vfio API in future
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+#include <err.h>
+
+static int net_vhost_vfio_init(NetClientState *peer, const char *device,
+                               const char *name, const char *sysfsdev,
+                               int queues)
+{
+    NetClientState *nc, *nc0 = NULL;
+    NetClientState *ncs[MAX_QUEUE_NUM];
+    VhostVFIOState *s;
+    int i;
+
+    assert(name);
+    assert(queues > 0);
+
+    for (i = 0; i < queues; i++) {
+        nc = qemu_new_net_client(&net_vhost_vfio_info, peer, device, name);
+        snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vfio%d to %s", i, name);
+        nc->queue_index = i;
+        if (!nc0) {
+            nc0 = nc;
+            s = DO_UPCAST(VhostVFIOState, nc, nc);
+        }
+
+        ncs[i]= nc;
+    }
+
+    int vfio_container_fd = -1;
+    int vfio_group_fd = -1;
+    int vfio_device_fd = -1;
+    int ret;
+
+    char linkname[PATH_MAX];
+    char pathname[PATH_MAX];
+    char *filename;
+    int group_no;
+
+    vfio_container_fd = open("/dev/vfio/vfio", O_RDWR);
+    if (vfio_container_fd == -1)
+        err(EXIT_FAILURE, "open(/dev/vfio/vfio)");
+
+    ret = ioctl(vfio_container_fd, VFIO_GET_API_VERSION);
+    if (ret < 0)
+        err(EXIT_FAILURE, "vfio get API version for container");
+
+    snprintf(linkname, sizeof(linkname), "%s/iommu_group", sysfsdev);
+    ret = readlink(linkname, pathname, sizeof(pathname));
+    if (ret < 0)
+        err(EXIT_FAILURE, "readlink(%s)", linkname);
+
+    filename = g_path_get_basename(pathname);
+    group_no = atoi(filename);
+    g_free(filename);
+    snprintf(pathname, sizeof(pathname), "/dev/vfio/%d", group_no);
+
+    vfio_group_fd = open(pathname, O_RDWR);
+    if (vfio_group_fd == -1)
+        err(EXIT_FAILURE, "open(%s)", pathname);
+
+    if (vfio_group_fd == 0)
+        err(EXIT_FAILURE, "%s not managed by VFIO driver", sysfsdev);
+
+    ret = ioctl(vfio_group_fd, VFIO_GROUP_SET_CONTAINER, &vfio_container_fd);
+    if (ret)
+        err(EXIT_FAILURE, "failed set container");
+
+    ret = ioctl(vfio_container_fd, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU);
+    if (ret)
+        err(EXIT_FAILURE, "failed set IOMMU");
+
+    filename = g_path_get_basename(sysfsdev);
+
+    vfio_device_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD, filename);
+    if (vfio_device_fd < 0)
+        err(EXIT_FAILURE, "failed to get device fd");
+
+    g_free(filename);
+
+    struct vfio_device_info device_info = {
+        .argsz = sizeof(device_info),
+    };
+
+    ret = ioctl(vfio_device_fd, VFIO_DEVICE_GET_INFO, &device_info);
+    if (ret)
+        err(EXIT_FAILURE, "failed to get device info");
+
+    for (i = 0; i < device_info.num_regions; i++) {
+        struct vfio_region_info region_info = {
+            .argsz = sizeof(region_info),
+        };
+
+        region_info.index = i;
+
+        ret = ioctl(vfio_device_fd, VFIO_DEVICE_GET_REGION_INFO, &region_info);
+        if (ret)
+            err(EXIT_FAILURE, "failed to get region info for region %d", i);
+
+        if (region_info.size == 0)
+            continue;
+
+        if (i == VFIO_PCI_BAR0_REGION_INDEX) {
+            s->vhost_vfio.bar0_offset = region_info.offset;
+            s->vhost_vfio.bar0_size   = region_info.size;
+        } else if (i == VFIO_PCI_BAR1_REGION_INDEX) {
+            s->vhost_vfio.bar1_offset = region_info.offset;
+            s->vhost_vfio.bar1_size   = region_info.size;
+        }
+    }
+
+    if (s->vhost_vfio.bar0_size == 0 || s->vhost_vfio.bar1_size == 0)
+            err(EXIT_FAILURE, "failed to get valid vdpa device");
+
+    s->vhost_vfio.device_fd = vfio_device_fd;
+    s->vhost_vfio.group_fd  = vfio_group_fd;
+    s->vhost_vfio.container_fd  = vfio_container_fd;
+
+    vhost_vfio_start(queues, ncs, (void *)&s->vhost_vfio);
+
+    assert(s->vhost_net);
+
+    return 0;
+}
+
+static int net_vhost_check_net(void *opaque, QemuOpts *opts, Error **errp)
+{
+    const char *name = opaque;
+    const char *driver, *netdev;
+
+    driver = qemu_opt_get(opts, "driver");
+    netdev = qemu_opt_get(opts, "netdev");
+
+    if (!driver || !netdev) {
+        return 0;
+    }
+
+    if (strcmp(netdev, name) == 0 &&
+        !g_str_has_prefix(driver, "virtio-net-")) {
+        error_setg(errp, "vhost-vfio requires frontend driver virtio-net-*");
+        return -1;
+    }
+
+    return 0;
+}
+
+int net_init_vhost_vfio(const Netdev *netdev, const char *name,
+                        NetClientState *peer, Error **errp)
+{
+    int queues;
+    const NetdevVhostVFIOOptions *vhost_vfio_opts;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_VHOST_VFIO);
+    vhost_vfio_opts = &netdev->u.vhost_vfio;
+
+    /* verify net frontend */
+    if (qemu_opts_foreach(qemu_find_opts("device"), net_vhost_check_net,
+                          (char *)name, errp)) {
+        return -1;
+    }
+
+    queues = vhost_vfio_opts->has_queues ? vhost_vfio_opts->queues : 1;
+    if (queues < 1 || queues > MAX_QUEUE_NUM) {
+        error_setg(errp,
+                   "vhost-vfio number of queues must be in range [1, %d]",
+                   MAX_QUEUE_NUM);
+        return -1;
+    }
+
+    return net_vhost_vfio_init(peer, "vhost_vfio", name,
+                               vhost_vfio_opts->sysfsdev, queues);
+
+    return 0;
+}
diff --git a/qapi/net.json b/qapi/net.json
index c86f3511..65c77c45 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -437,6 +437,23 @@
     '*vhostforce':    'bool',
     '*queues':        'int' } }
 
+##
+# @NetdevVhostVFIOOptions:
+#
+# Vhost-vfio network backend
+#
+# @sysfsdev: name of a mdev dev path in sysfs
+#
+# @queues: number of queues to be created for multiqueue vhost-vfio
+#          (default: 1) (Since 2.11)
+#
+# Since: 2.11
+##
+{ 'struct': 'NetdevVhostVFIOOptions',
+  'data': {
+    '*sysfsdev':     'str',
+    '*queues':       'int' } }
+
 ##
 # @NetClientDriver:
 #
@@ -448,7 +465,7 @@
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
+            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vfio' ] }
 
 ##
 # @Netdev:
@@ -476,7 +493,8 @@
     'bridge':   'NetdevBridgeOptions',
     'hubport':  'NetdevHubPortOptions',
     'netmap':   'NetdevNetmapOptions',
-    'vhost-user': 'NetdevVhostUserOptions' } }
+    'vhost-user': 'NetdevVhostUserOptions',
+    'vhost-vfio': 'NetdevVhostVFIOOptions' } }
 
 ##
 # @NetLegacy:
-- 
2.15.1
