Received: from eggs.gnu.org ([2001:4830:134:3::10]:47568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1sO-000172-J8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1sH-0007EH-4M
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1sG-0007DX-TT
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:05 -0500
Date: Thu, 21 Dec 2017 16:30:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-24-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 23/25] virtio-pci: Don't force Subsystem Vendor
 ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

The statement being removed doesn't change anything as virtio PCI devices already
have Subsystem Vendor ID set to pci_default_sub_vendor_id (0x1af4), same as Vendor
ID. And the Virtio spec does not require the two to be equal, either:

  "The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect the PCI
  Vendor and Device ID of the environment (for informational purposes by the driver)."

Background:

Following the recent virtio-win licensing change, several vendors are planning to
ship their own certified version of Windows guest Virtio drivers, potentially taking
advantage of Windows Update as a distribution channel. It is therefore critical that
each vendor uses their own PCI Subsystem Vendor ID for Virtio devices to prevent
drivers from other vendors binding to it.

This would be trivially done by adding:

  k->subsystem_vendor_id = ...

to virtio_pci_class_init(). Except for the problematic statement deleted by this
patch, which reverts the Subsystem Vendor ID back to 0x1af4 for legacy devices for
no good reason.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/virtio/virtio-pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 42b31fb..6c75cca 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1588,9 +1588,11 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                        "neither legacy nor transitional device.");
             return ;
         }
-        /* legacy and transitional */
-        pci_set_word(config + PCI_SUBSYSTEM_VENDOR_ID,
-                     pci_get_word(config + PCI_VENDOR_ID));
+        /*
+         * Legacy and transitional devices use specific subsystem IDs.
+         * Note that the subsystem vendor ID (config + PCI_SUBSYSTEM_VENDOR_ID)
+         * is set to PCI_SUBVENDOR_ID_REDHAT_QUMRANET by default.
+         */
         pci_set_word(config + PCI_SUBSYSTEM_ID, virtio_bus_get_vdev_id(bus));
     } else {
         /* pure virtio-1.0 */
-- 
MST
