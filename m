Received: from eggs.gnu.org ([2001:4830:134:3::10]:35686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1er8cU-0004Ke-B2
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1er8cR-0003zR-8q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:46:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1er8cQ-0003ys-Vx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:46:31 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 28 Feb 2018 13:46:20 -0700
Message-ID: <20180228204620.26629.74688.stgit@gimli.home>
In-Reply-To: <20180228201837.26629.3346.stgit@gimli.home>
References: <20180228201837.26629.3346.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 5/5] vfio/quirks: Enable ioeventfd quirks to be
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
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com, peterx@redhat.com, eric.auger@redhat.com

With vfio ioeventfd support, we can program vfio-pci to perform a
specified BAR write when an eventfd is triggered.  This allows the
KVM ioeventfd to be wired directly to vfio-pci, entirely avoiding
userspace handling for these events.  On the same micro-benchmark
where the ioeventfd got us to almost 90% of performance versus
disabling the GeForce quirks, this gets us to within 95%.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |   45 +++++++++++++++++++++++++++++++++++++++------
 hw/vfio/pci.h        |    1 +
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e01e2f0f69df..561fa6ea321d 100644
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
@@ -287,13 +288,31 @@ static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
     return quirk;
 }
 
-static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
+static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
 {
     QLIST_REMOVE(ioeventfd, next);
+
     memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
                               ioeventfd->match_data, ioeventfd->data,
                               &ioeventfd->e);
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
+        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
+
+    } else {
+        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
+                            NULL, NULL, NULL);
+    }
+
     event_notifier_cleanup(&ioeventfd->e);
     g_free(ioeventfd);
 }
@@ -304,7 +323,7 @@ static void vfio_drop_dynamic_eventfds(VFIOPCIDevice *vdev, VFIOQuirk *quirk)
 
     QLIST_FOREACH_SAFE(ioeventfd, &quirk->ioeventfds, next, tmp) {
         if (ioeventfd->dynamic) {
-            vfio_ioeventfd_exit(ioeventfd);
+            vfio_ioeventfd_exit(vdev, ioeventfd);
         }
     }
 }
@@ -326,6 +345,7 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
                                           hwaddr region_addr, bool dynamic)
 {
     VFIOIOEventFD *ioeventfd = g_malloc0(sizeof(*ioeventfd));
+    struct vfio_device_ioeventfd vfio_ioeventfd;
 
     if (event_notifier_init(&ioeventfd->e, 0)) {
         g_free(ioeventfd);
@@ -349,8 +369,21 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
     ioeventfd->region = region;
     ioeventfd->region_addr = region_addr;
 
-    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
-                        vfio_ioeventfd_handler, NULL, ioeventfd);
+    vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
+    vfio_ioeventfd.flags = ioeventfd->size;
+    vfio_ioeventfd.data = ioeventfd->data;
+    vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
+                            ioeventfd->region_addr;
+    vfio_ioeventfd.fd = event_notifier_get_fd(&ioeventfd->e);
+
+    ioeventfd->vfio = !ioctl(vdev->vbasedev.fd,
+                             VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
+
+    if (!ioeventfd->vfio) {
+        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
+                            vfio_ioeventfd_handler, NULL, ioeventfd);
+    }
+
     memory_region_add_eventfd(ioeventfd->mr, ioeventfd->addr,
                               ioeventfd->size, ioeventfd->match_data,
                               ioeventfd->data, &ioeventfd->e);
@@ -1820,7 +1853,7 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
 
     QLIST_FOREACH(quirk, &bar->quirks, next) {
         while (!QLIST_EMPTY(&quirk->ioeventfds)) {
-            vfio_ioeventfd_exit(QLIST_FIRST(&quirk->ioeventfds));
+            vfio_ioeventfd_exit(vdev, QLIST_FIRST(&quirk->ioeventfds));
         }
 
         for (i = 0; i < quirk->nr_mem; i++) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index de651993b57a..26c06e92ec26 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -35,6 +35,7 @@ typedef struct VFIOIOEventFD {
     hwaddr region_addr;
     bool match_data;
     bool dynamic;
+    bool vfio;
 } VFIOIOEventFD;
 
 typedef struct VFIOQuirk {
