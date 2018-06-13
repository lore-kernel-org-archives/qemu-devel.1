Received: from eggs.gnu.org ([2001:4830:134:3::10]:52426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SE-0001VF-HX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SD-0005NT-7a
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:50 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:54356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5SC-0005IW-M7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:48 -0400
Received: by mail-wm0-x235.google.com with SMTP id o13-v6so4577416wmf.4
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:04:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:55 +0100
Message-Id: <20180613125601.14371-17-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 16/22] risu_reginfo_aarch64: unionify
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
