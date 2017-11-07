Received: from eggs.gnu.org ([2001:4830:134:3::10]:34870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SP-0005vM-Ns
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SJ-00009N-RI
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:29 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:56644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SJ-00008w-Ki
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:23 -0500
Received: by mail-wm0-x241.google.com with SMTP id z3so4534872wme.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:57 +0000
Message-Id: <20171107150558.22131-10-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 09/10] risu_reginfo_aarch64: add
 reginfo_copy_sve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Add the ability to save SVE registers from the signal context. This is
controlled with an optional flag --test-sve. The whole thing is
conditionally compiled when SVE support is in the sigcontext headers.

Technically SVE registers could be beyond an EXTRA_MAGIC section. I've
not seen this on the model so currently we abort() if we encounter the
EXTRA_MAGIC section.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu_reginfo_aarch64.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_aarch64.h |  8 ++++++
 2 files changed, 82 insertions(+)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 38ad338..7c97790 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -13,12 +13,78 @@
 #include <stdio.h>
 #include <ucontext.h>
 #include <string.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <stdbool.h>
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
 
+#ifndef SVE_MAGIC
 void *arch_long_opts;
 char *arch_extra_help;
+#else
+/* Should we test SVE register state */
+static int test_sve;
+static struct option extra_opts[] = {
+    {"test-sve", no_argument, &test_sve, 1},
+    {0, 0, 0, 0}
+};
+
+void *arch_long_opts = &extra_opts[0];
+char *arch_extra_help = "  --test-sve        Compare SVE registers\n";
+
+/* Extra SVE copy function, only called with --test-sve */
+static void reginfo_copy_sve(struct reginfo *ri, struct _aarch64_ctx *ctx)
+{
+    struct sve_context *sve;
+    int r, vq;
+    bool found = false;
+
+    while (!found) {
+       switch (ctx->magic)
+       {
+          case SVE_MAGIC:
+             found = true;
+             break;
+          case EXTRA_MAGIC:
+             fprintf(stderr, "%s: found EXTRA_MAGIC\n", __func__);
+             abort();
+          case 0:
+             /* We might not have an SVE context */
+             fprintf(stderr, "%s: reached end of ctx, no joy (%d)\n", __func__, ctx->size);
+             return;
+          default:
+             ctx = (struct _aarch64_ctx *)((void *)ctx + ctx->size);
+             break;
+       }
+
+    }
+
+    sve = (struct sve_context *) ctx;
+    ri->vl = sve->vl;
+    vq = sve_vq_from_vl(sve->vl); /* number of quads for whole vl */
+
+    /* Copy ZREG's one at a time */
+    for (r = 0; r < SVE_NUM_ZREGS; r++) {
+        memcpy(&ri->zregs[r],
+               (char *)sve + SVE_SIG_ZREG_OFFSET(vq, r),
+               SVE_SIG_ZREG_SIZE(vq));
+    }
+
+    /* Copy PREG's one at a time */
+    for (r = 0; r < SVE_NUM_PREGS; r++) {
+        memcpy(&ri->pregs[r],
+               (char *)sve + SVE_SIG_PREG_OFFSET(vq, r),
+               SVE_SIG_PREG_SIZE(vq));
+    }
+
+    /* Finally the FFR */
+    memcpy(&ri->ffr,(char *)sve + SVE_SIG_FFR_OFFSET(vq),
+               SVE_SIG_FFR_SIZE(vq));
+
+}
+#endif
 
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
@@ -26,6 +92,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     int i;
     struct _aarch64_ctx *ctx;
     struct fpsimd_context *fp;
+
     /* necessary to be able to compare with memcmp later */
     memset(ri, 0, sizeof(*ri));
 
@@ -59,6 +126,13 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     for (i = 0; i < 32; i++) {
         ri->vregs[i] = fp->vregs[i];
     }
+
+#ifdef SVE_MAGIC
+    if (test_sve) {
+        ctx = (struct _aarch64_ctx *) &uc->uc_mcontext.__reserved[0];
+        reginfo_copy_sve(ri, ctx);
+    }
+#endif
 };
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index a05fb4e..317383f 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -25,6 +25,14 @@ struct reginfo {
     uint32_t fpsr;
     uint32_t fpcr;
     __uint128_t vregs[32];
+
+#ifdef SVE_MAGIC
+    /* SVE */
+    uint16_t    vl; /* current VL */
+    __uint128_t zregs[SVE_NUM_ZREGS][SVE_VQ_MAX];
+    uint16_t    pregs[SVE_NUM_PREGS][SVE_VQ_MAX];
+    uint16_t    ffr[SVE_VQ_MAX];
+#endif
 };
 
 #endif /* RISU_REGINFO_AARCH64_H */
-- 
2.14.2
