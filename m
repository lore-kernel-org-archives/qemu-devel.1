Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaP-0000fV-2i
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaL-0003Ci-U4
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqaL-0003Ar-PJ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:09 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 21 May 2018 12:34:53 -0700
Message-Id: <1526931304-7289-4-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 04/15] xen_pt: Present the size of 64 bit BARs
 correctly
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
