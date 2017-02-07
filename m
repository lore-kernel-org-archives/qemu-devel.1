Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAaf-0004ty-0G
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cbAaY-0001UB-1v
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:08 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cbAaX-0001Sx-KF
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:34:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  7 Feb 2017 19:33:53 +0100
Message-Id: <20170207183356.17840-3-laurent@vivier.eu>
In-Reply-To: <20170207183356.17840-1-laurent@vivier.eu>
References: <20170207183356.17840-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/5] m68k: implement server and client side
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

This also adds the basic test file and the configuration update.

This implementation can only test instructions with values in register and
no memory access.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure           |   6 ++-
 risu_m68k.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_m68k.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_m68k.h |  32 +++++++++++
 test_m68k.s         |  28 ++++++++++
 5 files changed, 368 insertions(+), 2 deletions(-)
 create mode 100644 risu_m68k.c
 create mode 100644 risu_reginfo_m68k.c
 create mode 100644 risu_reginfo_m68k.h
 create mode 100644 test_m68k.s

diff --git a/configure b/configure
index f81bdb5..f5921ee 100755
--- a/configure
+++ b/configure
@@ -18,7 +18,9 @@ EOF
 }
 
 guess_arch() {
-    if check_define __arm__ ; then
+    if check_define __m68k__ ; then
+        ARCH="m68k"
+    elif check_define __arm__ ; then
         ARCH="arm"
     elif check_define __aarch64__ ; then
         ARCH="aarch64"
@@ -63,7 +65,7 @@ Some influential environment variables:
                prefixed with the given string.
 
   ARCH         force target architecture instead of trying to detect it.
-               Valid values=[arm|aarch64|ppc64|ppc64le]
+               Valid values=[arm|aarch64|ppc64|ppc64le|m68k]
 
   CC           C compiler command
   CFLAGS       C compiler flags
diff --git a/risu_m68k.c b/risu_m68k.c
new file mode 100644
index 0000000..15e30b1
--- /dev/null
+++ b/risu_m68k.c
@@ -0,0 +1,153 @@
+/*******************************************************************************
+ * Copyright (c) 2016 Laurent Vivier
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ ******************************************************************************/
+
+#include <stdio.h>
+#include <ucontext.h>
+#include <string.h>
+
+#include "risu.h"
+#include "risu_reginfo_m68k.h"
+
+struct reginfo master_ri, apprentice_ri;
+static int mem_used = 0;
+static int packet_mismatch = 0;
+
+uint8_t apprentice_memblock[MEMBLOCKLEN];
+
+void advance_pc(void *vuc)
+{
+    ucontext_t *uc = (ucontext_t*)vuc;
+    uc->uc_mcontext.gregs[R_PC] += 4;
+}
+
+void set_a0(void *vuc, uint32_t a0)
+{
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.gregs[R_A0] = a0;
+}
+
+static int get_risuop(uint32_t insn)
+{
+    uint32_t op = insn & 0xf;
+    uint32_t key = insn & ~0xf;
+    uint32_t risukey = 0x4afc7000;
+    return (key != risukey) ? -1 : op;
+}
+
+int send_register_info(int sock, void *uc)
+{
+    struct reginfo ri;
+    int op;
+
+    reginfo_init(&ri, uc);
+    op = get_risuop(ri.faulting_insn);
+
+    switch (op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    default:
+        return send_data_pkt(sock, &ri, sizeof(ri));
+    case OP_SETMEMBLOCK:
+        memblock = (void*)ri.gregs[R_A0];
+        break;
+    case OP_GETMEMBLOCK:
+        set_a0(uc, ri.gregs[R_A0] + (uintptr_t)memblock);
+        break;
+    case OP_COMPAREMEM:
+        return send_data_pkt(sock, memblock, MEMBLOCKLEN);
+        break;
+    }
+    return 0;
+}
+
+/* Read register info from the socket and compare it with that from the
+ * ucontext. Return 0 for match, 1 for end-of-test, 2 for mismatch.
+ * NB: called from a signal handler.
+ */
+int recv_and_compare_register_info(int sock, void *uc)
+{
+    int resp = 0;
+    int op;
+
+    reginfo_init(&master_ri, uc);
+    op = get_risuop(master_ri.faulting_insn);
+
+    switch (op) {
+    case OP_COMPARE:
+    case OP_TESTEND:
+    default:
+        if (recv_data_pkt(sock, &apprentice_ri, sizeof(apprentice_ri))) {
+            packet_mismatch = 1;
+            resp = 2;
+        } else if (!reginfo_is_eq(&master_ri, &apprentice_ri, uc)) {
+            resp = 2;
+        }
+        else if (op == OP_TESTEND) {
+            resp = 1;
+        }
+        send_response_byte(sock, resp);
+        break;
+    case OP_SETMEMBLOCK:
+        memblock = (void*)master_ri.gregs[R_A0];
+        break;
+    case OP_GETMEMBLOCK:
+        set_a0(uc, master_ri.gregs[R_A0] + (uintptr_t)memblock);
+        break;
+    case OP_COMPAREMEM:
+        mem_used = 1;
+        if (recv_data_pkt(sock, apprentice_memblock, MEMBLOCKLEN)) {
+            packet_mismatch = 1;
+            resp = 2;
+        } else if (memcmp(memblock, apprentice_memblock, MEMBLOCKLEN) != 0) {
+            resp = 2;
+        }
+        send_response_byte(sock, resp);
+        break;
+    }
+    return resp;
+}
+
+/* Print a useful report on the status of the last comparison
+ * done in recv_and_compare_register_info(). This is called on
+ * exit, so need not restrict itself to signal-safe functions.
+ * Should return 0 if it was a good match (ie end of test)
+ * and 1 for a mismatch.
+ */
+int report_match_status(void)
+{
+    int resp = 0;
+    fprintf(stderr, "match status...\n");
+
+    if (packet_mismatch) {
+        fprintf(stderr, "packet mismatch (probably disagreement "
+                "about UNDEF on load/store)\n");
+        fprintf(stderr, "master reginfo:\n");
+        reginfo_dump(&master_ri, 0);
+    }
+    if (!reginfo_is_eq(&master_ri, &apprentice_ri, NULL)) {
+        fprintf(stderr, "mismatch on regs!\n");
+        resp = 1;
+    }
+    if (mem_used && memcmp(memblock, &apprentice_memblock, MEMBLOCKLEN) != 0) {
+        fprintf(stderr, "mismatch on memory!\n");
+        resp = 1;
+    }
+    if (!resp) {
+        fprintf(stderr, "match!\n");
+        return 0;
+    }
+
+    fprintf(stderr, "master reginfo:\n");
+    reginfo_dump(&master_ri, 1);
+
+    fprintf(stderr, "apprentice reginfo:\n");
+    reginfo_dump(&apprentice_ri, 0);
+
+    reginfo_dump_mismatch(&master_ri, &apprentice_ri, stderr);
+    return resp;
+}
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
new file mode 100644
index 0000000..c9d21cc
--- /dev/null
+++ b/risu_reginfo_m68k.c
@@ -0,0 +1,151 @@
+/*****************************************************************************
+ * Copyright (c) 2016 Laurent Vivier
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+#include <stdio.h>
+#include <ucontext.h>
+#include <string.h>
+#include <math.h>
+
+#include "risu.h"
+#include "risu_reginfo_m68k.h"
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+{
+    int i;
+    memset(ri, 0, sizeof(*ri));
+
+    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.gregs[R_PC]);
+    ri->pc = uc->uc_mcontext.gregs[R_PC] - image_start_address;
+
+    for (i = 0; i < NGREG; i++) {
+        ri->gregs[i] = uc->uc_mcontext.gregs[i];
+    }
+
+    ri->fpregs.f_pcr = uc->uc_mcontext.fpregs.f_pcr;
+    ri->fpregs.f_psr = uc->uc_mcontext.fpregs.f_psr;
+    ri->fpregs.f_fpiaddr = uc->uc_mcontext.fpregs.f_fpiaddr;
+    for (i = 0; i < 8; i++) {
+        memcpy(&ri->fpregs.f_fpregs[i * 3],
+               &uc->uc_mcontext.fpregs.f_fpregs[i * 3],
+               3 * sizeof(int));
+    }
+}
+
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a, ucontext_t *uc)
+{
+    int i;
+
+    if (m->gregs[R_PS] != a->gregs[R_PS]) {
+        return 0;
+    }
+
+    for (i = 0; i < 16; i++) {
+        if (i == R_SP || i == R_A6) {
+            continue;
+        }
+        if (m->gregs[i] != a->gregs[i]) {
+            return 0;
+        }
+    }
+
+    if (m->fpregs.f_pcr != a->fpregs.f_pcr) {
+        return 0;
+    }
+
+    if (m->fpregs.f_psr != a->fpregs.f_psr) {
+        return 0;
+    }
+
+    for (i = 0; i < 8; i++) {
+        if (m->fpregs.f_fpregs[i * 3] != a->fpregs.f_fpregs[i * 3] ||
+            m->fpregs.f_fpregs[i * 3 + 1] != a->fpregs.f_fpregs[i * 3 + 1] ||
+            m->fpregs.f_fpregs[i * 3 + 2] != a->fpregs.f_fpregs[i * 3 + 2]) {
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+void reginfo_dump(struct reginfo *ri, int is_master)
+{
+    int i;
+    if (is_master) {
+        fprintf(stderr, "  pc            \e[1;101;37m0x%08x\e[0m\n",
+                ri->pc);
+    }
+    fprintf(stderr, "\tPC: %08x\n", ri->gregs[R_PC]);
+    fprintf(stderr, "\tPS: %04x\n", ri->gregs[R_PS]);
+
+    for (i = 0; i < 8; i++) {
+        fprintf(stderr, "\tD%d: %8x\tA%d: %8x\n", i, ri->gregs[i],
+                i, ri->gregs[i + 8]);
+    }
+
+
+    for (i = 0; i < 8; i++) {
+        fprintf(stderr, "\tFP%d: %08x %08x %08x\n", i,
+                ri->fpregs.f_fpregs[i * 3], ri->fpregs.f_fpregs[i * 3 + 1],
+                ri->fpregs.f_fpregs[i * 3 + 2]);
+    }
+
+    fprintf(stderr, "\n");
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+
+    if (m->gregs[R_PS] != a->gregs[R_PS]) {
+            fprintf(f, "Mismatch: Register PS\n");
+            fprintf(f, "master: [%x] - apprentice: [%x]\n",
+                    m->gregs[R_PS], a->gregs[R_PS]);
+    }
+
+    for (i = 0; i < 16; i++) {
+        if (i == R_SP || i == R_A6) {
+            continue;
+        }
+        if (m->gregs[i] != a->gregs[i]) {
+            fprintf(f, "Mismatch: Register %c%d\n", i < 8 ? 'D' : 'A', i % 8);
+            fprintf(f, "master: [%x] - apprentice: [%x]\n",
+                    m->gregs[i], a->gregs[i]);
+        }
+    }
+
+    if (m->fpregs.f_pcr != a->fpregs.f_pcr) {
+        fprintf(f, "Mismatch: Register FPCR\n");
+        fprintf(f, "m: [%04x] != a: [%04x]\n",
+                m->fpregs.f_pcr, a->fpregs.f_pcr);
+    }
+
+    if (m->fpregs.f_psr != a->fpregs.f_psr) {
+        fprintf(f, "Mismatch: Register FPSR\n");
+        fprintf(f, "m: [%08x] != a: [%08x]\n",
+                m->fpregs.f_psr, a->fpregs.f_psr);
+    }
+
+    for (i = 0; i < 8; i++) {
+        if (m->fpregs.f_fpregs[i * 3] != a->fpregs.f_fpregs[i * 3] ||
+            m->fpregs.f_fpregs[i * 3 + 1] != a->fpregs.f_fpregs[i * 3 + 1] ||
+            m->fpregs.f_fpregs[i * 3 + 2] != a->fpregs.f_fpregs[i * 3 + 2]) {
+            fprintf(f, "Mismatch: Register FP%d\n", i);
+            fprintf(f, "m: [%08x %08x %08x] != a: [%08x %08x %08x]\n",
+                    m->fpregs.f_fpregs[i * 3], m->fpregs.f_fpregs[i * 3 + 1],
+                    m->fpregs.f_fpregs[i * 3 + 2], a->fpregs.f_fpregs[i * 3],
+                    a->fpregs.f_fpregs[i * 3 + 1],
+                    a->fpregs.f_fpregs[i * 3 + 2]);
+        }
+    }
+
+
+    return !ferror(f);
+}
diff --git a/risu_reginfo_m68k.h b/risu_reginfo_m68k.h
new file mode 100644
index 0000000..9dd8f32
--- /dev/null
+++ b/risu_reginfo_m68k.h
@@ -0,0 +1,32 @@
+/*****************************************************************************
+ * Copyright (c) 2016 Laurent Vivier
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+#ifndef RISU_REGINFO_M68K_H
+#define RISU_REGINFO_M68K_H
+
+struct reginfo
+{
+    uint32_t faulting_insn;
+    uint32_t pc;
+    gregset_t gregs;
+    fpregset_t fpregs;
+};
+
+/* initialize structure from a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc);
+
+/* return 1 if structs are equal, 0 otherwise. */
+int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2, ucontext_t *uc);
+
+/* print reginfo state to a stream */
+void reginfo_dump(struct reginfo *ri, int is_master);
+
+/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
+
+#endif /* RISU_REGINFO_M68K_H */
diff --git a/test_m68k.s b/test_m68k.s
new file mode 100644
index 0000000..6ca8a92
--- /dev/null
+++ b/test_m68k.s
@@ -0,0 +1,28 @@
+/*******************************************************************************
+ * Copyright (c) 2016 Laurent Vivier
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *******************************************************************************
+
+/* Initialise the gp regs */
+moveq.l #0, %d0
+move.l %d0, %d1
+move.l %d0, %d2
+move.l %d0, %d3
+move.l %d0, %d4
+move.l %d0, %d5
+move.l %d0, %d6
+move.l %d0, %d7
+move.l %d0, %a0
+move.l %d0, %a1
+move.l %d0, %a2
+move.l %d0, %a3
+move.l %d0, %a4
+move.l %d0, %a5
+
+/* do compare */
+.int 0x4afc7000
+/* exit test */
+.int 0x4afc7001
-- 
2.9.3
