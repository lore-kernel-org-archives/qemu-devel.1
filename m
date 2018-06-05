Received: from eggs.gnu.org ([2001:4830:134:3::10]:54917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIEM-0003nI-Ck
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIEK-0003EV-O1
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fQIEK-0003Dw-Ff
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E2BCC0587C9
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 20:06:55 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 05 Jun 2018 14:06:50 -0600
Message-ID: <20180605200650.24323.79466.stgit@gimli.home>
In-Reply-To: <20180605200425.24323.56023.stgit@gimli.home>
References: <20180605200425.24323.56023.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 5/6] vfio/quirks: Enable ioeventfd quirks to be
 handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With vfio ioeventfd support, we can program vfio-pci to perform a
specified BAR write when an eventfd is triggered.  This allows the
KVM ioeventfd to be wired directly to vfio-pci, entirely avoiding
userspace handling for these events.  On the same micro-benchmark
where the ioeventfd got us to almost 90% of performance versus
disabling the GeForce quirks, this gets us to within 95%.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |   53 +++++++++++++++++++++++++++++++++++++++++++-------
 hw/vfio/pci.c        |    2 ++
 hw/vfio/pci.h        |    2 ++
 hw/vfio/trace-events |    2 +-
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index f7886487744e..061259b86b71 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -16,6 +16,7 @@
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include <sys/ioctl.h>
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
 #include "trace.h"
@@ -287,12 +288,33 @@ static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
     return quirk;
 }
 
-static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
+static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
 {
     QLIST_REMOVE(ioeventfd, next);
     memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
                               true, ioeventfd->data, &ioeventfd->e);
-    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
+
+    if (ioeventfd->vfio) {
+        struct vfio_device_ioeventfd vfio_ioeventfd;
+
+        vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
+        vfio_ioeventfd.flags = ioeventfd->size;
+        vfio_ioeventfd.data = ioeventfd->data;
+        vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
+                                ioeventfd->region_addr;
+        vfio_ioeventfd.fd = -1;
+
+        if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd)) {
+            error_report("Failed to remove vfio ioeventfd for %s+0x%"
+                         HWADDR_PRIx"[%d]:0x%"PRIx64" (%m)",
+                         memory_region_name(ioeventfd->mr), ioeventfd->addr,
+                         ioeventfd->size, ioeventfd->data);
+        }
+    } else {
+        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
+                            NULL, NULL, NULL);
+    }
+
     event_notifier_cleanup(&ioeventfd->e);
     trace_vfio_ioeventfd_exit(memory_region_name(ioeventfd->mr),
                               (uint64_t)ioeventfd->addr, ioeventfd->size,
@@ -306,7 +328,7 @@ static void vfio_drop_dynamic_eventfds(VFIOPCIDevice *vdev, VFIOQuirk *quirk)
 
     QLIST_FOREACH_SAFE(ioeventfd, &quirk->ioeventfds, next, tmp) {
         if (ioeventfd->dynamic) {
-            vfio_ioeventfd_exit(ioeventfd);
+            vfio_ioeventfd_exit(vdev, ioeventfd);
         }
     }
 }
@@ -359,12 +381,29 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
     ioeventfd->region = region;
     ioeventfd->region_addr = region_addr;
 
-    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
-                        vfio_ioeventfd_handler, NULL, ioeventfd);
+    if (!vdev->no_vfio_ioeventfd) {
+        struct vfio_device_ioeventfd vfio_ioeventfd;
+
+        vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
+        vfio_ioeventfd.flags = ioeventfd->size;
+        vfio_ioeventfd.data = ioeventfd->data;
+        vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
+                                ioeventfd->region_addr;
+        vfio_ioeventfd.fd = event_notifier_get_fd(&ioeventfd->e);
+
+        ioeventfd->vfio = !ioctl(vdev->vbasedev.fd,
+                                 VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
+    }
+
+    if (!ioeventfd->vfio) {
+        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
+                            vfio_ioeventfd_handler, NULL, ioeventfd);
+    }
+
     memory_region_add_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
                               true, ioeventfd->data, &ioeventfd->e);
     trace_vfio_ioeventfd_init(memory_region_name(mr), (uint64_t)addr,
-                              size, data);
+                              size, data, ioeventfd->vfio);
 
     return ioeventfd;
 }
@@ -1827,7 +1866,7 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
 
     QLIST_FOREACH(quirk, &bar->quirks, next) {
         while (!QLIST_EMPTY(&quirk->ioeventfds)) {
-            vfio_ioeventfd_exit(QLIST_FIRST(&quirk->ioeventfds));
+            vfio_ioeventfd_exit(vdev, QLIST_FIRST(&quirk->ioeventfds));
         }
 
         for (i = 0; i < quirk->nr_mem; i++) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ba1239551115..84e27c7bb2d1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3177,6 +3177,8 @@ static Property vfio_pci_dev_properties[] = {
                      no_geforce_quirks, false),
     DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
                      false),
+    DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
+                     false),
     DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a4ac583fbd6e..52b065421a68 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -34,6 +34,7 @@ typedef struct VFIOIOEventFD {
     VFIORegion *region;
     hwaddr region_addr;
     bool dynamic; /* Added runtime, removed on device reset */
+    bool vfio;
 } VFIOIOEventFD;
 
 typedef struct VFIOQuirk {
@@ -163,6 +164,7 @@ typedef struct VFIOPCIDevice {
     bool no_kvm_msix;
     bool no_geforce_quirks;
     bool no_kvm_ioeventfd;
+    bool no_vfio_ioeventfd;
     VFIODisplay *dpy;
 } VFIOPCIDevice;
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f8f97d1ff90c..d2a74952e389 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -79,7 +79,7 @@ vfio_quirk_ati_bonaire_reset_done(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset(const char *name) "%s"
 vfio_ioeventfd_exit(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d]:0x%"PRIx64
 vfio_ioeventfd_handler(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d] -> 0x%"PRIx64
-vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d]:0x%"PRIx64
+vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size, uint64_t data, bool vfio) "%s+0x%"PRIx64"[%d]:0x%"PRIx64" vfio:%d"
 vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [0x%03x] 0x%08x -> 0x%08x"
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_opregion_enabled(const char *name) "%s"
