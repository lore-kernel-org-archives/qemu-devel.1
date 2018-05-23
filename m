Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHUA-0000gT-7b
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fLHU7-0001X1-Fm
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:34 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:44835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fLHU7-0001Vy-4s
	for qemu-devel@nongnu.org; Tue, 22 May 2018 20:18:31 -0400
Received: by mail-pf0-x236.google.com with SMTP id q22-v6so9550341pff.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 17:18:31 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 23 May 2018 12:15:15 +1200
Message-Id: <1527034517-7851-29-git-send-email-mjc@sifive.com>
In-Reply-To: <1527034517-7851-1-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 28/30] RISC-V: linux-user support for RVE ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Kito Cheng <kito.cheng@gmail.com>

This change checks elf_flags for EF_RISCV_RVE and if
present uses the RVE linux syscall ABI which uses t0
for the syscall number instead of a7.

Warn and exit if a non-RVE ABI binary is run on a
cpu with the RVE extension as it is incompatible.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Co-authored-by: Kito Cheng <kito.cheng@gmail.com>
Co-authored-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 linux-user/riscv/cpu_loop.c | 14 +++++++++++++-
 target/riscv/cpu.h          |  4 ++++
 target/riscv/cpu_user.h     |  3 ++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index f137d39d7e82..5f6a941c6c19 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
+#include "elf.h"
 
 void cpu_loop(CPURISCVState *env)
 {
@@ -53,7 +54,8 @@ void cpu_loop(CPURISCVState *env)
                 ret = 0;
             } else {
                 ret = do_syscall(env,
-                                 env->gpr[xA7],
+                                 env->gpr[(env->elf_flags & EF_RISCV_RVE)
+                                    ? xT0 : xA7],
                                  env->gpr[xA0],
                                  env->gpr[xA1],
                                  env->gpr[xA2],
@@ -113,6 +115,16 @@ void cpu_loop(CPURISCVState *env)
 
 void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
 {
+    CPUState *cpu = ENV_GET_CPU(env);
+    TaskState *ts = cpu->opaque;
+    struct image_info *info = ts->info;
+
     env->pc = regs->sepc;
     env->gpr[xSP] = regs->sp;
+    env->elf_flags = info->elf_flags;
+
+    if ((env->misa & RVE) && !(env->elf_flags & EF_RISCV_RVE)) {
+        fprintf(stderr, "Incompatible ELF: RVE cpu requires RVE ABI binary\n");
+        exit(EXIT_FAILURE);
+    }
 }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 830a9d476dce..0823461ae9f2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -123,6 +123,10 @@ struct CPURISCVState {
 
     uint32_t features;
 
+#ifdef CONFIG_USER_ONLY
+    uint32_t elf_flags;
+#endif
+
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
     target_ulong resetvec;
diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
index c2199610abff..52d380aa98c2 100644
--- a/target/riscv/cpu_user.h
+++ b/target/riscv/cpu_user.h
@@ -10,4 +10,5 @@
 #define xA4 14
 #define xA5 15
 #define xA6 16
-#define xA7 17  /* syscall number goes here */
+#define xA7 17  /* syscall number for RVI ABI */
+#define xT0 5   /* syscall number for RVE ABI */
-- 
2.7.0
