Received: from eggs.gnu.org ([209.51.188.92]:58360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007Zw-Gk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0L-0007Co-Dv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0L-0007Bq-66
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id 64so13099362otb.8
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:25 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Date: Mon,  8 Apr 2019 14:27:46 -0400
Message-Id: <20190408182748.1238-4-jan.bobek@gmail.com>
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 3/5] risu_reginfo_i386: implement
 arch-specific reginfo interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Bobek <jan.bobek@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

CPU-specific code in risu_reginfo_* is expected to define and export
the following symbols:

- arch_long_opts, arch_extra_help, process_arch_opt
- reginfo_size
- reginfo_init
- reginfo_is_eq
- reginfo_dump, reginfo_dump_mismatch

Make risu_reginfo_i386.c implement this interface.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index e8d671f..3882261 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -10,12 +10,28 @@
  ******************************************************************************/
 
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <ucontext.h>
 
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
+const struct option * const arch_long_opts;
+const char * const arch_extra_help;
+
+void process_arch_opt(int opt, const char *arg)
+{
+    abort();
+}
+
+const int reginfo_size(void)
+{
+    return sizeof(struct reginfo);
+}
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
     int i;
     for (i = 0; i < NGREG; i++) {
@@ -51,18 +67,38 @@ static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
     ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
 }
 
-static char *regname[] = {
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+{
+    return 0 == memcmp(m, a, sizeof(*m));
+}
+
+static const char *const regname[NGREG] = {
     "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
     "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-    "CS", "EFL", "UESP", "SS", 0
+    "CS", "EFL", "UESP", "SS"
 };
 
-static void dump_reginfo(struct reginfo *ri)
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
-    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
     for (i = 0; i < NGREG; i++) {
-        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
+        fprintf(f, "  %s: %x\n", regname[i] ? regname[i] : "???",
                 ri->gregs[i]);
     }
+    return !ferror(f);
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        if (m->gregs[i] != a->gregs[i]) {
+            fprintf(f, "Mismatch: Register %s\n", regname[i] ? regname[i] : "???");
+            fprintf(f, "m: [%x] != a: [%x]\n", m->gregs[i], a->gregs[i]);
+        }
+    }
+    return !ferror(f);
 }
-- 
2.20.1
