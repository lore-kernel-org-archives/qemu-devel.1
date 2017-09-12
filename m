Received: from eggs.gnu.org ([2001:4830:134:3::10]:37798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dro02-0001dE-3w
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1drnzz-0006xl-2t
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:22 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1drnzy-0006xI-Qa
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:25:19 -0400
Received: by mail-pf0-x231.google.com with SMTP id e1so19440042pfk.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 09:25:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Sep 2017 09:24:58 -0700
Message-Id: <20170912162513.21694-2-richard.henderson@linaro.org>
In-Reply-To: <20170912162513.21694-1-richard.henderson@linaro.org>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 01/16] tcg: Add expanders for out-of-line
 vector helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

This is a minimum extraction from a full generic vector patchset
in order to support simultaneous development in target/arm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target     |  5 +--
 tcg/tcg-gvec-desc.h | 49 ++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.h   | 43 +++++++++++++++++++++++++
 tcg/tcg-op-gvec.c   | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 2 deletions(-)
 create mode 100644 tcg/tcg-gvec-desc.h
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 tcg/tcg-op-gvec.c

diff --git a/Makefile.target b/Makefile.target
index 7f42c45db8..e647b6e2cb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -93,8 +93,9 @@ all: $(PROGS) stap
 # cpu emulator library
 obj-y += exec.o
 obj-y += accel/
-obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
-obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/tcg-runtime.o
+obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-gvec.o
+obj-$(CONFIG_TCG) += tcg/optimize.o tcg/tcg-common.o
+obj-$(CONFIG_TCG) += tcg/tcg-runtime.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
diff --git a/tcg/tcg-gvec-desc.h b/tcg/tcg-gvec-desc.h
new file mode 100644
index 0000000000..8ba9a8168d
--- /dev/null
+++ b/tcg/tcg-gvec-desc.h
@@ -0,0 +1,49 @@
+/*
+ *  Generic vector operation descriptor
+ *
+ *  Copyright (c) 2017 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vectors. */
+#define SIMD_OPRSZ_SHIFT   0
+#define SIMD_OPRSZ_BITS    5
+
+#define SIMD_MAXSZ_SHIFT   (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
+#define SIMD_MAXSZ_BITS    5
+
+#define SIMD_DATA_SHIFT    (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_DATA_BITS     (32 - SIMD_DATA_SHIFT)
+
+/* Create a descriptor from components.  */
+uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
+
+/* Extract the operation size from a descriptor.  */
+static inline intptr_t simd_oprsz(uint32_t desc)
+{
+    return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) + 1) * 8;
+}
+
+/* Extract the max vector size from a descriptor.  */
+static inline intptr_t simd_maxsz(uint32_t desc)
+{
+    return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) + 1) * 8;
+}
+
+/* Extract the operation-specific data from a descriptor.  */
+static inline int32_t simd_data(uint32_t desc)
+{
+    return sextract32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS);
+}
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
new file mode 100644
index 0000000000..affb7c2e89
--- /dev/null
+++ b/tcg/tcg-op-gvec.h
@@ -0,0 +1,43 @@
+/*
+ *  Generic vector operation expansion
+ *
+ *  Copyright (c) 2017 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * "Generic" vectors.  All operands are given as offsets from ENV,
+ * and therefore cannot also be allocated via tcg_global_mem_new_*.
+ * OPRSZ is the byte size of the vector upon which the operation is performed.
+ * MAXSZ is the byte size of the full vector; bytes beyond OPSZ are cleared.
+ *
+ * All sizes must be 8 or any multiple of 16.
+ * When OPRSZ is 8, the alignment may be 8, otherwise must be 16.
+ * Operands may completely, but not partially, overlap.
+ */
+
+/* Expand a call to a gvec-stype helper, with pointers to three vector
+   operands, and a descriptor (see tcg-gvec-desc.h).  */
+typedef void (gen_helper_gvec_3)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, uint32_t data,
+                        gen_helper_gvec_3 *fn);
+
+/* Similarly, passing an extra pointer (e.g. env or float_status).  */
+typedef void (gen_helper_gvec_3_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr,
+                                     TCGv_ptr, TCGv_i32);
+void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
+                        uint32_t data, gen_helper_gvec_3_ptr *fn);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
new file mode 100644
index 0000000000..f48415020d
--- /dev/null
+++ b/tcg/tcg-op-gvec.c
@@ -0,0 +1,93 @@
+/*
+ *  Generic vector operation expansion
+ *
+ *  Copyright (c) 2017 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "tcg.h"
+#include "tcg-op.h"
+#include "tcg-op-gvec.h"
+#include "tcg-gvec-desc.h"
+
+
+/* Create a descriptor from components.  */
+uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
+{
+    uint32_t desc = 0;
+
+    assert(oprsz % 8 == 0 && oprsz <= (8 << SIMD_OPRSZ_BITS));
+    assert(maxsz % 8 == 0 && maxsz <= (8 << SIMD_MAXSZ_BITS));
+    assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+
+    oprsz = (oprsz / 8) - 1;
+    maxsz = (maxsz / 8) - 1;
+    desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
+    desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
+    desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
+
+    return desc;
+}
+
+/* Generate a call to a gvec-style helper with three vector operands.  */
+void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, uint32_t data,
+                        gen_helper_gvec_3 *fn)
+{
+    TCGv_ptr a0, a1, a2;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+    a2 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, tcg_ctx.tcg_env, dofs);
+    tcg_gen_addi_ptr(a1, tcg_ctx.tcg_env, aofs);
+    tcg_gen_addi_ptr(a2, tcg_ctx.tcg_env, bofs);
+
+    fn(a0, a1, a2, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_ptr(a2);
+    tcg_temp_free_i32(desc);
+}
+
+/* Generate a call to a gvec-style helper with three vector operands
+   and an extra pointer operand.  */
+void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        TCGv_ptr ptr, uint32_t oprsz, uint32_t maxsz,
+                        uint32_t data, gen_helper_gvec_3_ptr *fn)
+{
+    TCGv_ptr a0, a1, a2;
+    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+
+    a0 = tcg_temp_new_ptr();
+    a1 = tcg_temp_new_ptr();
+    a2 = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(a0, tcg_ctx.tcg_env, dofs);
+    tcg_gen_addi_ptr(a1, tcg_ctx.tcg_env, aofs);
+    tcg_gen_addi_ptr(a2, tcg_ctx.tcg_env, bofs);
+
+    fn(a0, a1, a2, ptr, desc);
+
+    tcg_temp_free_ptr(a0);
+    tcg_temp_free_ptr(a1);
+    tcg_temp_free_ptr(a2);
+    tcg_temp_free_i32(desc);
+}
-- 
2.13.5
