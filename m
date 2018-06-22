Received: from eggs.gnu.org ([2001:4830:134:3::10]:41761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMww-0005uE-J7
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwt-0003Vp-Af
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:06 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMwt-0003V5-38
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:03 -0400
Received: by mail-wm0-x241.google.com with SMTP id p126-v6so2445853wmb.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:12:01 +0100
Message-Id: <20180622141205.16306-19-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 18/22] risu_reginfo_aarch64: left
 justify regnums and drop masks
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

Left justification is more pleasing to the eye than the default. We
also drop the masking which isn't needed as we are casting to a
smaller size anyway.

This was split out of Richard's re-factoring work for SVE.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 5da9e39..3ccaf0e 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -90,7 +90,7 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  faulting insn %08x\n", ri->faulting_insn);
 
     for (i = 0; i < 31; i++) {
-        fprintf(f, "  X%2d   : %016" PRIx64 "\n", i, ri->regs[i]);
+        fprintf(f, "  X%-2d   : %016" PRIx64 "\n", i, ri->regs[i]);
     }
 
     fprintf(f, "  sp    : %016" PRIx64 "\n", ri->sp);
@@ -100,9 +100,9 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  fpcr  : %08x\n", ri->fpcr);
 
     for (i = 0; i < 32; i++) {
-        fprintf(f, "  V%2d   : %016" PRIx64 "%016" PRIx64 "\n", i,
+        fprintf(f, "  V%-2d   : %016" PRIx64 "%016" PRIx64 "\n", i,
                 (uint64_t) (ri->simd.vregs[i] >> 64),
-                (uint64_t) (ri->simd.vregs[i] & 0xffffffffffffffff));
+                (uint64_t) (ri->simd.vregs[i]));
     }
 
     return !ferror(f);
@@ -119,7 +119,7 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
     }
     for (i = 0; i < 31; i++) {
         if (m->regs[i] != a->regs[i]) {
-            fprintf(f, "  X%2d   : %016" PRIx64 " vs %016" PRIx64 "\n",
+            fprintf(f, "  X%-2d   : %016" PRIx64 " vs %016" PRIx64 "\n",
                     i, m->regs[i], a->regs[i]);
         }
     }
@@ -148,13 +148,13 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 
     for (i = 0; i < 32; i++) {
         if (m->simd.vregs[i] != a->simd.vregs[i]) {
-            fprintf(f, "  V%2d   : "
+            fprintf(f, "  V%-2d   : "
                     "%016" PRIx64 "%016" PRIx64 " vs "
                     "%016" PRIx64 "%016" PRIx64 "\n", i,
                     (uint64_t) (m->simd.vregs[i] >> 64),
-                    (uint64_t) (m->simd.vregs[i] & 0xffffffffffffffff),
+                    (uint64_t) m->simd.vregs[i],
                     (uint64_t) (a->simd.vregs[i] >> 64),
-                    (uint64_t) (a->simd.vregs[i] & 0xffffffffffffffff));
+                    (uint64_t) a->simd.vregs[i]);
         }
     }
 
-- 
2.17.1
