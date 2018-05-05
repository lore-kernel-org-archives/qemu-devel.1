Received: from eggs.gnu.org ([2001:4830:134:3::10]:54481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kG-0004Ji-RW
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kF-0003w3-FY
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:40 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6kF-0003vp-9X
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:39 -0400
Received: by mail-pf0-x242.google.com with SMTP id p14so8709721pfh.9
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:39 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:19 +1200
Message-Id: <1525563325-62963-15-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL 14/20] RISC-V: Clear mtval/stval on exceptions
 without info
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index 02cbcea2b731..95889f23b94d 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -466,6 +466,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->sbadaddr = env->badaddr;
+        } else {
+            /* otherwise we must clear sbadaddr/stval
+             * todo: support populating stval on illegal instructions */
+            env->sbadaddr = 0;
         }
 
         target_ulong s = env->mstatus;
@@ -487,6 +491,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
