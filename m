Received: from eggs.gnu.org ([2001:4830:134:3::10]:52512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKm-0006K3-3z
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rKl-0001i9-6a
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:45:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:43:02 -0300
Message-Id: <20180415234307.28132-37-f4bug@amsat.org>
In-Reply-To: <20180415234307.28132-1-f4bug@amsat.org>
References: <20180415234307.28132-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 36/41] hw/vfio: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/vfio/pci-quirks.c | 9 +++++----
 hw/vfio/pci.c        | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index e5779a7ad3..4fa181a977 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
@@ -1255,9 +1256,9 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
         ggms = 1 << ggms;
     }
 
-    ggms *= 1024 * 1024;
+    ggms *= M_BYTE;
 
-    return (ggms / (4 * 1024)) * (gen < 8 ? 4 : 8);
+    return (ggms / (4 * K_BYTE)) * (gen < 8 ? 4 : 8);
 }
 
 /*
@@ -1514,7 +1515,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     igd->vdev = vdev;
     igd->index = ~0;
     igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
-    igd->bdsm &= ~((1 << 20) - 1); /* 1MB aligned */
+    igd->bdsm &= ~((1 * M_BYTE) - 1); /* 1MB aligned */
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
                           igd, "vfio-igd-index-quirk", 4);
@@ -1561,7 +1562,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * config offset 0x5C.
      */
     bdsm_size = g_malloc(sizeof(*bdsm_size));
-    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * 1024 * 1024);
+    *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * M_BYTE);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b9bc6cd310..fb9450b3a4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
+#include "qemu/units.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "pci.h"
@@ -1417,7 +1418,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
     }
 
     /* 2GB max size for 32-bit BARs, cannot double if already > 1G */
-    if (vdev->bars[target_bar].size > (1 * 1024 * 1024 * 1024) &&
+    if (vdev->bars[target_bar].size > 1 * G_BYTE &&
         !vdev->bars[target_bar].mem64) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "no space to extend 32-bit BAR", target_bar);
-- 
2.17.0
