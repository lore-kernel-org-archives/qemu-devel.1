Received: from eggs.gnu.org ([2001:4830:134:3::10]:59688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxL-0000BD-Dv
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxH-0001vi-2k
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:23 -0500
Received: from [59.151.112.132] (port=13743 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxG-0001qP-NS
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:19 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 15:12:03 +0800
Message-ID: <1484291524-1261-10-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 09/10] msi_init: convert assert to return
 -errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

According to the disscussion:
http://lists.nongnu.org/archive/html/qemu-devel/2016-09/msg08215.html

Let leaf function returns reasonable -errno, let caller decide how to
handle the return value.

Suggested-by: Markus Armbruster <armbru@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/pci/msi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b2278a373..af3efbe525ce 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -201,9 +201,12 @@ int msi_init(struct PCIDevice *dev, uint8_t offset,
                    " 64bit %d mask %d\n",
                    offset, nr_vectors, msi64bit, msi_per_vector_mask);
 
-    assert(!(nr_vectors & (nr_vectors - 1)));   /* power of 2 */
-    assert(nr_vectors > 0);
-    assert(nr_vectors <= PCI_MSI_VECTORS_MAX);
+    /* vector sanity test: should in range 1 - 32, should be power of 2 */
+    if (!is_power_of_2(nr_vectors) || nr_vectors > PCI_MSI_VECTORS_MAX) {
+        error_setg(errp, "Invalid vector number: %d", nr_vectors);
+        return -EINVAL;
+    }
+
     /* the nr of MSI vectors is up to 32 */
     vectors_order = ctz32(nr_vectors);
 
-- 
2.1.0
