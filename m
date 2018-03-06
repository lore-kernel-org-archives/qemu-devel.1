Received: from eggs.gnu.org ([2001:4830:134:3::10]:53589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfY-0000vo-CS
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfX-0002vm-IQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:44 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJfX-0002vg-Ch
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:43 -0500
Received: by mail-pl0-x241.google.com with SMTP id 93-v6so3098plc.9
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:58:43 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:29 +1300
Message-Id: <1520369790-38306-20-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 21/22] RISC-V: No traps on writes to
 misa/minstret/mcycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

These fields are marked WARL in the specification so illegal
writes are silently dropped.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index aa101cc..f8595a6 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -200,17 +200,19 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
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
@@ -300,10 +302,9 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
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
@@ -328,7 +329,6 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     case CSR_PMPADDR15:
        pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val_to_write);
        break;
-    do_illegal:
 #endif
     default:
         do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-- 
2.7.0
