Received: from eggs.gnu.org ([2001:4830:134:3::10]:39185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmodo-00080O-HG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmodj-0001bk-Ji
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dmodj-0001Zj-Dy
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:43 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 29 Aug 2017 16:05:39 -0600
Message-ID: <20170829220539.31136.82540.stgit@gimli.home>
In-Reply-To: <20170829214929.31136.21144.stgit@gimli.home>
References: <20170829214929.31136.21144.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] vfio/pci: Add virtual capabilities quirk
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: a175818323@gmail.com

If the hypervisor needs to add purely virtual capabilties, give us a
hook through quirks to do that.  Note that we determine the maximum
size for a capability based on the physical device, if we insert a
virtual capability, that can change.  Therefore if maximum size is
smaller after added virt capabilities, use that.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |    4 ++++
 hw/vfio/pci.c        |    8 ++++++++
 hw/vfio/pci.h        |    1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 349085ea12bc..40aaae76feb9 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1850,3 +1850,7 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev)
         break;
     }
 }
+int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
+{
+    return 0;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 916d365dfab3..bfeaaef22d00 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1833,8 +1833,16 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         pdev->config[PCI_CAPABILITY_LIST] = 0;
         vdev->emulated_config_bits[PCI_CAPABILITY_LIST] = 0xff;
         vdev->emulated_config_bits[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
+
+        ret = vfio_add_virt_caps(vdev, errp);
+        if (ret) {
+            return ret;
+        }
     }
 
+    /* Scale down size, esp in case virt caps were added above */
+    size = MIN(size, vfio_std_cap_max_size(pdev, pos));
+
     /* Use emulated next pointer to allow dropping caps */
     pci_set_byte(vdev->emulated_config_bits + pos + PCI_CAP_LIST_NEXT, 0xff);
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a8366bb2a74a..958cee058b3b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -160,6 +160,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
+int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
