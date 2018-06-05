Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIDw-0003Vf-Dr
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fQIDr-0002yL-EF
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fQIDr-0002yA-55
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 16:06:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74621B0838
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 20:06:26 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 05 Jun 2018 14:06:23 -0600
Message-ID: <20180605200623.24323.8406.stgit@gimli.home>
In-Reply-To: <20180605200425.24323.56023.stgit@gimli.home>
References: <20180605200425.24323.56023.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/6] vfio/quirks: Add common quirk alloc helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This will later be used to include list initialization.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |   48 +++++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e5779a7ad35b..cc3a74ed992a 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -275,6 +275,15 @@ static const MemoryRegionOps vfio_ati_3c3_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
+{
+    VFIOQuirk *quirk = g_new0(VFIOQuirk, 1);
+    quirk->mem = g_new0(MemoryRegion, nr_mem);
+    quirk->nr_mem = nr_mem;
+
+    return quirk;
+}
+
 static void vfio_vga_probe_ati_3c3_quirk(VFIOPCIDevice *vdev)
 {
     VFIOQuirk *quirk;
@@ -288,9 +297,7 @@ static void vfio_vga_probe_ati_3c3_quirk(VFIOPCIDevice *vdev)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
-    quirk->mem = g_new0(MemoryRegion, 1);
-    quirk->nr_mem = 1;
+    quirk = vfio_quirk_alloc(1);
 
     memory_region_init_io(quirk->mem, OBJECT(vdev), &vfio_ati_3c3_quirk, vdev,
                           "vfio-ati-3c3-quirk", 1);
@@ -323,9 +330,7 @@ static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
-    quirk->mem = g_new0(MemoryRegion, 2);
-    quirk->nr_mem = 2;
+    quirk = vfio_quirk_alloc(2);
     window = quirk->data = g_malloc0(sizeof(*window) +
                                      sizeof(VFIOConfigWindowMatch));
     window->vdev = vdev;
@@ -371,10 +376,9 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = vfio_quirk_alloc(1);
     mirror = quirk->data = g_malloc0(sizeof(*mirror));
-    mirror->mem = quirk->mem = g_new0(MemoryRegion, 1);
-    quirk->nr_mem = 1;
+    mirror->mem = quirk->mem;
     mirror->vdev = vdev;
     mirror->offset = 0x4000;
     mirror->bar = nr;
@@ -548,10 +552,8 @@ static void vfio_vga_probe_nvidia_3d0_quirk(VFIOPCIDevice *vdev)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = vfio_quirk_alloc(2);
     quirk->data = data = g_malloc0(sizeof(*data));
-    quirk->mem = g_new0(MemoryRegion, 2);
-    quirk->nr_mem = 2;
     data->vdev = vdev;
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_nvidia_3d4_quirk,
@@ -667,9 +669,7 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
-    quirk->mem = g_new0(MemoryRegion, 4);
-    quirk->nr_mem = 4;
+    quirk = vfio_quirk_alloc(4);
     bar5 = quirk->data = g_malloc0(sizeof(*bar5) +
                                    (sizeof(VFIOConfigWindowMatch) * 2));
     window = &bar5->window;
@@ -762,10 +762,9 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = vfio_quirk_alloc(1);
     mirror = quirk->data = g_malloc0(sizeof(*mirror));
-    mirror->mem = quirk->mem = g_new0(MemoryRegion, 1);
-    quirk->nr_mem = 1;
+    mirror->mem = quirk->mem;
     mirror->vdev = vdev;
     mirror->offset = 0x88000;
     mirror->bar = nr;
@@ -781,10 +780,9 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* The 0x1800 offset mirror only seems to get used by legacy VGA */
     if (vdev->vga) {
-        quirk = g_malloc0(sizeof(*quirk));
+        quirk = vfio_quirk_alloc(1);
         mirror = quirk->data = g_malloc0(sizeof(*mirror));
-        mirror->mem = quirk->mem = g_new0(MemoryRegion, 1);
-        quirk->nr_mem = 1;
+        mirror->mem = quirk->mem;
         mirror->vdev = vdev;
         mirror->offset = 0x1800;
         mirror->bar = nr;
@@ -945,9 +943,7 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
-    quirk->mem = g_new0(MemoryRegion, 2);
-    quirk->nr_mem = 2;
+    quirk = vfio_quirk_alloc(2);
     quirk->data = rtl = g_malloc0(sizeof(*rtl));
     rtl->vdev = vdev;
 
@@ -1507,9 +1503,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
-    quirk = g_malloc0(sizeof(*quirk));
-    quirk->mem = g_new0(MemoryRegion, 2);
-    quirk->nr_mem = 2;
+    quirk = vfio_quirk_alloc(2);
     igd = quirk->data = g_malloc0(sizeof(*igd));
     igd->vdev = vdev;
     igd->index = ~0;
