Received: from eggs.gnu.org ([208.118.235.92]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznku-0006tq-7k
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznga-0003nc-Cs
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:19:04 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:36964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eznga-0003mv-6Q
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:36 -0400
Received: by mail-pl0-x242.google.com with SMTP id w12-v6so9376648plp.4
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:36 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:37 -0700
Message-Id: <1521915220-65389-12-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 23/26] RISC-V: Clear mtval/stval on
 exceptions without info
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

mtval/stval must be set on all exceptions but zero is
a legal value if there is no exception specific info.
Placing the instruction bytes for illegal instruction
exceptions in mtval/stval is an optional feature and
is currently not supported by QEMU RISC-V.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index b2e3f45..0d802a8 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -489,6 +489,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->sbadaddr = env->badaddr;
+        } else {
+            /* otherwise we must clear sbadaddr/stval
+             * todo: support populating stval on illegal instructions */
+            env->sbadaddr = 0;
         }
 
         target_ulong s = env->mstatus;
@@ -510,6 +514,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->mbadaddr = env->badaddr;
+        } else {
+            /* otherwise we must clear mbadaddr/mtval
+             * todo: support populating mtval on illegal instructions */
+            env->mbadaddr = 0;
         }
 
         target_ulong s = env->mstatus;
-- 
2.7.0
