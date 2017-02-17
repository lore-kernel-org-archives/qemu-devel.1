Received: from eggs.gnu.org ([2001:4830:134:3::10]:44008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobS-0003i8-AF
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobN-0005AK-I0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:02 -0500
Received: from mail.kernel.org ([198.145.29.136]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobN-00059H-Bi
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:53:57 -0500
Date: Fri, 17 Feb 2017 21:53:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-2-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/23] pci/pcie: don't assume cap id 0 is
 reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

VFIO actually wants to create a capability with ID == 0.
This is done to make guest drivers skip the given capability.
pcie_add_capability then trips up on this capability
when looking for end of capability list.

To support this use-case, it's easy enough to switch to
e.g. 0xffffffff for these comparisons - we can be sure
it will never match a 16-bit capability ID.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pcie.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index cbd4bb4..f4dd177 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -610,7 +610,8 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
  * uint16_t ext_cap_size
  */
 
-static uint16_t pcie_find_capability_list(PCIDevice *dev, uint16_t cap_id,
+/* Passing a cap_id value > 0xffff will return 0 and put end of list in prev */
+static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
                                           uint16_t *prev_p)
 {
     uint16_t prev = 0;
@@ -679,9 +680,11 @@ void pcie_add_capability(PCIDevice *dev,
     } else {
         uint16_t prev;
 
-        /* 0 is reserved cap id. use internally to find the last capability
-           in the linked list */
-        next = pcie_find_capability_list(dev, 0, &prev);
+        /*
+         * 0xffffffff is not a valid cap id (it's a 16 bit field). use
+         * internally to find the last capability in the linked list.
+         */
+        next = pcie_find_capability_list(dev, 0xffffffff, &prev);
 
         assert(prev >= PCI_CONFIG_SPACE_SIZE);
         assert(next == 0);
-- 
MST
