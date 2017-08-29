Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmodc-0007r1-TG
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dmodb-0001Tp-Tz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dmodb-0001TG-NL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:05:35 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 29 Aug 2017 16:05:32 -0600
Message-ID: <20170829220532.31136.42932.stgit@gimli.home>
In-Reply-To: <20170829214929.31136.21144.stgit@gimli.home>
References: <20170829214929.31136.21144.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/3] vfio/pci: Do not unwind on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: a175818323@gmail.com

If vfio_add_std_cap() errors then going to out prepends irrelevant
errors for capabilities we haven't attempted to add as we unwind our
recursive stack.  Just return error.

Fixes: 7ef165b9a8d9 ("vfio/pci: Pass an error object to vfio_add_capabilities")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 31e1edf44745..916d365dfab3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1826,7 +1826,7 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
     if (next) {
         ret = vfio_add_std_cap(vdev, next, errp);
         if (ret) {
-            goto out;
+            return ret;
         }
     } else {
         /* Begin the rebuild, use QEMU emulated list bits */
@@ -1862,7 +1862,7 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         ret = pci_add_capability(pdev, cap_id, pos, size, errp);
         break;
     }
-out:
+
     if (ret < 0) {
         error_prepend(errp,
                       "failed to add PCI capability 0x%x[0x%x]@0x%x: ",
