Received: from eggs.gnu.org ([2001:4830:134:3::10]:52467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8u-0007zQ-Dd
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8s-0008B7-0Y
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:56 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:49536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8r-0008Ar-RE
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:53 -0400
Received: by mail-oi0-x22f.google.com with SMTP id t21so3682310oih.6
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:24 -0700
Message-Id: <20170917150535.8284-7-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/17] accel/tcg: move USER code to user-exec.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170912211934.20919-1-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.c | 54 -------------------------------------------------
 accel/tcg/user-exec.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 3e23649dd7..aafb171294 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -178,57 +178,3 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
 }
-
-#ifndef CONFIG_SOFTMMU
-/* The softmmu versions of these helpers are in cputlb.c.  */
-
-/* Do not allow unaligned operations to proceed.  Return the host address.  */
-static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
-                               int size, uintptr_t retaddr)
-{
-    /* Enforce qemu required alignment.  */
-    if (unlikely(addr & (size - 1))) {
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
-    }
-    return g2h(addr);
-}
-
-/* Macro to call the above, with local variables from the use context.  */
-#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
-
-#define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
-#define EXTRA_ARGS
-
-#define DATA_SIZE 1
-#include "atomic_template.h"
-
-#define DATA_SIZE 2
-#include "atomic_template.h"
-
-#define DATA_SIZE 4
-#include "atomic_template.h"
-
-#ifdef CONFIG_ATOMIC64
-#define DATA_SIZE 8
-#include "atomic_template.h"
-#endif
-
-/* The following is only callable from other helpers, and matches up
-   with the softmmu version.  */
-
-#ifdef CONFIG_ATOMIC128
-
-#undef EXTRA_ARGS
-#undef ATOMIC_NAME
-#undef ATOMIC_MMU_LOOKUP
-
-#define EXTRA_ARGS     , TCGMemOpIdx oi, uintptr_t retaddr
-#define ATOMIC_NAME(X) \
-    HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
-#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, retaddr)
-
-#define DATA_SIZE 16
-#include "atomic_template.h"
-#endif /* CONFIG_ATOMIC128 */
-
-#endif /* !CONFIG_SOFTMMU */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2a975eaf69..492ea0826c 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -24,6 +24,7 @@
 #include "qemu/bitops.h"
 #include "exec/cpu_ldst.h"
 #include "translate-all.h"
+#include "exec/helper-proto.h"
 
 #undef EAX
 #undef ECX
@@ -573,3 +574,54 @@ int cpu_signal_handler(int host_signum, void *pinfo,
 #error host CPU specific signal handler needed
 
 #endif
+
+/* The softmmu versions of these helpers are in cputlb.c.  */
+
+/* Do not allow unaligned operations to proceed.  Return the host address.  */
+static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
+                               int size, uintptr_t retaddr)
+{
+    /* Enforce qemu required alignment.  */
+    if (unlikely(addr & (size - 1))) {
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), retaddr);
+    }
+    return g2h(addr);
+}
+
+/* Macro to call the above, with local variables from the use context.  */
+#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
+
+#define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
+#define EXTRA_ARGS
+
+#define DATA_SIZE 1
+#include "atomic_template.h"
+
+#define DATA_SIZE 2
+#include "atomic_template.h"
+
+#define DATA_SIZE 4
+#include "atomic_template.h"
+
+#ifdef CONFIG_ATOMIC64
+#define DATA_SIZE 8
+#include "atomic_template.h"
+#endif
+
+/* The following is only callable from other helpers, and matches up
+   with the softmmu version.  */
+
+#ifdef CONFIG_ATOMIC128
+
+#undef EXTRA_ARGS
+#undef ATOMIC_NAME
+#undef ATOMIC_MMU_LOOKUP
+
+#define EXTRA_ARGS     , TCGMemOpIdx oi, uintptr_t retaddr
+#define ATOMIC_NAME(X) \
+    HELPER(glue(glue(glue(atomic_ ## X, SUFFIX), END), _mmu))
+#define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, retaddr)
+
+#define DATA_SIZE 16
+#include "atomic_template.h"
+#endif /* CONFIG_ATOMIC128 */
-- 
2.13.5
