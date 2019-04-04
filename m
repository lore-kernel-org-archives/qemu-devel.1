Received: from eggs.gnu.org ([209.51.188.92]:43698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3SH-0007E9-EU
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3SF-0004EB-Mz
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hC3SD-00049X-Rf
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:34:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34EPYYV106465
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 10:34:56 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnhyhpw0s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:34:55 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 4 Apr 2019 15:34:55 +0100
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  4 Apr 2019 10:34:26 -0400
In-Reply-To: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1554388475-18329-8-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v6 07/16] s390-bios: ptr2u32 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Introduce inline functions to convert between pointers and unsigned 32-bit
ints. These are used to hide the ugliness required to  avoid compiler
warnings.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/helper.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 pc-bios/s390-ccw/helper.h

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
new file mode 100644
index 0000000..78d5bc7
--- /dev/null
+++ b/pc-bios/s390-ccw/helper.h
@@ -0,0 +1,31 @@
+/*
+ * Helper Functions
+ *
+ * Copyright (c) 2019 IBM Corp.
+ *
+ * Author(s): Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390_CCW_HELPER_H
+#define S390_CCW_HELPER_H
+
+#include "s390-ccw.h"
+
+/* Avoids compiler warnings when casting a pointer to a u32 */
+static inline uint32_t ptr2u32(void *ptr)
+{
+    IPL_assert((uint64_t)ptr <= 0xffffffff, "ptr2u32: ptr too large");
+    return (uint32_t)(uint64_t)ptr;
+}
+
+/* Avoids compiler warnings when casting a u32 to a pointer */
+static inline void *u32toptr(uint32_t n)
+{
+    return (void *)(uint64_t)n;
+}
+
+#endif
-- 
2.7.4
