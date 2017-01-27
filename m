Received: from eggs.gnu.org ([2001:4830:134:3::10]:59754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vw-00018d-VM
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vv-0005Au-Qz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vv-00055y-Jf
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vg-0003Md-US
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:20 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:00 +0000
Message-Id: <1485531137-2362-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/22] hw/registerfields.h: Pull FIELD etc
 macros out of hw/register.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hw/register.h provides macros like FIELD which make it easy to define
shift, mask and length constants for the fields within a register.
Unfortunately register.h also includes a lot of other things, some
of which will only compile in the softmmu build.

Pull the FIELD macro and friends out into a separate header file,
so they can be used in places like target/arm files which also
get built in the user-only configs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1484937883-1068-5-git-send-email-peter.maydell@linaro.org
---
 include/hw/register.h       | 47 +----------------------------------
 include/hw/registerfields.h | 60 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 46 deletions(-)
 create mode 100644 include/hw/registerfields.h

diff --git a/include/hw/register.h b/include/hw/register.h
index 5b6dc32..de2414e 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -13,6 +13,7 @@
 
 #include "hw/qdev-core.h"
 #include "exec/memory.h"
+#include "hw/registerfields.h"
 
 typedef struct RegisterInfo RegisterInfo;
 typedef struct RegisterAccessInfo RegisterAccessInfo;
@@ -206,50 +207,4 @@ RegisterInfoArray *register_init_block32(DeviceState *owner,
 
 void register_finalize_block(RegisterInfoArray *r_array);
 
-/* Define constants for a 32 bit register */
-
-/* This macro will define A_FOO, for the byte address of a register
- * as well as R_FOO for the uint32_t[] register number (A_FOO / 4).
- */
-#define REG32(reg, addr)                                                  \
-    enum { A_ ## reg = (addr) };                                          \
-    enum { R_ ## reg = (addr) / 4 };
-
-/* Define SHIFT, LENGTH and MASK constants for a field within a register */
-
-/* This macro will define FOO_BAR_MASK, FOO_BAR_SHIFT and FOO_BAR_LENGTH 
- * constants for field BAR in register FOO.
- */
-#define FIELD(reg, field, shift, length)                                  \
-    enum { R_ ## reg ## _ ## field ## _SHIFT = (shift)};                  \
-    enum { R_ ## reg ## _ ## field ## _LENGTH = (length)};                \
-    enum { R_ ## reg ## _ ## field ## _MASK =                             \
-                                        MAKE_64BIT_MASK(shift, length)};
-
-/* Extract a field from a register */
-#define FIELD_EX32(storage, reg, field)                                   \
-    extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
-              R_ ## reg ## _ ## field ## _LENGTH)
-
-/* Extract a field from an array of registers */
-#define ARRAY_FIELD_EX32(regs, reg, field)                                \
-    FIELD_EX32((regs)[R_ ## reg], reg, field)
-
-/* Deposit a register field.
- * Assigning values larger then the target field will result in
- * compilation warnings.
- */
-#define FIELD_DP32(storage, reg, field, val) ({                           \
-    struct {                                                              \
-        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint32_t d;                                                           \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
-
-/* Deposit a field to array of registers.  */
-#define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
-    (regs)[R_ ## reg] = FIELD_DP32((regs)[R_ ## reg], reg, field, val);
-
 #endif
diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
new file mode 100644
index 0000000..af101d5
--- /dev/null
+++ b/include/hw/registerfields.h
@@ -0,0 +1,60 @@
+/*
+ * Register Definition API: field macros
+ *
+ * Copyright (c) 2016 Xilinx Inc.
+ * Copyright (c) 2013 Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef REGISTERFIELDS_H
+#define REGISTERFIELDS_H
+
+/* Define constants for a 32 bit register */
+
+/* This macro will define A_FOO, for the byte address of a register
+ * as well as R_FOO for the uint32_t[] register number (A_FOO / 4).
+ */
+#define REG32(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) / 4 };
+
+/* Define SHIFT, LENGTH and MASK constants for a field within a register */
+
+/* This macro will define FOO_BAR_MASK, FOO_BAR_SHIFT and FOO_BAR_LENGTH 
+ * constants for field BAR in register FOO.
+ */
+#define FIELD(reg, field, shift, length)                                  \
+    enum { R_ ## reg ## _ ## field ## _SHIFT = (shift)};                  \
+    enum { R_ ## reg ## _ ## field ## _LENGTH = (length)};                \
+    enum { R_ ## reg ## _ ## field ## _MASK =                             \
+                                        MAKE_64BIT_MASK(shift, length)};
+
+/* Extract a field from a register */
+#define FIELD_EX32(storage, reg, field)                                   \
+    extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
+              R_ ## reg ## _ ## field ## _LENGTH)
+
+/* Extract a field from an array of registers */
+#define ARRAY_FIELD_EX32(regs, reg, field)                                \
+    FIELD_EX32((regs)[R_ ## reg], reg, field)
+
+/* Deposit a register field.
+ * Assigning values larger then the target field will result in
+ * compilation warnings.
+ */
+#define FIELD_DP32(storage, reg, field, val) ({                           \
+    struct {                                                              \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
+    } v = { .v = val };                                                   \
+    uint32_t d;                                                           \
+    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
+    d; })
+
+/* Deposit a field to array of registers.  */
+#define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
+    (regs)[R_ ## reg] = FIELD_DP32((regs)[R_ ## reg], reg, field, val);
+
+#endif
-- 
2.7.4
