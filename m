Received: from eggs.gnu.org ([2001:4830:134:3::10]:53500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfL-0000iN-BP
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJfK-0002t1-G1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:31 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJfK-0002st-9u
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:30 -0500
Received: by mail-pl0-x244.google.com with SMTP id 61-v6so12182plf.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:58:30 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:25 +1300
Message-Id: <1520369790-38306-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 17/22] RISC-V: Hardwire satp to 0 for no-mmu
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
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

satp is WARL so it should not trap on illegal writes, rather
it can be hardwired to zero and silently ignore illegal writes.

It seems the RISC-V WARL behaviour is preferred to having to
bear trap overhead, versus simply reading back the value and
checking if the write took (saves hundreds of cycles and much
more complex trap handling code).

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
