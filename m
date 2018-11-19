Received: from eggs.gnu.org ([2001:4830:134:3::10]:55076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOmOD-0003ls-SD
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOmOB-0007iX-Pe
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:27:09 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOmOA-0007gp-6f
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:27:07 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 16:26:58 +0000
Message-Id: <20181119162658.30358-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] hw/xen/xen_pt_graphics: Don't trust
 the BIOS ROM contents so much
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

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
---
Disclaimer: compile tested only, as I don't have a Xen setup,
let alone one with pass-through PCI graphics.

Note that https://xenbits.xen.org/xsa/advisory-124.html
defines that bugs which are only exploitable by a malicious
piece of hardware that is passed through to the guest are
not security vulnerabilities as far as the Xen Project is
concerned, and are treated like normal non-security-related bugs.
So this is just a bugfix, not a security issue.

Marked "for-3.1" because it would let us squash another Coverity
issue, and it is a bug fix; on the other hand it's an obscure
corner case and has been this way since forever.

---
 hw/xen/xen_pt_graphics.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 135c8df1e72..60d6b4a5563 100644
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
2.19.1
