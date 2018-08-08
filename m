Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnNkc-0004Xg-6v
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnNka-0006yu-I5
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnNka-0006wL-5t
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:39:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id g6-v6so1909805wrp.0
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 05:39:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  8 Aug 2018 13:39:33 +0100
Message-Id: <20180808123934.17450-4-alex.bennee@linaro.org>
In-Reply-To: <20180808123934.17450-1-alex.bennee@linaro.org>
References: <20180808123934.17450-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/4] target/arm: add a fallback disassemble
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Now we can generate a disassembler we need a function to hook into it.
As we only deal with SVE instructions at the moment we don't need to
differentiate the various decoders.

I special case 0x5af0 as it is used by RISU for checkpoints.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/Makefile.objs |  8 ++++++++
 target/arm/disassemble.c | 22 ++++++++++++++++++++++
 target/arm/internals.h   |  2 ++
 3 files changed, 32 insertions(+)
 create mode 100644 target/arm/disassemble.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 11c7baf8a3..4339353df8 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -20,3 +20,11 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
 
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
+
+target/arm/disas-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --disassemble -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/disassemble.o: target/arm/disas-sve.inc.c
+obj-$(TARGET_AARCH64) += disassemble.o
diff --git a/target/arm/disassemble.c b/target/arm/disassemble.c
new file mode 100644
index 0000000000..801f9680cb
--- /dev/null
+++ b/target/arm/disassemble.c
@@ -0,0 +1,22 @@
+/*
+ * Fallback dissasembly
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "decoder.h"
+
+#include "disas-sve.inc.c"
+
+size_t do_aarch64_fallback_disassembly(const uint8_t *insnp, char *ptr, size_t n)
+{
+    uint32_t insn = ldl_p(insnp);
+
+    if (insn == 0x5af0) {
+        snprintf(ptr, n, "illegal insn (risu checkpoint?)");
+    } else if (!decode(ptr, n, insn)) {
+        snprintf(ptr, n, "failed decode");
+    }
+
+    return 4;
+}
diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc9357766c..80796632a2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -796,4 +796,6 @@ static inline uint32_t arm_debug_exception_fsr(CPUARMState *env)
     }
 }
 
+size_t do_aarch64_fallback_disassembly(const uint8_t *insn, char *ptr, size_t n);
+
 #endif
-- 
2.17.1
