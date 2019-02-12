Received: from eggs.gnu.org ([209.51.188.92]:60587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gthAq-0005qT-3v
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gthAp-0003OI-1u
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:09:08 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gthAo-0003NE-SW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:09:07 -0500
Received: by mail-pl1-x641.google.com with SMTP id 101so189246pld.6
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 15:09:06 -0800 (PST)
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 12 Feb 2019 15:09:03 -0800
Message-Id: <20190212230903.9215-1-jimw@sifive.com>
In-Reply-To: <CAFyWVabfDYU+2+iDYOeFMBL4+hVFL5q=fSR7Pb=VX1af5xsTNg@mail.gmail.com>
References: <CAFyWVabfDYU+2+iDYOeFMBL4+hVFL5q=fSR7Pb=VX1af5xsTNg@mail.gmail.com>
Subject: [Qemu-devel] [PATCH v4 4/5] RISC-V: Add debug support for accessing
 CSRs.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jim Wilson <jimw@sifive.com>

Add a debugger field to CPURISCVState.  Add riscv_csrrw_debug function
to set it.  Disable mode checks when debugger field true.

Signed-off-by: Jim Wilson <jimw@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  5 +++++
 target/riscv/csr.c | 34 ++++++++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 743f02c..04a050e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -170,6 +170,9 @@ struct CPURISCVState {
 
     /* physical memory protection */
     pmp_table_t pmp_state;
+
+    /* True if in debugger mode.  */
+    bool debugger;
 #endif
 
     float_status fp_status;
@@ -292,6 +295,8 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 
 int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
                 target_ulong new_value, target_ulong write_mask);
+int riscv_csrrw_debug(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                      target_ulong new_value, target_ulong write_mask);
 
 static inline void csr_write_helper(CPURISCVState *env, target_ulong val,
                                     int csrno)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5e7e7d1..de28a5d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
 #endif
@@ -58,7 +58,7 @@ static int ctr(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
     target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
                           env->priv == PRV_S ? env->mcounteren : -1U;
-    if (!(ctr_en & (1 << (csrno & 31)))) {
+    if (!env->debugger && !(ctr_en & (1 << (csrno & 31)))) {
         return -1;
     }
 #endif
@@ -86,7 +86,7 @@ static int pmp(CPURISCVState *env, int csrno)
 static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
 #endif
@@ -97,7 +97,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -109,7 +109,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
 #endif
@@ -120,7 +120,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -132,7 +132,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
 #endif
@@ -144,7 +144,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -772,6 +772,24 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
     return 0;
 }
 
+/*
+ * Debugger support.  If not in user mode, set env->debugger before the
+ * riscv_csrrw call and clear it after the call.
+ */
+int riscv_csrrw_debug(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                target_ulong new_value, target_ulong write_mask)
+{
+    int ret;
+#if !defined(CONFIG_USER_ONLY)
+    env->debugger = true;
+#endif
+    ret = riscv_csrrw(env, csrno, ret_value, new_value, write_mask);
+#if !defined(CONFIG_USER_ONLY)
+    env->debugger = false;
+#endif
+    return ret;
+}
+
 /* Control and Status Register function table */
 static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     /* User Floating-Point CSRs */
-- 
2.7.4
