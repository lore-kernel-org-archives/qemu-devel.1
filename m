Received: from eggs.gnu.org ([2001:4830:134:3::10]:46627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU8y-0005Br-6D
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU8v-0005Bu-3a
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:12 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:46822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU8u-0005BY-Sc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:09 -0400
Received: by mail-pf0-x243.google.com with SMTP id p12so593734pff.13
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:08 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:20 +1200
Message-Id: <1524699938-6764-18-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 17/35] RISC-V: No traps on writes to misa,
 minstret, mcycle
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

These fields are marked WARL (Write Any Values, Reads
Legal Values) in the RISC-V Privileged Architecture
Specification so instead of raising exceptions,
illegal writes are silently dropped.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 828f20c..b81b9b6 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -213,17 +213,19 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         break;
     }
     case CSR_MINSTRET:
-        qemu_log_mask(LOG_UNIMP, "CSR_MINSTRET: write not implemented");
-        goto do_illegal;
+        /* minstret is WARL so unsupported writes are ignored */
+        break;
     case CSR_MCYCLE:
-        qemu_log_mask(LOG_UNIMP, "CSR_MCYCLE: write not implemented");
-        goto do_illegal;
+        /* mcycle is WARL so unsupported writes are ignored */
+        break;
+#if defined(TARGET_RISCV32)
     case CSR_MINSTRETH:
-        qemu_log_mask(LOG_UNIMP, "CSR_MINSTRETH: write not implemented");
-        goto do_illegal;
+        /* minstreth is WARL so unsupported writes are ignored */
+        break;
     case CSR_MCYCLEH:
-        qemu_log_mask(LOG_UNIMP, "CSR_MCYCLEH: write not implemented");
-        goto do_illegal;
+        /* mcycleh is WARL so unsupported writes are ignored */
+        break;
+#endif
     case CSR_MUCOUNTEREN:
         env->mucounteren = val_to_write;
         break;
@@ -314,10 +316,9 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     case CSR_MBADADDR:
         env->mbadaddr = val_to_write;
         break;
-    case CSR_MISA: {
-        qemu_log_mask(LOG_UNIMP, "CSR_MISA: misa writes not supported");
-        goto do_illegal;
-    }
+    case CSR_MISA:
+        /* misa is WARL so unsupported writes are ignored */
+        break;
     case CSR_PMPCFG0:
     case CSR_PMPCFG1:
     case CSR_PMPCFG2:
@@ -342,7 +343,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     case CSR_PMPADDR15:
        pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val_to_write);
        break;
-    do_illegal:
 #endif
     default:
         do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-- 
2.7.0
