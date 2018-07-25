Received: from eggs.gnu.org ([2001:4830:134:3::10]:56629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpB-0002E0-15
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSp8-00048V-1Z
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSp7-000476-Jo
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:01 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 25 Jul 2018 16:03:48 -0700
Message-Id: <c054d251fead8e6e38f78b8180803fb7382fe0ab.1532559484.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1532559484.git.alistair.francis@wdc.com>
References: <cover.1532559484.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/4] target/riscv: Rename mbadaddr and
 sbadaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

Update to the latest spec (v1.10.0) and rename mbadaddr and sbadaddr to
mtval and stval.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |  3 +--
 target/riscv/cpu_bits.h  |  4 ++--
 target/riscv/helper.c    |  8 ++++----
 target/riscv/op_helper.c | 16 ++++++++--------
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34abc383e3..0243f73129 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -138,8 +138,6 @@ struct CPURISCVState {
 
     target_ulong sptbr;  /* until: priv-1.9.1 */
     target_ulong satp;   /* since: priv-1.10.0 */
-    target_ulong sbadaddr;
-    target_ulong mbadaddr;
     target_ulong medeleg;
 
     target_ulong stvec;
@@ -150,6 +148,7 @@ struct CPURISCVState {
     target_ulong mepc;
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
+    target_ulong stval;  /* since: priv-1.10.0 */
 
     target_ulong scounteren;
     target_ulong mcounteren;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 64aa097181..135202c359 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -68,7 +68,7 @@
 #define CSR_SSCRATCH 0x140
 #define CSR_SEPC 0x141
 #define CSR_SCAUSE 0x142
-#define CSR_SBADADDR 0x143
+#define CSR_STVAL 0x143
 #define CSR_SIP 0x144
 #define CSR_SPTBR 0x180
 #define CSR_SATP 0x180
@@ -82,7 +82,7 @@
 #define CSR_MSCRATCH 0x340
 #define CSR_MEPC 0x341
 #define CSR_MCAUSE 0x342
-#define CSR_MBADADDR 0x343
+#define CSR_MTVAL 0x343
 #define CSR_MIP 0x344
 #define CSR_PMPCFG0 0x3a0
 #define CSR_PMPCFG1 0x3a1
diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 29e1a603dc..b4a3f80872 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -465,11 +465,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
-            env->sbadaddr = env->badaddr;
+            env->stval = env->badaddr;
         } else {
             /* otherwise we must clear sbadaddr/stval
              * todo: support populating stval on illegal instructions */
-            env->sbadaddr = 0;
+            env->stval = 0;
         }
 
         target_ulong s = env->mstatus;
@@ -490,11 +490,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
-            env->mbadaddr = env->badaddr;
+            env->mtval = env->badaddr;
         } else {
             /* otherwise we must clear mbadaddr/mtval
              * todo: support populating mtval on illegal instructions */
-            env->mbadaddr = 0;
+            env->mtval = 0;
         }
 
         target_ulong s = env->mstatus;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index aec7558e1b..d2ec078765 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -310,8 +310,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     case CSR_SCAUSE:
         env->scause = val_to_write;
         break;
-    case CSR_SBADADDR:
-        env->sbadaddr = val_to_write;
+    case CSR_STVAL:
+        env->stval = val_to_write;
         break;
     case CSR_MEPC:
         env->mepc = val_to_write;
@@ -338,8 +338,8 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     case CSR_MCAUSE:
         env->mcause = val_to_write;
         break;
-    case CSR_MBADADDR:
-        env->mbadaddr = val_to_write;
+    case CSR_MTVAL:
+        env->mtval = val_to_write;
         break;
     case CSR_MISA:
         /* misa is WARL so unsupported writes are ignored */
@@ -515,8 +515,8 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
         return env->mie & env->mideleg;
     case CSR_SEPC:
         return env->sepc;
-    case CSR_SBADADDR:
-        return env->sbadaddr;
+    case CSR_STVAL:
+        return env->stval;
     case CSR_STVEC:
         return env->stvec;
     case CSR_SCOUNTEREN:
@@ -554,8 +554,8 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
         return env->mscratch;
     case CSR_MCAUSE:
         return env->mcause;
-    case CSR_MBADADDR:
-        return env->mbadaddr;
+    case CSR_MTVAL:
+        return env->mtval;
     case CSR_MISA:
         return env->misa;
     case CSR_MARCHID:
-- 
2.17.1
