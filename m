Received: from eggs.gnu.org ([2001:4830:134:3::10]:51126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45f9-0002fA-SK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d45f4-0005mu-US
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d45f4-0005mV-L3
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:10:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3SDA9JZ108043
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:13 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a45pyt8t8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 09:10:12 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 28 Apr 2017 07:10:11 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 28 Apr 2017 15:09:40 +0200
In-Reply-To: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170428130951.44771-3-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 02/13] vfio: linux-headers update for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com

This is a placeholder for a linux-headers update.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 linux-headers/linux/vfio.h     | 17 +++++++++++++++++
 linux-headers/linux/vfio_ccw.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 linux-headers/linux/vfio_ccw.h

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 531cb2e..39a1d3b 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -198,6 +198,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)	/* vfio-ccw device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -446,6 +447,22 @@ enum {
 	VFIO_PCI_NUM_IRQS
 };
 
+/*
+ * The VFIO-CCW bus driver makes use of the following fixed region and
+ * IRQ index mapping.  Unimplemented regions return a size of zero.
+ * Unimplemented IRQ types return a count of zero.
+ */
+
+enum {
+        VFIO_CCW_CONFIG_REGION_INDEX,
+        VFIO_CCW_NUM_REGIONS
+};
+
+enum {
+        VFIO_CCW_IO_IRQ_INDEX,
+        VFIO_CCW_NUM_IRQS
+};
+
 /**
  * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
diff --git a/linux-headers/linux/vfio_ccw.h b/linux-headers/linux/vfio_ccw.h
new file mode 100644
index 0000000..4ee74ae
--- /dev/null
+++ b/linux-headers/linux/vfio_ccw.h
@@ -0,0 +1,28 @@
+/*
+ * Interfaces for vfio-ccw
+ *
+ * Copyright IBM Corp. 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ */
+
+#ifndef _VFIO_CCW_H_
+#define _VFIO_CCW_H_
+
+#include <linux/types.h>
+
+struct ccw_io_region {
+#define ORB_AREA_SIZE 12
+	__u8	orb_area[ORB_AREA_SIZE];
+#define SCSW_AREA_SIZE 12
+	__u8	scsw_area[SCSW_AREA_SIZE];
+#define IRB_AREA_SIZE 96
+	__u8	irb_area[IRB_AREA_SIZE];
+	__u32	ret_code;
+} __packed;
+
+#endif
-- 
2.10.2
