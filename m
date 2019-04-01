Received: from eggs.gnu.org ([209.51.188.92]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hB2MJ-0003aa-Nf
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 15:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hB2MI-0003aB-Pu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 15:12:39 -0400
MIME-Version: 1.0
From: Jonathan Behrens <fintelia@gmail.com>
Date: Mon, 1 Apr 2019 15:12:07 -0400
Message-ID: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] target/riscv: Do not allow sfence.vma from
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org

The 'sfence.vma' instruction is privileged, and should only ever be allowed
when executing in supervisor mode or higher.

Jonathan

Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
---
 target/riscv/op_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b7dc18a41e..644d0fb35f 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
 {
     RISCVCPU *cpu = riscv_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
-    if (env->priv == PRV_S &&
-        env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(env->mstatus, MSTATUS_TVM)) {
+    if (!(env->priv >= PRV_S) ||
+        (env->priv == PRV_S &&
+         env->priv_ver >= PRIV_VERSION_1_10_0 &&
+         get_field(env->mstatus, MSTATUS_TVM))) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         tlb_flush(cs);
-- 
2.20.1
