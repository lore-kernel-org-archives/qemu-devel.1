Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SJ-0001ZD-31
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SG-0005X0-P4
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:55 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:41612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5SG-0005Um-F7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:52 -0400
Received: by mail-wr0-x22d.google.com with SMTP id h10-v6so2662866wrq.8
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:04:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:56:01 +0100
Message-Id: <20180613125601.14371-23-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 22/22] risu_reginfo_aarch64: handle
 variable VQ
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

This involves parsing the command line parameter and calling the
kernel to set the VQ limit. We also add dumping of the register state
in the main register dump.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu_reginfo_aarch64.c | 164 +++++++++++++++++++++++++++++------------
 1 file changed, 115 insertions(+), 49 deletions(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index a352b4c..71c57b9 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -18,6 +18,8 @@
 #include <stddef.h>
 #include <stdbool.h>
 #include <inttypes.h>
+#include <assert.h>
+#include <sys/prctl.h>
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
@@ -30,17 +32,41 @@ const char * const arch_extra_help;
 /* Should we test SVE register state */
 static int test_sve;
 static const struct option extra_opts[] = {
-    {"test-sve", no_argument, &test_sve, 1},
+    {"test-sve", required_argument, NULL, FIRST_ARCH_OPT },
     {0, 0, 0, 0}
 };
 
 const struct option * const arch_long_opts = &extra_opts[0];
-const char * const arch_extra_help = "  --test-sve        Compare SVE registers\n";
+const char * const arch_extra_help
+    = "  --test-sve=<vq>        Compare SVE registers with VQ\n";
 #endif
 
 void process_arch_opt(int opt, const char *arg)
 {
+#ifdef SVE_MAGIC
+    long want, got;
+
+    assert(opt == FIRST_ARCH_OPT);
+    test_sve = strtol(arg, 0, 10);
+
+    if (test_sve <= 0 || test_sve > SVE_VQ_MAX) {
+        fprintf(stderr, "Invalid value for VQ (1-%d)\n", SVE_VQ_MAX);
+        exit(1);
+    }
+    want = sve_vl_from_vq(test_sve);
+    got = prctl(PR_SVE_SET_VL, want);
+    if (want != got) {
+        if (got < 0) {
+            perror("prctl PR_SVE_SET_VL");
+        } else {
+            fprintf(stderr, "Unsupported value for VQ (%d != %d)\n",
+                    test_sve, (int)sve_vq_from_vl(got));
+        }
+        exit(1);
+    }
+#else
     abort();
+#endif
 }
 
 const int reginfo_size(void)
@@ -113,12 +139,18 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 
 #ifdef SVE_MAGIC
     if (test_sve) {
-        int vq = sve_vq_from_vl(sve->vl); /* number of quads for whole vl */
+        int vq = test_sve;
 
         if (sve == NULL) {
             fprintf(stderr, "risu_reginfo_aarch64: failed to get SVE state\n");
             return;
         }
+        if (sve->vl != sve_vl_from_vq(vq)) {
+            fprintf(stderr, "risu_reginfo_aarch64: "
+                    "unexpected SVE state: %d != %d\n",
+                    sve->vl, sve_vl_from_vq(vq));
+            return;
+        }
 
         ri->sve.vl = sve->vl;
 
@@ -147,12 +179,12 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
         }
 
         /* Finally the FFR */
-        memcpy(&ri->sve.ffr,(void *)sve + SVE_SIG_FFR_OFFSET(vq),
+        memcpy(&ri->sve.ffr, (void *)sve + SVE_SIG_FFR_OFFSET(vq),
                SVE_SIG_FFR_SIZE(vq));
 
         return;
     }
-#endif
+#endif /* SVE_MAGIC */
 
     for (i = 0; i < 32; i++) {
         ri->simd.vregs[i] = fp->vregs[i];
@@ -166,32 +198,49 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 }
 
 #ifdef SVE_MAGIC
-static int sve_zreg_is_eq(struct reginfo *r1, struct reginfo *r2, int z)
+static int sve_zreg_is_eq(int vq, const void *z1, const void *z2)
 {
-    return memcmp(r1->sve.zregs[z], r2->sve.zregs[z], sizeof(*r1->sve.zregs[z])) == 0;
+    return memcmp(z1, z2, vq * 16) == 0;
 }
 
-static int sve_preg_is_eq(uint16_t const (*p1)[SVE_VQ_MAX],
-                          uint16_t const (*p2)[SVE_VQ_MAX])
+static int sve_preg_is_eq(int vq, const void *p1, const void *p2)
 {
-    return memcmp(p1, p2, sizeof *p1) == 0;
+    return memcmp(p1, p2, vq * 2) == 0;
 }
 
-static void sve_dump_preg_diff(FILE *f, int vq,
-                               uint16_t const (*p1)[SVE_VQ_MAX],
-                               uint16_t const (*p2)[SVE_VQ_MAX])
+static void sve_dump_preg(FILE *f, int vq, const uint16_t *p)
 {
     int q;
-
-    for (q = 0; q < vq; q++) {
-       fprintf(f, "%#04x", *p1[q]);
+    for (q = vq - 1; q >= 0; q--) {
+        fprintf(f, "%04x", p[q]);
     }
+}
+
+static void sve_dump_preg_diff(FILE *f, int vq, const uint16_t *p1,
+                               const uint16_t *p2)
+{
+    sve_dump_preg(f, vq, p1);
     fprintf(f, " vs ");
-    for (q = 0; q < vq; q++) {
-       fprintf(f, "%#04x", *p2[q]);
-    }
+    sve_dump_preg(f, vq, p2);
     fprintf(f, "\n");
 }
+
+static void sve_dump_zreg_diff(FILE *f, int vq, const __uint128_t *z1,
+                               const __uint128_t *z2)
+{
+    const char *pad = "";
+    int q;
+
+    for (q = 0; q < vq; ++q) {
+        if (z1[q] != z2[q]) {
+            fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64
+                    " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
+                    (uint64_t)(z1[q] >> 64), (uint64_t)z1[q],
+                    (uint64_t)(z2[q] >> 64), (uint64_t)z2[q]);
+            pad = "          ";
+        }
+    }
+}
 #endif
 
 /* reginfo_dump: print state to a stream, returns nonzero on success */
@@ -210,6 +259,36 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  fpsr  : %08x\n", ri->fpsr);
     fprintf(f, "  fpcr  : %08x\n", ri->fpcr);
 
+#ifdef SVE_MAGIC
+    if (test_sve) {
+        int q, vq = test_sve;
+
+        fprintf(f, "  vl    : %d\n", ri->sve.vl);
+
+        for (i = 0; i < 32; i++) {
+            fprintf(f, "  Z%-2d q%-2d: %016" PRIx64 "%016" PRIx64 "\n", i, 0,
+                    (uint64_t)(ri->sve.zregs[i][0] >> 64),
+                    (uint64_t)ri->sve.zregs[i][0]);
+            for (q = 1; q < vq; ++q) {
+                fprintf(f, "      q%-2d: %016" PRIx64 "%016" PRIx64 "\n", q,
+                        (uint64_t)(ri->sve.zregs[i][q] >> 64),
+                        (uint64_t)ri->sve.zregs[i][q]);
+            }
+        }
+
+        for (i = 0; i < 16; i++) {
+            fprintf(f, "  P%-2d    : ", i);
+            sve_dump_preg(f, vq, &ri->sve.pregs[i][0]);
+            fprintf(f, "\n");
+        }
+        fprintf(f, "  FFR    : ");
+        sve_dump_preg(f, vq, &ri->sve.ffr[0]);
+        fprintf(f, "\n");
+
+        return !ferror(f);
+    }
+#endif
+
     for (i = 0; i < 32; i++) {
         fprintf(f, "  V%-2d   : %016" PRIx64 "%016" PRIx64 "\n", i,
                 (uint64_t) (ri->simd.vregs[i] >> 64),
@@ -259,42 +338,29 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 
 #ifdef SVE_MAGIC
     if (test_sve) {
-        struct sve_reginfo *ms = &m->sve;
-        struct sve_reginfo *as = &a->sve;
+        int vq = sve_vq_from_vl(m->sve.vl);
 
-        if (ms->vl != as->vl) {
-            fprintf(f, "  SVE VL  : %d vs %d\n", ms->vl, as->vl);
+        if (m->sve.vl != a->sve.vl) {
+            fprintf(f, "  vl    : %d vs %d\n", m->sve.vl, a->sve.vl);
         }
 
-        if (!sve_preg_is_eq(&ms->ffr, &as->ffr)) {
-           fprintf(f, "  FFR   : ");
-           sve_dump_preg_diff(f, sve_vq_from_vl(ms->vl),
-                              &ms->pregs[i], &as->pregs[i]);
+        for (i = 0; i < SVE_NUM_ZREGS; i++) {
+            if (!sve_zreg_is_eq(vq, &m->sve.zregs[i], &a->sve.zregs[i])) {
+                fprintf(f, "  Z%-2d   : ", i);
+                sve_dump_zreg_diff(f, vq, &m->sve.zregs[i][0],
+                                   &a->sve.zregs[i][0]);
+            }
         }
         for (i = 0; i < SVE_NUM_PREGS; i++) {
-           if (!sve_preg_is_eq(&ms->pregs[i], &as->pregs[i])) {
-              fprintf(f, "  P%2d   : ", i);
-              sve_dump_preg_diff(f, sve_vq_from_vl(ms->vl),
-                                 &ms->pregs[i], &as->pregs[i]);
-           }
+            if (!sve_preg_is_eq(vq, &m->sve.pregs[i], &a->sve.pregs[i])) {
+                fprintf(f, "  P%-2d   : ", i);
+                sve_dump_preg_diff(f, vq, &m->sve.pregs[i][0],
+                                   &a->sve.pregs[i][0]);
+            }
         }
-        for (i = 0; i < SVE_NUM_ZREGS; i++) {
-           if (!sve_zreg_is_eq(m, a, i)) {
-              int q;
-              char *pad="";
-              fprintf(f, "  Z%2d   : ", i);
-              for (q = 0; q < sve_vq_from_vl(ms->vl); q++) {
-                 if (ms->zregs[i][q] != as->zregs[i][q]) {
-                    fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64
-                            " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
-                            (uint64_t) (ms->zregs[i][q] >> 64),
-                            (uint64_t) ms->zregs[i][q],
-                            (uint64_t) (as->zregs[i][q] >> 64),
-                            (uint64_t) as->zregs[i][q]);
-                    pad = "          ";
-                 }
-              }
-           }
+        if (!sve_preg_is_eq(vq, &m->sve.ffr, &a->sve.ffr)) {
+            fprintf(f, "  FFR   : ");
+            sve_dump_preg_diff(f, vq, &m->sve.pregs[i][0], &a->sve.pregs[i][0]);
         }
 
         return !ferror(f);
-- 
2.17.1
