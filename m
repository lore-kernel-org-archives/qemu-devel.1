Received: from eggs.gnu.org ([208.118.235.92]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznhZ-0004YY-Qx
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezngV-0003kp-QQ
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:15:37 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngV-0003kg-Jj
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:31 -0400
Received: by mail-pf0-x242.google.com with SMTP id f15so208103pfn.0
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:31 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:32 -0700
Message-Id: <1521915220-65389-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 16/26] RISC-V: Hardwire satp to 0 for no-mmu
 case
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

satp is WARL so it should not trap on illegal writes, rather
it can be hardwired to zero and silently ignore illegal writes.

It seems the RISC-V WARL behaviour is preferred to having to
trap overhead versus simply reading back the value and checking
if the write took (saves hundreds of cycles and more complex
trap handling code).

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index e34715d..dd3e417 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -242,7 +242,7 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     }
     case CSR_SATP: /* CSR_SPTBR */ {
         if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
-            goto do_illegal;
+            break;
         }
         if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val_to_write ^ env->sptbr))
         {
@@ -452,7 +452,10 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
         return env->scounteren;
     case CSR_SCAUSE:
         return env->scause;
-    case CSR_SPTBR:
+    case CSR_SATP: /* CSR_SPTBR */
+        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+            return 0;
+        }
         if (env->priv_ver >= PRIV_VERSION_1_10_0) {
             return env->satp;
         } else {
-- 
2.7.0
