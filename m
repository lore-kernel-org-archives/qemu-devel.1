Received: from eggs.gnu.org ([2001:4830:134:3::10]:52310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY18-00024O-77
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY15-0006m0-Fz
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dTY15-0006lL-AG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:11 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri,  7 Jul 2017 11:30:04 -0700
Message-Id: <1499452204-20769-3-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1499452204-20769-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
	<1499452204-20769-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 3/3] xen/pt: Fixup addr validation in
 xen_pt_pci_config_access_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Anoob Soman <anoob.soman@citrix.com>

From: Anoob Soman <anoob.soman@citrix.com>

xen_pt_pci_config_access_check checks if addr >= 0xFF. 0xFF is a valid
address and should not be ignored.

Signed-off-by: Anoob Soman <anoob.soman@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index b6d71bb..375efa6 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -85,7 +85,7 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)
 static int xen_pt_pci_config_access_check(PCIDevice *d, uint32_t addr, int len)
 {
     /* check offset range */
-    if (addr >= 0xFF) {
+    if (addr > 0xFF) {
         XEN_PT_ERR(d, "Failed to access register with offset exceeding 0xFF. "
                    "(addr: 0x%02x, len: %d)\n", addr, len);
         return -1;
-- 
1.9.1
