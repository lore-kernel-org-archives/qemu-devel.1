Received: from eggs.gnu.org ([2001:4830:134:3::10]:33190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBIXT-0000HJ-87
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBIXR-0001Ab-2Z
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:24:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBIXQ-0001AF-Uc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 07:24:41 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed, 25 Apr 2018 16:54:14 +0530
Message-Id: <20180425112415.12327-3-pagupta@redhat.com>
In-Reply-To: <20180425112415.12327-1-pagupta@redhat.com>
References: <20180425112415.12327-1-pagupta@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/2] pmem: device flush over VIRTIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, pagupta@redhat.com, lcapitulino@redhat.com

This patch adds functionality to perform 
flush from guest to hosy over VIRTIO 
when 'ND_REGION_VIRTIO'flag is set on 
nd_negion. Flag is set by 'virtio-pmem'
driver.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/nvdimm/region_devs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index a612be6..6c6454e 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -20,6 +20,7 @@
 #include <linux/nd.h>
 #include "nd-core.h"
 #include "nd.h"
+#include <linux/virtio_pmem.h>
 
 /*
  * For readq() and writeq() on 32-bit builds, the hi-lo, lo-hi order is
@@ -1074,6 +1075,12 @@ void nvdimm_flush(struct nd_region *nd_region)
 	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
 	int i, idx;
 
+       /* call PV device flush */
+	if (test_bit(ND_REGION_VIRTIO, &nd_region->flags)) {
+		virtio_pmem_flush(&nd_region->dev);
+		return;
+	}
+
 	/*
 	 * Try to encourage some diversity in flush hint addresses
 	 * across cpus assuming a limited number of flush hints.
-- 
2.9.3
