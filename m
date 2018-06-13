Received: from eggs.gnu.org ([2001:4830:134:3::10]:52546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SJ-0001Zy-SQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SD-0005Ox-S0
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:55 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:39123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5SD-0005M3-Ji
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:49 -0400
Received: by mail-wr0-x231.google.com with SMTP id w7-v6so2683375wrn.6
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:04:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:59 +0100
Message-Id: <20180613125601.14371-21-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 20/22] risu_reginfo_aarch64: add SVE
 support to reginfo_dump_mismatch
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - include ffr in comparison
  - mild re-factor of preg cmp/diff
v3
  - re-factoring
---
 risu_reginfo_aarch64.c | 74 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 79db5dd..a352b4c 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include <stdbool.h>
+#include <inttypes.h>
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
@@ -164,6 +165,35 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
     return memcmp(r1, r2, reginfo_size()) == 0;
 }
 
+#ifdef SVE_MAGIC
+static int sve_zreg_is_eq(struct reginfo *r1, struct reginfo *r2, int z)
+{
+    return memcmp(r1->sve.zregs[z], r2->sve.zregs[z], sizeof(*r1->sve.zregs[z])) == 0;
+}
+
+static int sve_preg_is_eq(uint16_t const (*p1)[SVE_VQ_MAX],
+                          uint16_t const (*p2)[SVE_VQ_MAX])
+{
+    return memcmp(p1, p2, sizeof *p1) == 0;
+}
+
+static void sve_dump_preg_diff(FILE *f, int vq,
+                               uint16_t const (*p1)[SVE_VQ_MAX],
+                               uint16_t const (*p2)[SVE_VQ_MAX])
+{
+    int q;
+
+    for (q = 0; q < vq; q++) {
+       fprintf(f, "%#04x", *p1[q]);
+    }
+    fprintf(f, " vs ");
+    for (q = 0; q < vq; q++) {
+       fprintf(f, "%#04x", *p2[q]);
+    }
+    fprintf(f, "\n");
+}
+#endif
+
 /* reginfo_dump: print state to a stream, returns nonzero on success */
 int reginfo_dump(struct reginfo *ri, FILE * f)
 {
@@ -227,6 +257,50 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
         fprintf(f, "  fpcr  : %08x vs %08x\n", m->fpcr, a->fpcr);
     }
 
+#ifdef SVE_MAGIC
+    if (test_sve) {
+        struct sve_reginfo *ms = &m->sve;
+        struct sve_reginfo *as = &a->sve;
+
+        if (ms->vl != as->vl) {
+            fprintf(f, "  SVE VL  : %d vs %d\n", ms->vl, as->vl);
+        }
+
+        if (!sve_preg_is_eq(&ms->ffr, &as->ffr)) {
+           fprintf(f, "  FFR   : ");
+           sve_dump_preg_diff(f, sve_vq_from_vl(ms->vl),
+                              &ms->pregs[i], &as->pregs[i]);
+        }
+        for (i = 0; i < SVE_NUM_PREGS; i++) {
+           if (!sve_preg_is_eq(&ms->pregs[i], &as->pregs[i])) {
+              fprintf(f, "  P%2d   : ", i);
+              sve_dump_preg_diff(f, sve_vq_from_vl(ms->vl),
+                                 &ms->pregs[i], &as->pregs[i]);
+           }
+        }
+        for (i = 0; i < SVE_NUM_ZREGS; i++) {
+           if (!sve_zreg_is_eq(m, a, i)) {
+              int q;
+              char *pad="";
+              fprintf(f, "  Z%2d   : ", i);
+              for (q = 0; q < sve_vq_from_vl(ms->vl); q++) {
+                 if (ms->zregs[i][q] != as->zregs[i][q]) {
+                    fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64
+                            " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
+                            (uint64_t) (ms->zregs[i][q] >> 64),
+                            (uint64_t) ms->zregs[i][q],
+                            (uint64_t) (as->zregs[i][q] >> 64),
+                            (uint64_t) as->zregs[i][q]);
+                    pad = "          ";
+                 }
+              }
+           }
+        }
+
+        return !ferror(f);
+    }
+#endif
+
     for (i = 0; i < 32; i++) {
         if (m->simd.vregs[i] != a->simd.vregs[i]) {
             fprintf(f, "  V%-2d   : "
-- 
2.17.1
