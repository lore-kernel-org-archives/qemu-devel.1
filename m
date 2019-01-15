Received: from eggs.gnu.org ([209.51.188.92]:32872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUwO-0005ll-Oz
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUwN-0001xx-La
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUwN-0001uE-Ae
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:03 -0500
Date: Tue, 15 Jan 2019 15:04:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-3-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 02/49] msix: make pba size math more uniform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dongli Zhang <dongli.zhang@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Dongli Zhang <dongli.zhang@oracle.com>

In msix_exclusive_bar the bar_pba_size is more than what the pba is
expected to have, although this never affects the bar size.

Specifically, the math in msix_init_exclusive_bar allocates too much
memory in some cases.

For example consider nentries = 8.  msix_exclusive_bar will give us
bar_pba_size = 16.  So 16 bytes.  However 8 bytes would be enough - this
is all that the spec requires.

So in practice bar_pba_size sometimes allocates an extra 8 bytes but
never more.

Since each MSIX entry size is 16 bytes, and since we make sure that
table+pba is a power of two, this always leaves a multiple of 16 bytes
for the PBA, so extra 8 bytes have no effect.

However, its ugly to have pba size temporary variable have an incorrect
value.  For consistency switch to the formula used in msix_init.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/msix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c7bdbeda9e..4e336416a7 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -345,7 +345,7 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
     char *name;
     uint32_t bar_size = 4096;
     uint32_t bar_pba_offset = bar_size / 2;
-    uint32_t bar_pba_size = (nentries / 8 + 1) * 8;
+    uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
 
     /*
      * Migration compatibility dictates that this remains a 4k
-- 
MST
