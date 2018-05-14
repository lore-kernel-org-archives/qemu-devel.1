Received: from eggs.gnu.org ([2001:4830:134:3::10]:37972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=665482757=ross.lagerwall@citrix.com>)
	id 1fIAhi-0000cd-Im
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=665482757=ross.lagerwall@citrix.com>)
	id 1fIAhe-0001iY-Iv
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:27:42 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:33714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=665482757=ross.lagerwall@citrix.com>)
	id 1fIAhe-0001hj-AQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:27:38 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Mon, 14 May 2018 10:57:46 +0100
Message-ID: <20180514095746.5058-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen_pt: Present the size of 64 bit BARs
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>

The full size of the BAR is stored in the lower PCIIORegion.size. The
upper PCIIORegion.size is 0.  Calculate the size of the upper half
correctly from the lower half otherwise the size read by the guest will
be incorrect.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/xen/xen_pt_config_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index a3ce33e..aee31c6 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -504,6 +504,8 @@ static int xen_pt_bar_reg_write(XenPCIPassthroughState *s, XenPTReg *cfg_entry,
         bar_ro_mask = XEN_PT_BAR_IO_RO_MASK | (r_size - 1);
         break;
     case XEN_PT_BAR_FLAG_UPPER:
+        assert(index > 0);
+        r_size = d->io_regions[index - 1].size >> 32;
         bar_emu_mask = XEN_PT_BAR_ALLF;
         bar_ro_mask = r_size ? r_size - 1 : 0;
         break;
-- 
2.9.5
