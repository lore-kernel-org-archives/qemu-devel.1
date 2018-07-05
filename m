Received: from eggs.gnu.org ([2001:4830:134:3::10]:53057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6eU-0004Rz-El
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6eT-00057R-FJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  5 Jul 2018 12:58:07 -0300
Message-Id: <20180705155811.20366-4-f4bug@amsat.org>
In-Reply-To: <20180705155811.20366-1-f4bug@amsat.org>
References: <20180705155811.20366-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/7] xen: Use the PCI_DEVICE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

TYPE_XEN_PT_DEVICE is a subclass of TYPE_PCI_DEVICE, the clean way
to access the PCIDevice pointer is using the PCI_DEVICE() macro.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/xen/xen_pt_config_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index aee31c62bb..47f9010c75 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -358,7 +358,7 @@ static uint64_t xen_pt_get_bar_size(PCIIORegion *r)
 static XenPTBarFlag xen_pt_bar_reg_parse(XenPCIPassthroughState *s,
                                          int index)
 {
-    PCIDevice *d = &s->dev;
+    PCIDevice *d = PCI_DEVICE(s);
     XenPTRegion *region = NULL;
     PCIIORegion *r;
 
@@ -469,7 +469,7 @@ static int xen_pt_bar_reg_write(XenPCIPassthroughState *s, XenPTReg *cfg_entry,
 {
     XenPTRegInfo *reg = cfg_entry->reg;
     XenPTRegion *base = NULL;
-    PCIDevice *d = &s->dev;
+    PCIDevice *d = PCI_DEVICE(s);
     const PCIIORegion *r;
     uint32_t writable_mask = 0;
     uint32_t bar_emu_mask = 0;
@@ -543,7 +543,7 @@ static int xen_pt_exp_rom_bar_reg_write(XenPCIPassthroughState *s,
 {
     XenPTRegInfo *reg = cfg_entry->reg;
     XenPTRegion *base = NULL;
-    PCIDevice *d = (PCIDevice *)&s->dev;
+    PCIDevice *d = PCI_DEVICE(s);
     uint32_t writable_mask = 0;
     uint32_t throughable_mask = get_throughable_mask(s, reg, valid_mask);
     pcibus_t r_size = 0;
@@ -1587,7 +1587,7 @@ static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
                                  uint32_t base_offset, uint8_t *size)
 {
-    PCIDevice *d = &s->dev;
+    PCIDevice *d = PCI_DEVICE(s);
     uint8_t version = get_capability_version(s, base_offset);
     uint8_t type = get_device_type(s, base_offset);
     uint8_t pcie_size = 0;
-- 
2.18.0
