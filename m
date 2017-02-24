Received: from eggs.gnu.org ([2001:4830:134:3::10]:35231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmX-0003yZ-A9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmQ-000595-DR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmQ-0004Og-4y
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:42 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:23 +0000
Message-Id: <1487957728-8354-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 4/9] ppc64le,
 m68k: Make reginfo_dump() API match arm, aarch64
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

Make the reginfo_dump() API for ppc64le and m68k match the one used
for ARM and AArch64, which takes a FILE*, doesn't have a flag for
is_master, and returns a success indication.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 risu_m68k.c            |  6 +++---
 risu_ppc64le.c         |  6 +++---
 risu_reginfo_m68k.c    | 21 +++++++++++----------
 risu_reginfo_m68k.h    |  4 ++--
 risu_reginfo_ppc64le.c | 49 +++++++++++++++++++++++++------------------------
 risu_reginfo_ppc64le.h |  4 ++--
 6 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/risu_m68k.c b/risu_m68k.c
index 8c138dd..87776ab 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -135,7 +135,7 @@ int report_match_status(void)
         fprintf(stderr, "packet mismatch (probably disagreement "
                 "about UNDEF on load/store)\n");
         fprintf(stderr, "master reginfo:\n");
-        reginfo_dump(&master_ri, 0);
+        reginfo_dump(&master_ri, stderr);
     }
     if (!reginfo_is_eq(&master_ri, &apprentice_ri, NULL)) {
         fprintf(stderr, "mismatch on regs!\n");
@@ -151,10 +151,10 @@ int report_match_status(void)
     }
 
     fprintf(stderr, "master reginfo:\n");
-    reginfo_dump(&master_ri, 1);
+    reginfo_dump(&master_ri, stderr);
 
     fprintf(stderr, "apprentice reginfo:\n");
-    reginfo_dump(&apprentice_ri, 0);
+    reginfo_dump(&apprentice_ri, stderr);
 
     reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
     return resp;
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 43170ea..8757712 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -140,7 +140,7 @@ int report_match_status(void)
         fprintf(stderr, "packet mismatch (probably disagreement "
                 "about UNDEF on load/store)\n");
         fprintf(stderr, "master reginfo:\n");
-        reginfo_dump(&master_ri, 0);
+        reginfo_dump(&master_ri, stderr);
     }
     if (!reginfo_is_eq(&master_ri, &apprentice_ri)) {
         fprintf(stderr, "mismatch on regs!\n");
@@ -156,10 +156,10 @@ int report_match_status(void)
     }
 
     fprintf(stderr, "master reginfo:\n");
-    reginfo_dump(&master_ri, 1);
+    reginfo_dump(&master_ri, stderr);
 
     fprintf(stderr, "apprentice reginfo:\n");
-    reginfo_dump(&apprentice_ri, 0);
+    reginfo_dump(&apprentice_ri, stderr);
 
     reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
     return resp;
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index d0d47d9..3988d71 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -75,29 +75,30 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
 }
 
 /* reginfo_dump: print state to a stream, returns nonzero on success */
-void reginfo_dump(struct reginfo *ri, int is_master)
+int reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
-    if (is_master) {
-        fprintf(stderr, "  pc            \e[1;101;37m0x%08x\e[0m\n",
-                ri->pc);
-    }
-    fprintf(stderr, "\tPC: %08x\n", ri->gregs[R_PC]);
-    fprintf(stderr, "\tPS: %04x\n", ri->gregs[R_PS]);
+    fprintf(f, "  pc            \e[1;101;37m0x%08x\e[0m\n",
+            ri->pc);
+
+    fprintf(f, "\tPC: %08x\n", ri->gregs[R_PC]);
+    fprintf(f, "\tPS: %04x\n", ri->gregs[R_PS]);
 
     for (i = 0; i < 8; i++) {
-        fprintf(stderr, "\tD%d: %8x\tA%d: %8x\n", i, ri->gregs[i],
+        fprintf(f, "\tD%d: %8x\tA%d: %8x\n", i, ri->gregs[i],
                 i, ri->gregs[i + 8]);
     }
 
 
     for (i = 0; i < 8; i++) {
-        fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
+        fprintf(f, "\tFP%d: %08x %08x %08x\n", i,
                 ri->fpregs.f_fpregs[i][0], ri->fpregs.f_fpregs[i][1],
                 ri->fpregs.f_fpregs[i][2]);
     }
 
-    fprintf(stderr, "\n");
+    fprintf(f, "\n");
+
+    return !ferror(f);
 }
 
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_m68k.h b/risu_reginfo_m68k.h
index 9dd8f32..3922bf6 100644
--- a/risu_reginfo_m68k.h
+++ b/risu_reginfo_m68k.h
@@ -23,8 +23,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 /* return 1 if structs are equal, 0 otherwise. */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2, ucontext_t *uc);
 
-/* print reginfo state to a stream */
-void reginfo_dump(struct reginfo *ri, int is_master);
+/* print reginfo state to a stream, returns 1 on success, 0 on failure */
+int reginfo_dump(struct reginfo *ri, FILE *f);
 
 /* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
index 585d8b7..9e673e1 100644
--- a/risu_reginfo_ppc64le.c
+++ b/risu_reginfo_ppc64le.c
@@ -93,46 +93,47 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 }
 
 /* reginfo_dump: print state to a stream, returns nonzero on success */
-void reginfo_dump(struct reginfo *ri, int is_master)
+int reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
-    if (is_master) {
-        fprintf(stderr, "  faulting insn 0x%x\n", ri->faulting_insn);
-        fprintf(stderr, "  prev insn     0x%x\n", ri->prev_insn);
-        fprintf(stderr, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
-    }
+
+    fprintf(f, "  faulting insn 0x%x\n", ri->faulting_insn);
+    fprintf(f, "  prev insn     0x%x\n", ri->prev_insn);
+    fprintf(f, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
 
     for (i = 0; i < 16; i++) {
-        fprintf(stderr, "\tr%2d: %16lx\tr%2d: %16lx\n", i, ri->gregs[i],
+        fprintf(f, "\tr%2d: %16lx\tr%2d: %16lx\n", i, ri->gregs[i],
                 i + 16, ri->gregs[i + 16]);
     }
 
-    fprintf(stderr, "\n");
-    fprintf(stderr, "\tnip    : %16lx\n", ri->gregs[32]);
-    fprintf(stderr, "\tmsr    : %16lx\n", ri->gregs[33]);
-    fprintf(stderr, "\torig r3: %16lx\n", ri->gregs[34]);
-    fprintf(stderr, "\tctr    : %16lx\n", ri->gregs[35]);
-    fprintf(stderr, "\tlnk    : %16lx\n", ri->gregs[36]);
-    fprintf(stderr, "\txer    : %16lx\n", ri->gregs[37]);
-    fprintf(stderr, "\tccr    : %16lx\n", ri->gregs[38]);
-    fprintf(stderr, "\tmq     : %16lx\n", ri->gregs[39]);
-    fprintf(stderr, "\ttrap   : %16lx\n", ri->gregs[40]);
-    fprintf(stderr, "\tdar    : %16lx\n", ri->gregs[41]);
-    fprintf(stderr, "\tdsisr  : %16lx\n", ri->gregs[42]);
-    fprintf(stderr, "\tresult : %16lx\n", ri->gregs[43]);
-    fprintf(stderr, "\tdscr   : %16lx\n\n", ri->gregs[44]);
+    fprintf(f, "\n");
+    fprintf(f, "\tnip    : %16lx\n", ri->gregs[32]);
+    fprintf(f, "\tmsr    : %16lx\n", ri->gregs[33]);
+    fprintf(f, "\torig r3: %16lx\n", ri->gregs[34]);
+    fprintf(f, "\tctr    : %16lx\n", ri->gregs[35]);
+    fprintf(f, "\tlnk    : %16lx\n", ri->gregs[36]);
+    fprintf(f, "\txer    : %16lx\n", ri->gregs[37]);
+    fprintf(f, "\tccr    : %16lx\n", ri->gregs[38]);
+    fprintf(f, "\tmq     : %16lx\n", ri->gregs[39]);
+    fprintf(f, "\ttrap   : %16lx\n", ri->gregs[40]);
+    fprintf(f, "\tdar    : %16lx\n", ri->gregs[41]);
+    fprintf(f, "\tdsisr  : %16lx\n", ri->gregs[42]);
+    fprintf(f, "\tresult : %16lx\n", ri->gregs[43]);
+    fprintf(f, "\tdscr   : %16lx\n\n", ri->gregs[44]);
 
     for (i = 0; i < 16; i++) {
-        fprintf(stderr, "\tf%2d: %.4f\tr%2d: %.4f\n", i, ri->fpregs[i],
+        fprintf(f, "\tf%2d: %.4f\tr%2d: %.4f\n", i, ri->fpregs[i],
                 i + 16, ri->fpregs[i + 16]);
     }
-    fprintf(stderr, "\tfpscr: %f\n\n", ri->fpregs[32]);
+    fprintf(f, "\tfpscr: %f\n\n", ri->fpregs[32]);
 
     for (i = 0; i < 32; i++) {
-        fprintf(stderr, "vr%02d: %8x, %8x, %8x, %8x\n", i,
+        fprintf(f, "vr%02d: %8x, %8x, %8x, %8x\n", i,
                 ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
                 ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
     }
+
+    return !ferror(f);
 }
 
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
diff --git a/risu_reginfo_ppc64le.h b/risu_reginfo_ppc64le.h
index 49bb1aa..9f74cd3 100644
--- a/risu_reginfo_ppc64le.h
+++ b/risu_reginfo_ppc64le.h
@@ -31,8 +31,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc);
 /* return 1 if structs are equal, 0 otherwise. */
 int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
-/* print reginfo state to a stream */
-void reginfo_dump(struct reginfo *ri, int is_master);
+/* print reginfo state to a stream, returns 1 on success, 0 on failure */
+int reginfo_dump(struct reginfo *ri, FILE *f);
 
 /* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
-- 
2.7.4
