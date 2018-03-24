Received: from eggs.gnu.org ([2001:4830:134:3::10]:44183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezqQX-0006xI-Tt
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezqPR-0002aW-7k
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:10:11 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngY-0003lc-78
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:34 -0400
Received: by mail-pf0-x242.google.com with SMTP id u5so5951892pfh.6
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:34 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:35 -0700
Message-Id: <1521915220-65389-10-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 20/26] RISC-V: No traps on writes to misa,
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

These fields are marked WARL in the specification so illegal
writes are silently dropped.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 36b9e8e..ba3639d 100644
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
