Received: from eggs.gnu.org ([209.51.188.92]:45938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2j1-0004hh-QD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2et-0002OO-ED
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:52:09 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:65429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2et-0002N4-6M
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:52:07 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 14 Jan 2019 13:51:30 +0000
Message-ID: <20190114135154.16826-2-anthony.perard@citrix.com>
In-Reply-To: <20190114135154.16826-1-anthony.perard@citrix.com>
References: <20190114135154.16826-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 01/25] hw/xen/xen_pt_graphics: Don't trust the
 BIOS ROM contents so much
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity (CID 796599) points out that xen_pt_setup_vga() trusts
the rom->size field in the BIOS ROM from a PCI passthrough VGA
device, and uses it as an index into the memory which contains
the BIOS image. A corrupt BIOS ROM could therefore cause us to
index off the end of the buffer.

Check that the size is within bounds before we use it.

We are also trusting the pcioffset field, and assuming that
the whole rom_header is present; Coverity doesn't notice these,
but check them too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen_pt_graphics.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 135c8df1e7..60d6b4a556 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -185,8 +185,19 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         return;
     }
 
+    if (bios_size < sizeof(struct rom_header)) {
+        error_setg(errp, "VGA: VBIOS image corrupt (too small)");
+        return;
+    }
+
     /* Currently we fixed this address as a primary. */
     rom = (struct rom_header *)bios;
+
+    if (rom->pcioffset + sizeof(struct pci_data) > bios_size) {
+        error_setg(errp, "VGA: VBIOS image corrupt (bad pcioffset field)");
+        return;
+    }
+
     pd = (void *)(bios + (unsigned char)rom->pcioffset);
 
     /* We may need to fixup Device Identification. */
@@ -194,6 +205,11 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         pd->device = s->real_device.device_id;
 
         len = rom->size * 512;
+        if (len > bios_size) {
+            error_setg(errp, "VGA: VBIOS image corrupt (bad size field)");
+            return;
+        }
+
         /* Then adjust the bios checksum */
         for (c = (char *)bios; c < ((char *)bios + len); c++) {
             checksum += *c;
-- 
Anthony PERARD
