Received: from eggs.gnu.org ([2001:4830:134:3::10]:38726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnX-0006HK-BL
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnU-0006Dt-00
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:23 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:50486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnT-0006DF-Q7
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:19 -0400
Received: by mail-wm0-x22c.google.com with SMTP id e16-v6so2421295wmd.0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:59 +0100
Message-Id: <20180622141205.16306-17-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 16/22] risu_reginfo_aarch64: unionify
 VFP regs
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

This is preparation for the SVE work as we won't want to be carrying
around both VFP and SVE registers at the same time as they overlap.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.c | 16 ++++++++--------
 risu_reginfo_aarch64.h |  9 ++++++++-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 34dd9af..62a5599 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -64,7 +64,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     ri->fpcr = fp->fpcr;
 
     for (i = 0; i < 32; i++) {
-        ri->vregs[i] = fp->vregs[i];
+        ri->simd.vregs[i] = fp->vregs[i];
     }
 }
 
@@ -92,8 +92,8 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
 
     for (i = 0; i < 32; i++) {
         fprintf(f, "  V%2d   : %016" PRIx64 "%016" PRIx64 "\n", i,
-                (uint64_t) (ri->vregs[i] >> 64),
-                (uint64_t) (ri->vregs[i] & 0xffffffffffffffff));
+                (uint64_t) (ri->simd.vregs[i] >> 64),
+                (uint64_t) (ri->simd.vregs[i] & 0xffffffffffffffff));
     }
 
     return !ferror(f);
@@ -138,14 +138,14 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
     }
 
     for (i = 0; i < 32; i++) {
-        if (m->vregs[i] != a->vregs[i]) {
+        if (m->simd.vregs[i] != a->simd.vregs[i]) {
             fprintf(f, "  V%2d   : "
                     "%016" PRIx64 "%016" PRIx64 " vs "
                     "%016" PRIx64 "%016" PRIx64 "\n", i,
-                    (uint64_t) (m->vregs[i] >> 64),
-                    (uint64_t) (m->vregs[i] & 0xffffffffffffffff),
-                    (uint64_t) (a->vregs[i] >> 64),
-                    (uint64_t) (a->vregs[i] & 0xffffffffffffffff));
+                    (uint64_t) (m->simd.vregs[i] >> 64),
+                    (uint64_t) (m->simd.vregs[i] & 0xffffffffffffffff),
+                    (uint64_t) (a->simd.vregs[i] >> 64),
+                    (uint64_t) (a->simd.vregs[i] & 0xffffffffffffffff));
         }
     }
 
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index a05fb4e..a1c708b 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -13,6 +13,10 @@
 #ifndef RISU_REGINFO_AARCH64_H
 #define RISU_REGINFO_AARCH64_H
 
+struct simd_reginfo {
+    __uint128_t vregs[32];
+};
+
 struct reginfo {
     uint64_t fault_address;
     uint64_t regs[31];
@@ -24,7 +28,10 @@ struct reginfo {
     /* FP/SIMD */
     uint32_t fpsr;
     uint32_t fpcr;
-    __uint128_t vregs[32];
+
+    union {
+        struct simd_reginfo simd;
+    };
 };
 
 #endif /* RISU_REGINFO_AARCH64_H */
-- 
2.17.1
