Received: from eggs.gnu.org ([209.51.188.92]:38721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOj-0005to-5I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOg-00053o-9p
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:00 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOf-0004kz-Ly
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:58 -0500
Received: by mail-pf1-x444.google.com with SMTP id z9so344965pfi.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:58 -0800
Message-Id: <20190211235258.542-29-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 28/28] tests/tcg/aarch64: Add mte smoke tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/mte-1.c         | 27 +++++++++++++++++++++
 tests/tcg/aarch64/mte-2.c         | 39 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  4 ++++
 3 files changed, 70 insertions(+)
 create mode 100644 tests/tcg/aarch64/mte-1.c
 create mode 100644 tests/tcg/aarch64/mte-2.c

diff --git a/tests/tcg/aarch64/mte-1.c b/tests/tcg/aarch64/mte-1.c
new file mode 100644
index 0000000000..18bfb1120f
--- /dev/null
+++ b/tests/tcg/aarch64/mte-1.c
@@ -0,0 +1,27 @@
+/*
+ * Memory tagging, basic pass cases.
+ */
+
+#include <assert.h>
+
+asm(".arch armv8.5-a+memtag");
+
+int data[16 / sizeof(int)] __attribute__((aligned(16)));
+
+int main(int ac, char **av)
+{
+    int *p0 = data;
+    int *p1, *p2;
+    long c;
+
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(1));
+    assert(p1 != p0);
+    asm("subp %0,%1,%2" : "=r"(c) : "r"(p0), "r"(p1));
+    assert(c == 0);
+
+    asm("stg %0, [%0]" : : "r"(p1));
+    asm("ldg %0, [%1]" : "=r"(p2) : "r"(p0), "0"(p0));
+    assert(p1 == p2);
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/mte-2.c b/tests/tcg/aarch64/mte-2.c
new file mode 100644
index 0000000000..2991b7df69
--- /dev/null
+++ b/tests/tcg/aarch64/mte-2.c
@@ -0,0 +1,39 @@
+/*
+ * Memory tagging, basic fail cases.
+ */
+
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+
+asm(".arch armv8.5-a+memtag");
+
+int data[16 / sizeof(int)] __attribute__((aligned(16)));
+
+void pass(int sig)
+{
+    exit(0);
+}
+
+int main(int ac, char **av)
+{
+    int *p0 = data;
+    int *p1, *p2;
+    long excl = 1;
+
+    /* Create two differently tagged pointers.  */
+    asm("irg %0,%1,%2" : "=r"(p1) : "r"(p0), "r"(excl));
+    asm("gmi %0,%1,%0" : "+r"(excl) : "r" (p1));
+    assert(excl != 1);
+    asm("irg %0,%1,%2" : "=r"(p2) : "r"(p0), "r"(excl));
+    assert(p1 != p2);
+
+    /* Store the tag from the first pointer.  */
+    asm("stg %0, [%0]" : : "r"(p1));
+
+    *p1 = 0;
+    signal(SIGSEGV, pass);
+    *p2 = 0;
+
+    assert(0);
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 55420aeea6..614dfcd14d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -22,4 +22,8 @@ AARCH64_TESTS += bti-1
 bti-1: LDFLAGS += -nostartfiles -nodefaultlibs -nostdlib
 run-bti-1: QEMU += -cpu max,x-guarded-pages=on
 
+AARCH64_TESTS += mte-1 mte-2
+mte-%: CFLAGS += -O -g
+run-mte-%: QEMU += -cpu max,x-tagged-pages=on
+
 TESTS:=$(AARCH64_TESTS)
-- 
2.17.2
