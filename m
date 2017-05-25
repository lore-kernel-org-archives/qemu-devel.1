Received: from eggs.gnu.org ([2001:4830:134:3::10]:60330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDyAg-0003xE-5Z
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1dDyAa-0001iX-G6
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1dDyAa-0001iM-2O
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:11:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4PJ8gT4136257
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 15:11:34 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ap4wrrr7b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 15:11:34 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Thu, 25 May 2017 16:11:31 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4PJBJj418284824
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:11:28 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4PJAtHI013688
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:10:55 -0300
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Thu, 25 May 2017 16:10:23 -0300
In-Reply-To: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1495739423-32326-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1495739423-32326-5-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu v3 4/4] build: Add support to PowerPC BE
 and remove ARCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

Essentialy the code for PowerPC BE and LE are the same, so this patch
renames all *ppc64le.* files to *ppc64.* and reflects such in the
Makefile.

Due to the fact that all supported archs are covered by guess_arch
function, this also drops the ARCH parameter from the Makefile.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 build-all-archs        |   2 +-
 configure              |  13 +---
 risu_ppc64.c           |  40 ++++++++++
 risu_ppc64le.c         |  40 ----------
 risu_reginfo_ppc64.c   | 193 +++++++++++++++++++++++++++++++++++++++++++++++++
 risu_reginfo_ppc64.h   |  28 +++++++
 risu_reginfo_ppc64le.c | 193 -------------------------------------------------
 risu_reginfo_ppc64le.h |  28 -------
 test_ppc64.s           |  49 +++++++++++++
 test_ppc64le.s         |  49 -------------
 10 files changed, 313 insertions(+), 322 deletions(-)
 create mode 100644 risu_ppc64.c
 delete mode 100644 risu_ppc64le.c
 create mode 100644 risu_reginfo_ppc64.c
 create mode 100644 risu_reginfo_ppc64.h
 delete mode 100644 risu_reginfo_ppc64le.c
 delete mode 100644 risu_reginfo_ppc64le.h
 create mode 100644 test_ppc64.s
 delete mode 100644 test_ppc64le.s

diff --git a/build-all-archs b/build-all-archs
index e98ab9d..2768727 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -25,7 +25,7 @@ program_exists() {
 
 # powerpc64-linux-gnu doesn't work at the moment, so not yet listed.
 for triplet in aarch64-linux-gnu arm-linux-gnueabihf m68k-linux-gnu \
-    powerpc64le-linux-gnu ; do
+    powerpc64le-linux-gnu powerpc64-linux-gnu ; do
 
     if ! program_exists "${triplet}-gcc"; then
         echo "Skipping ${triplet}: no compiler found"
diff --git a/configure b/configure
index dd64d8b..180194a 100755
--- a/configure
+++ b/configure
@@ -51,7 +51,7 @@ guess_arch() {
     elif check_define __aarch64__ ; then
         ARCH="aarch64"
     elif check_define __powerpc64__ ; then
-        ARCH="ppc64le"
+        ARCH="ppc64"
     else
         echo "This cpu is not supported by risu. Try -h. " >&2
         exit 1
@@ -87,9 +87,6 @@ Some influential environment variables:
   CROSS_PREFIX cross-compiler prefix, defaults to gcc and other tools
                prefixed with the given string.
 
-  ARCH         force target architecture instead of trying to detect it.
-               Valid values=[arm|aarch64|ppc64|ppc64le|m68k]
-
   CC           C compiler command
   CFLAGS       C compiler flags
   CPPFLAGS     C preprocessor flags, e.g. -I<include dir>
@@ -121,13 +118,7 @@ AS="${AS-${CROSS_PREFIX}as}"
 OBJCOPY="${OBJCOPY-${CROSS_PREFIX}objcopy}"
 OBJDUMP="${OBJDUMP-${CROSS_PREFIX}objdump}"
 
-if test "x${ARCH}" = "x"; then
-    guess_arch
-elif test "x${ARCH}" = "xppc64"; then
-    # ppc64 and ppc64le uses the same C source code
-    ARCH="ppc64le"
-fi
-
+guess_arch
 generate_makefilein
 
 # Are we in a separate build tree? If so, link the Makefile
diff --git a/risu_ppc64.c b/risu_ppc64.c
new file mode 100644
index 0000000..b575078
--- /dev/null
+++ b/risu_ppc64.c
@@ -0,0 +1,40 @@
+/******************************************************************************
+ * Copyright (c) IBM Corp, 2016
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Jose Ricardo Ziviani - initial implementation
+ *     based on Claudio Fontana's risu_aarch64.c
+ *     based on Peter Maydell's risu_arm.c
+ *****************************************************************************/
+
+#include "risu.h"
+
+void advance_pc(void *vuc)
+{
+    ucontext_t *uc = (ucontext_t*)vuc;
+    uc->uc_mcontext.regs->nip += 4;
+}
+
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext.gp_regs[0] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[0];
+}
+
+int get_risuop(struct reginfo *ri)
+{
+    uint32_t insn = ri->faulting_insn;
+    uint32_t op = insn & 0xf;
+    uint32_t key = insn & ~0xf;
+    uint32_t risukey = 0x00005af0;
+    return (key != risukey) ? -1 : op;
+}
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
deleted file mode 100644
index b575078..0000000
--- a/risu_ppc64le.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/******************************************************************************
- * Copyright (c) IBM Corp, 2016
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * which accompanies this distribution, and is available at
- * http://www.eclipse.org/legal/epl-v10.html
- *
- * Contributors:
- *     Jose Ricardo Ziviani - initial implementation
- *     based on Claudio Fontana's risu_aarch64.c
- *     based on Peter Maydell's risu_arm.c
- *****************************************************************************/
-
-#include "risu.h"
-
-void advance_pc(void *vuc)
-{
-    ucontext_t *uc = (ucontext_t*)vuc;
-    uc->uc_mcontext.regs->nip += 4;
-}
-
-void set_ucontext_paramreg(void *vuc, uint64_t value)
-{
-    ucontext_t *uc = vuc;
-    uc->uc_mcontext.gp_regs[0] = value;
-}
-
-uint64_t get_reginfo_paramreg(struct reginfo *ri)
-{
-    return ri->gregs[0];
-}
-
-int get_risuop(struct reginfo *ri)
-{
-    uint32_t insn = ri->faulting_insn;
-    uint32_t op = insn & 0xf;
-    uint32_t key = insn & ~0xf;
-    uint32_t risukey = 0x00005af0;
-    return (key != risukey) ? -1 : op;
-}
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
new file mode 100644
index 0000000..ae86263
--- /dev/null
+++ b/risu_reginfo_ppc64.c
@@ -0,0 +1,193 @@
+/******************************************************************************
+ * Copyright (c) IBM Corp, 2016
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Jose Ricardo Ziviani - initial implementation
+ *     based on Claudio Fontana's risu_aarch64.c
+ *     based on Peter Maydell's risu_arm.c
+ *****************************************************************************/
+
+#include <stdio.h>
+#include <ucontext.h>
+#include <string.h>
+#include <math.h>
+
+#include "risu.h"
+#include "risu_reginfo_ppc64.h"
+
+#define XER 37
+#define CCR 38
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
+{
+    int i;
+    memset(ri, 0, sizeof(*ri));
+
+    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.regs->nip);
+    ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
+
+    for (i = 0; i < NGREG; i++) {
+        ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
+    }
+
+    for (i = 0; i < NFPREG; i++) {
+        ri->fpregs[i] = uc->uc_mcontext.fp_regs[i];
+    }
+
+    for (i = 0; i < 32; i++) {
+        ri->vrregs.vrregs[i][0] = uc->uc_mcontext.v_regs->vrregs[i][0];
+        ri->vrregs.vrregs[i][1] = uc->uc_mcontext.v_regs->vrregs[i][1];
+        ri->vrregs.vrregs[i][2] = uc->uc_mcontext.v_regs->vrregs[i][2];
+        ri->vrregs.vrregs[i][3] = uc->uc_mcontext.v_regs->vrregs[i][3];
+    }
+    ri->vrregs.vscr = uc->uc_mcontext.v_regs->vscr;
+    ri->vrregs.vrsave = uc->uc_mcontext.v_regs->vrsave;
+}
+
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+{
+    int i;
+    for (i = 0; i < 32; i++) {
+        if (i == 1 || i == 13) {
+            continue;
+        }
+
+        if (m->gregs[i] != a->gregs[i]) {
+            return 0;
+        }
+    }
+
+    if (m->gregs[XER] != a->gregs[XER]) {
+        return 0;
+    }
+
+    if ((m->gregs[CCR] & 0x10) != (a->gregs[CCR] & 0x10)) {
+        return 0;
+    }
+
+    for (i = 0; i < 32; i++) {
+        if (isnan(m->fpregs[i]) && isnan(a->fpregs[i])) {
+            continue;
+        }
+
+        if  (m->fpregs[i] != a->fpregs[i]) {
+            return 0;
+        }
+    }
+
+    for (i = 0; i < 32; i++) {
+        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
+                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
+                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
+                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
+            return 0;
+        }
+    }
+    return 1;
+}
+
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE *f)
+{
+    int i;
+
+    fprintf(f, "  faulting insn 0x%x\n", ri->faulting_insn);
+    fprintf(f, "  prev insn     0x%x\n", ri->prev_insn);
+    fprintf(f, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
+
+    for (i = 0; i < 16; i++) {
+        fprintf(f, "\tr%2d: %16lx\tr%2d: %16lx\n", i, ri->gregs[i],
+                i + 16, ri->gregs[i + 16]);
+    }
+
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
+
+    for (i = 0; i < 16; i++) {
+        fprintf(f, "\tf%2d: %.4f\tr%2d: %.4f\n", i, ri->fpregs[i],
+                i + 16, ri->fpregs[i + 16]);
+    }
+    fprintf(f, "\tfpscr: %f\n\n", ri->fpregs[32]);
+
+    for (i = 0; i < 32; i++) {
+        fprintf(f, "vr%02d: %8x, %8x, %8x, %8x\n", i,
+                ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
+                ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
+    }
+
+    return !ferror(f);
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+    for (i = 0; i < 32; i++) {
+        if (i == 1 || i == 13) {
+            continue;
+        }
+
+        if (m->gregs[i] != a->gregs[i]) {
+            fprintf(f, "Mismatch: Register r%d\n", i);
+            fprintf(f, "master: [%lx] - apprentice: [%lx]\n",
+                    m->gregs[i], a->gregs[i]);
+        }
+    }
+
+    if (m->gregs[XER] != a->gregs[XER]) {
+        fprintf(f, "Mismatch: XER\n");
+        fprintf(f, "m: [%lx] != a: [%lx]\n",
+                m->gregs[XER], a->gregs[XER]);
+    }
+
+    if (m->gregs[CCR] != a->gregs[CCR]) {
+        fprintf(f, "Mismatch: Cond. Register\n");
+        fprintf(f, "m: [%lx] != a: [%lx]\n",
+                m->gregs[CCR], a->gregs[CCR]);
+    }
+
+    for (i = 0; i < 32; i++) {
+        if (isnan(m->fpregs[i]) && isnan(a->fpregs[i])) {
+            continue;
+        }
+
+        if  (m->fpregs[i] != a->fpregs[i]) {
+            fprintf(f, "Mismatch: Register r%d\n", i);
+            fprintf(f, "m: [%f] != a: [%f]\n",
+                    m->fpregs[i], a->fpregs[i]);
+        }
+    }
+
+    for (i = 0; i < 32; i++) {
+        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
+                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
+                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
+                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
+
+            fprintf(f, "Mismatch: Register vr%d\n", i);
+            fprintf(f, "m: [%x, %x, %x, %x] != a: [%x, %x, %x, %x]\n",
+                    m->vrregs.vrregs[i][0], m->vrregs.vrregs[i][1],
+                    m->vrregs.vrregs[i][2], m->vrregs.vrregs[i][3],
+                    a->vrregs.vrregs[i][0], a->vrregs.vrregs[i][1],
+                    a->vrregs.vrregs[i][2], a->vrregs.vrregs[i][3]);
+        }
+    }
+    return !ferror(f);
+}
diff --git a/risu_reginfo_ppc64.h b/risu_reginfo_ppc64.h
new file mode 100644
index 0000000..826143e
--- /dev/null
+++ b/risu_reginfo_ppc64.h
@@ -0,0 +1,28 @@
+/******************************************************************************
+ * Copyright (c) IBM Corp, 2016
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Jose Ricardo Ziviani - initial implementation
+ *     based on Claudio Fontana's risu_reginfo_aarch64
+ *     based on Peter Maydell's risu_arm.c
+ *****************************************************************************/
+
+#ifndef RISU_REGINFO_PPC64LE_H
+#define RISU_REGINFO_PPC64LE_H
+
+struct reginfo
+{
+    uint32_t faulting_insn;
+    uint32_t prev_insn;
+    uint64_t nip;
+    uint64_t prev_addr;
+    gregset_t gregs;
+    fpregset_t fpregs;
+    vrregset_t vrregs;
+};
+
+#endif /* RISU_REGINFO_PPC64LE_H */
diff --git a/risu_reginfo_ppc64le.c b/risu_reginfo_ppc64le.c
deleted file mode 100644
index 9e673e1..0000000
--- a/risu_reginfo_ppc64le.c
+++ /dev/null
@@ -1,193 +0,0 @@
-/******************************************************************************
- * Copyright (c) IBM Corp, 2016
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * which accompanies this distribution, and is available at
- * http://www.eclipse.org/legal/epl-v10.html
- *
- * Contributors:
- *     Jose Ricardo Ziviani - initial implementation
- *     based on Claudio Fontana's risu_aarch64.c
- *     based on Peter Maydell's risu_arm.c
- *****************************************************************************/
-
-#include <stdio.h>
-#include <ucontext.h>
-#include <string.h>
-#include <math.h>
-
-#include "risu.h"
-#include "risu_reginfo_ppc64le.h"
-
-#define XER 37
-#define CCR 38
-
-/* reginfo_init: initialize with a ucontext */
-void reginfo_init(struct reginfo *ri, ucontext_t *uc)
-{
-    int i;
-    memset(ri, 0, sizeof(*ri));
-
-    ri->faulting_insn = *((uint32_t *)uc->uc_mcontext.regs->nip);
-    ri->nip = uc->uc_mcontext.regs->nip - image_start_address;
-
-    for (i = 0; i < NGREG; i++) {
-        ri->gregs[i] = uc->uc_mcontext.gp_regs[i];
-    }
-
-    for (i = 0; i < NFPREG; i++) {
-        ri->fpregs[i] = uc->uc_mcontext.fp_regs[i];
-    }
-
-    for (i = 0; i < 32; i++) {
-        ri->vrregs.vrregs[i][0] = uc->uc_mcontext.v_regs->vrregs[i][0];
-        ri->vrregs.vrregs[i][1] = uc->uc_mcontext.v_regs->vrregs[i][1];
-        ri->vrregs.vrregs[i][2] = uc->uc_mcontext.v_regs->vrregs[i][2];
-        ri->vrregs.vrregs[i][3] = uc->uc_mcontext.v_regs->vrregs[i][3];
-    }
-    ri->vrregs.vscr = uc->uc_mcontext.v_regs->vscr;
-    ri->vrregs.vrsave = uc->uc_mcontext.v_regs->vrsave;
-}
-
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
-{
-    int i;
-    for (i = 0; i < 32; i++) {
-        if (i == 1 || i == 13) {
-            continue;
-        }
-
-        if (m->gregs[i] != a->gregs[i]) {
-            return 0;
-        }
-    }
-
-    if (m->gregs[XER] != a->gregs[XER]) {
-        return 0;
-    }
-
-    if ((m->gregs[CCR] & 0x10) != (a->gregs[CCR] & 0x10)) {
-        return 0;
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (isnan(m->fpregs[i]) && isnan(a->fpregs[i])) {
-            continue;
-        }
-
-        if  (m->fpregs[i] != a->fpregs[i]) {
-            return 0;
-        }
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
-                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
-                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
-            return 0;
-        }
-    }
-    return 1;
-}
-
-/* reginfo_dump: print state to a stream, returns nonzero on success */
-int reginfo_dump(struct reginfo *ri, FILE *f)
-{
-    int i;
-
-    fprintf(f, "  faulting insn 0x%x\n", ri->faulting_insn);
-    fprintf(f, "  prev insn     0x%x\n", ri->prev_insn);
-    fprintf(f, "  prev addr    0x%" PRIx64 "\n\n", ri->nip);
-
-    for (i = 0; i < 16; i++) {
-        fprintf(f, "\tr%2d: %16lx\tr%2d: %16lx\n", i, ri->gregs[i],
-                i + 16, ri->gregs[i + 16]);
-    }
-
-    fprintf(f, "\n");
-    fprintf(f, "\tnip    : %16lx\n", ri->gregs[32]);
-    fprintf(f, "\tmsr    : %16lx\n", ri->gregs[33]);
-    fprintf(f, "\torig r3: %16lx\n", ri->gregs[34]);
-    fprintf(f, "\tctr    : %16lx\n", ri->gregs[35]);
-    fprintf(f, "\tlnk    : %16lx\n", ri->gregs[36]);
-    fprintf(f, "\txer    : %16lx\n", ri->gregs[37]);
-    fprintf(f, "\tccr    : %16lx\n", ri->gregs[38]);
-    fprintf(f, "\tmq     : %16lx\n", ri->gregs[39]);
-    fprintf(f, "\ttrap   : %16lx\n", ri->gregs[40]);
-    fprintf(f, "\tdar    : %16lx\n", ri->gregs[41]);
-    fprintf(f, "\tdsisr  : %16lx\n", ri->gregs[42]);
-    fprintf(f, "\tresult : %16lx\n", ri->gregs[43]);
-    fprintf(f, "\tdscr   : %16lx\n\n", ri->gregs[44]);
-
-    for (i = 0; i < 16; i++) {
-        fprintf(f, "\tf%2d: %.4f\tr%2d: %.4f\n", i, ri->fpregs[i],
-                i + 16, ri->fpregs[i + 16]);
-    }
-    fprintf(f, "\tfpscr: %f\n\n", ri->fpregs[32]);
-
-    for (i = 0; i < 32; i++) {
-        fprintf(f, "vr%02d: %8x, %8x, %8x, %8x\n", i,
-                ri->vrregs.vrregs[i][0], ri->vrregs.vrregs[i][1],
-                ri->vrregs.vrregs[i][2], ri->vrregs.vrregs[i][3]);
-    }
-
-    return !ferror(f);
-}
-
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
-{
-    int i;
-    for (i = 0; i < 32; i++) {
-        if (i == 1 || i == 13) {
-            continue;
-        }
-
-        if (m->gregs[i] != a->gregs[i]) {
-            fprintf(f, "Mismatch: Register r%d\n", i);
-            fprintf(f, "master: [%lx] - apprentice: [%lx]\n",
-                    m->gregs[i], a->gregs[i]);
-        }
-    }
-
-    if (m->gregs[XER] != a->gregs[XER]) {
-        fprintf(f, "Mismatch: XER\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n",
-                m->gregs[XER], a->gregs[XER]);
-    }
-
-    if (m->gregs[CCR] != a->gregs[CCR]) {
-        fprintf(f, "Mismatch: Cond. Register\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n",
-                m->gregs[CCR], a->gregs[CCR]);
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (isnan(m->fpregs[i]) && isnan(a->fpregs[i])) {
-            continue;
-        }
-
-        if  (m->fpregs[i] != a->fpregs[i]) {
-            fprintf(f, "Mismatch: Register r%d\n", i);
-            fprintf(f, "m: [%f] != a: [%f]\n",
-                    m->fpregs[i], a->fpregs[i]);
-        }
-    }
-
-    for (i = 0; i < 32; i++) {
-        if (m->vrregs.vrregs[i][0] != a->vrregs.vrregs[i][0] ||
-                m->vrregs.vrregs[i][1] != a->vrregs.vrregs[i][1] ||
-                m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
-                m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
-
-            fprintf(f, "Mismatch: Register vr%d\n", i);
-            fprintf(f, "m: [%x, %x, %x, %x] != a: [%x, %x, %x, %x]\n",
-                    m->vrregs.vrregs[i][0], m->vrregs.vrregs[i][1],
-                    m->vrregs.vrregs[i][2], m->vrregs.vrregs[i][3],
-                    a->vrregs.vrregs[i][0], a->vrregs.vrregs[i][1],
-                    a->vrregs.vrregs[i][2], a->vrregs.vrregs[i][3]);
-        }
-    }
-    return !ferror(f);
-}
diff --git a/risu_reginfo_ppc64le.h b/risu_reginfo_ppc64le.h
deleted file mode 100644
index 826143e..0000000
--- a/risu_reginfo_ppc64le.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/******************************************************************************
- * Copyright (c) IBM Corp, 2016
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * which accompanies this distribution, and is available at
- * http://www.eclipse.org/legal/epl-v10.html
- *
- * Contributors:
- *     Jose Ricardo Ziviani - initial implementation
- *     based on Claudio Fontana's risu_reginfo_aarch64
- *     based on Peter Maydell's risu_arm.c
- *****************************************************************************/
-
-#ifndef RISU_REGINFO_PPC64LE_H
-#define RISU_REGINFO_PPC64LE_H
-
-struct reginfo
-{
-    uint32_t faulting_insn;
-    uint32_t prev_insn;
-    uint64_t nip;
-    uint64_t prev_addr;
-    gregset_t gregs;
-    fpregset_t fpregs;
-    vrregset_t vrregs;
-};
-
-#endif /* RISU_REGINFO_PPC64LE_H */
diff --git a/test_ppc64.s b/test_ppc64.s
new file mode 100644
index 0000000..4af770c
--- /dev/null
+++ b/test_ppc64.s
@@ -0,0 +1,49 @@
+/*****************************************************************************
+ * Copyright (c) IBM Corp, 2016
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Jose Ricardo Ziviani - ppc64le implementation
+ *     based on Claudio Fontana
+ *     based on test_arm.s by Peter Maydell
+ *****************************************************************************/
+
+/* Initialise the gp regs */
+li 0, 0
+li 2, 2
+li 3, 3
+li 4, 4
+li 5, 5
+li 6, 6
+li 7, 7
+li 8, 8
+li 9, 9
+li 10, 10
+li 11, 11
+li 12, 12
+li 14, 14
+li 15, 15
+li 16, 16
+li 17, 17
+li 18, 18
+li 19, 19
+li 20, 20
+li 21, 21
+li 22, 22
+li 23, 23
+li 24, 24
+li 25, 25
+li 26, 26
+li 27, 27
+li 28, 28
+li 29, 29
+li 30, 30
+li 31, 31
+
+/* do compare */
+.int 0x00005af0
+/* exit test */
+.int 0x00005af1
diff --git a/test_ppc64le.s b/test_ppc64le.s
deleted file mode 100644
index 4af770c..0000000
--- a/test_ppc64le.s
+++ /dev/null
@@ -1,49 +0,0 @@
-/*****************************************************************************
- * Copyright (c) IBM Corp, 2016
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1.0
- * which accompanies this distribution, and is available at
- * http://www.eclipse.org/legal/epl-v10.html
- *
- * Contributors:
- *     Jose Ricardo Ziviani - ppc64le implementation
- *     based on Claudio Fontana
- *     based on test_arm.s by Peter Maydell
- *****************************************************************************/
-
-/* Initialise the gp regs */
-li 0, 0
-li 2, 2
-li 3, 3
-li 4, 4
-li 5, 5
-li 6, 6
-li 7, 7
-li 8, 8
-li 9, 9
-li 10, 10
-li 11, 11
-li 12, 12
-li 14, 14
-li 15, 15
-li 16, 16
-li 17, 17
-li 18, 18
-li 19, 19
-li 20, 20
-li 21, 21
-li 22, 22
-li 23, 23
-li 24, 24
-li 25, 25
-li 26, 26
-li 27, 27
-li 28, 28
-li 29, 29
-li 30, 30
-li 31, 31
-
-/* do compare */
-.int 0x00005af0
-/* exit test */
-.int 0x00005af1
-- 
2.7.4
