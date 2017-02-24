Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmQ-0003u2-0Y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmO-00051t-Q6
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:42 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmO-0004Og-F8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:40 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:25 +0000
Message-Id: <1487957728-8354-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 6/9] Make reginfo_{init, is_eq, dump,
 dump_mismatch} official per-CPU API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>

All CPUs now implement reginfo_{init,is_eq,dump,dump_mismatch} with the
same API and semantics. Make this official by moving the prototypes
into risu.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 risu.h                 | 13 +++++++++++++
 risu_reginfo_aarch64.h | 12 ------------
 risu_reginfo_arm.h     | 12 ------------
 risu_reginfo_m68k.h    | 12 ------------
 risu_reginfo_ppc64le.h | 12 ------------
 5 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/risu.h b/risu.h
index 1525b3e..d95dace 100644
--- a/risu.h
+++ b/risu.h
@@ -14,6 +14,7 @@
 
 #include <inttypes.h>
 #include <stdint.h>
+#include <ucontext.h>
 
 /* Socket related routines */
 int master_connect(int port);
@@ -79,4 +80,16 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri);
  */
 int get_risuop(struct reginfo *ri);
 
+/* initialize structure from a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc);
+
+/* return 1 if structs are equal, 0 otherwise. */
+int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
+
+/* print reginfo state to a stream, returns 1 on success, 0 on failure */
+int reginfo_dump(struct reginfo *ri, FILE *f);
+
+/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
+
 #endif /* RISU_H */
diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index 166b76c..3d1b2fd 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -28,16 +28,4 @@ struct reginfo
     __uint128_t vregs[32];
 };
 
-/* initialize structure from a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc);
-
-/* return 1 if structs are equal, 0 otherwise. */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
-
-/* print reginfo state to a stream, returns 1 on success, 0 on failure */
-int reginfo_dump(struct reginfo *ri, FILE *f);
-
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
-
 #endif /* RISU_REGINFO_AARCH64_H */
diff --git a/risu_reginfo_arm.h b/risu_reginfo_arm.h
index 80c28c6..96e5791 100644
--- a/risu_reginfo_arm.h
+++ b/risu_reginfo_arm.h
@@ -23,16 +23,4 @@ struct reginfo
     uint32_t fpscr;
 };
 
-/* initialize a reginfo structure with data from uc */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc);
-
-/* returns 1 if structs are equal, zero otherwise */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
-
-/* print struct values to a stream, return 0 on stream err, 1 on success */
-int reginfo_dump(struct reginfo *ri, FILE *f);
-
-/* print a detailed mismatch report, return 0 on stream err, 1 on success */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
-
 #endif /* RISU_REGINFO_ARM_H */
diff --git a/risu_reginfo_m68k.h b/risu_reginfo_m68k.h
index 021939d..06ea61d 100644
--- a/risu_reginfo_m68k.h
+++ b/risu_reginfo_m68k.h
@@ -17,16 +17,4 @@ struct reginfo
     fpregset_t fpregs;
 };
 
-/* initialize structure from a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc);
-
-/* return 1 if structs are equal, 0 otherwise. */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
-
-/* print reginfo state to a stream, returns 1 on success, 0 on failure */
-int reginfo_dump(struct reginfo *ri, FILE *f);
-
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
-
 #endif /* RISU_REGINFO_M68K_H */
diff --git a/risu_reginfo_ppc64le.h b/risu_reginfo_ppc64le.h
index 9f74cd3..826143e 100644
--- a/risu_reginfo_ppc64le.h
+++ b/risu_reginfo_ppc64le.h
@@ -25,16 +25,4 @@ struct reginfo
     vrregset_t vrregs;
 };
 
-/* initialize structure from a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc);
-
-/* return 1 if structs are equal, 0 otherwise. */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
-
-/* print reginfo state to a stream, returns 1 on success, 0 on failure */
-int reginfo_dump(struct reginfo *ri, FILE *f);
-
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
-
 #endif /* RISU_REGINFO_PPC64LE_H */
-- 
2.7.4
