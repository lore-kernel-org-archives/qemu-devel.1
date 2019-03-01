Received: from eggs.gnu.org ([209.51.188.92]:47013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <08005325@163.com>) id 1gzZY6-00036p-Gy
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <08005325@163.com>) id 1gzZY5-0001XB-Lh
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:13:26 -0500
Received: from m50-138.163.com ([123.125.50.138]:50584)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <08005325@163.com>) id 1gzZY4-0001Uc-GM
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 23:13:25 -0500
From: 08005325@163.com
Date: Fri,  1 Mar 2019 12:13:08 +0800
Message-Id: <1551413588-36475-1-git-send-email-08005325@163.com>
Subject: [Qemu-devel] [PATCH] Fix coredump when using virtio-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Michael Qiu <qiudayu@huayun.com>

From: Michael Qiu <qiudayu@huayun.com>

When using command -device virtio-vga,virgl=on
the default max_outputs is 0, this will lead coredump,

    (con=0x0, hw_ops=0x5555564452e0 <virtio_vga_ops>,
     opaque=0x55555754ec60) at ui/console.c:1872
    (vpci_dev=0x55555754ec60, errp=0x7fffffffdbb8)
     at qemu/hw/display/virtio-vga.c:160
    (pci_dev=0x55555754ec60, errp=0x7fffffffdbb8)
     at hw/virtio/virtio-pci.c:1786
...

This patch force ths max_outputs to 1 when it not greater
than 0.

Signed-off-by: Michael Qiu <qiudayu@huayun.com>
---
 hw/display/virtio-gpu-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index bdcd33c..59b571d 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -46,6 +46,11 @@ static void virtio_gpu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     int i;
     Error *local_error = NULL;
 
+    if (g->conf.max_outputs <= 0) {
+        qemu_log("WARNING: virtio gpu max_outputs must greater than 1");
+        g->conf.max_outputs = 1;
+    }
+
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
     virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(vdev), true, "realized", &local_error);
-- 
1.8.3.1
