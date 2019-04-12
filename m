Received: from eggs.gnu.org ([209.51.188.92]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFh-0002LE-4J
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFf-0002Sg-CX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:53 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 12 Apr 2019 14:25:13 +0200
Message-Id: <20190412122523.24111-8-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 07/17] s390-bios:
 ptr2u32 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Introduce inline functions to convert between pointers and unsigned 32-bi=
t
ints. These are used to hide the ugliness required to  avoid compiler
warnings.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-8-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/helper.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 pc-bios/s390-ccw/helper.h

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
new file mode 100644
index 0000000000..78d5bc7442
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
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
+    IPL_assert((uint64_t)ptr <=3D 0xffffffff, "ptr2u32: ptr too large");
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
--=20
2.21.0
