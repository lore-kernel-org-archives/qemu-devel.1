Received: from eggs.gnu.org ([2001:4830:134:3::10]:38324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJdoF-0006jM-06
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJdoC-000823-KF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:44:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:40792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJdoC-00080N-8u
	for qemu-devel@nongnu.org; Fri, 18 May 2018 07:44:28 -0400
Received: by mail-wr0-x236.google.com with SMTP id v60-v6so8883291wrc.7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 04:44:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 18 May 2018 12:44:24 +0100
Message-Id: <20180518114424.18054-3-alex.bennee@linaro.org>
In-Reply-To: <20180518114424.18054-1-alex.bennee@linaro.org>
References: <20180518114424.18054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] tests/tcg/aarch64: userspace system
 register test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/sysregs.c       | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index ac177d9747..595927f027 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -7,7 +7,7 @@ VPATH 		+= $(AARCH64_SRC)
 
 # we don't build any of the ARM tests
 AARCH64_TESTS=$(filter-out $(ARM_TESTS), $(TESTS))
-AARCH64_TESTS+=fcvt
+AARCH64_TESTS+=fcvt sysregs
 TESTS:=$(AARCH64_TESTS)
 
 fcvt: LDFLAGS+=-lm
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
new file mode 100644
index 0000000000..0cd0c42d8c
--- /dev/null
+++ b/tests/tcg/aarch64/sysregs.c
@@ -0,0 +1,14 @@
+#include <stdio.h>
+
+#define get_cpu_reg(id) ({                                      \
+                unsigned long __val;                            \
+                asm("mrs %0, "#id : "=r" (__val));              \
+                printf("%-20s: 0x%016lx\n", #id, __val);        \
+        })
+
+int main(void)
+{
+    get_cpu_reg(cntvct_el0);
+    get_cpu_reg(cntfrq_el0);
+    return 0;
+}
-- 
2.17.0
