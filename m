Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU90-0005DW-1E
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBU8z-0005E8-52
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:14 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:45671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBU8y-0005Dp-Vw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 19:48:13 -0400
Received: by mail-pg0-x244.google.com with SMTP id i29so12947377pgn.12
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 16:48:12 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Thu, 26 Apr 2018 11:45:21 +1200
Message-Id: <1524699938-6764-19-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-1-git-send-email-mjc@sifive.com>
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v8 18/35] RISC-V: Clear mtval/stval on
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
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

mtval/stval must be set on all exceptions but zero is
a legal value if there is no exception specific info.
Placing the instruction bytes for illegal instruction
exceptions in mtval/stval is an optional feature and
is currently not supported by QEMU RISC-V.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 459fc97..3b57e13 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -492,6 +492,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->sbadaddr = env->badaddr;
+        } else {
+            /* otherwise we must clear sbadaddr/stval
+             * todo: support populating stval on illegal instructions */
+            env->sbadaddr = 0;
         }
 
         target_ulong s = env->mstatus;
@@ -513,6 +517,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
