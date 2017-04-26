Received: from eggs.gnu.org ([2001:4830:134:3::10]:50533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7Q-0002tf-NL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7L-0002U7-P4
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:23414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7L-0002Tv-Gs
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:15 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:40 +0800
Message-Id: <1493201210-14357-11-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 10/20] VFIO: notify vIOMMU emulator when
 device is assigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

With vIOMMU exposed to guest, notify vIOMMU emulator to record information
of this assigned device. This patch adds iommu_ops->record_device to record
the host bus/slot/function for this device. In future, it can be extended to
other info which is needed.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9e13472..a1e6942 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2881,6 +2881,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                    subregion,
                                    0,
                                    &n1);
+
+            memory_region_notify_device_record(subregion,
+                                               &vdev->host);
+
         }
     }
 
-- 
1.9.1
