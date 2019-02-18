Received: from eggs.gnu.org ([209.51.188.92]:52268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqE-0006q9-HC
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqD-0006gP-Ge
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:06 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:46 +0100
Message-Id: <20190218111153.22681-4-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] target/s390x: Split out s390-tod.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>

From: Richard Henderson <richard.henderson@linaro.org>

We will need these from CONFIG_USER_ONLY as well,
which cannot access include/hw/.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190212053044.29015-2-richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/s390x/tod.h  | 16 +---------------
 target/s390x/s390-tod.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 15 deletions(-)
 create mode 100644 target/s390x/s390-tod.h

diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 47ef9de869cc..9c4a6000c331 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -12,6 +12,7 @@
 #define HW_S390_TOD_H
 
 #include "hw/qdev.h"
+#include "s390-tod.h"
 
 typedef struct S390TOD {
     uint8_t high;
@@ -50,21 +51,6 @@ typedef struct S390TODClass {
     void (*set)(S390TODState *td, const S390TOD *tod, Error **errp);
 } S390TODClass;
 
-/* The value of the TOD clock for 1.1.1970. */
-#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
-
-/* Converts ns to s390's clock format */
-static inline uint64_t time2tod(uint64_t ns)
-{
-    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
-}
-
-/* Converts s390's clock format to ns */
-static inline uint64_t tod2time(uint64_t t)
-{
-    return ((t >> 9) * 125) + (((t & 0x1ff) * 125) >> 9);
-}
-
 void s390_init_tod(void);
 S390TODState *s390_get_todstate(void);
 
diff --git a/target/s390x/s390-tod.h b/target/s390x/s390-tod.h
new file mode 100644
index 000000000000..8b74d6a6d886
--- /dev/null
+++ b/target/s390x/s390-tod.h
@@ -0,0 +1,29 @@
+/*
+ * TOD (Time Of Day) clock
+ *
+ * Copyright 2018 Red Hat, Inc.
+ * Author(s): David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TARGET_S390_TOD_H
+#define TARGET_S390_TOD_H
+
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
+/* Converts ns to s390's clock format */
+static inline uint64_t time2tod(uint64_t ns)
+{
+    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
+}
+
+/* Converts s390's clock format to ns */
+static inline uint64_t tod2time(uint64_t t)
+{
+    return ((t >> 9) * 125) + (((t & 0x1ff) * 125) >> 9);
+}
+
+#endif
-- 
2.17.2
