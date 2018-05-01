Received: from eggs.gnu.org ([2001:4830:134:3::10]:55402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDYNI-00048I-0C
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fDYNE-0007LY-3B
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:43:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fDYND-0007Ky-TQ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:43:28 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 01 May 2018 10:43:18 -0600
Message-ID: <20180501164318.28940.89195.stgit@gimli.home>
In-Reply-To: <20180501162901.28940.1075.stgit@gimli.home>
References: <20180501162901.28940.1075.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/4] vfio/quirks: Add quirk reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, eric.auger@redhat.com, peterx@redhat.com

Quirks can be self modifying, provide a hook to allow them to cleanup
on device reset if desired.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |   15 +++++++++++++++
 hw/vfio/pci.c        |    2 ++
 hw/vfio/pci.h        |    2 ++
 3 files changed, 19 insertions(+)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index cc3a74ed992a..f0947cbf152f 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1694,6 +1694,21 @@ void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr)
 /*
  * Reset quirks
  */
+void vfio_quirk_reset(VFIOPCIDevice *vdev)
+{
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        VFIOQuirk *quirk;
+        VFIOBAR *bar = &vdev->bars[i];
+
+        QLIST_FOREACH(quirk, &bar->quirks, next) {
+            if (quirk->reset) {
+                quirk->reset(vdev, quirk);
+            }
+        }
+    }
+}
 
 /*
  * AMD Radeon PCI config reset, based on Linux:
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4947fe39a28c..65446fb42845 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2207,6 +2207,8 @@ static void vfio_pci_post_reset(VFIOPCIDevice *vdev)
                          vdev->vbasedev.name, nr);
         }
     }
+
+    vfio_quirk_reset(vdev);
 }
 
 static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 59ab7757a300..594a5bd00593 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -29,6 +29,7 @@ typedef struct VFIOQuirk {
     void *data;
     int nr_mem;
     MemoryRegion *mem;
+    void (*reset)(struct VFIOPCIDevice *vdev, struct VFIOQuirk *quirk);
 } VFIOQuirk;
 
 typedef struct VFIOBAR {
@@ -167,6 +168,7 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+void vfio_quirk_reset(VFIOPCIDevice *vdev);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
