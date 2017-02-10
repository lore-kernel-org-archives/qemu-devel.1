Received: from eggs.gnu.org ([2001:4830:134:3::10]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIyE-0007qT-0S
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIyA-0002bU-Rv
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ccIyA-0002bO-MY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:43:06 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C95DD61D17
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 21:43:06 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 10 Feb 2017 14:43:05 -0700
Message-ID: <20170210214255.22071.40864.stgit@gimli.home>
In-Reply-To: <20170210214127.22071.16525.stgit@gimli.home>
References: <20170210214127.22071.16525.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/3] vfio-pci: Fix GTT wrap-around for Skylake+
 IGD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Previous IGD, up through Broadwell, only seem to write GTT values into
the first 1MB of space allocated for the BDSM, but clearly the GTT
can be multiple MB in size.  Our test in vfio_igd_quirk_data_write()
correctly filters out indexes beyond 1MB, but given the 1MB mask we're
using, we re-apply writes only to the first 1MB of the guest allocated
BDSM.

We can't assume either the host or guest BDSM is naturally aligned, so
we can't simply apply a different mask.  Instead, save the host BDSM
and do the arithmetic to subtract the host value to get the BDSM
offset and add it to the guest allocated BDSM.

Reported-by: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Tested-by: Alexander Indenbaum <alexander.indenbaum@gmail.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci-quirks.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 6c771f778bd0..ec0feca376f6 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1041,6 +1041,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
 typedef struct VFIOIGDQuirk {
     struct VFIOPCIDevice *vdev;
     uint32_t index;
+    uint32_t bdsm;
 } VFIOIGDQuirk;
 
 #define IGD_GMCH 0x50 /* Graphics Control Register */
@@ -1304,7 +1305,7 @@ static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
                          "BIOS reserved stolen memory.  Unsupported BIOS?");
             }
 
-            val = base | (data & ((1 << 20) - 1));
+            val = data - igd->bdsm + base;
         } else {
             val = 0; /* upper 32bits of pte, we only enable below 4G PTEs */
         }
@@ -1503,6 +1504,8 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     igd = quirk->data = g_malloc0(sizeof(*igd));
     igd->vdev = vdev;
     igd->index = ~0;
+    igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    igd->bdsm &= ~((1 << 20) - 1); /* 1MB aligned */
 
     memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
                           igd, "vfio-igd-index-quirk", 4);
