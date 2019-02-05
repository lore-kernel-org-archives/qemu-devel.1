Received: from eggs.gnu.org ([209.51.188.92]:36005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AU-0001uc-Bv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0000bH-MT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AS-0000P1-CO
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id z5so4445339wmf.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.27
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:59 +0000
Message-Id: <20190205170510.21984-12-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/22] tests/tcg/aarch64: Add pauth smoke test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190201195404.30486-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  6 +++++-
 tests/tcg/aarch64/pauth-1.c       | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/pauth-1.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 08c45b8470c..2bb914975be 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -8,10 +8,14 @@ VPATH 		+= $(AARCH64_SRC)
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
+run-pauth-%: QEMU += -cpu max
+
+TESTS:=$(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/pauth-1.c b/tests/tcg/aarch64/pauth-1.c
new file mode 100644
index 00000000000..ae6dc05c2b1
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
+    prctl(PR_PAC_RESET_KEYS, PR_PAC_APDAKEY, 0, 0, 0);
+    asm volatile("pacdza %0" : "=r"(p2) : "0"(p0));
+
+    assert(p1 != p0);
+    assert(p1 != p2);
+    return 0;
+}
-- 
2.20.1
