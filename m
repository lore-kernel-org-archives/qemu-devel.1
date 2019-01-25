Received: from eggs.gnu.org ([209.51.188.92]:36788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAe4-0004rv-0G
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAPf-0005Pd-6C
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:31 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAPe-0005Od-So
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:27 -0500
Received: by mail-pl1-x641.google.com with SMTP id y1so5198329plp.9
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:57:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 14:57:14 -0800
Message-Id: <20190125225714.10234-8-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-1-richard.henderson@linaro.org>
References: <20190125225714.10234-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] tests/tcg/aarch64: Add pauth smoke tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/pauth-1.c       | 23 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  7 ++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/pauth-1.c

diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
new file mode 100644
index 0000000000..9bd8d28ede
--- /dev/null
+++ b/tests/tcg/aarch64/pauth-1.c
@@ -0,0 +1,23 @@
+#include <assert.h>
+#include <sys/prctl.h>
+
+asm(".arch armv8.4-a");
+
+#ifndef PR_PAC_RESET_KEYS
+#define PR_PAC_RESET_KEYS  54
+#define PR_PAC_APDAKEY     (1 << 2)
+#endif
+
+int main()
+{
+    int x;
+    void *p0 = &x, *p1, *p2;
+
+    asm volatile("pacdza %0" : "=r"(p1) : "0"(p0));
+    prctl(PR_PAC_RESET_KEYS, PR_PAC_APDAKEY);
+    asm volatile("pacdza %0" : "=r"(p2) : "0"(p0));
+
+    assert(p1 != p0);
+    assert(p1 != p2);
+    return 0;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 08c45b8470..e80d07276c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -8,10 +8,15 @@ VPATH 		+= $(AARCH64_SRC)
 # we don't build any of the ARM tests
 AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
 AARCH64_TESTS+=fcvt
-TESTS:=$(AARCH64_TESTS)
 
 fcvt: LDFLAGS+=-lm
 
 run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
+
+AARCH64_TESTS += pauth-1
+pauth-%: CFLAGS += -O -g
+run-pauth-%: QEMU += -cpu max
+
+TESTS:=$(AARCH64_TESTS)
-- 
2.17.2
