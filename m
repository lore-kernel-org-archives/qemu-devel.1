Received: from eggs.gnu.org ([2001:4830:134:3::10]:55963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9R1-0004cR-3g
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9R0-0007AT-9C
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:11 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9R0-0007AB-2w
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:15:10 -0500
Received: by mail-pf0-x244.google.com with SMTP id z10so826722pfh.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:15:10 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:42 +1300
Message-Id: <1520568765-58189-21-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 20/23] RISC-V: vectored traps are optional
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

Vectored traps for asynchrounous interrupts are optional.
The mtvec/stvec mode field is WARL and hence does not trap
if an illegal value is written. Illegal values are ignored.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/op_helper.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f79716a..aa101cc 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -262,11 +262,10 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         env->sepc = val_to_write;
         break;
     case CSR_STVEC:
-        if (val_to_write & 1) {
-            qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
-            goto do_illegal;
+        /* we do not support vectored traps for asynchrounous interrupts */ 
+        if ((val_to_write & 3) == 0) {
+            env->stvec = val_to_write >> 2 << 2;
         }
-        env->stvec = val_to_write >> 2 << 2;
         break;
     case CSR_SCOUNTEREN:
         env->scounteren = val_to_write;
@@ -284,11 +283,10 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         env->mepc = val_to_write;
         break;
     case CSR_MTVEC:
-        if (val_to_write & 1) {
-            qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
-            goto do_illegal;
+        /* we do not support vectored traps for asynchrounous interrupts */ 
+        if ((val_to_write & 3) == 0) {
+            env->mtvec = val_to_write >> 2 << 2;
         }
-        env->mtvec = val_to_write >> 2 << 2;
         break;
     case CSR_MCOUNTEREN:
         env->mcounteren = val_to_write;
-- 
2.7.0
