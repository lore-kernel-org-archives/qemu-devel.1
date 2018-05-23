Received: from eggs.gnu.org ([2001:4830:134:3::10]:42645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTm-0000JW-Ii
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTl-0001FU-Cb
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:10 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTl-0001FA-49
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:09 -0400
Received: by mail-pg0-x241.google.com with SMTP id k2-v6so8592091pgc.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:09 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:09 +1200
Message-Id: <1527034517-7851-23-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 22/30] RISC-V: Add misa runtime write support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>

This patch adds support for writing misa. misa is validated based
on rules in the ISA specification. 'E' is mutually exclusive with
all other extensions. 'D' depends on 'F' so 'D' bit is dropped
if 'F' is not present. A conservative approach to consistency is
taken by flushing the translation cache on misa writes. misa_mask
is added to the CPU struct to store the original set of extensions.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu.c      |  2 +-
 target/riscv/cpu.h      |  4 +++-
 target/riscv/cpu_bits.h | 11 +++++++++++
 target/riscv/csr.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9f47f2072c56..d59e1c0c146d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -86,7 +86,7 @@ typedef struct RISCVCPUInfo {
 
 static void set_misa(CPURISCVState *env, target_ulong misa)
 {
-    env->misa = misa;
+    env->misa_mask = env->misa = misa;
 }
 
 static void set_versions(CPURISCVState *env, int user_ver, int priv_ver)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ae0e3f6a544d..830a9d476dce 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -86,7 +86,8 @@
    so a cpu features bitfield is required, likewise for optional PMP support */
 enum {
     RISCV_FEATURE_MMU,
-    RISCV_FEATURE_PMP
+    RISCV_FEATURE_PMP,
+    RISCV_FEATURE_MISA_RW
 };
 
 #define USER_VERSION_2_02_0 0x00020200
@@ -118,6 +119,7 @@ struct CPURISCVState {
     target_ulong user_ver;
     target_ulong priv_ver;
     target_ulong misa;
+    target_ulong misa_mask;
 
     uint32_t features;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 878de6233846..55b45a40ca3f 100644
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
index 9bbe81a110a5..0be973002ee2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -341,6 +341,56 @@ static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
     return 0;
 }
 
+static int write_misa(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if (!riscv_feature(env, RISCV_FEATURE_MISA_RW)) {
+        /* drop write to misa */
+        return 0;
+    }
+
+    /* 'I' or 'E' must be present */
+    if (!(val & (RVI | RVE))) {
+        /* it not, drop write to misa */
+        return 0;
+    }
+
+    /* 'E' excludes all other extensions */
+    if (val & RVE) {
+        /* when we support 'E' we can do "val = RVE;" however
+         * for now we just drop writes if 'E' is present */
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
+       TODO: this should check next_pc */
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
@@ -821,7 +871,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
 
     /* Machine Trap Setup */
     [CSR_MSTATUS] =             { any,  read_mstatus,     write_mstatus     },
-    [CSR_MISA] =                { any,  read_misa                           },
+    [CSR_MISA] =                { any,  read_misa,        write_misa        },
     [CSR_MIDELEG] =             { any,  read_mideleg,     write_mideleg     },
     [CSR_MEDELEG] =             { any,  read_medeleg,     write_medeleg     },
     [CSR_MIE] =                 { any,  read_mie,         write_mie         },
-- 
2.7.0
