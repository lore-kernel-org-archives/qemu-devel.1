Received: from eggs.gnu.org ([209.51.188.92]:46635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8p-0001PP-OK
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8o-00007P-2a
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDi8n-00006E-9P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id h5so4281706pfo.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 21:13:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Apr 2019 18:13:36 -1000
Message-Id: <20190409041337.23602-2-richard.henderson@linaro.org>
In-Reply-To: <20190409041337.23602-1-richard.henderson@linaro.org>
References: <20190409041337.23602-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] i386: Add avx512 state to reginfo_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jan.bobek@gmail.com

The state beyond what is present on the running cpu will be zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_i386.h |  15 ++++
 risu_reginfo_i386.c | 194 ++++++++++++++++++++++++++++++++++++++++++--
 test_i386.S         |  39 +++++++++
 3 files changed, 243 insertions(+), 5 deletions(-)

diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
index 755283a..1d13e41 100644
--- a/risu_reginfo_i386.h
+++ b/risu_reginfo_i386.h
@@ -12,14 +12,29 @@
 #ifndef RISU_REGINFO_I386_H
 #define RISU_REGINFO_I386_H
 
+struct avx512_reg {
+    uint64_t q[8];
+};
+
 /*
  * This is the data structure we pass over the socket.
  * It is a simplified and reduced subset of what can
  * be obtained with a ucontext_t*
  */
 struct reginfo {
+    uint16_t nvecregs;
+    uint16_t nvecquads;
     uint32_t faulting_insn;
+    uint32_t mxcsr;
+
     gregset_t gregs;
+
+#ifdef __x86_64__
+    struct avx512_reg vregs[32];
+#else
+    struct avx512_reg vregs[8];
+#endif
+    uint64_t kregs[8];
 };
 
 /*
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index c4dc14a..e1974ec 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -11,13 +11,17 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stddef.h>
 #include <string.h>
 #include <ucontext.h>
 #include <assert.h>
+#include <cpuid.h>
 
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
+#include <asm/sigcontext.h>
+
 const struct option * const arch_long_opts;
 const char * const arch_extra_help;
 
@@ -31,10 +35,30 @@ const int reginfo_size(void)
     return sizeof(struct reginfo);
 }
 
+static void *xsave_feature_buf(struct _xstate *xs, int feature)
+{
+    unsigned int eax, ebx, ecx, edx;
+    int ok;
+
+    /*
+     * Get the location of the XSAVE feature from the cpuid leaf.
+     * Given that we know the xfeature bit is set, this must succeed.
+     */
+    ok = __get_cpuid_count(0xd, feature, &eax, &ebx, &ecx, &edx);
+    assert(ok);
+
+    /* Sanity check that the frame stored by the kernel contains the data. */
+    assert(xs->fpstate.sw_reserved.extended_size >= eax + ebx);
+
+    return (void *)xs + ebx;
+}
+
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
-    int i;
+    int i, nvecregs, nvecquads;
+    struct _fpstate *fp;
+    struct _xstate *xs;
 
     memset(ri, 0, sizeof(*ri));
 
@@ -79,12 +103,100 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc)
      * distinguish 'do compare' from 'stop'.
      */
     ri->faulting_insn = *(uint32_t *)uc->uc_mcontext.gregs[REG_E(IP)];
+
+    /*
+     * FP state is omitted if unused (aka in init state).
+     * Use the <asm/sigcontext.h> struct for access to AVX state.
+     */
+    fp = (struct _fpstate *)uc->uc_mcontext.fpregs;
+    if (fp == NULL) {
+        return;
+    }
+
+#ifdef __x86_64__
+    nvecregs = 16;
+#else
+    /* We don't (currently) care about the 80387 state, only SSE+.  */
+    if (fp->magic != X86_FXSR_MAGIC) {
+        return;
+    }
+    nvecregs = 8;
+#endif
+    nvecquads = 2;
+
+    /*
+     * Now we know that _fpstate contains FXSAVE data.
+     */
+    ri->mxcsr = fp->mxcsr;
+
+    for (i = 0; i < nvecregs; ++i) {
+#ifdef __x86_64__
+        memcpy(&ri->vregs[i], &fp->xmm_space[i], 16);
+#else
+        memcpy(&ri->vregs[i], &fp->_xmm[i * 4], 16);
+#endif
+    }
+
+    if (fp->sw_reserved.magic1 != FP_XSTATE_MAGIC1) {
+        return;
+    }
+    xs = (struct _xstate *)fp;
+
+    /*
+     * Now we know that _fpstate contains XSAVE data.
+     */
+
+    if (xs->xstate_hdr.xfeatures & (1 << 2)) {
+        /* YMM_Hi128 state */
+        void *buf = xsave_feature_buf(xs, 2);
+        for (i = 0; i < nvecregs; ++i) {
+            memcpy(&ri->vregs[i].q[2], buf + 16 * i, 16);
+        }
+        nvecquads = 4;
+    }
+
+    if (xs->xstate_hdr.xfeatures & (1 << 5)) {
+        /* Opmask state */
+        uint64_t *buf = xsave_feature_buf(xs, 5);
+        for (i = 0; i < 8; ++i) {
+            ri->kregs[i] = buf[i];
+        }
+    }
+
+    if (xs->xstate_hdr.xfeatures & (1 << 6)) {
+        /* ZMM_Hi256 state */
+        void *buf = xsave_feature_buf(xs, 6);
+        for (i = 0; i < nvecregs; ++i) {
+            memcpy(&ri->vregs[i].q[4], buf + 32 * i, 32);
+        }
+        nvecquads = 8;
+    }
+
+#ifdef __x86_64__
+    if (xs->xstate_hdr.xfeatures & (1 << 7)) {
+        /* Hi16_ZMM state */
+        void *buf = xsave_feature_buf(xs, 7);
+        for (i = 0; i < 16; ++i) {
+            memcpy(&ri->vregs[i + 16], buf + 64 * i, 64);
+        }
+        nvecregs = 32;
+    }
+#endif
+
+    ri->nvecregs = nvecregs;
+    ri->nvecquads = nvecquads;
 }
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
 int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
-    return 0 == memcmp(m, a, sizeof(*m));
+    /*
+     * Do not compare nvecregs & nvecquads.  This allows master 
+     * and apprentice to have different vector widths, so long
+     * as we're only interested in the low N bits of the register.
+     */
+    return !memcmp(&m->faulting_insn, &a->faulting_insn,
+                   sizeof(*m) - offsetof(struct reginfo, faulting_insn));
 }
 
 static const char *const regname[NGREG] = {
@@ -129,25 +241,97 @@ static const char *const regname[NGREG] = {
 /* reginfo_dump: print state to a stream, returns nonzero on success */
 int reginfo_dump(struct reginfo *ri, FILE *f)
 {
-    int i;
+    int i, j, n, w;
+    char r;
+
     fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
     for (i = 0; i < NGREG; i++) {
         if (regname[i]) {
             fprintf(f, "  %-6s: " PRIxREG "\n", regname[i], ri->gregs[i]);
         }
     }
+
+    fprintf(f, "  mxcsr : %x\n", ri->mxcsr);
+
+    n = ri->nvecregs;
+    w = ri->nvecquads;
+    r = (w <= 2 ? 'x' : w <= 4 ? 'y' : 'z');
+
+    for (i = 0; i < n; i++) {
+        fprintf(f, "  %cmm%-3d: ", r, i);
+        for (j = w - 1; j >= 0; j--) {
+            fprintf(f, "%016" PRIx64 "%c",
+                    ri->vregs[i].q[j], j == 0 ? '\n' : ' ');
+        }
+    }
+
+    if (n >= 32 || w >= 8) {
+        for (i = 0; i < 8; i++) {
+            fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
+        }
+    }
+
     return !ferror(f);
 }
 
+static void reginfo_dump_mismatch_vreg(struct reginfo *m, struct reginfo *a,
+                                       FILE *f, int i, int w)
+{
+    char r = (w <= 2 ? 'x' : w <= 4 ? 'y' : 'z');
+    int j;
+
+    fprintf(f, "  %cmm%-3d: ", r, i);
+    for (j = w - 1; j >= 0; j--) {
+        fprintf(f, "%016" PRIx64 "%c",
+                m->vregs[i].q[j], j == 0 ? '\n' : ' ');
+    }
+    fprintf(f, "      vs: ");
+    for (j = w - 1; j >= 0; j--) {
+        fprintf(f, "%016" PRIx64 "%c",
+                a->vregs[i].q[j], j == 0 ? '\n' : ' ');
+    }
+}
+
 int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
-    int i;
+    int i, n, wmin, wmax;
+
+    fprintf(f, "Mismatch (master v apprentice):\n");
+
     for (i = 0; i < NGREG; i++) {
         if (m->gregs[i] != a->gregs[i]) {
             assert(regname[i]);
-            fprintf(f, "Mismatch: %s: " PRIxREG " v " PRIxREG "\n",
+            fprintf(f, "  %-6s: " PRIxREG " v " PRIxREG "\n",
                     regname[i], m->gregs[i], a->gregs[i]);
         }
     }
+
+    if (m->mxcsr != a->mxcsr) {
+        fprintf(f, "  mxcsr : %x v %x\n", m->mxcsr, a->mxcsr);
+    }
+
+    n = sizeof(m->vregs) / sizeof(m->vregs[0]);
+    wmax = sizeof(m->vregs[0]) / sizeof(m->vregs[0].q[0]);
+    wmin = m->nvecquads;
+
+    for (i = 0; i < n; i++) {
+        if (memcmp(&m->vregs[i], &a->vregs[i], wmax * 8)) {
+            if (memcmp(&m->vregs[i], &a->vregs[i], wmin * 8)) {
+                /* This is expected behaviour.  */
+                reginfo_dump_mismatch_vreg(m, a, f, i, wmin);
+            } else {
+                /* This probably means different vector widths.  */
+                reginfo_dump_mismatch_vreg(m, a, f, i, wmax);
+            }
+        }
+    }
+
+    for (i = 0; i < 8; i++) {
+        if (m->kregs[i] != a->kregs[i]) {
+            fprintf(f, "  k%-5d: %016" PRIx64 " v %016" PRIx64 "\n",
+                    i, m->kregs[i], a->kregs[i]);
+        }
+    }
+
     return !ferror(f);
 }
diff --git a/test_i386.S b/test_i386.S
index 456b99c..05344d7 100644
--- a/test_i386.S
+++ b/test_i386.S
@@ -12,6 +12,37 @@
 /* A trivial test image for x86 */
 
 /* Initialise the registers to avoid spurious mismatches */
+
+#ifdef __x86_64__
+#define BASE	%rax
+	lea	2f(%rip), BASE
+#else
+#define BASE	%eax
+	call	1f
+1:	pop	BASE
+	add	$2f-1b, BASE
+#endif
+
+	movdqa	0(BASE), %xmm0
+	movdqa	1*16(BASE), %xmm1
+	movdqa	2*16(BASE), %xmm2
+	movdqa	3*16(BASE), %xmm3
+	movdqa	4*16(BASE), %xmm4
+	movdqa	5*16(BASE), %xmm5
+	movdqa	6*16(BASE), %xmm6
+	movdqa	7*16(BASE), %xmm7
+
+#ifdef __x86_64__
+	movdqa	8*16(BASE), %xmm8
+	movdqa	9*16(BASE), %xmm9
+	movdqa	10*16(BASE), %xmm10
+	movdqa	11*16(BASE), %xmm11
+	movdqa	12*16(BASE), %xmm12
+	movdqa	13*16(BASE), %xmm13
+	movdqa	14*16(BASE), %xmm14
+	movdqa	15*16(BASE), %xmm15
+#endif
+
 	xor	%eax, %eax
 	sahf				/* init eflags */
 
@@ -39,3 +70,11 @@
 
 /* exit test */
 	ud1	%ecx, %eax
+
+	.p2align 16
+2:
+	.set	i, 0
+	.rept	256
+	.byte	i
+	.set	i, i + 1
+	.endr
-- 
2.17.1
