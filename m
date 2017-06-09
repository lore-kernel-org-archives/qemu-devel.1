Received: from eggs.gnu.org ([2001:4830:134:3::10]:59159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3j-0003dK-HS
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3h-0000a3-Jp
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:31 -0400
Received: from [59.151.112.132] (port=44692 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dJI3h-0000YA-7w
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:26:29 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 9 Jun 2017 19:24:36 +0800
Message-ID: <ed9724f87e996e2bf95f2e722280713a461068fc.1496994386.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/7] pci: Clean up error checking in
 pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com

On success, pci_add_capability2() returns a positive value. On
failure, it sets an error and return a negative value.

pci_add_capability() laboriously checks this behavior. No other
caller does. Drop the checks from pci_add_capability().

Cc: mst@redhat.com
Cc: marcel@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 98ccc27..53566b8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2270,12 +2270,8 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
     Error *local_err = NULL;
 
     ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
-    if (local_err) {
-        assert(ret < 0);
+    if (ret < 0) {
         error_report_err(local_err);
-    } else {
-        /* success implies a positive offset in config space */
-        assert(ret > 0);
     }
     return ret;
 }
-- 
2.9.3
