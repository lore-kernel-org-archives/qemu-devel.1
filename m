Received: from eggs.gnu.org ([209.51.188.92]:42998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqe-0002x6-W3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqb-0005Hx-DN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:53 +0100
Message-Id: <20190311090322.21603-5-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/33] s390x/tcg: Utilities for vector
 instruction helpers
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

We'll have to read/write vector elements quite frequently from helpers.
The tricky bit is properly taking care of endianess. Handle it similar
to aarch64.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-4-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/vec.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 target/s390x/vec.h

diff --git a/target/s390x/vec.h b/target/s390x/vec.h
new file mode 100644
index 000000000000..3313fb43ee75
--- /dev/null
+++ b/target/s390x/vec.h
@@ -0,0 +1,101 @@
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
+static inline uint8_t s390_vec_read_element8(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 16);
+    return v->byte[H1(enr)];
+}
+
+static inline uint16_t s390_vec_read_element16(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 8);
+    return v->halfword[H2(enr)];
+}
+
+static inline uint32_t s390_vec_read_element32(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 4);
+    return v->word[H4(enr)];
+}
+
+static inline uint64_t s390_vec_read_element64(const S390Vector *v, uint8_t enr)
+{
+    g_assert(enr < 2);
+    return v->doubleword[enr];
+}
+
+static inline void s390_vec_write_element8(S390Vector *v, uint8_t enr,
+                                           uint8_t data)
+{
+    g_assert(enr < 16);
+    v->byte[H1(enr)] = data;
+}
+
+static inline void s390_vec_write_element16(S390Vector *v, uint8_t enr,
+                                            uint16_t data)
+{
+    g_assert(enr < 8);
+    v->halfword[H2(enr)] = data;
+}
+
+static inline void s390_vec_write_element32(S390Vector *v, uint8_t enr,
+                                            uint32_t data)
+{
+    g_assert(enr < 4);
+    v->word[H4(enr)] = data;
+}
+
+static inline void s390_vec_write_element64(S390Vector *v, uint8_t enr,
+                                            uint64_t data)
+{
+    g_assert(enr < 2);
+    v->doubleword[enr] = data;
+}
+
+#endif /* S390X_VEC_H */
-- 
2.17.2
