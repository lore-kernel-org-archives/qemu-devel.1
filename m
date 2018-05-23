Received: from eggs.gnu.org ([2001:4830:134:3::10]:42328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTL-0008NK-43
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHTK-0000xQ-57
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:43 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:38974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHTJ-0000x4-V0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:17:42 -0400
Received: by mail-pf0-x22f.google.com with SMTP id a22-v6so9550470pfn.6
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:17:41 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:02 +1200
Message-Id: <1527034517-7851-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 15/30] RISC-V: Add hartid and \n to
 interrupt logging
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

Add carriage return that was erroneously removed
when converting to qemu_log. Change hard coded
core number to the actual hartid.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/cpu_helper.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bc15e19022cc..69592c037042 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -446,11 +446,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -512,8 +514,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
         if (hasbadaddr) {
             if (RISCV_DEBUG_INTERRUPT) {
-                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld
-                    ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
+                qemu_log_mask(LOG_TRACE, "core " TARGET_FMT_ld ": badaddr 0x"
+                    TARGET_FMT_lx "\n", env->mhartid, env->badaddr);
             }
             env->sbadaddr = env->badaddr;
         } else {
@@ -537,8 +539,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
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
2.7.0
