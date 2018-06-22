Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMww-0005uA-Hh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwu-0003WJ-2E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:06 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:40714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMwt-0003VY-On
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:03 -0400
Received: by mail-wm0-x232.google.com with SMTP id n5-v6so2799610wmc.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:12:00 +0100
Message-Id: <20180622141205.16306-18-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 17/22] risu_reginfo: introduce
 reginfo_size()
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

In preparation for conditionally supporting SVE we need to be able to
have different sized reginfos. This introduces reginfo_size() to
abstract the size away to the code the actually knows. For aarch64 we
also use this while initialising the block.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 reginfo.c              |  6 +++---
 risu.h                 |  3 +++
 risu_reginfo_aarch64.c | 11 ++++++++++-
 risu_reginfo_aarch64.h |  1 +
 risu_reginfo_arm.c     |  5 +++++
 risu_reginfo_m68k.c    |  5 +++++
 risu_reginfo_ppc64.c   |  5 +++++
 7 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/reginfo.c b/reginfo.c
index 1f55d06..dd42ae2 100644
--- a/reginfo.c
+++ b/reginfo.c
@@ -39,7 +39,7 @@ int send_register_info(write_fn write_fn, void *uc)
 
     switch (op) {
     case OP_TESTEND:
-        write_fn(&ri, sizeof(ri));
+        write_fn(&ri, reginfo_size());
         /* if we are tracing write_fn will return 0 unlike a remote
            end, hence we force return of 1 here */
         return 1;
@@ -58,7 +58,7 @@ int send_register_info(write_fn write_fn, void *uc)
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        return write_fn(&ri, sizeof(ri));
+        return write_fn(&ri, reginfo_size());
     }
     return 0;
 }
@@ -101,7 +101,7 @@ int recv_and_compare_register_info(read_fn read_fn,
         /* Do a simple register compare on (a) explicit request
          * (b) end of test (c) a non-risuop UNDEF
          */
-        if (read_fn(&apprentice_ri, sizeof(apprentice_ri))) {
+        if (read_fn(&apprentice_ri, reginfo_size())) {
             packet_mismatch = 1;
             resp = 2;
         } else if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
diff --git a/risu.h b/risu.h
index 48c50d9..8d2d646 100644
--- a/risu.h
+++ b/risu.h
@@ -133,4 +133,7 @@ int reginfo_dump(struct reginfo *ri, FILE * f);
 /* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
 
+/* return size of reginfo */
+const int reginfo_size(void);
+
 #endif /* RISU_H */
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 62a5599..5da9e39 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -15,6 +15,8 @@
 #include <string.h>
 #include <signal.h> /* for FPSIMD_MAGIC */
 #include <stdlib.h>
+#include <stddef.h>
+#include <assert.h>
 
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
@@ -27,6 +29,13 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+const int reginfo_size(void)
+{
+    const int size = offsetof(struct reginfo, simd.end);
+    assert(sizeof(struct reginfo)==size);
+    return size;
+}
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
@@ -71,7 +80,7 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
-    return memcmp(r1, r2, sizeof(*r1)) == 0;
+    return memcmp(r1, r2, reginfo_size()) == 0;
 }
 
 /* reginfo_dump: print state to a stream, returns nonzero on success */
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index a1c708b..ef97622 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -15,6 +15,7 @@
 
 struct simd_reginfo {
     __uint128_t vregs[32];
+    char end[0];
 };
 
 struct reginfo {
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 12ad0ef..3662f12 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -36,6 +36,11 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+const int reginfo_size(void)
+{
+    return sizeof(struct reginfo);
+}
+
 static void reginfo_init_vfp(struct reginfo *ri, ucontext_t *uc)
 {
     /* Read VFP registers. These live in uc->uc_regspace, which is
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index 7a1c5a9..32b28c8 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -23,6 +23,11 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+const int reginfo_size(void)
+{
+    return sizeof(struct reginfo);
+}
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 4b70460..f9d2f0d 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -31,6 +31,11 @@ void process_arch_opt(int opt, const char *arg)
     abort();
 }
 
+const int reginfo_size(void)
+{
+    return sizeof(struct reginfo);
+}
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
-- 
2.17.1
