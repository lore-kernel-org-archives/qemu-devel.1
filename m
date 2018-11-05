Received: from eggs.gnu.org ([2001:4830:134:3::10]:38025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJcfY-0004lv-Uz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJcfO-0006p5-Pt
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:03:44 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  5 Nov 2018 12:03:10 +0100
Message-Id: <20181105110313.29312-2-david@redhat.com>
In-Reply-To: <20181105110313.29312-1-david@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/4] s390x/zpci: drop msix.available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

I fail to see why this is useful as we require MSIX always and
completely fail adding a device.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 --
 hw/s390x/s390-pci-bus.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e1b14b131b..1eaae3aca6 100644
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
