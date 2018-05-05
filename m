Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kR-0004Rh-A1
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kN-00042A-C8
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:51 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6kN-00041r-36
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:47 -0400
Received: by mail-pg0-x241.google.com with SMTP id n9-v6so17787895pgq.5
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:46 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:21 +1200
Message-Id: <1525563325-62963-17-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL 16/20] RISC-V: Use [ms]counteren CSRs when priv
 ISA >= v1.10
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

Privileged ISA v1.9.1 defines mscounteren and mucounteren:

* mscounteren contains a mask of counters available to S-mode
* mucounteren contains a mask of counters available to U-mode

Privileged ISA v1.10 defines mcounteren and scounteren:

* mcounteren contains a mask of counters available to S-mode
* scounteren contains a mask of counters available to U-mode

mcounteren and scounteren CSR registers were implemented
however they were not honoured for counter accesses when
the privilege ISA was >= v1.10. This fix solves the issue
by coalescing the counter enable registers. In addition
the code now  generates illegal instruction exceptions
for accesses to the counter enabled registers depending
on the privileged ISA version.

- Coalesce mscounteren and mcounteren into one variable
- Coalesce mucounteren and scounteren into one variable
- Makes mcounteren and scounteren CSR accesses generate
  illegal instructions when the privileged ISA <= v1.9.1
- Makes mscounteren and mucounteren CSR accesses generate
  illegal instructions when the privileged ISA >= v1.10

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.h       |  6 ++---
 target/riscv/op_helper.c | 62 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1dcbdbe6f77d..34abc383e3d4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -151,10 +151,8 @@ struct CPURISCVState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
-    uint32_t mucounteren;
-    uint32_t mscounteren;
-    target_ulong scounteren; /* since: priv-1.10.0 */
-    target_ulong mcounteren; /* since: priv-1.10.0 */
+    target_ulong scounteren;
+    target_ulong mcounteren;
 
     target_ulong sscratch;
     target_ulong mscratch;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f45ac7306c38..7416412b187c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -225,11 +225,19 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         qemu_log_mask(LOG_UNIMP, "CSR_MCYCLEH: write not implemented");
         goto do_illegal;
     case CSR_MUCOUNTEREN:
-        env->mucounteren = val_to_write;
-        break;
+        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+            env->scounteren = val_to_write;
+            break;
+        } else {
+            goto do_illegal;
+        }
     case CSR_MSCOUNTEREN:
-        env->mscounteren = val_to_write;
-        break;
+        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+            env->mcounteren = val_to_write;
+            break;
+        } else {
+            goto do_illegal;
+        }
     case CSR_SSTATUS: {
         target_ulong ms = env->mstatus;
         target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
@@ -286,8 +294,12 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         env->stvec = val_to_write >> 2 << 2;
         break;
     case CSR_SCOUNTEREN:
-        env->scounteren = val_to_write;
-        break;
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            env->scounteren = val_to_write;
+            break;
+        } else {
+            goto do_illegal;
+        }
     case CSR_SSCRATCH:
         env->sscratch = val_to_write;
         break;
@@ -308,8 +320,12 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         env->mtvec = val_to_write >> 2 << 2;
         break;
     case CSR_MCOUNTEREN:
-        env->mcounteren = val_to_write;
-        break;
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            env->mcounteren = val_to_write;
+            break;
+        } else {
+            goto do_illegal;
+        }
     case CSR_MSCRATCH:
         env->mscratch = val_to_write;
         break;
@@ -347,6 +363,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     case CSR_PMPADDR15:
        pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val_to_write);
        break;
+#endif
+#if !defined(CONFIG_USER_ONLY)
     do_illegal:
 #endif
     default:
@@ -362,8 +380,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
 target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
 {
 #ifndef CONFIG_USER_ONLY
-    target_ulong ctr_en = env->priv == PRV_U ? env->mucounteren :
-                   env->priv == PRV_S ? env->mscounteren : -1U;
+    target_ulong ctr_en = env->priv == PRV_U ? env->scounteren :
+                          env->priv == PRV_S ? env->mcounteren : -1U;
 #else
     target_ulong ctr_en = -1;
 #endif
@@ -438,9 +456,17 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
 #endif
         break;
     case CSR_MUCOUNTEREN:
-        return env->mucounteren;
+        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+            return env->scounteren;
+        } else {
+            break; /* illegal instruction */
+        }
     case CSR_MSCOUNTEREN:
-        return env->mscounteren;
+        if (env->priv_ver <= PRIV_VERSION_1_09_1) {
+            return env->mcounteren;
+        } else {
+            break; /* illegal instruction */
+        }
     case CSR_SSTATUS: {
         target_ulong mask = SSTATUS_SIE | SSTATUS_SPIE | SSTATUS_UIE
             | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS
@@ -465,7 +491,11 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
     case CSR_STVEC:
         return env->stvec;
     case CSR_SCOUNTEREN:
-        return env->scounteren;
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            return env->scounteren;
+        } else {
+            break; /* illegal instruction */
+        }
     case CSR_SCAUSE:
         return env->scause;
     case CSR_SATP: /* CSR_SPTBR */
@@ -510,7 +540,11 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
     case CSR_MTVEC:
         return env->mtvec;
     case CSR_MCOUNTEREN:
-        return env->mcounteren;
+        if (env->priv_ver >= PRIV_VERSION_1_10_0) {
+            return env->mcounteren;
+        } else {
+            break; /* illegal instruction */
+        }
     case CSR_MEDELEG:
         return env->medeleg;
     case CSR_MIDELEG:
-- 
2.7.0
