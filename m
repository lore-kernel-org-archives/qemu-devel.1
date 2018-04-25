Received: from eggs.gnu.org ([2001:4830:134:3::10]:46547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU8o-00050R-BP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU8n-000578-IJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:02 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:46979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU8n-00056m-DF
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:01 -0400
Received: by mail-pg0-x242.google.com with SMTP id z4so1557260pgu.13
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:01 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:18 +1200
Message-Id: <1524699938-6764-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 15/35] RISC-V: Hardwire satp to 0 for no-mmu
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

satp is WARL so it should not trap on illegal writes, rather
it can be hardwired to zero and silently ignore illegal writes.

It seems the RISC-V WARL behaviour is preferred to having to
trap overhead versus simply reading back the value and checking
if the write took (saves hundreds of cycles and more complex
trap handling code).

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 7c6068b..101dac1 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -255,7 +255,7 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
     }
     case CSR_SATP: /* CSR_SPTBR */ {
         if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
-            goto do_illegal;
+            break;
         }
         if (env->priv_ver <= PRIV_VERSION_1_09_1 && (val_to_write ^ env->sptbr))
         {
@@ -465,7 +465,10 @@ target_ulong csr_read_helper(CPURISCVState *env, target_ulong csrno)
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
