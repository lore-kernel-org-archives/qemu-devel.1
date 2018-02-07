Received: from eggs.gnu.org ([2001:4830:134:3::10]:56452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejDZZ-0007nH-0r
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ejDZX-0005mL-Ss
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:26:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ejDZX-0005jh-Kl
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:26:47 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 06 Feb 2018 17:26:46 -0700
Message-ID: <20180207002646.1156.37051.stgit@gimli.home>
In-Reply-To: <20180207001615.1156.10547.stgit@gimli.home>
References: <20180207001615.1156.10547.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH 5/5] vfio/quirks: Enable ioeventfd quirks
 to be handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, kvm@vger.kernel.org

With vfio ioeventfd support, we can program vfio-pci to perform a
specified BAR write when an eventfd is triggered.  This allows the
KVM ioeventfd to be wired directly to vfio-pci, entirely avoiding
userspace handling for these events.  On the same micro-benchmark
where the ioeventfd got us to almost 90% of performance versus
disabling the GeForce quirks, this gets us to within 95%.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e739efe601b1..35a4d5197e2d 100644
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
@@ -287,13 +288,27 @@ static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
     return quirk;
 }
 
-static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
+static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
 {
+    struct vfio_device_ioeventfd vfio_ioeventfd;
+
     QLIST_REMOVE(ioeventfd, next);
+
     memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
                               ioeventfd->match_data, ioeventfd->data,
                               &ioeventfd->e);
+
     qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
+
+    vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
+    vfio_ioeventfd.flags = ioeventfd->size;
+    vfio_ioeventfd.data = ioeventfd->data;
+    vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
+                            ioeventfd->region_addr;
+    vfio_ioeventfd.fd = -1;
+
+    ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
+
     event_notifier_cleanup(&ioeventfd->e);
     g_free(ioeventfd);
 }
@@ -315,6 +330,8 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
                                           hwaddr region_addr)
 {
     VFIOIOEventFD *ioeventfd = g_malloc0(sizeof(*ioeventfd));
+    struct vfio_device_ioeventfd vfio_ioeventfd;
+    char vfio_enabled = '+';
 
     if (event_notifier_init(&ioeventfd->e, 0)) {
         g_free(ioeventfd);
@@ -329,15 +346,28 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
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
+    if (ioctl(vdev->vbasedev.fd,
+              VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd) != 0) {
+        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
+                            vfio_ioeventfd_handler, NULL, ioeventfd);
+        vfio_enabled = '-';
+    }
+
     memory_region_add_eventfd(ioeventfd->mr, ioeventfd->addr,
                               ioeventfd->size, ioeventfd->match_data,
                               ioeventfd->data, &ioeventfd->e);
 
     info_report("Enabled automatic ioeventfd acceleration for %s region %d, "
-                "offset 0x%"HWADDR_PRIx", data 0x%"PRIx64", size %u",
-                vdev->vbasedev.name, region->nr, region_addr, data, size);
+                "offset 0x%"HWADDR_PRIx", data 0x%"PRIx64", size %u, vfio%c",
+                vdev->vbasedev.name, region->nr, region_addr, data, size,
+                vfio_enabled);
 
     return ioeventfd;
 }
@@ -1767,7 +1797,7 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
 
     QLIST_FOREACH(quirk, &bar->quirks, next) {
         while (!QLIST_EMPTY(&quirk->ioeventfds)) {
-            vfio_ioeventfd_exit(QLIST_FIRST(&quirk->ioeventfds));
+            vfio_ioeventfd_exit(vdev, QLIST_FIRST(&quirk->ioeventfds));
         }
 
         for (i = 0; i < quirk->nr_mem; i++) {
