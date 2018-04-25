Received: from eggs.gnu.org ([2001:4830:134:3::10]:46960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9y-00064y-UH
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU9y-0005if-5J
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:49:14 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU9x-0005iG-VC
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:49:14 -0400
Received: by mail-pf0-x244.google.com with SMTP id j5so16590109pfh.2
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:49:13 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:37 +1200
Message-Id: <1524699938-6764-35-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 34/35] RISC-V: Add hartid and \n to
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
index 5d33f7b..a45885f 100644
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
2.7.0
