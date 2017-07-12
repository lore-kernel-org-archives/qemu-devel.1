Received: from eggs.gnu.org ([2001:4830:134:3::10]:46575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dVFzT-0004vA-I1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dVFzQ-0006bv-D0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:39:35 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:37673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <j.pelczar@samsung.com>)
	id 1dVFzQ-0006aL-6U
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:39:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OSZ00E4571O4K30@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:39:26 +0100 (BST)
Received: from eusmges3.samsung.com (unknown [203.254.199.242])
	by	eucas1p1.samsung.com (KnoxPortal) with ESMTP
	id	20170712113926eucas1p12d09c8575758b5dc398d4884a16f0320~QklQ8iZ900130601306eucas1p1u
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:39:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180])
	by	eucas1p1.samsung.com (KnoxPortal) with ESMTP
	id	20170712113922eucas1p1c6588b2e29439254cafd3d8dde5c505c~QklNOrvq93241132411eucas1p12
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:39:22 +0000 (GMT)
Received: from AMDN1843 ([106.120.52.68])
	by eusync1.samsung.com (Oracle	Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with	ESMTPA id <0OSZ00DMP71LI460@eusync1.samsung.com> for
	qemu-devel@nongnu.org;	Wed, 12 Jul 2017 12:39:21 +0100 (BST)
From: Jaroslaw Pelczar <j.pelczar@samsung.com>
Date: Wed, 12 Jul 2017 13:39:20 +0200
Message-id: <001801d2fb03$811079e0$83316da0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: pl
References: <CGME20170712113922eucas1p1c6588b2e29439254cafd3d8dde5c505c@eucas1p1.samsung.com>
Subject: [Qemu-devel] target/arm: Fix abort on exception return from AArch64
 to AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Problem manifests itself when we handle the following sequence:

1. 64-bit Secure EL3 returns to 32-bit Secure EL1
2. 32-bit Secure EL1 performs SMC call to 64-bit Secure EL3
3. 64-bit Secure EL3 performs return ERET to 32-bit Secure EL1]
4. 32-bit Secure EL1 receives prefetch abort

If CPU's env->pc is not set to the same value as env->regs[15],
during ERET the simulator will try to fetch instruction from EL3's
virtual address inside 32-bit Secure EL1 virtual address space.
This will cause Prefetch Abort in 32-bit Secure EL1.

Problem occurs because of the following code generation scheme:

1. disas_uncond_b_reg will decode ERET
2. gen_helper_exception_return(cpu_env) will generate thunk to
   helper_exception_return
3. s->is_jmp is set to DISAS_JUMP
4. gen_intermediate_code_a64 will see dc->is_jmp == DISAS_JUMP
5. tcg_gen_lookup_and_goto_ptr(cpu_pc) will be called which trigger
   access cpu->pc to fetch next opcode

At this point cpu->pc will have EL3's PC value.

Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
---
 target/arm/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 2a85666..8222c19 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1027,6 +1027,9 @@ void HELPER(exception_return)(CPUARMState *env)
         } else {
             env->regs[15] = env->elr_el[cur_el] & ~0x3;
         }
+
+        env->pc = env->regs[15];
+
         qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d to "
                       "AArch32 EL%d PC 0x%" PRIx32 "\n",
                       cur_el, new_el, env->regs[15]);
-- 
2.7.4
	
