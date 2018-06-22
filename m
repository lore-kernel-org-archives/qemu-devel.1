Received: from eggs.gnu.org ([2001:4830:134:3::10]:41824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwy-0005wD-Gn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMww-0003YS-V3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:08 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMww-0003XS-KQ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:06 -0400
Received: by mail-wm0-x244.google.com with SMTP id o13-v6so2421348wmf.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:12:02 +0100
Message-Id: <20180622141205.16306-20-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 19/22] risu_reginfo_aarch64: add
 support for copying SVE register state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Add the ability to save SVE registers from the signal context. This is
controlled with an optional flag --test-sve. The whole thing is
conditionally compiled when SVE support is in the sigcontext headers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - support EXTRA_MAGIC contexts
v3
  - handle conditional bits
  - include <signal.h> in reginfo.h
  - move from helper function to main init function
  - (void *) cast for memcpy
  - additional ifdef SVE_MAGIC stuff
---
 risu_reginfo_aarch64.c | 107 ++++++++++++++++++++++++++++++++++++-----
 risu_reginfo_aarch64.h |  16 ++++++
 2 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 3ccaf0e..79db5dd 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -16,13 +16,26 @@
 #include <signal.h> /* for FPSIMD_MAGIC */
 #include <stdlib.h>
 #include <stddef.h>
-#include <assert.h>
+#include <stdbool.h>
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
 
+#ifndef SVE_MAGIC
 const struct option * const arch_long_opts;
 const char * const arch_extra_help;
+#else
+
+/* Should we test SVE register state */
+static int test_sve;
+static const struct option extra_opts[] = {
+    {"test-sve", no_argument, &test_sve, 1},
+    {0, 0, 0, 0}
+};
+
+const struct option * const arch_long_opts = &extra_opts[0];
+const char * const arch_extra_help = "  --test-sve        Compare SVE registers\n";
+#endif
 
 void process_arch_opt(int opt, const char *arg)
 {
@@ -31,8 +44,12 @@ void process_arch_opt(int opt, const char *arg)
 
 const int reginfo_size(void)
 {
-    const int size = offsetof(struct reginfo, simd.end);
-    assert(sizeof(struct reginfo)==size);
+    int size = offsetof(struct reginfo, simd.end);
+#ifdef SVE_MAGIC
+    if (test_sve) {
+        size = offsetof(struct reginfo, sve.end);
+    }
+#endif
     return size;
 }
 
@@ -40,8 +57,12 @@ const int reginfo_size(void)
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
     int i;
-    struct _aarch64_ctx *ctx;
-    struct fpsimd_context *fp;
+    struct _aarch64_ctx *ctx, *extra = NULL;
+    struct fpsimd_context *fp = NULL;
+#ifdef SVE_MAGIC
+    struct sve_context *sve = NULL;
+#endif
+
     /* necessary to be able to compare with memcmp later */
     memset(ri, 0, sizeof(*ri));
 
@@ -57,21 +78,81 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.pc);
 
     ctx = (struct _aarch64_ctx *) &uc->uc_mcontext.__reserved[0];
-
-    while (ctx->magic != FPSIMD_MAGIC && ctx->size != 0) {
-        ctx += (ctx->size + sizeof(*ctx) - 1) / sizeof(*ctx);
+    while (ctx) {
+        switch (ctx->magic) {
+        case FPSIMD_MAGIC:
+            fp = (void *)ctx;
+            break;
+#ifdef SVE_MAGIC
+        case SVE_MAGIC:
+            sve = (void *)ctx;
+            break;
+        case EXTRA_MAGIC:
+            extra = (void *)((struct extra_context *)(ctx))->datap;
+            break;
+#endif
+        case 0:
+            /* End of list.  */
+            ctx = extra;
+            extra = NULL;
+            continue;
+        default:
+            /* Unknown record -- skip it.  */
+            break;
+        }
+        ctx = (void *)ctx + ctx->size;
     }
 
-    if (ctx->magic != FPSIMD_MAGIC || ctx->size != sizeof(*fp)) {
-        fprintf(stderr,
-                "risu_reginfo_aarch64: failed to get FP/SIMD state\n");
+    if (!fp || fp->head.size != sizeof(*fp)) {
+        fprintf(stderr, "risu_reginfo_aarch64: failed to get FP/SIMD state\n");
         return;
     }
-
-    fp = (struct fpsimd_context *) ctx;
     ri->fpsr = fp->fpsr;
     ri->fpcr = fp->fpcr;
 
+#ifdef SVE_MAGIC
+    if (test_sve) {
+        int vq = sve_vq_from_vl(sve->vl); /* number of quads for whole vl */
+
+        if (sve == NULL) {
+            fprintf(stderr, "risu_reginfo_aarch64: failed to get SVE state\n");
+            return;
+        }
+
+        ri->sve.vl = sve->vl;
+
+        if (sve->head.size < SVE_SIG_CONTEXT_SIZE(vq)) {
+            if (sve->head.size == sizeof(*sve)) {
+                /* SVE state is empty -- not an error.  */
+            } else {
+                fprintf(stderr, "risu_reginfo_aarch64: "
+                        "failed to get complete SVE state\n");
+            }
+            return;
+        }
+
+        /* Copy ZREG's one at a time */
+        for (i = 0; i < SVE_NUM_ZREGS; i++) {
+            memcpy(&ri->sve.zregs[i],
+                   (void *)sve + SVE_SIG_ZREG_OFFSET(vq, i),
+                   SVE_SIG_ZREG_SIZE(vq));
+        }
+
+        /* Copy PREG's one at a time */
+        for (i = 0; i < SVE_NUM_PREGS; i++) {
+            memcpy(&ri->sve.pregs[i],
+                   (void *)sve + SVE_SIG_PREG_OFFSET(vq, i),
+                   SVE_SIG_PREG_SIZE(vq));
+        }
+
+        /* Finally the FFR */
+        memcpy(&ri->sve.ffr,(void *)sve + SVE_SIG_FFR_OFFSET(vq),
+               SVE_SIG_FFR_SIZE(vq));
+
+        return;
+    }
+#endif
+
     for (i = 0; i < 32; i++) {
         ri->simd.vregs[i] = fp->vregs[i];
     }
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index ef97622..b3701b3 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -13,11 +13,24 @@
 #ifndef RISU_REGINFO_AARCH64_H
 #define RISU_REGINFO_AARCH64_H
 
+#include <signal.h> /* for SVE_MAGIC */
+
 struct simd_reginfo {
     __uint128_t vregs[32];
     char end[0];
 };
 
+#ifdef SVE_MAGIC
+struct sve_reginfo {
+    /* SVE */
+    uint16_t    vl; /* current VL */
+    __uint128_t zregs[SVE_NUM_ZREGS][SVE_VQ_MAX];
+    uint16_t    pregs[SVE_NUM_PREGS][SVE_VQ_MAX];
+    uint16_t    ffr[SVE_VQ_MAX];
+    char end[0];
+};
+#endif
+
 struct reginfo {
     uint64_t fault_address;
     uint64_t regs[31];
@@ -32,6 +45,9 @@ struct reginfo {
 
     union {
         struct simd_reginfo simd;
+#ifdef SVE_MAGIC
+        struct sve_reginfo sve;
+#endif
     };
 };
 
-- 
2.17.1
