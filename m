Received: from eggs.gnu.org ([2001:4830:134:3::10]:43921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3528ad87b=anoob.soman@citrix.com>)
	id 1dSko3-0003PR-1q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3528ad87b=anoob.soman@citrix.com>)
	id 1dSkny-0005WK-B8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:57:27 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:21124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3528ad87b=anoob.soman@citrix.com>)
	id 1dSkny-0005VN-4o
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:57:22 -0400
From: Anoob Soman <anoob.soman@citrix.com>
Date: Wed, 5 Jul 2017 14:56:35 +0100
Message-ID: <1499262995-11621-1-git-send-email-anoob.soman@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen/pt: Fixup addr validation in
 xen_pt_pci_config_access_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony.perard@citrix.com, Anoob Soman <anoob.soman@citrix.com>

xen_pt_pci_config_access_check checks if addr >= 0xFF. 0xFF is a valid
address and should not be ignored.

Signed-off-by: Anoob Soman <anoob.soman@citrix.com>
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
1.8.3.1
