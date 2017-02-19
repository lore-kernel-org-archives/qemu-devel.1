Received: from eggs.gnu.org ([2001:4830:134:3::10]:58578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfXgy-0001C3-Gi
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 15:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cfXgv-0005xH-FG
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 15:02:44 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cfXgv-0005wO-54
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 15:02:41 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sun, 19 Feb 2017 21:02:31 +0100
Message-Id: <20170219200231.30672-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] risu-m68k: update fpregs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

f_fpregs is a 2d array, not 1d:

 typedef struct fpregset
 {
   int f_pcr;
   int f_psr;
   int f_fpiaddr;
 #ifdef __mcoldfire__
   int f_fpregs[8][2];
 #else
   int f_fpregs[8][3];
 #endif
 } fpregset_t;

For the moment, we don't manage ColdFire case, only 680x0.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 risu_reginfo_m68k.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index c9d21cc..d0d47d9 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -31,9 +31,9 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
     ri->fpregs.f_psr = uc->uc_mcontext.fpregs.f_psr;
     ri->fpregs.f_fpiaddr = uc->uc_mcontext.fpregs.f_fpiaddr;
     for (i = 0; i < 8; i++) {
-        memcpy(&ri->fpregs.f_fpregs[i * 3],
-               &uc->uc_mcontext.fpregs.f_fpregs[i * 3],
-               3 * sizeof(int));
+        memcpy(ri->fpregs.f_fpregs[i],
+               uc->uc_mcontext.fpregs.f_fpregs[i],
+               sizeof(ri->fpregs.f_fpregs[0]));
     }
 }
 
@@ -64,9 +64,9 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
     }
 
     for (i = 0; i < 8; i++) {
-        if (m->fpregs.f_fpregs[i * 3] != a->fpregs.f_fpregs[i * 3] ||
-            m->fpregs.f_fpregs[i * 3 + 1] != a->fpregs.f_fpregs[i * 3 + 1] ||
-            m->fpregs.f_fpregs[i * 3 + 2] != a->fpregs.f_fpregs[i * 3 + 2]) {
+        if (m->fpregs.f_fpregs[i][0] != a->fpregs.f_fpregs[i][0] ||
+            m->fpregs.f_fpregs[i][1] != a->fpregs.f_fpregs[i][1] ||
+            m->fpregs.f_fpregs[i][2] != a->fpregs.f_fpregs[i][2]) {
             return 0;
         }
     }
@@ -93,8 +93,8 @@ void reginfo_dump(struct reginfo *ri, int is_master)
 
     for (i = 0; i < 8; i++) {
         fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
-                ri->fpregs.f_fpregs[i * 3], ri->fpregs.f_fpregs[i * 3 + 1],
-                ri->fpregs.f_fpregs[i * 3 + 2]);
+                ri->fpregs.f_fpregs[i][0], ri->fpregs.f_fpregs[i][1],
+                ri->fpregs.f_fpregs[i][2]);
     }
 
     fprintf(stderr, "\n");
@@ -134,15 +134,14 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
     }
 
     for (i = 0; i < 8; i++) {
-        if (m->fpregs.f_fpregs[i * 3] != a->fpregs.f_fpregs[i * 3] ||
-            m->fpregs.f_fpregs[i * 3 + 1] != a->fpregs.f_fpregs[i * 3 + 1] ||
-            m->fpregs.f_fpregs[i * 3 + 2] != a->fpregs.f_fpregs[i * 3 + 2]) {
+        if (m->fpregs.f_fpregs[i][0] != a->fpregs.f_fpregs[i][0] ||
+            m->fpregs.f_fpregs[i][1] != a->fpregs.f_fpregs[i][1] ||
+            m->fpregs.f_fpregs[i][2] != a->fpregs.f_fpregs[i][2]) {
             fprintf(f, "Mismatch: Register FP%d\n", i);
             fprintf(f, "m: [%08x %08x %08x] != a: [%08x %08x %08x]\n",
-                    m->fpregs.f_fpregs[i * 3], m->fpregs.f_fpregs[i * 3 + 1],
-                    m->fpregs.f_fpregs[i * 3 + 2], a->fpregs.f_fpregs[i * 3],
-                    a->fpregs.f_fpregs[i * 3 + 1],
-                    a->fpregs.f_fpregs[i * 3 + 2]);
+                    m->fpregs.f_fpregs[i][0], m->fpregs.f_fpregs[i][1],
+                    m->fpregs.f_fpregs[i][2], a->fpregs.f_fpregs[i][0],
+                    a->fpregs.f_fpregs[i][1], a->fpregs.f_fpregs[i][2]);
         }
     }
 
-- 
2.9.3
