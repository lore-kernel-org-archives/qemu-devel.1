Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRX-00008C-82
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRV-0001Ma-8f
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:23 -0400
Received: from [59.151.112.132] (port=6328 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dGhRU-0001Jk-TK
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:56:21 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 2 Jun 2017 15:54:37 +0800
Message-ID: <ffa2cc4d0706fa522a5e581af14dadb03aec323a.1496387804.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/6] pci: Clean up error checking in
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
Cc: mst@redhat.com, marcel@redhat.com, armbru@redhat.com

On success, pci_add_capability2() returns a positive value. On
failure, it sets an error and return a negative value.

pci_add_capability() laboriously checks this behavior. No other
caller does. Drop the checks from pci_add_capability().

Cc: mst@redhat.com
Cc: marcel@redhat.com
Cc: armbru@redhat.com
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
