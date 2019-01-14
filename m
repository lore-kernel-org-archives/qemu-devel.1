Received: from eggs.gnu.org ([209.51.188.92]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC8I-0004H6-Mc
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC8H-0001Cc-Cx
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:59:06 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:59:00 +0000
Message-ID: <f7184f107ba99dab6b85da6916fc09663ffd3e21.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 8/8] RISC-V: Add misa runtime write support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Michael Clark <mjc@sifive.com>

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
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c      |  2 +-
 target/riscv/cpu.h      |  4 ++-
 target/riscv/cpu_bits.h | 11 +++++++++
 target/riscv/csr.c      | 54 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 28d7e5302f..cc3ddc0ae4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -88,7 +88,7 @@ typedef struct RISCVCPUInfo {
=20
 static void set_misa(CPURISCVState *env, target_ulong misa)
 {
-    env->misa =3D misa;
+    env->misa_mask =3D env->misa =3D misa;
 }
=20
 static void set_versions(CPURISCVState *env, int user_ver, int priv_ver)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a97435bd7b..5c2aebf132 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -86,7 +86,8 @@
    so a cpu features bitfield is required, likewise for optional PMP suppo=
rt */
 enum {
     RISCV_FEATURE_MMU,
-    RISCV_FEATURE_PMP
+    RISCV_FEATURE_PMP,
+    RISCV_FEATURE_MISA
 };
=20
 #define USER_VERSION_2_02_0 0x00020200
@@ -118,6 +119,7 @@ struct CPURISCVState {
     target_ulong user_ver;
     target_ulong priv_ver;
     target_ulong misa;
+    target_ulong misa_mask;
=20
     uint32_t features;
=20
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 5439f4719e..7afcb2468d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -311,10 +311,21 @@
 #define MSTATUS32_SD        0x80000000
 #define MSTATUS64_SD        0x8000000000000000ULL
=20
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
=20
 /* sstatus CSR bits */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e2bd374f09..e72fcf1265 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -332,6 +332,58 @@ static int read_misa(CPURISCVState *env, int csrno, ta=
rget_ulong *val)
     return 0;
 }
=20
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
+        /* when we support 'E' we can do "val =3D RVE;" however
+         * for now we just drop writes if 'E' is present.
+         */
+        return 0;
+    }
+
+    /* Mask extensions that are not supported by this hart */
+    val &=3D env->misa_mask;
+
+    /* Mask extensions that are not supported by QEMU */
+    val &=3D (RVI | RVE | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+
+    /* 'D' depends on 'F', so clear 'D' if 'F' is not present */
+    if ((val & RVD) && !(val & RVF)) {
+        val &=3D ~RVD;
+    }
+
+    /* Suppress 'C' if next instruction is not aligned
+     * TODO: this should check next_pc
+     */
+    if ((val & RVC) && (GETPC() & ~3) !=3D 0) {
+        val &=3D ~RVC;
+    }
+
+    /* misa.MXL writes are not supported by QEMU */
+    val =3D (env->misa & MISA_MXL) | (val & ~MISA_MXL);
+
+    /* flush translation cache */
+    if (val !=3D env->misa) {
+        tb_flush(CPU(riscv_env_get_cpu(env)));
+    }
+
+    env->misa =3D val;
+
+    return 0;
+}
+
 static int read_medeleg(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val =3D env->medeleg;
@@ -810,7 +862,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
=20
     /* Machine Trap Setup */
     [CSR_MSTATUS] =3D             { any,  read_mstatus,     write_mstatus =
    },
-    [CSR_MISA] =3D                { any,  read_misa                       =
    },
+    [CSR_MISA] =3D                { any,  read_misa,        write_misa    =
    },
     [CSR_MIDELEG] =3D             { any,  read_mideleg,     write_mideleg =
    },
     [CSR_MEDELEG] =3D             { any,  read_medeleg,     write_medeleg =
    },
     [CSR_MIE] =3D                 { any,  read_mie,         write_mie     =
    },
--=20
2.19.1
