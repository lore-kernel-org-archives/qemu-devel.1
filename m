Received: from eggs.gnu.org ([2001:4830:134:3::10]:54561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kV-0004Vg-7v
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kU-000489-9n
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:55 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6kU-00047h-3l
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:54 -0400
Received: by mail-pf0-x242.google.com with SMTP id a14so20111150pfi.1
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:53 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:23 +1200
Message-Id: <1525563325-62963-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL 18/20] RISC-V: Make mtvec/stvec ignore vectored
 traps
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

Vectored traps for asynchrounous interrupts are optional.
The mtvec/stvec mode field is WARL and hence does not trap
if an illegal value is written. Illegal values are ignored.

Later we can add RISCV_FEATURE_VECTORED_TRAPS however
until then the correct behavior for WARL (Write Any, Read
Legal) fields is to drop writes to unsupported bits.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/op_helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3512462f4fd8..af0c52a48418 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -287,11 +287,12 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         env->sepc = val_to_write;
         break;
     case CSR_STVEC:
-        if (val_to_write & 1) {
+        /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
+        if ((val_to_write & 3) == 0) {
+            env->stvec = val_to_write >> 2 << 2;
+        } else {
             qemu_log_mask(LOG_UNIMP, "CSR_STVEC: vectored traps not supported");
-            goto do_illegal;
         }
-        env->stvec = val_to_write >> 2 << 2;
         break;
     case CSR_SCOUNTEREN:
         if (env->priv_ver >= PRIV_VERSION_1_10_0) {
@@ -313,11 +314,12 @@ void csr_write_helper(CPURISCVState *env, target_ulong val_to_write,
         env->mepc = val_to_write;
         break;
     case CSR_MTVEC:
-        if (val_to_write & 1) {
+        /* bits [1:0] indicate mode; 0 = direct, 1 = vectored, 2 >= reserved */
+        if ((val_to_write & 3) == 0) {
+            env->mtvec = val_to_write >> 2 << 2;
+        } else {
             qemu_log_mask(LOG_UNIMP, "CSR_MTVEC: vectored traps not supported");
-            goto do_illegal;
         }
-        env->mtvec = val_to_write >> 2 << 2;
         break;
     case CSR_MCOUNTEREN:
         if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-- 
2.7.0
