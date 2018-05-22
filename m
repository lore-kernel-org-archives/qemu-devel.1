Received: from eggs.gnu.org ([2001:4830:134:3::10]:50672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ4-0001cF-Jl
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ3-0007Pw-Ok
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fLCJ3-0007PP-JP
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:45 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 22 May 2018 11:46:31 -0700
Message-Id: <1527014802-11289-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL v2 04/15] xen_pt: Present the size of 64 bit
 BARs correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

The full size of the BAR is stored in the lower PCIIORegion.size. The
upper PCIIORegion.size is 0.  Calculate the size of the upper half
correctly from the lower half otherwise the size read by the guest will
be incorrect.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
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
1.9.1
