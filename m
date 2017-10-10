Received: from eggs.gnu.org ([2001:4830:134:3::10]:56784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jim.Quigley@oracle.com>) id 1e1rgG-0002vW-2Z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jim.Quigley@oracle.com>) id 1e1rgE-0007Dp-Qm
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:22:32 -0400
From: Jim Quigley <Jim.Quigley@oracle.com>
Date: Tue, 10 Oct 2017 06:22:08 -0400
Message-Id: <1507630928-28307-1-git-send-email-Jim.Quigley@oracle.com>
Subject: [Qemu-devel] [PATCH] hw/vfio: improve error message when cannot
 init vfio event notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, alex.williamson@redhat.com

More information is required to assist trouble-shooting when
QEMU fails to initialise the event notifications for devices
assigned with VFIO-PCI. Instead of supplying the user with a cryptic
error number only, print out a proper error message with strerror()
so that the user has a better way to figure out what the problem is.

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: Jim Quigley <Jim.Quigley@oracle.com>
---
Cc: qemu-trivial@nongnu.org
Cc: mjt@tls.msk.ru
Cc: laurent@vivier.eu
Cc: alex.williamson@redhat.com
---
 hw/vfio/pci.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 31e1edf..3bffb93 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -430,13 +430,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                   int vector_n, bool msix)
 {
-    int virq;
+    int virq, ret;
 
     if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
         return;
     }
 
-    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
+    ret = event_notifier_init(&vector->kvm_interrupt, 0);
+    if (ret) {
+        error_report("vfio (%s): Error: unable to init event notifier: %s (%d)",
+                     __func__, strerror(-ret), -ret);
         return;
     }
 
@@ -486,8 +489,11 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     if (!vector->use) {
         vector->vdev = vdev;
         vector->virq = -1;
-        if (event_notifier_init(&vector->interrupt, 0)) {
-            error_report("vfio: Error: event_notifier_init failed");
+        ret = event_notifier_init(&vector->interrupt, 0);
+        if (ret) {
+            error_report("vfio (%s): Error: "
+                         "unable to init event notifier: %s (%d)",
+                         __func__, strerror(-ret), -ret);
         }
         vector->use = true;
         msix_vector_use(pdev, nr);
@@ -658,8 +664,11 @@ retry:
         vector->virq = -1;
         vector->use = true;
 
-        if (event_notifier_init(&vector->interrupt, 0)) {
-            error_report("vfio: Error: event_notifier_init failed");
+        ret = event_notifier_init(&vector->interrupt, 0);
+        if (ret) {
+            error_report("vfio (%s): Error: "
+                         "unable to init event notifier: %s (%d)",
+                         __func__, strerror(-ret), -ret);
         }
 
         qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -2471,8 +2480,10 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->err_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for error detection");
+    ret = event_notifier_init(&vdev->err_notifier, 0);
+    if (ret) {
+        error_report("vfio (%s): Error: unable to init event notifier: %s (%d)"
+            " for error detection", __func__, strerror(-ret), -ret);
         vdev->pci_aer = false;
         return;
     }
@@ -2553,7 +2564,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
                                       .index = VFIO_PCI_REQ_IRQ_INDEX };
-    int argsz;
+    int argsz, ret;
     struct vfio_irq_set *irq_set;
     int32_t *pfd;
 
@@ -2566,8 +2577,10 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->req_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for device request");
+    ret = event_notifier_init(&vdev->req_notifier, 0);
+    if (ret) {
+        error_report("vfio (%s): Error: unable to init event notifier: %s (%d)"
+            " for device request", __func__, strerror(-ret), -ret);
         return;
     }
 
-- 
1.8.3.1
