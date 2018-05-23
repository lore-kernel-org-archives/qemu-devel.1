Received: from eggs.gnu.org ([2001:4830:134:3::10]:42167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSy-00085I-K1
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHSx-0000lv-Fe
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:20 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:44734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHSx-0000kg-7X
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:19 -0400
Received: by mail-pl0-x244.google.com with SMTP id m24-v6so487333pls.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:19 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:14:56 +1200
Message-Id: <1527034517-7851-10-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 09/30] RISC-V: Implement atomic mip/sip CSR
 updates
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

Use the new CSR read/modify/write interface to implement
atomic updates to mip/sip.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/csr.c | 56 +++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e08f3523d854..631a5ff9f7d8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -493,25 +493,31 @@ static int write_mbadaddr(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -631,17 +637,11 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -823,7 +823,7 @@ static const riscv_csr_operations csr_ops[0xfff] = {
     [CSR_MEPC] =                { read_mepc,        write_mepc        },
     [CSR_MCAUSE] =              { read_mcause,      write_mcause      },
     [CSR_MBADADDR] =            { read_mbadaddr,    write_mbadaddr    },
-    [CSR_MIP] =                 { read_mip,         write_mip         },
+    [CSR_MIP] =                 { NULL,     NULL,     rmw_mip         },
 
     /* Supervisor Trap Setup */
     [CSR_SSTATUS] =             { read_sstatus,     write_sstatus     },
@@ -836,7 +836,7 @@ static const riscv_csr_operations csr_ops[0xfff] = {
     [CSR_SEPC] =                { read_sepc,        write_sepc        },
     [CSR_SCAUSE] =              { read_scause,      write_scause      },
     [CSR_SBADADDR] =            { read_sbadaddr,    write_sbadaddr    },
-    [CSR_SIP] =                 { read_sip,         write_sip         },
+    [CSR_SIP] =                 { NULL,     NULL,     rmw_sip         },
 
     /* Supervisor Protection and Translation */
     [CSR_SATP] =                { read_satp,        write_satp        },
-- 
2.7.0
