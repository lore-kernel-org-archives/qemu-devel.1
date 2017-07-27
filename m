Received: from eggs.gnu.org ([2001:4830:134:3::10]:54698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlR-0005VP-VM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlR-0007xK-79
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:02 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:14 -0300
Message-Id: <20170727024224.22900-10-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 09/20] vfio/pci: fix use of freed
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

hw/vfio/pci.c:308:29: warning: Use of memory after it is freed
        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
                            ^~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d4051cb951..31e1edf447 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -257,7 +257,7 @@ static void vfio_intx_update(PCIDevice *pdev)
 static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
-    int ret, argsz;
+    int ret, argsz, retval = 0;
     struct vfio_irq_set *irq_set;
     int32_t *pfd;
     Error *err = NULL;
@@ -302,12 +302,12 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     qemu_set_fd_handler(*pfd, vfio_intx_interrupt, NULL, vdev);
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
     if (ret) {
         error_setg_errno(errp, -ret, "failed to setup INTx fd");
         qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
-        return -errno;
+        retval = -errno;
+        goto cleanup;
     }
 
     vfio_intx_enable_kvm(vdev, &err);
@@ -319,7 +319,10 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 
     trace_vfio_intx_enable(vdev->vbasedev.name);
 
-    return 0;
+cleanup:
+    g_free(irq_set);
+
+    return retval;
 }
 
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
-- 
2.13.3
