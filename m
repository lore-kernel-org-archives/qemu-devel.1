Received: from eggs.gnu.org ([2001:4830:134:3::10]:35182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmS-0003u8-F9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1chJmR-0005Cl-Am
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:44 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1chJmQ-0004Og-Ux
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:35:43 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:35:22 +0000
Message-Id: <1487957728-8354-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
References: <1487957728-8354-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu 3/9] Make get_risuop() a formal part of
 the CPU interface
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

From: Peter Maydell <pmaydell@chiark.greenend.org.uk>

Make get_risuop() a formal part of the CPU interface rather than
just a de-facto common routine.

Signed-off-by: Peter Maydell <pmaydell@chiark.greenend.org.uk>
---
 risu.h         | 5 +++++
 risu_aarch64.c | 7 ++++---
 risu_arm.c     | 9 +++++----
 risu_m68k.c    | 7 ++++---
 risu_ppc64le.c | 7 ++++---
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/risu.h b/risu.h
index 4f923b2..1525b3e 100644
--- a/risu.h
+++ b/risu.h
@@ -74,4 +74,9 @@ void set_ucontext_paramreg(void *vuc, uint64_t value);
 /* Return the value of the parameter register from a reginfo. */
 uint64_t get_reginfo_paramreg(struct reginfo *ri);
 
+/* Return the risu operation number we have been asked to do,
+ * or -1 if this was a SIGILL for a non-risuop insn.
+ */
+int get_risuop(struct reginfo *ri);
+
 #endif /* RISU_H */
diff --git a/risu_aarch64.c b/risu_aarch64.c
index f13338d..81573e3 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -41,11 +41,12 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->regs[0];
 }
 
-static int get_risuop(uint32_t insn)
+int get_risuop(struct reginfo *ri)
 {
     /* Return the risuop we have been asked to do
      * (or -1 if this was a SIGILL for a non-risuop insn)
      */
+    uint32_t insn = ri->faulting_insn;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = 0x00005af0;
@@ -57,7 +58,7 @@ int send_register_info(int sock, void *uc)
     struct reginfo ri;
     int op;
     reginfo_init(&ri, uc);
-    op = get_risuop(ri.faulting_insn);
+    op = get_risuop(&ri);
 
     switch (op) {
     case OP_COMPARE:
@@ -94,7 +95,7 @@ int recv_and_compare_register_info(int sock, void *uc)
     int resp = 0, op;
 
     reginfo_init(&master_ri, uc);
-    op = get_risuop(master_ri.faulting_insn);
+    op = get_risuop(&master_ri);
 
     switch (op) {
     case OP_COMPARE:
diff --git a/risu_arm.c b/risu_arm.c
index c2b79a5..36ac3c8 100644
--- a/risu_arm.c
+++ b/risu_arm.c
@@ -64,24 +64,25 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gpreg[0];
 }
 
-static int get_risuop(uint32_t insn, int isz)
+int get_risuop(struct reginfo *ri)
 {
    /* Return the risuop we have been asked to do
     * (or -1 if this was a SIGILL for a non-risuop insn)
     */
+   uint32_t insn = ri->faulting_insn;
+   int isz = ri->faulting_insn_size;
    uint32_t op = insn & 0xf;
    uint32_t key = insn & ~0xf;
    uint32_t risukey = (isz == 2) ? 0xdee0 : 0xe7fe5af0;
    return (key != risukey) ? -1 : op;
 }
 
-
 int send_register_info(int sock, void *uc)
 {
    struct reginfo ri;
    int op;
    reginfo_init(&ri, uc);
-   op = get_risuop(ri.faulting_insn, ri.faulting_insn_size);
+   op = get_risuop(&ri);
 
    switch (op)
    {
@@ -119,7 +120,7 @@ int recv_and_compare_register_info(int sock, void *uc)
    int resp = 0, op;
 
    reginfo_init(&master_ri, uc);
-   op = get_risuop(master_ri.faulting_insn, master_ri.faulting_insn_size);
+   op = get_risuop(&master_ri);
 
    switch (op)
    {
diff --git a/risu_m68k.c b/risu_m68k.c
index feb3912..8c138dd 100644
--- a/risu_m68k.c
+++ b/risu_m68k.c
@@ -36,8 +36,9 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gregs[R_A0];
 }
 
-static int get_risuop(uint32_t insn)
+int get_risuop(struct reginfo *ri)
 {
+    uint32_t insn = ri->faulting_insn;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = 0x4afc7000;
@@ -50,7 +51,7 @@ int send_register_info(int sock, void *uc)
     int op;
 
     reginfo_init(&ri, uc);
-    op = get_risuop(ri.faulting_insn);
+    op = get_risuop(&ri);
 
     switch (op) {
     case OP_COMPARE:
@@ -81,7 +82,7 @@ int recv_and_compare_register_info(int sock, void *uc)
     int op;
 
     reginfo_init(&master_ri, uc);
-    op = get_risuop(master_ri.faulting_insn);
+    op = get_risuop(&master_ri);
 
     switch (op) {
     case OP_COMPARE:
diff --git a/risu_ppc64le.c b/risu_ppc64le.c
index 05b0294..43170ea 100644
--- a/risu_ppc64le.c
+++ b/risu_ppc64le.c
@@ -41,8 +41,9 @@ uint64_t get_reginfo_paramreg(struct reginfo *ri)
     return ri->gregs[0];
 }
 
-static int get_risuop(uint32_t insn)
+int get_risuop(struct reginfo *ri)
 {
+    uint32_t insn = ri->faulting_insn;
     uint32_t op = insn & 0xf;
     uint32_t key = insn & ~0xf;
     uint32_t risukey = 0x00005af0;
@@ -55,7 +56,7 @@ int send_register_info(int sock, void *uc)
     int op;
 
     reginfo_init(&ri, uc);
-    op = get_risuop(ri.faulting_insn);
+    op = get_risuop(&ri);
 
     switch (op) {
     case OP_COMPARE:
@@ -86,7 +87,7 @@ int recv_and_compare_register_info(int sock, void *uc)
     int op;
 
     reginfo_init(&master_ri, uc);
-    op = get_risuop(master_ri.faulting_insn);
+    op = get_risuop(&master_ri);
 
     switch (op) {
     case OP_COMPARE:
-- 
2.7.4
