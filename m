Received: from eggs.gnu.org ([209.51.188.92]:38442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn6-0004ga-N9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn4-00007T-8W
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:48 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:43626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotn3-0008R7-VE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:46 -0500
Received: by mail-pg1-x536.google.com with SMTP id v28so110578pgk.10
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:22 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:54 -0800
Message-Id: <20190130173601.3268-4-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 03/10] RISC-V: Implement mstatus.TSR/TW/TVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Michael Clark <mjc@sifive.com>

This adds the necessary minimum to support S-mode
virtualization for priv ISA >= v1.10

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Co-authored-by: Matthew Suozzo <msuozzo@google.com>
Co-authored-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c       | 17 +++++++++++++----
 target/riscv/op_helper.c | 25 +++++++++++++++++++++----
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 571414768992..390d3a9a5634 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -305,7 +305,8 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
         }
         mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
             MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
-            MSTATUS_MPP | MSTATUS_MXR;
+            MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
+            MSTATUS_TW;
     }
 
     /* silenty discard mstatus.mpp writes for unsupported modes */
@@ -642,7 +643,11 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
     if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
         *val = 0;
     } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        *val = env->satp;
+        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
+            return -1;
+        } else {
+            *val = env->satp;
+        }
     } else {
         *val = env->sptbr;
     }
@@ -663,8 +668,12 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         validate_vm(env, get_field(val, SATP_MODE)) &&
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
-        tlb_flush(CPU(riscv_env_get_cpu(env)));
-        env->satp = val;
+        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
+            return -1;
+        } else {
+            tlb_flush(CPU(riscv_env_get_cpu(env)));
+            env->satp = val;
+        }
     }
     return 0;
 }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 81bd1a77ea90..77c79ba36e0b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -82,6 +82,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         do_raise_exception_err(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
     }
 
+    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
+        get_field(env->mstatus, MSTATUS_TSR)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
     target_ulong mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
     mstatus = set_field(mstatus,
@@ -125,16 +130,28 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = CPU(riscv_env_get_cpu(env));
 
-    cs->halted = 1;
-    cs->exception_index = EXCP_HLT;
-    cpu_loop_exit(cs);
+    if (env->priv == PRV_S &&
+        env->priv_ver >= PRIV_VERSION_1_10_0 &&
+        get_field(env->mstatus, MSTATUS_TW)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    } else {
+        cs->halted = 1;
+        cs->exception_index = EXCP_HLT;
+        cpu_loop_exit(cs);
+    }
 }
 
 void helper_tlb_flush(CPURISCVState *env)
 {
     RISCVCPU *cpu = riscv_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
-    tlb_flush(cs);
+    if (env->priv == PRV_S &&
+        env->priv_ver >= PRIV_VERSION_1_10_0 &&
+        get_field(env->mstatus, MSTATUS_TVM)) {
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    } else {
+        tlb_flush(cs);
+    }
 }
 
 #endif /* !CONFIG_USER_ONLY */
-- 
2.18.1
