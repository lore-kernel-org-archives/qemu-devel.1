Received: from eggs.gnu.org ([208.118.235.92]:48194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrZ-0004Y1-G7
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrX-0007zw-G6
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:57 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:40296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrX-0007l3-8j
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:55 -0500
Received: by mail-qk1-x732.google.com with SMTP id y16so9621685qki.7
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:26 -0800 (PST)
Date: Wed, 26 Dec 2018 09:19:58 -0800
Message-Id: <20181226172005.26990-8-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 07/14] RISC-V: Add hartid and \n to interrupt
 logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

Add carriage return that was erroneously removed
when converting to qemu_log. Change hard coded
core number to the actual hartid.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 86f9f4730c88..0234c2d52886 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -445,11 +445,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (RISCV_DEBUG_INTERRUPT) {
         int log_cause = cs->exception_index & RISCV_EXCP_INT_MASK;
         if (cs->exception_index & RISCV_EXCP_INT_FLAG) {
-            qemu_log_mask(LOG_TRACE, "core   0: trap %s, epc 0x" TARGET_FMT_lx,
-                riscv_intr_names[log_cause], env->pc);
+            qemu_log_mask(LOG_TRACE, "core "
+                TARGET_FMT_ld ": trap %s, epc 0x" TARGET_FMT_lx "\n",
+                env->mhartid, riscv_intr_names[log_cause], env->pc);
         } else {
-            qemu_log_mask(LOG_TRACE, "core   0: intr %s, epc 0x" TARGET_FMT_lx,
-                riscv_excp_names[log_cause], env->pc);
+            qemu_log_mask(LOG_TRACE, "core "
+                TARGET_FMT_ld ": intr %s, epc 0x" TARGET_FMT_lx "\n",
+                env->mhartid, riscv_excp_names[log_cause], env->pc);
         }
     }
 
@@ -511,8 +513,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
         if (hasbadaddr) {
             if (RISCV_DEBUG_INTERRUPT) {
-                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
-                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
+                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr 0x"
+                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
             }
             env->sbadaddr = env->badaddr;
         } else {
@@ -536,8 +538,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
         if (hasbadaddr) {
             if (RISCV_DEBUG_INTERRUPT) {
-                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
-                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
+                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr 0x"
+                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
             }
             env->mbadaddr = env->badaddr;
         } else {
-- 
2.18.1
