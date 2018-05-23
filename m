Received: from eggs.gnu.org ([2001:4830:134:3::10]:42299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTH-0008K1-N4
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTG-0000vX-Hx
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:39 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTG-0000vA-BN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:38 -0400
Received: by mail-pf0-x243.google.com with SMTP id f189-v6so9564049pfa.7
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:38 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:01 +1200
Message-Id: <1527034517-7851-15-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 14/30] RISC-V: Add public API for the CSR
 dispatch table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

This allows hardware and/or derived cpu instances
to override or implement new CSR operations.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.h | 18 ++++++++++++++++++
 target/riscv/csr.c | 35 ++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 242a8fcbe180..1ade90d23bbc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -307,6 +307,24 @@ static inline target_ulong csr_read_helper(CPURISCVState *env, int csrno)
     return val;
 }
 
+typedef int (*riscv_csr_predicate_fn)(CPURISCVState *env, int csrno);
+typedef int (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
+    target_ulong *ret_value);
+typedef int (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
+    target_ulong new_value);
+typedef int (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
+    target_ulong *ret_value, target_ulong new_value, target_ulong write_mask);
+
+typedef struct {
+    riscv_csr_predicate_fn predicate;
+    riscv_csr_read_fn read;
+    riscv_csr_write_fn write;
+    riscv_csr_op_fn op;
+} riscv_csr_operations;
+
+void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+
 #include "exec/cpu-all.h"
 
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 509215327243..0f886e04b130 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -23,28 +23,29 @@
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
 
+/* CSR function table */
 
-/* Control and Status Register function table forward declaration */
+static riscv_csr_operations csr_ops[];
 
-typedef int (*riscv_csr_predicate_fn)(CPURISCVState *env, int csrno);
-typedef int (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
-    target_ulong *ret_value);
-typedef int (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
-    target_ulong new_value);
-typedef int (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
-    target_ulong *ret_value, target_ulong new_value, target_ulong write_mask);
+/* CSR function table constants */
 
-typedef struct {
-    riscv_csr_predicate_fn predicate;
-    riscv_csr_read_fn read;
-    riscv_csr_write_fn write;
-    riscv_csr_op_fn op;
-} riscv_csr_operations;
+enum {
+    CSR_TABLE_SIZE = 0xfff
+};
+
+/* CSR function table public API */
 
-static const riscv_csr_operations csr_ops[];
+void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
+{
+    *ops = csr_ops[csrno & CSR_TABLE_SIZE];
+}
 
+void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
+{
+    csr_ops[csrno & CSR_TABLE_SIZE] = *ops;
+}
 
-/* Predicates */
+/* CSR function table predicates (private) */
 
 static int fs(CPURISCVState *env, int csrno)
 {
@@ -784,7 +785,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
 /* Control and Status Register function table */
 
-static const riscv_csr_operations csr_ops[0xfff] = {
+static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* User Floating-Point CSRs */
     [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
     [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
-- 
2.7.0
