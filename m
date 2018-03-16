Received: from eggs.gnu.org ([2001:4830:134:3::10]:40475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFR-0007fN-Ep
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ewvFQ-0003rf-IK
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:41 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ewvFQ-0003rS-Bk
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:42:40 -0400
Received: by mail-pg0-x242.google.com with SMTP id e9so4459854pgs.10
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:42:40 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Fri, 16 Mar 2018 12:41:21 -0700
Message-Id: <1521229281-73637-25-git-send-email-mjc@sifive.com>
In-Reply-To: <1521229281-73637-1-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 24/24] RISC-V: Clear mtval/stval on
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
index c430e95..54d4ff7 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -499,6 +499,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->sbadaddr = env->badaddr;
+        } else {
+            /* otherwise we must clear sbadaddr/stval
+             * todo: support populating stval on illegal instructions */
+            env->sbadaddr = 0;
         }
 
         target_ulong s = env->mstatus;
@@ -520,6 +524,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
