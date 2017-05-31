Received: from eggs.gnu.org ([2001:4830:134:3::10]:59565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFxho-0006WI-Mx
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFxhk-0004Ul-3e
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:06:08 -0400
Received: from [59.151.112.132] (port=49018 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFxhj-0004Ud-Ng
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:06:04 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 31 May 2017 15:04:38 +0800
Message-ID: <20170531070438.14081-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] pci: Fix unreasonable return value check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, armbru@redhat.com

The return value of pci_add_capability2() is only 2 cases, positive
on success, nagetive on failure and set error message to Error. In
other worlds, If Error is filled, the return value must be nagetive.
There is no case where errp is set but the return value is a positive.
But pci_add_capability() does. So the return value check is illogical.

Meanwhile, all other callers of pci_add_capability2() do the same
check as this patch. So fix it.

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b..1faf060 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2269,12 +2269,8 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
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
