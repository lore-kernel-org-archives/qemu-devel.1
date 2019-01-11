Received: from eggs.gnu.org ([209.51.188.92]:45617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Cg-0008QD-BJ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Ce-0002e4-DK
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:46 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:38627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gi1Ce-0002bJ-76
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:44 -0500
Received: by mail-pg1-x534.google.com with SMTP id g189so6625702pgc.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:06:41 -0800 (PST)
Date: Fri, 11 Jan 2019 10:06:28 -0800
Message-Id: <20190111180630.6433-3-palmer@sifive.com>
In-Reply-To: <20190111180630.6433-1-palmer@sifive.com>
References: <20190111180630.6433-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 2/4] RISC-V: Implement atomic mip/sip CSR updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

Use the new CSR read/modify/write interface to implement
atomic updates to mip/sip.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b61b0ef37971..44ea8b7cb6e8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -487,25 +487,31 @@ static int write_mbadaddr(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
-static int read_mip(CPURISCVState *env, int csrno, target_ulong *val)
-{
-    *val = atomic_read(&env->mip);
-    return 0;
-}
-
-static int write_mip(CPURISCVState *env, int csrno, target_ulong val)
+static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
 {
     RISCVCPU *cpu = riscv_env_get_cpu(env);
+    target_ulong mask = write_mask & delegable_ints;
+    uint32_t old_mip;
+
+    /* We can't allow the supervisor to control SEIP as this would allow the
+     * supervisor to clear a pending external interrupt which will result in
+     * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
+     * hardware controlled when a PLIC is attached. This should be an option
+     * for CPUs with software-delegated Supervisor External Interrupts. */
+    mask &= ~MIP_SEIP;
+
+    if (mask) {
+        qemu_mutex_lock_iothread();
+        old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
+        qemu_mutex_unlock_iothread();
+    } else {
+        old_mip = atomic_read(&env->mip);
+    }
 
-    /*
-     * csrs, csrc on mip.SEIP is not decomposable into separate read and
-     * write steps, so a different implementation is needed
-     */
-
-    qemu_mutex_lock_iothread();
-    riscv_cpu_update_mip(cpu, MIP_SSIP | MIP_STIP,
-                         (val & (MIP_SSIP | MIP_STIP)));
-    qemu_mutex_unlock_iothread();
+    if (ret_value) {
+        *ret_value = old_mip;
+    }
 
     return 0;
 }
@@ -623,17 +629,11 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
-static int read_sip(CPURISCVState *env, int csrno, target_ulong *val)
-{
-    *val = atomic_read(&env->mip) & env->mideleg;
-    return 0;
-}
-
-static int write_sip(CPURISCVState *env, int csrno, target_ulong val)
+static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
+                   target_ulong new_value, target_ulong write_mask)
 {
-    target_ulong newval = (atomic_read(&env->mip) & ~env->mideleg)
-                          | (val & env->mideleg);
-    return write_mip(env, CSR_MIP, newval);
+    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
+                   write_mask & env->mideleg);
 }
 
 /* Supervisor Protection and Translation */
@@ -812,7 +812,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MEPC] =                { read_mepc,        write_mepc        },
     [CSR_MCAUSE] =              { read_mcause,      write_mcause      },
     [CSR_MBADADDR] =            { read_mbadaddr,    write_mbadaddr    },
-    [CSR_MIP] =                 { read_mip,         write_mip         },
+    [CSR_MIP] =                 { NULL,     NULL,     rmw_mip         },
 
     /* Supervisor Trap Setup */
     [CSR_SSTATUS] =             { read_sstatus,     write_sstatus     },
@@ -825,7 +825,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SEPC] =                { read_sepc,        write_sepc        },
     [CSR_SCAUSE] =              { read_scause,      write_scause      },
     [CSR_SBADADDR] =            { read_sbadaddr,    write_sbadaddr    },
-    [CSR_SIP] =                 { read_sip,         write_sip         },
+    [CSR_SIP] =                 { NULL,     NULL,     rmw_sip         },
 
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { read_satp,        write_satp        },
-- 
2.18.1
