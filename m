Received: from eggs.gnu.org ([209.51.188.92]:38505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn7-0004h6-8H
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gotn4-00007r-GC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:49 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gotn4-0008Uj-84
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:36:46 -0500
Received: by mail-pg1-x542.google.com with SMTP id s198so131465pgs.2
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 09:36:32 -0800 (PST)
Date: Wed, 30 Jan 2019 09:35:59 -0800
Message-Id: <20190130173601.3268-9-palmer@sifive.com>
In-Reply-To: <20190130173601.3268-1-palmer@sifive.com>
References: <20190130173601.3268-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 08/10] RISC-V: Add misa runtime write support
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

This patch adds support for writing misa. misa is validated based
on rules in the ISA specification. 'E' is mutually exclusive with
all other extensions. 'D' depends on 'F' so 'D' bit is dropped
if 'F' is not present. A conservative approach to consistency is
taken by flushing the translation cache on misa writes. misa_mask
is added to the CPU struct to store the original set of extensions.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c      |  2 +-
 target/riscv/cpu.h      |  4 ++-
 target/riscv/cpu_bits.h | 11 +++++++++
 target/riscv/csr.c      | 54 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 28d7e5302fb1..cc3ddc0ae4b5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -88,7 +88,7 @@ typedef struct RISCVCPUInfo {
 
 static void set_misa(CPURISCVState *env, target_ulong misa)
 {
-    env->misa = misa;
+    env->misa_mask = env->misa = misa;
 }
 
 static void set_versions(CPURISCVState *env, int user_ver, int priv_ver)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a97435bd7b1d..5c2aebf13251 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -86,7 +86,8 @@
    so a cpu features bitfield is required, likewise for optional PMP support */
 enum {
     RISCV_FEATURE_MMU,
-    RISCV_FEATURE_PMP
+    RISCV_FEATURE_PMP,
+    RISCV_FEATURE_MISA
 };
 
 #define USER_VERSION_2_02_0 0x00020200
@@ -118,6 +119,7 @@ struct CPURISCVState {
     target_ulong user_ver;
     target_ulong priv_ver;
     target_ulong misa;
+    target_ulong misa_mask;
 
     uint32_t features;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 5439f4719ee5..7afcb2468d80 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -311,10 +311,21 @@
 #define MSTATUS32_SD        0x80000000
 #define MSTATUS64_SD        0x8000000000000000ULL
 
+#define MISA32_MXL          0xC0000000
+#define MISA64_MXL          0xC000000000000000ULL
+
+#define MXL_RV32            1
+#define MXL_RV64            2
+#define MXL_RV128           3
+
 #if defined(TARGET_RISCV32)
 #define MSTATUS_SD MSTATUS32_SD
+#define MISA_MXL MISA32_MXL
+#define MXL_VAL MXL_RV32
 #elif defined(TARGET_RISCV64)
 #define MSTATUS_SD MSTATUS64_SD
+#define MISA_MXL MISA64_MXL
+#define MXL_VAL MXL_RV64
 #endif
 
 /* sstatus CSR bits */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e2bd374f09ed..e72fcf1265d4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -332,6 +332,58 @@ static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
     return 0;
 }
 
+static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_feature(env, RISCV_FEATURE_MISA)) {
+        /* drop write to misa */
+        return 0;
+    }
+
+    /* 'I' or 'E' must be present */
+    if (!(val & (RVI | RVE))) {
+        /* It is not, drop write to misa */
+        return 0;
+    }
+
+    /* 'E' excludes all other extensions */
+    if (val & RVE) {
+        /* when we support 'E' we can do "val = RVE;" however
+         * for now we just drop writes if 'E' is present.
+         */
+        return 0;
+    }
+
+    /* Mask extensions that are not supported by this hart */
+    val &= env->misa_mask;
+
+    /* Mask extensions that are not supported by QEMU */
+    val &= (RVI | RVE | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+
+    /* 'D' depends on 'F', so clear 'D' if 'F' is not present */
+    if ((val & RVD) && !(val & RVF)) {
+        val &= ~RVD;
+    }
+
+    /* Suppress 'C' if next instruction is not aligned
+     * TODO: this should check next_pc
+     */
+    if ((val & RVC) && (GETPC() & ~3) != 0) {
+        val &= ~RVC;
+    }
+
+    /* misa.MXL writes are not supported by QEMU */
+    val = (env->misa & MISA_MXL) | (val & ~MISA_MXL);
+
+    /* flush translation cache */
+    if (val != env->misa) {
+        tb_flush(CPU(riscv_env_get_cpu(env)));
+    }
+
+    env->misa = val;
+
+    return 0;
+}
+
 static int read_medeleg(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->medeleg;
@@ -810,7 +862,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     /* Machine Trap Setup */
     [CSR_MSTATUS] =             { any,  read_mstatus,     write_mstatus     },
-    [CSR_MISA] =                { any,  read_misa                           },
+    [CSR_MISA] =                { any,  read_misa,        write_misa        },
     [CSR_MIDELEG] =             { any,  read_mideleg,     write_mideleg     },
     [CSR_MEDELEG] =             { any,  read_medeleg,     write_medeleg     },
     [CSR_MIE] =                 { any,  read_mie,         write_mie         },
-- 
2.18.1
