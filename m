Received: from eggs.gnu.org ([2001:4830:134:3::10]:46698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU99-0005Mn-UN
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU96-0005Hw-Qu
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:24 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU96-0005Hg-IW
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:20 -0400
Received: by mail-pg0-x242.google.com with SMTP id i194so14461622pgd.0
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:20 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:23 +1200
Message-Id: <1524699938-6764-21-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 20/35] RISC-V: Use [ms]counteren CSRs when
 priv ISA >= v1.10
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
 target/riscv/op_helper.c | 63 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 890cd96..e0608e6 100644
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
index 88c263a..2daf07c 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -227,11 +227,19 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         break;
 #endif
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
@@ -287,8 +295,12 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         }
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
         }
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
@@ -347,6 +363,9 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
        pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val_to_write);
        break;
 #endif
+#if !defined(CONFIG_USER_ONLY)
+    do_illegal:
+#endif
     default:
         do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
@@ -360,8 +379,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
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
@@ -436,9 +455,17 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
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
@@ -463,7 +490,11 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
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
@@ -508,7 +539,11 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
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
