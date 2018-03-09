Received: from eggs.gnu.org ([2001:4830:134:3::10]:55870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qs-0004Sn-6P
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Qr-00076n-CS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:02 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Qr-00076Y-6F
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:01 -0500
Received: by mail-pl0-x244.google.com with SMTP id c11-v6so4623402plo.0
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:15:01 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:39 +1300
Message-Id: <1520568765-58189-18-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 17/23] RISC-V: Hardwire satp to 0 for no-mmu
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
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

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
