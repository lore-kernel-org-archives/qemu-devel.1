Received: from eggs.gnu.org ([2001:4830:134:3::10]:46711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9B-0005O1-9D
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9A-0005JR-8V
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:25 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU9A-0005J2-1u
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:24 -0400
Received: by mail-pf0-x242.google.com with SMTP id p6so16582911pfn.4
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:23 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:24 +1200
Message-Id: <1524699938-6764-22-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 21/35] RISC-V: Add mcycle/minstret support
 for -icount auto
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

Previously the mycycle/minstret CSRs and rdcycle/rdinstret
psuedo instructions would return the time as a proxy for an
increasing instruction counter in the absence of having a
precise instruction count. If QEMU is invoked with -icount,
the mcycle/minstret CSRs and rdcycle/rdinstret psuedo
instructions will return the instruction count.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 24 ++++++++++++++++++++----
 target/riscv/translate.c |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 2daf07c..7d3f1ee 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -433,25 +433,41 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
     case CSR_INSTRET:
     case CSR_CYCLE:
         if (ctr_ok) {
-            return cpu_get_host_ticks();
+            if (use_icount) {
+                return cpu_get_icount();
+            } else {
+                return cpu_get_host_ticks();
+            }
         }
         break;
 #if defined(TARGET_RISCV32)
     case CSR_INSTRETH:
     case CSR_CYCLEH:
         if (ctr_ok) {
-            return cpu_get_host_ticks() >> 32;
+            if (use_icount) {
+                return cpu_get_icount() >> 32;
+            } else {
+                return cpu_get_host_ticks() >> 32;
+            }
         }
         break;
 #endif
 #ifndef CONFIG_USER_ONLY
     case CSR_MINSTRET:
     case CSR_MCYCLE:
-        return cpu_get_host_ticks();
+        if (use_icount) {
+            return cpu_get_icount();
+        } else {
+            return cpu_get_host_ticks();
+        }
     case CSR_MINSTRETH:
     case CSR_MCYCLEH:
 #if defined(TARGET_RISCV32)
-        return cpu_get_host_ticks() >> 32;
+        if (use_icount) {
+            return cpu_get_icount() >> 32;
+        } else {
+            return cpu_get_host_ticks() >> 32;
+        }
 #endif
         break;
     case CSR_MUCOUNTEREN:
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c3a029a..c0e6a04 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1390,6 +1390,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
         break;
     default:
         tcg_gen_movi_tl(imm_rs1, rs1);
+        gen_io_start();
         switch (opc) {
         case OPC_RISC_CSRRW:
             gen_helper_csrrw(dest, cpu_env, source1, csr_store);
@@ -1413,6 +1414,7 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
             gen_exception_illegal(ctx);
             return;
         }
+        gen_io_end();
         gen_set_gpr(rd, dest);
         /* end tb since we may be changing priv modes, to get mmu_index right */
         tcg_gen_movi_tl(cpu_pc, ctx->next_pc);
-- 
2.7.0
