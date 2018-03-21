Received: from eggs.gnu.org ([2001:4830:134:3::10]:42160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029u-TY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000zE-9B
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000yA-1v
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:42 -0400
Message-Id: <1521663109-32262-8-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 07/14] fpu: introduce hostfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The appended paves the way for leveraging the host FPU for a subset
of guest FP operations. For most guest workloads (e.g. FP flags
aren't ever cleared, inexact occurs often and rounding is set to the
default [to nearest]) this will yield sizable performance speedups.

The approach followed here avoids checking the FP exception flags register.
See the comment at the top of hostfloat.c for details.

This assumes that QEMU is running on an IEEE754-compliant FPU and
that the rounding is set to the default (to nearest). The
implementation-dependent specifics of the FPU should not matter; things
like tininess detection and snan representation are still dealt with in
soft-fp. However, this approach will break on most hosts if we compile
QEMU with flags such as -ffast-math. We control the flags so this should
be easy to enforce though.

The licensing in softfloat.h is complicated at best, so to keep things
simple I'm adding this as a separate, GPL'ed file.

This patch just adds some boilerplate code; subsequent patches add
operations, one per commit to ease bisection.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 Makefile.target           |  2 +-
 include/fpu/hostfloat.h   | 14 +++++++
 include/fpu/softfloat.h   |  1 +
 fpu/hostfloat.c           | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/Makefile.objs |  2 +-
 tests/fp-test/Makefile    |  2 +-
 6 files changed, 114 insertions(+), 3 deletions(-)
 create mode 100644 include/fpu/hostfloat.h
 create mode 100644 fpu/hostfloat.c

diff --git a/Makefile.target b/Makefile.target
index 6549481..efcdfb9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -97,7 +97,7 @@ obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
-obj-y += fpu/softfloat.o
+obj-y += fpu/softfloat.o fpu/hostfloat.o
 obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
diff --git a/include/fpu/hostfloat.h b/include/fpu/hostfloat.h
new file mode 100644
index 0000000..b01291b
--- /dev/null
+++ b/include/fpu/hostfloat.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#ifndef HOSTFLOAT_H
+#define HOSTFLOAT_H
+
+#ifndef SOFTFLOAT_H
+#error fpu/hostfloat.h must only be included from softfloat.h
+#endif
+
+#endif /* HOSTFLOAT_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 8fb44a8..8963b68 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -95,6 +95,7 @@ enum {
 };
 
 #include "fpu/softfloat-types.h"
+#include "fpu/hostfloat.h"
 
 static inline void set_float_detect_tininess(int val, float_status *status)
 {
diff --git a/fpu/hostfloat.c b/fpu/hostfloat.c
new file mode 100644
index 0000000..cab0341
--- /dev/null
+++ b/fpu/hostfloat.c
@@ -0,0 +1,96 @@
+/*
+ * hostfloat.c - FP primitives that use the host's FPU whenever possible.
+ *
+ * Copyright (C) 2018, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * Fast emulation of guest FP instructions is challenging for two reasons.
+ * First, FP instruction semantics are similar but not identical, particularly
+ * when handling NaNs. Second, emulating at reasonable speed the guest FP
+ * exception flags is not trivial: reading the host's flags register with a
+ * feclearexcept & fetestexcept pair is slow [slightly slower than soft-fp],
+ * and trapping on every FP exception is not fast nor pleasant to work with.
+ *
+ * This module leverages the host FPU for a subset of the operations. To
+ * do this it follows the main idea presented in this paper:
+ *
+ * Guo, Yu-Chuan, et al. "Translating the ARM Neon and VFP instructions in a
+ * binary translator." Software: Practice and Experience 46.12 (2016):1591-1615.
+ *
+ * The idea is thus to leverage the host FPU to (1) compute FP operations
+ * and (2) identify whether FP exceptions occurred while avoiding
+ * expensive exception flag register accesses.
+ *
+ * An important optimization shown in the paper is that given that exception
+ * flags are rarely cleared by the guest, we can avoid recomputing some flags.
+ * This is particularly useful for the inexact flag, which is very frequently
+ * raised in floating-point workloads.
+ *
+ * We optimize the code further by deferring to soft-fp whenever FP
+ * exception detection might get hairy. Fortunately this is not common.
+ */
+#include <math.h>
+
+#include "qemu/osdep.h"
+#include "fpu/softfloat.h"
+
+#define GEN_TYPE_CONV(name, to_t, from_t)       \
+    static inline to_t name(from_t a)           \
+    {                                           \
+        to_t r = *(to_t *)&a;                   \
+        return r;                               \
+    }
+
+GEN_TYPE_CONV(float32_to_float, float, float32)
+GEN_TYPE_CONV(float64_to_double, double, float64)
+GEN_TYPE_CONV(float_to_float32, float32, float)
+GEN_TYPE_CONV(double_to_float64, float64, double)
+#undef GEN_TYPE_CONV
+
+#define GEN_INPUT_FLUSH(soft_t)                                         \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush__nocheck(soft_t *a, float_status *s)         \
+    {                                                                   \
+        if (unlikely(soft_t ## _is_denormal(*a))) {                     \
+            *a = soft_t ## _set_sign(soft_t ## _zero,                   \
+                                     soft_t ## _is_neg(*a));            \
+            s->float_exception_flags |= float_flag_input_denormal;      \
+        }                                                               \
+    }                                                                   \
+                                                                        \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush1(soft_t *a, float_status *s)                 \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+    }                                                                   \
+                                                                        \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush2(soft_t *a, soft_t *b, float_status *s)      \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+        soft_t ## _input_flush__nocheck(b, s);                          \
+    }                                                                   \
+                                                                        \
+    static inline __attribute__((always_inline)) void                   \
+    soft_t ## _input_flush3(soft_t *a, soft_t *b, soft_t *c,            \
+                            float_status *s)                            \
+    {                                                                   \
+        if (likely(!s->flush_inputs_to_zero)) {                         \
+            return;                                                     \
+        }                                                               \
+        soft_t ## _input_flush__nocheck(a, s);                          \
+        soft_t ## _input_flush__nocheck(b, s);                          \
+        soft_t ## _input_flush__nocheck(c, s);                          \
+    }
+
+GEN_INPUT_FLUSH(float32)
+GEN_INPUT_FLUSH(float64)
+#undef GEN_INPUT_FLUSH
diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
index ac61948..2868b11 100644
--- a/target/m68k/Makefile.objs
+++ b/target/m68k/Makefile.objs
@@ -1,5 +1,5 @@
 obj-y += m68k-semi.o
 obj-y += translate.o op_helper.o helper.o cpu.o
-obj-y += fpu_helper.o softfloat.o
+obj-y += fpu_helper.o softfloat.o hostfloat.o
 obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += monitor.o
diff --git a/tests/fp-test/Makefile b/tests/fp-test/Makefile
index 703434f..187cfcc 100644
--- a/tests/fp-test/Makefile
+++ b/tests/fp-test/Makefile
@@ -28,7 +28,7 @@ ibm:
 $(WHITELIST_FILES):
 	wget -nv -O $@ http://www.cs.columbia.edu/~cota/qemu/fpbench-$@
 
-fp-test$(EXESUF): fp-test.o softfloat.o
+fp-test$(EXESUF): fp-test.o softfloat.o hostfloat.o
 
 clean:
 	rm -f *.o *.d $(OBJS)
-- 
2.7.4
