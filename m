Received: from eggs.gnu.org ([2001:4830:134:3::10]:58431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXatC-000855-Fq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dXatB-0004S1-Hf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dXatB-0004Qd-CV
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 18:22:45 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 18 Jul 2017 15:22:36 -0700
Message-Id: <1500416562-27337-1-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL for-2.10 1/7] hw/xen: Set emu_mask for
 igd_opregion register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Xiong Zhang <xiong.y.zhang@intel.com>

From: Xiong Zhang <xiong.y.zhang@intel.com>

In igd passthrough environment, guest could only access opregion at the
first bootup time. Once guest shutdown, later guest couldn't access
opregion anymore.
This is because qemu set emulated guest opregion base address to host
register. Later guest get a wrong host opregion base address, and couldn't
access it anymore.

This patch set emu_mask for igd_opregion register, so guest won't set
guest opregion base address to host.

Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen_pt_config_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 6f18366..1f04ec5 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1535,6 +1535,7 @@ static XenPTRegInfo xen_pt_emu_reg_igd_opregion[] = {
         .offset     = 0x0,
         .size       = 4,
         .init_val   = 0,
+        .emu_mask   = 0xFFFFFFFF,
         .u.dw.read   = xen_pt_intel_opregion_read,
         .u.dw.write  = xen_pt_intel_opregion_write,
     },
-- 
1.9.1
