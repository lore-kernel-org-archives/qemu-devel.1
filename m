Received: from eggs.gnu.org ([2001:4830:134:3::10]:60879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1exp30-0002i0-FU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1exp2z-0008Up-3k
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1exp2y-0008Rg-O9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 03:17:33 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 19 Mar 2018 15:15:34 +0800
Message-Id: <20180319071537.28649-4-tiwei.bie@intel.com>
In-Reply-To: <20180319071537.28649-1-tiwei.bie@intel.com>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v2 3/6] virtio: support adding sub-regions for
 notify region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

Provide APIs to support querying whether the page-per-vq
is enabled and adding sub-regions for notify region.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 Makefile.target            |  4 ++++
 hw/virtio/virtio-pci.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-pci.h     |  5 +++++
 hw/virtio/virtio.c         | 39 +++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h |  5 +++++
 include/qemu/osdep.h       |  1 +
 scripts/create_config      |  3 +++
 7 files changed, 105 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index 6549481096..b2cf618dc9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -39,6 +39,9 @@ STPFILES=
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
 
+config-devices.h: config-devices.h-timestamp
+config-devices.h-timestamp: config-devices.mak
+
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp
 
@@ -224,4 +227,5 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 endif
 
 GENERATED_FILES += config-target.h
+GENERATED_FILES += config-devices.h
 Makefile: $(GENERATED_FILES)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1e8ab7bbc5..b17471092a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1534,6 +1534,54 @@ static void virtio_pci_modern_io_region_unmap(VirtIOPCIProxy *proxy,
                                 &region->mr);
 }
 
+static VirtIOPCIProxy *virtio_device_to_virtio_pci_proxy(VirtIODevice *vdev)
+{
+    VirtIOPCIProxy *proxy = NULL;
+
+    if (vdev->device_id == VIRTIO_ID_NET) {
+        VirtIONetPCI *d = container_of(vdev, VirtIONetPCI, vdev.parent_obj);
+        proxy = &d->parent_obj;
+    }
+
+    return proxy;
+}
+
+bool virtio_pci_page_per_vq_enabled(VirtIODevice *vdev)
+{
+    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
+
+    if (proxy == NULL) {
+        return false;
+    }
+
+    return !!(proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ);
+}
+
+int virtio_pci_notify_region_map(VirtIODevice *vdev, int queue_idx,
+                                 MemoryRegion *mr)
+{
+    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
+    int offset;
+
+    if (proxy == NULL || !virtio_pci_modern(proxy)) {
+        return -1;
+    }
+
+    offset = virtio_pci_queue_mem_mult(proxy) * queue_idx;
+    memory_region_add_subregion(&proxy->notify.mr, offset, mr);
+
+    return 0;
+}
+
+void virtio_pci_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr)
+{
+    VirtIOPCIProxy *proxy = virtio_device_to_virtio_pci_proxy(vdev);
+
+    if (proxy != NULL) {
+        memory_region_del_subregion(&proxy->notify.mr, mr);
+    }
+}
+
 static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..8061133741 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -213,6 +213,11 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
     proxy->disable_modern = true;
 }
 
+bool virtio_pci_page_per_vq_enabled(VirtIODevice *vdev);
+int virtio_pci_notify_region_map(VirtIODevice *vdev, int queue_idx,
+                                 MemoryRegion *mr);
+void virtio_pci_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr);
+
 /*
  * virtio-scsi-pci: This extends VirtioPCIProxy.
  */
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 006d3d1148..90ee72984c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -22,6 +22,7 @@
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
+#include "hw/virtio/virtio-pci.h"
 #include "sysemu/dma.h"
 
 /*
@@ -2681,6 +2682,44 @@ void virtio_device_release_ioeventfd(VirtIODevice *vdev)
     virtio_bus_release_ioeventfd(vbus);
 }
 
+bool virtio_device_parent_is_pci_device(VirtIODevice *vdev)
+{
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    const char *typename = object_get_typename(OBJECT(qbus->parent));
+
+    return strstr(typename, "pci") != NULL;
+}
+
+bool virtio_device_page_per_vq_enabled(VirtIODevice *vdev)
+{
+#ifdef CONFIG_VIRTIO_PCI
+    if (virtio_device_parent_is_pci_device(vdev)) {
+        return virtio_pci_page_per_vq_enabled(vdev);
+    }
+#endif
+    return false;
+}
+
+int virtio_device_notify_region_map(VirtIODevice *vdev, int queue_idx,
+                                    MemoryRegion *mr)
+{
+#ifdef CONFIG_VIRTIO_PCI
+    if (virtio_device_parent_is_pci_device(vdev)) {
+        return virtio_pci_notify_region_map(vdev, queue_idx, mr);
+    }
+#endif
+    return -1;
+}
+
+void virtio_device_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr)
+{
+#ifdef CONFIG_VIRTIO_PCI
+    if (virtio_device_parent_is_pci_device(vdev)) {
+        virtio_pci_notify_region_unmap(vdev, mr);
+    }
+#endif
+}
+
 static void virtio_device_class_init(ObjectClass *klass, void *data)
 {
     /* Set the default value here. */
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 098bdaaea3..b14accdb08 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -285,6 +285,11 @@ void virtio_device_stop_ioeventfd(VirtIODevice *vdev);
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
+bool virtio_device_parent_is_pci_device(VirtIODevice *vdev);
+bool virtio_device_page_per_vq_enabled(VirtIODevice *vdev);
+int virtio_device_notify_region_map(VirtIODevice *vdev, int queue_idx,
+                                    MemoryRegion *mr);
+void virtio_device_notify_region_unmap(VirtIODevice *vdev, MemoryRegion *mr);
 EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
 void virtio_queue_host_notifier_read(EventNotifier *n);
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 41658060a7..2532c278ef 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -30,6 +30,7 @@
 #include "config-host.h"
 #ifdef NEED_CPU_H
 #include "config-target.h"
+#include "config-devices.h"
 #else
 #include "exec/poison.h"
 #endif
diff --git a/scripts/create_config b/scripts/create_config
index d727e5e36e..e4541a51ed 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -58,6 +58,9 @@ case $line in
     name=${line%=*}
     echo "#define $name 1"
     ;;
+ CONFIG_*='$(CONFIG_'*')') # configuration
+    continue
+    ;;
  CONFIG_*=*) # configuration
     name=${line%=*}
     value=${line#*=}
-- 
2.11.0
