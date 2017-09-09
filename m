Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dqZC6-0007FQ-TL
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 02:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dqZC3-0004el-PY
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 02:24:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14312
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dqZC3-0004cf-CJ
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 02:24:39 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Sat, 9 Sep 2017 14:22:26 +0800
Message-ID: <2896466deb1ff8d832e39ce389ce268ee38e4e4f.1504935362.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4] pci: Set err to errp directly rather than
 through error_propagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

ioh3420_interrupts_init() pass error message to local_err, then
propagate it to errp by error_propagate(), which is not necessary.
So eliminate it and pass errp directly instead of local_err.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com> 
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4:
it not apply clearly on HEAD, so rebase it and modify the commit
message.
---

 hw/pci-bridge/ioh3420.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
index da4e5bd..5f56a2f 100644
--- a/hw/pci-bridge/ioh3420.c
+++ b/hw/pci-bridge/ioh3420.c
@@ -64,15 +64,13 @@ static uint8_t ioh3420_aer_vector(const PCIDevice *d)
 static int ioh3420_interrupts_init(PCIDevice *d, Error **errp)
 {
     int rc;
-    Error *local_err = NULL;
 
     rc = msi_init(d, IOH_EP_MSI_OFFSET, IOH_EP_MSI_NR_VECTOR,
                   IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
                   IOH_EP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
-                  &local_err);
+                  errp);
     if (rc < 0) {
         assert(rc == -ENOTSUP);
-        error_propagate(errp, local_err);
     }
 
     return rc;
-- 
2.9.4
