Received: from eggs.gnu.org ([2001:4830:134:3::10]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFR-0007ek-2b
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFM-0003qL-VG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:41 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFM-0003px-Ht
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:36 -0400
Received: by mail-pl0-x244.google.com with SMTP id f23-v6so6498942plr.10
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:36 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:17 -0700
Message-Id: <1521229281-73637-21-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 20/24] RISC-V: vectored traps are optional
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
