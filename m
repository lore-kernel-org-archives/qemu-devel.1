Received: from eggs.gnu.org ([2001:4830:134:3::10]:34846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SM-0005rc-2N
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SI-00008g-MB
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:26 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SI-00007d-GY
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:22 -0500
Received: by mail-wm0-x242.google.com with SMTP id s66so4334632wmf.5
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:58 +0000
Message-Id: <20171107150558.22131-11-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 10/10] risu_reginfo_aarch64: add SVE
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
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu_reginfo_aarch64.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 7c97790..8aba192 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -141,6 +141,18 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
     return memcmp(r1, r2, sizeof(*r1)) == 0;
 }
 
+#ifdef SVE_MAGIC
+static int sve_zreg_is_eq(struct reginfo *r1, struct reginfo *r2, int z)
+{
+    return memcmp(r1->zregs[z], r2->zregs[z], sizeof(*r1->zregs[z])) == 0;
+}
+
+static int sve_preg_is_eq(struct reginfo *r1, struct reginfo *r2, int p)
+{
+    return memcmp(r1->pregs[p], r2->pregs[p], sizeof(*r1->pregs[p])) == 0;
+}
+#endif
+
 /* reginfo_dump: print state to a stream, returns nonzero on success */
 int reginfo_dump(struct reginfo *ri, FILE * f)
 {
@@ -216,5 +228,42 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
         }
     }
 
+#ifdef SVE_MAGIC
+    if (test_sve) {
+        if (m->vl != a->vl) {
+            fprintf(f, "  SVE VL  : %d vs %d\n", m->vl, a->vl);
+        }
+        for (i = 0; i < SVE_NUM_PREGS; i++) {
+           if (!sve_preg_is_eq(m, a, i)) {
+              int q;
+              fprintf(f, "  P%2d   : ", i);
+              for (q = 0; q < sve_vq_from_vl(m->vl); q++) {
+                 fprintf(f, "%04x", m->pregs[i][q]);
+              }
+              fprintf(f, " vs ");
+              for (q = 0; q < sve_vq_from_vl(m->vl); q++) {
+                 fprintf(f, "%04x", a->pregs[i][q]);
+              }
+              fprintf(f, "\n");
+            }
+        }
+        for (i = 0; i < SVE_NUM_ZREGS; i++) {
+           if (!sve_zreg_is_eq(m, a, i)) {
+              int q;
+              char *pad="";
+              fprintf(f, "  Z%2d   : ", i);
+              for (q = 0; q < sve_vq_from_vl(m->vl); q++) {
+                 if (m->zregs[i][q] != a->zregs[i][q]) {
+                    fprintf(f, "%sq%02d: %016" PRIx64 "%016" PRIx64 " vs %016" PRIx64 "%016" PRIx64"\n", pad, q,
+                            (uint64_t) (m->zregs[i][q] >> 64), (uint64_t) m->zregs[i][q],
+                            (uint64_t) (a->zregs[i][q] >> 64), (uint64_t) a->zregs[i][q]);
+                    pad = "          ";
+                 }
+              }
+           }
+        }
+    }
+#endif
+
     return !ferror(f);
 }
-- 
2.14.2
