Received: from eggs.gnu.org ([209.51.188.92]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5T-0004bT-7f
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5O-0006r1-Ej
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:39:47 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:38:46 +0100
Message-Id: <20190226113915.20150-5-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 04/33] s390x/tcg: Utilities for vector
 instruction helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We'll have to read/write vector elements quite frequently from helpers.
The tricky bit is properly taking care of endianess. Handle it similar
to aarch64.

target/s390x/vec_helper.c will later also contain vector support
instruction helpers.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/Makefile.objs |  1 +
 target/s390x/vec.h         | 31 +++++++++++++
 target/s390x/vec_helper.c  | 90 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 target/s390x/vec.h
 create mode 100644 target/s390x/vec_helper.c

diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index 22a9a9927a..68eeee3d2f 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -1,6 +1,7 @@
 obj-y += cpu.o cpu_models.o cpu_features.o gdbstub.o interrupt.o helper.o
 obj-$(CONFIG_TCG) += translate.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o crypto_helper.o
+obj-$(CONFIG_TCG) += vec_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o diag.o
 obj-$(CONFIG_SOFTMMU) += sigp.o
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/target/s390x/vec.h b/target/s390x/vec.h
new file mode 100644
index 0000000000..c03be1a9c9
--- /dev/null
+++ b/target/s390x/vec.h
@@ -0,0 +1,31 @@
+/*
+ * QEMU TCG support -- s390x vector utilitites
+ *
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef S390X_VEC_H
+#define S390X_VEC_H
+
+typedef union S390Vector {
+    uint64_t doubleword[2];
+    uint32_t word[4];
+    uint16_t halfword[8];
+    uint8_t byte[16];
+} S390Vector;
+
+uint8_t s390_vec_read_element8(const S390Vector *v, uint8_t enr);
+uint16_t s390_vec_read_element16(const S390Vector *v, uint8_t enr);
+uint32_t s390_vec_read_element32(const S390Vector *v, uint8_t enr);
+uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr);
+void s390_vec_write_element8(S390Vector *v, uint8_t enr, uint8_t data);
+void s390_vec_write_element16(S390Vector *v, uint8_t enr, uint16_t data);
+void s390_vec_write_element32(S390Vector *v, uint8_t enr, uint32_t data);
+void s390_vec_write_element64(S390Vector *v, uint8_t enr, uint64_t data);
+
+#endif /* S390X_VEC_H */
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
new file mode 100644
index 0000000000..3e21e440ba
--- /dev/null
+++ b/target/s390x/vec_helper.c
@@ -0,0 +1,90 @@
+/*
+ * QEMU TCG support -- s390x vector support instructions and utilitites
+ *
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "vec.h"
+#include "tcg/tcg.h"
+
+/*
+ * Each vector is stored as two 64bit host values. So when talking about
+ * byte/halfword/word numbers, we have to take care of proper translation
+ * between element numbers.
+ *
+ * Big Endian (target/possible host)
+ * B:  [ 0][ 1][ 2][ 3][ 4][ 5][ 6][ 7] - [ 8][ 9][10][11][12][13][14][15]
+ * HW: [     0][     1][     2][     3] - [     4][     5][     6][     7]
+ * W:  [             0][             1] - [             2][             3]
+ * DW: [                             0] - [                             1]
+ *
+ * Little Endian (possible host)
+ * B:  [ 7][ 6][ 5][ 4][ 3][ 2][ 1][ 0] - [15][14][13][12][11][10][ 9][ 8]
+ * HW: [     3][     2][     1][     0] - [     7][     6][     5][     4]
+ * W:  [             1][             0] - [             3][             2]
+ * DW: [                             0] - [                             1]
+ */
+#ifndef HOST_WORDS_BIGENDIAN
+#define H1(x)  ((x) ^ 7)
+#define H2(x)  ((x) ^ 3)
+#define H4(x)  ((x) ^ 1)
+#else
+#define H1(x)  (x)
+#define H2(x)  (x)
+#define H4(x)  (x)
+#endif
+
+uint8_t s390_vec_read_element8(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 16);
+    return v->byte[H1(enr)];
+}
+
+uint16_t s390_vec_read_element16(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 8);
+    return v->halfword[H2(enr)];
+}
+
+uint32_t s390_vec_read_element32(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 4);
+    return v->word[H4(enr)];
+}
+
+uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 2);
+    return v->doubleword[enr];
+}
+
+void s390_vec_write_element8(S390Vector *v, uint8_t enr, uint8_t data)
+{
+    g_assert(enr < 16);
+    v->byte[H1(enr)] = data;
+}
+
+void s390_vec_write_element16(S390Vector *v, uint8_t enr, uint16_t data)
+{
+    g_assert(enr < 8);
+    v->halfword[H2(enr)] = data;
+}
+
+void s390_vec_write_element32(S390Vector *v, uint8_t enr, uint32_t data)
+{
+    g_assert(enr < 4);
+    v->word[H4(enr)] = data;
+}
+
+void s390_vec_write_element64(S390Vector *v, uint8_t enr, uint64_t data)
+{
+    g_assert(enr < 2);
+    v->doubleword[enr] = data;
+}
-- 
2.17.2
