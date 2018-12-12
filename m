Received: from eggs.gnu.org ([2001:4830:134:3::10]:43520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Ep-000661-Ap
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1En-0006Uw-9j
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:31 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:14 +0100
Message-Id: <20181212095519.6390-2-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
References: <20181212095519.6390-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] s390x/zpci: drop msix.available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

I fail to see why this is useful as we require MSIX always and
completely fail adding a device.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181105110313.29312-2-david@redhat.com>
Fixes: 4f6482bfe3da1e6b51ad4722a0c22f22f0d54a3b
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 --
 hw/s390x/s390-pci-bus.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 060ff062bc..99d0368868 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -745,7 +745,6 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
 
     pos = pci_find_capability(pbdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
-        pbdev->msix.available = false;
         return -1;
     }
 
@@ -761,7 +760,6 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
     pbdev->msix.pba_bar = pba & PCI_MSIX_FLAGS_BIRMASK;
     pbdev->msix.pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     pbdev->msix.entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
-    pbdev->msix.available = true;
 
     name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
     memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 1f7f9b5814..f47a0f2da5 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -252,7 +252,6 @@ typedef struct ChscSeiNt2Res {
 } QEMU_PACKED ChscSeiNt2Res;
 
 typedef struct S390MsixInfo {
-    bool available;
     uint8_t table_bar;
     uint8_t pba_bar;
     uint16_t entries;
-- 
2.17.2
